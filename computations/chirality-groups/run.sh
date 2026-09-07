#!/usr/bin/env bash
# Run all chirality-group computations and the verification, saving
# deterministic transcripts under results/.
#
# Usage:  ./run.sh            (from any directory)
#         GAP=/path/to/gap ./run.sh
#
# GAP is located as follows: the GAP environment variable, then `gap` on the
# PATH, then the GAP bundled with a SageMath installation (`sage -gap`).
# (A hard-coded fallback to the SageMath 10.7 location on the development
# machine, /private/var/tmp/sage-10.7-current/local/bin/gap, is tried before
# `sage -gap`; it is skipped when absent.)
# Note: in some shells `gap` is an alias (e.g. for `git apply`); aliases are
# not used by this script.  Only core GAP and the packages GAP always loads
# (gapdoc, primgrp, smallgrp, transgrp) are required; GAP is started with
# -A (no autoloading of further packages).
#
# Exit status: 0 only if all three GAP runs exit 0, every transcript is free
# of "Error"/"Syntax error"/"Syntax warning" lines, both compute transcripts
# end with their "Done:" sentinel, and verify.g prints "ALL CHECKS PASSED".
# (GAP exits 0 after a syntax error, which merely truncates the file being
# read; hence the explicit scan of the transcripts.)

set -euo pipefail
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

mkdir -p results
strip_ansi() { sed 's/\x1b\[[0-9;]*m//g'; }

echo "Using GAP: ${GAPCMD[*]}"
{
  echo "GAP command: ${GAPCMD[*]} ${GAPOPTS[*]}"
  "${GAPCMD[@]}" -q -A <<'GAPEOF' 2>&1 | strip_ansi
Print("GAP version: ", GAPInfo.Version, "\n");
Print("GAP architecture: ", GAPInfo.Architecture, "\n");
Print("Loaded packages (with -A):\n");
for n in Set(RecNames(GAPInfo.PackagesLoaded)) do
  Print("  ", n, " ", GAPInfo.PackagesLoaded.(n)[2], "\n");
od;
QUIT;
GAPEOF
} > results/environment.txt
cat results/environment.txt

status=0
run_one() {  # $1 = script, $2 = transcript name
  echo "--- running $1 -> results/$2"
  if "${GAPCMD[@]}" "${GAPOPTS[@]}" "$1" < /dev/null 2>&1 | strip_ansi > "results/$2"; then
    :
  else
    echo "ERROR: GAP exited with non-zero status while running $1" >&2
    status=1
  fi
}

run_one rolis-cube/compute.g        rolis-cube.transcript.txt
run_one 12-over-1-5-3-5/compute.g   12-over-1-5-3-5.transcript.txt
run_one verify.g                    verify.transcript.txt

echo
tail -n 4 results/verify.transcript.txt
if ! grep -q "ALL CHECKS PASSED" results/verify.transcript.txt; then
  echo "ERROR: verification did not pass" >&2
  status=1
fi
if grep -q -E "^(Error|Syntax error|Syntax warning)" results/*.transcript.txt; then
  echo "ERROR: a GAP error or syntax error/warning appears in a transcript" >&2
  grep -n -E "^(Error|Syntax error|Syntax warning)" results/*.transcript.txt >&2
  status=1
fi
if ! grep -q "^Done: Roli's cube\.$" results/rolis-cube.transcript.txt; then
  echo "ERROR: rolis-cube transcript is truncated (no Done sentinel)" >&2
  status=1
fi
if ! grep -q "^Done: {12/(1,5),3,5}\.$" results/12-over-1-5-3-5.transcript.txt; then
  echo "ERROR: 12-over-1-5-3-5 transcript is truncated (no Done sentinel)" >&2
  status=1
fi
if [ $status -eq 0 ]; then echo "run.sh: all runs completed, all checks passed."; fi
exit $status
