#!/usr/bin/env bash
# run-all.sh -- clean re-run of every verifier of the fable-ultra-equivalence audit.
#
#   1. extracts the producer commit 71ef1cda7ca927b090068c796bfdcc10ca097a2c into
#      build/producer/ (git archive; the working tree is never used as input),
#   2. runs the four independent methods and the author's check on the extracted
#      logs/alpha-survivors.g, tee-ing every transcript into logs/,
#   3. rebuilds EQUIVALENCE-TABLE.tsv from the method outputs (make-table.py),
#   4. checks that no pre-existing file of the repository changed (git status
#      must show nothing outside this audit directory and the untracked
#      zoom-5-sept.md), and writes the SHA-256 manifest.
#
# Usage:  scripts/run-all.sh          (from anywhere inside the repository)
# Exit status 0 only if every step succeeded and every transcript ends with its
# "Done:" sentinel.
set -uo pipefail
AUDIT="$(cd "$(dirname "$0")/.." && pwd)"
REPO="$(cd "$AUDIT" && git rev-parse --show-toplevel)"
PRODUCER_COMMIT=71ef1cda7ca927b090068c796bfdcc10ca097a2c
GAP=${GAP:-/private/var/tmp/sage-10.7-current/local/bin/gap}
SAGE=${SAGE:-/usr/local/bin/sage}
PY=${PY:-/Library/Frameworks/Python.framework/Versions/3.11/bin/python3}
cd "$AUDIT"
mkdir -p logs build
status=0

echo "== audit directory: $AUDIT"
echo "== repository:      $REPO  HEAD $(git -C "$REPO" rev-parse HEAD)"
echo "== date:            $(date -u +%Y-%m-%dT%H:%M:%SZ)"
{
  echo "date: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "HEAD: $(git -C "$REPO" rev-parse HEAD)"
  echo "producer commit: $PRODUCER_COMMIT"
  echo "GAP: $GAP"; "$GAP" -q -A -c 'Print(GAPInfo.Version, " ", GAPInfo.Architecture, "\n");' < /dev/null 2>&1 | head -1
  echo "Sage: $SAGE"; "$SAGE" -c 'print(version())' 2>&1 | head -1
  echo "python3: $PY"; "$PY" --version 2>&1
  echo "uname: $(uname -a)"
} > logs/environment.txt
cat logs/environment.txt

echo "== extracting producer commit into build/producer"
rm -rf build/producer && mkdir -p build/producer
git -C "$REPO" archive "$PRODUCER_COMMIT" research/petcox-facet-extensions | tar -x -C build/producer || { echo "ERROR: git archive failed"; exit 2; }
export PETCOX_DATA="$AUDIT/build/producer/research/petcox-facet-extensions/logs/alpha-survivors.g"
export PETCOX_PRODUCER="$AUDIT/build/producer/research/petcox-facet-extensions"
export PETCOX_AUDIT="$AUDIT"
export M2_DATA="$PETCOX_DATA"
export M2_AUDIT="$AUDIT"
shasum -a 256 "$PETCOX_DATA" | tee logs/producer-data.sha256
grep -c '^Add(PX.Saved' "$PETCOX_DATA" | sed 's/^/records in alpha-survivors.g: /'

run_gap() {   # $1 script name in scripts/, $2 transcript name
  echo "--- GAP  scripts/$1 -> logs/$2"
  ( cd scripts && "$GAP" -q -A --quitonbreak "$1" < /dev/null 2>&1 | sed 's/\x1b\[[0-9;]*m//g' > "../logs/$2" ) || { echo "ERROR: GAP exited non-zero in $1"; status=1; }
  grep -q "^Done: $1" "logs/$2" || { echo "ERROR: logs/$2 lacks its Done sentinel"; status=1; }
  grep -q -E "^(Error|Syntax error)" "logs/$2" && { echo "ERROR: GAP error in logs/$2"; grep -n -E "^(Error|Syntax error)" "logs/$2" | head; status=1; }
  grep -q "^FAIL" "logs/$2" && { echo "ERROR: FAIL lines in logs/$2"; grep -n "^FAIL" "logs/$2" | head; status=1; }
}
run_cmd() {   # $1 transcript name, $2 sentinel, rest = command (run inside scripts/)
  local log=$1 sentinel=$2; shift 2
  echo "--- $* -> logs/$log"
  ( cd scripts && "$@" 2>&1 > "../logs/$log" ) || { echo "ERROR: non-zero exit: $*"; status=1; }
  grep -q "^Done: $sentinel" "logs/$log" || { echo "ERROR: logs/$log lacks its Done sentinel"; status=1; }
}

run_gap author-check-antiautomorphism.g author-check-antiautomorphism.log
run_gap method1-flag-search.g            method1-flag-search.log
run_cmd method2-canonical.log            method2-canonical.sage        "$SAGE" method2-canonical.sage
run_gap method2-verify-certificates.g   method2-verify-certificates.log
rm -f scripts/method2-canonical.sage.py   # transient file created by the sage runner
run_gap method3-anti-automorphism.g      method3-anti-automorphism.log
run_cmd method4-verify-certificates.log  method4-verify-certificates.py "$PY" method4-verify-certificates.py
run_cmd extract-previous-audit-certificates.log extract-previous-audit-certificates.py "$PY" extract-previous-audit-certificates.py
run_gap previous-audit-check.g           previous-audit-check.log
run_cmd make-table.log                   make-table.py                  "$PY" make-table.py
run_cmd make-certificates.log            make-certificates.py           "$PY" make-certificates.py

echo "== git status (must show only this audit directory and the pre-existing untracked zoom-5-sept.md)"
git -C "$REPO" status --porcelain=v1 | tee logs/final-git-status.txt
if git -C "$REPO" status --porcelain=v1 | grep -v -E '^\?\? (zoom-5-sept\.md|research/petcox-facet-extensions/audits/fable-ultra-equivalence/)$' | grep -q .; then
  echo "ERROR: a pre-existing file changed or an unexpected path appeared"; status=1
else
  echo "OK: no pre-existing file changed"
fi

scripts/make-manifest.sh
if [ $status -eq 0 ]; then echo "run-all.sh: ALL STEPS COMPLETED."; else echo "run-all.sh: FAILURES (see above)."; fi
exit $status
