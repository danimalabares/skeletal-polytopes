#!/usr/bin/env python3
"""extract-previous-audit-certificates.py -- transcribe the twelve certificate matrices printed in the
previous audit's transcript (audits/fable-ultra/logs/audit-runs/congruence-certify.log, read-only) into
../logs/previous-audit-certificates.g for exact re-verification by previous-audit-check.g.
Exits 1 unless exactly 12 certificates are found."""
import os, re, sys
HERE = os.path.dirname(os.path.abspath(__file__))
AUDIT = os.path.dirname(HERE)
PREV = os.path.join(os.path.dirname(AUDIT), "fable-ultra", "logs", "audit-runs", "congruence-certify.log")
OUT = os.path.join(AUDIT, "logs", "previous-audit-certificates.g")
txt = open(PREV).read()
pat = re.compile(r"   (L3-\S+) vs (L3-\S+): CONGRUENT up to scale \((\d+) structure-preserving similarities found; det (.*?) ~ [^,]*, lambda = (.*?)\)\n\s+handedness: (\w+) similarity.*?\n.*?\n\s+certificate g \(rows\).*?\n((?:\s+\[.*?\]\n){4})", re.S)
recs = []
for m in pat.finditer(txt):
    a, b, n, det, lam, hand, rows = m.groups()
    rows = [r.strip() for r in rows.strip().splitlines()]
    recs.append((a, b, int(n), det, lam, hand, rows))
with open(OUT, "w") as fh:
    fh.write("# machine-transcribed by scripts/extract-previous-audit-certificates.py from\n# %s\n" % PREV)
    fh.write("# each record: case_a, case_b (the previous audit's convention w_a g = w_b, row vectors), its printed det, lambda, handedness, and the 4 rows of g\n")
    fh.write("PREV := [];\n")
    for a, b, n, det, lam, hand, rows in recs:
        fh.write('Add(PREV, rec(case_a := "%s", case_b := "%s", nsim := %d, det := %s, lambda := %s, handedness := "%s", g := [ %s ]));\n'
                 % (a, b, n, det, lam, hand, ", ".join(rows)))
print("source:", PREV)
print("extracted %d certificates -> %s" % (len(recs), OUT))
for r in recs:
    print("  %s -> %s  (%d similarities, lambda = %s, %s)" % (r[0], r[1], r[2], r[4], r[5]))
if len(recs) != 12:
    print("ERROR: expected 12 certificates"); print("Done: extract-previous-audit-certificates.py (with failures)"); sys.exit(1)
print("Done: extract-previous-audit-certificates.py")
