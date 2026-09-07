#!/usr/bin/env bash
# verify.sh -- rerun every decisive computation of research/petcox-facet-extensions
# and exit non-zero on any failure.
#
# Usage:  ./verify.sh                 (from any directory)
#         GAP=/path/to/gap ./verify.sh
#
# GAP is located via $GAP, then `gap` on PATH (shell aliases are ignored), then
# the SageMath 10.7 bundle of the development machine, then `sage -gap`.
# Only core GAP (started with -A) is needed.  Runtime is about 35-50 minutes,
# dominated by parent-search.g (exhaustive searches in groups of order up to
# 14400), alpha-complete.g (the exact Level 3 solution) and compare.g.
#
# Exit status 0 only if every GAP run exits 0, no transcript contains an
# "Error" or "Syntax error" line, every transcript ends with its "Done:"
# sentinel, and no "FAIL" line appears in any transcript.  GAP's "Syntax
# warning: Unbound global variable" lines are counted and reported but are not
# failures (they are emitted for top-level loop variables that are assigned
# later in the same file).

set -uo pipefail
cd "$(dirname "$0")"

if [ -n "${GAP:-}" ]; then
  GAPCMD=("$GAP")
elif command -v gap >/dev/null 2>&1; then
  GAPCMD=("$(command -v gap)")
elif [ -x /private/var/tmp/sage-10.7-current/local/bin/gap ]; then
  GAPCMD=(/private/var/tmp/sage-10.7-current/local/bin/gap)
elif command -v sage >/dev/null 2>&1; then
  GAPCMD=("$(command -v sage)" -gap)
else
  echo "ERROR: GAP not found. Set GAP=/path/to/gap." >&2
  exit 2
fi
GAPOPTS=(-q -A --quitonbreak)
mkdir -p logs
strip_ansi() { sed 's/\x1b\[[0-9;]*m//g'; }

echo "Using GAP: ${GAPCMD[*]}"
{
  echo "GAP command: ${GAPCMD[*]} ${GAPOPTS[*]}"
  echo "date: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  "${GAPCMD[@]}" -q -A <<'GAPEOF' 2>&1 | strip_ansi
Print("GAP version: ", GAPInfo.Version, "\n");
Print("GAP architecture: ", GAPInfo.Architecture, "\n");
Print("Loaded packages (with -A):\n");
for n in Set(RecNames(GAPInfo.PackagesLoaded)) do
  Print("  ", n, " ", GAPInfo.PackagesLoaded.(n)[2], "\n");
od;
QUIT;
GAPEOF
} > logs/environment.txt
cat logs/environment.txt

status=0
run_one() {  # $1 = script (in gap/), $2 = transcript name
  echo "--- running gap/$1 -> logs/$2"
  if ( cd gap && "${GAPCMD[@]}" "${GAPOPTS[@]}" "$1" < /dev/null 2>&1 | strip_ansi > "../logs/$2" ); then
    :
  else
    echo "ERROR: GAP exited with non-zero status while running $1" >&2
    status=1
  fi
  if ! grep -q "^Done: $1" "logs/$2"; then
    echo "ERROR: logs/$2 lacks its 'Done: $1' sentinel (truncated or failed run)" >&2
    status=1
  fi
  if grep -q -E "^(Error|Syntax error)" "logs/$2"; then
    echo "ERROR: GAP error in logs/$2" >&2; grep -n -E "^(Error|Syntax error)" "logs/$2" >&2
    status=1
  fi
  if grep -q "^FAIL" "logs/$2"; then
    echo "ERROR: failed checks in logs/$2:" >&2; grep -n "^FAIL" "logs/$2" >&2
    status=1
  fi
  local w
  w=$(grep -c "^Syntax warning" "logs/$2" || true)
  grep -E "^[a-z0-9-]+\.g: [0-9]+ passed" "logs/$2" | sed "s/\$/  (syntax warnings: ${w:-0})/" || true
}

# Order matters: parent-search.g and alpha-complete.g write the survivor files
# that compare.g reads.
run_one canonical.g          canonical.log
run_one alpha-locus.g        alpha-locus.log
run_one census-audit.g       census-audit.log
run_one controls.g           controls.log
run_one alpha-complete.g     alpha-complete.log
run_one roli-alpha-infinity.g roli-alpha-infinity.log
run_one parent-search.g      parent-search.log
run_one compare.g            compare.log
run_one summary.g            summary.log
run_one conder-check.g       conder-check.log
run_one chirality-group.g    chirality-group.log

# final classification table (python3 is only needed for this presentation step)
if command -v python3 >/dev/null 2>&1; then
  python3 make-candidate-table.py || { echo "ERROR: make-candidate-table.py failed" >&2; status=1; }
else
  echo "WARNING: python3 not found; candidate-table.tsv not regenerated" >&2
fi

total_pass=$(grep -h "^PASS" logs/*.log | wc -l | tr -d ' ')
total_fail=$(grep -h "^FAIL" logs/*.log | wc -l | tr -d ' ')
total_warn=$(grep -h "^Syntax warning" logs/*.log | wc -l | tr -d ' ')
echo
echo "verify.sh: $total_pass PASS lines, $total_fail FAIL lines, $total_warn GAP syntax warnings (harmless)."
if [ $status -eq 0 ]; then echo "verify.sh: ALL RUNS COMPLETED, ALL CHECKS PASSED."; else echo "verify.sh: FAILURES (see above)."; fi
exit $status
