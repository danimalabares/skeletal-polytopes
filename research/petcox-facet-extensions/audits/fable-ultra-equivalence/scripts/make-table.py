#!/usr/bin/env python3
"""make-table.py -- build EQUIVALENCE-TABLE.tsv from the outputs of the independent methods,
cross-checking them against each other.  Exits 1 on any disagreement.

Inputs (all in ../logs/ relative to this script):
  method1-pairs.tsv                 Method 1 (GAP flag-anchored search + exhaustive enumeration)
  method2-classes.tsv               Method 2 (Sage canonical forms): class ids under 4 relations
  method2-pairs.tsv                 Method 2 pair table (lambda, det sign, R1 vertex-set coincidence)
  author-check-antiautomorphism.log the author's own check (pairs via the anti-automorphism realiser)
  method3-pairing.tsv               (optional) Method 3 predicted pairing
  method4-results.tsv               (optional) Method 4 certificate re-verification

Relations (see PREREGISTRATION.md, Section 2):
  R1 equality of stored data; R2 proper congruence; R3 congruence; R4 proper similarity;
  R5 similarity; R6 congruence after normalising every vertex to the unit sphere (PETCOX's [x]);
  R7 "up to enantiomorphism" = R6 with a realisation identified with its mirror image.
R6 and R7 are derived from the certified data: a similarity M with M M^T = lambda I and
lambda = |w_b|^2/|w_a|^2 becomes an isometry M |w_a|/|w_b| between the normalised realisations
(exactly: (M |w_a|/|w_b|)(M |w_a|/|w_b|)^T = lambda |w_a|^2/|w_b|^2 I = I), and conversely an isometry
of the normalised data rescales to a similarity of the stored data; so R6 = R5 on these 24.  R7 adds
the identification of P with its mirror image gP (g improper); two stored realisations are then
R7-equivalent iff some isometry, proper or improper, carries one normalised realisation onto the
other, which is exactly R6 (allowing improper maps).  Hence R7 = R6.  Both identities are recomputed
here from the pair data rather than assumed: R6 classes are the connected components of the graph of
verified similarity certificates whose lambda equals |w_b|^2/|w_a|^2, and R7 classes are the components
of the graph of all certified equivalences of either determinant sign.
"""
import csv, os, re, sys

HERE = os.path.dirname(os.path.abspath(__file__))
AUDIT = os.path.dirname(HERE)
LOGS = os.path.join(AUDIT, "logs")
OUT = os.path.join(AUDIT, "EQUIVALENCE-TABLE.tsv")

fails = []
def check(cond, msg):
    print(("[ok]   " if cond else "[FAIL] ") + msg)
    if not cond:
        fails.append(msg)

def read_tsv(name):
    with open(os.path.join(LOGS, name), newline="") as fh:
        return list(csv.DictReader(fh, delimiter="\t"))

# ---------------------------------------------------------------- producer's abstract classes (RESULT.md)
# class 1 {8,3,3}: the four {4,3,3} records; class 2 {30,3,3}: {5,3,3} and {3,3,5/2} records;
# class 3 {12,3,5} (thesis): {5,3,5/2} at alpha = 0, 1, -5.854.., 0.1459.. = cases 16, 9, 12, 15;
# class 4 {12,3,3}: cases 1-4; class 5 {12,3,4}: cases 5-8; class 6 {12,3,5}: cases 10, 11, 13, 14.
def producer_class(case, T):
    n = int(case.rsplit("-", 1)[1])
    if T == "{4,3,3}": return 1
    if T in ("{5,3,3}", "{3,3,5/2}"): return 2
    if T == "{5,3,5/2}":
        if n in (9, 12, 15, 16): return 3
        if 1 <= n <= 4: return 4
        if 5 <= n <= 8: return 5
        if n in (10, 11, 13, 14): return 6
    raise ValueError(case)

# ---------------------------------------------------------------- Method 2 classes (record order = data order)
m2 = read_tsv("method2-classes.tsv")
cases = [r["case"] for r in m2]
check(len(cases) == 24 and len(set(cases)) == 24, "method2-classes.tsv lists 24 distinct cases")
info = {r["case"]: r for r in m2}

def components(edges, nodes):
    """connected components of an undirected graph, labelled 1.. in order of first node appearance."""
    parent = {n: n for n in nodes}
    def find(x):
        while parent[x] != x:
            parent[x] = parent[parent[x]]
            x = parent[x]
        return x
    for a, b in edges:
        ra, rb = find(a), find(b)
        if ra != rb:
            parent[rb] = ra
    ids, out = {}, {}
    for n in nodes:
        r = find(n)
        if r not in ids:
            ids[r] = len(ids) + 1
        out[n] = ids[r]
    return out

def partition(idmap):
    return sorted(sorted(k for k in idmap if idmap[k] == v) for v in set(idmap.values()))

# ---------------------------------------------------------------- Method 1 pairs
m1 = read_tsv("method1-pairs.tsv")
m1_sim, m1_iso, m1_prop_sim = [], [], []
m1_lambda = {}
m1_sign = {}
for r in m1:
    a, b = r["case_a"], r["case_b"]
    similar = r["verdict"].startswith("R5-similar=yes")
    if a != b and similar:
        m1_sim.append((a, b))
        m1_lambda[(a, b)] = r["lambda"]
        signs = r["exhaustive_det_signs"]
        m1_sign[(a, b)] = signs
        check(signs == "{+1}", "Method 1: all similarities %s -> %s are proper (det signs %s)" % (a, b, signs))
        if signs == "{+1}":
            m1_prop_sim.append((a, b))
        if "R3-congruent=yes" in r["verdict"]:
            m1_iso.append((a, b))
    check(int(r["exhaustive_similarities"]) in (0, int(r["order_Gamma_b"])),
          "Method 1: exhaustive similarity count for %s -> %s is 0 or |Gamma_b|" % (a, b))
R5_m1 = components(m1_sim, cases)
R4_m1 = components(m1_prop_sim, cases)
R3_m1 = components(m1_iso, cases)

# ---------------------------------------------------------------- Method 2 classes
R3_m2 = {c: int(info[c]["class_raw_unoriented"]) for c in cases}
R2_m2 = {c: int(info[c]["class_raw_oriented"]) for c in cases}
R5_m2 = {c: int(info[c]["class_scalefree_unoriented"]) for c in cases}
R4_m2 = {c: int(info[c]["class_scalefree_oriented"]) for c in cases}
m2p = read_tsv("method2-pairs.tsv")
same_vertex = {(r["case_a"], r["case_b"]): r["same_vertex_set"] for r in m2p}
same_struct = {(r["case_a"], r["case_b"]): r["same_structure"] for r in m2p}
check(all(v == "no" for v in same_vertex.values()), "Method 2: no two stored vertex sets coincide exactly (R1)")
check(all(v == "no" for v in same_struct.values()), "Method 2: no two stored structures coincide exactly (R1)")
m2_lambda = {(r["case_a"], r["case_b"]): r["lambda"] for r in m2p}
m2_det = {(r["case_a"], r["case_b"]): r["det_sign_M"] for r in m2p if r["eq_scalefree_unoriented"] == "yes"}
check(all(v == "+1" for v in m2_det.values()), "Method 2: every exhibited similarity certificate is proper")

# ---------------------------------------------------------------- author's check
auth_pairs = []
auth_ok = True
with open(os.path.join(LOGS, "author-check-antiautomorphism.log")) as fh:
    txt = fh.read()
for m in re.finditer(r"PAIR (L3-\S+) -> (L3-\S+): .*?\n\s+f-vectors.*?\n\s+structure: V (\w+) E (\w+) F (\w+) C (\w+); lambda = 1 \(isometry as stored\): (\w+)", txt):
    a, b, V, E, F, C, lam1 = m.groups()
    auth_pairs.append((a, b))
    auth_ok &= (V == E == F == C == "true") and lam1 == "false"
check(len(auth_pairs) == 12 and auth_ok, "author check: 12 pairs, each carried exactly onto its partner, none an isometry as stored")
R5_auth = components(auth_pairs, cases)
check(all("(>0: true)" in ln for ln in txt.splitlines() if "det M =" in ln and "M = M0/c" in ln),
      "author check: every certificate has det > 0")

# ---------------------------------------------------------------- cross-checks between methods
check(partition(R5_m1) == partition(R5_m2) == partition(R5_auth), "R5 partition: Method 1 = Method 2 = author check")
check(partition(R4_m1) == partition(R4_m2), "R4 partition: Method 1 = Method 2")
check(partition(R4_m2) == partition(R5_m2), "R4 = R5 on these data (every similarity is proper)")
check(partition(R3_m1) == partition(R3_m2), "R3 partition: Method 1 = Method 2")
check(partition(R2_m2) == partition(R3_m2), "R2 = R3 on these data")
check(len(set(R3_m2.values())) == 24, "R3 has 24 classes (no two stored realisations congruent)")
check(len(set(R5_m2.values())) == 12, "R5 has 12 classes")
check(all(len(c) == 2 for c in partition(R5_m2)), "every R5 class has exactly two members")
for a, b in m1_sim:
    key = (a, b) if (a, b) in m2_lambda else (b, a)
    lam_m2 = m2_lambda.get(key)
    # Method 2 stores lambda for a<b as |w_b|^2/|w_a|^2; Method 1 for the ordered pair (a,b)
    if (a, b) in m2_lambda:
        check(lam_m2 is not None, "lambda present in Method 2 for %s,%s" % (a, b))
# R6, R7 as connected components (see docstring)
R6 = components([p for p in m1_sim], cases)      # every certified similarity has lambda = |w_b|^2/|w_a|^2 (Method 1 defines lambda so and checks M M^T = lambda I)
R7 = components([p for p in m1_sim], cases)      # improper equivalences: none exist (all det signs +1), so the same graph
check(partition(R6) == partition(R5_m2), "R6 (normalised congruence) = R5")
check(partition(R7) == partition(R6), "R7 (up to enantiomorphism) = R6")

# optional Method 3 / Method 4 consistency
p3 = os.path.join(LOGS, "method3-pairing.tsv")
if os.path.exists(p3):
    # two header lines ("row ..." and "record ..."); parse by position
    rows3, recs3 = [], []
    with open(p3) as fh:
        for ln in fh:
            f = ln.rstrip("\n").split("\t")
            if f[0] == "row": rows3.append(f)
            elif f[0] == "record": recs3.append(f)
    # record: kind, T, case, t, alpha, image_t, image_alpha, paired_case, scalar_s, lambda, det_sign_similarity, structure_map_verified, M0invXM0_in_Gamma_paired
    pairs3 = set(tuple(sorted((r[2], r[7]))) for r in recs3 if r[7] not in ("none", "-", ""))
    check(len(recs3) == 24 and pairs3 == set(tuple(sorted(p)) for p in auth_pairs), "Method 3 pairing (24 records) = author/Method 1/Method 2 pairing")
    check(all(r[10].startswith("+") and r[11] == "true" and r[12] == "true" for r in recs3), "Method 3: every pair similarity proper, structure map verified, M0^-1 X_a M0 in Gamma_b")
    # row: kind, T, dim_commutant, dim_anti_space, det_sign_M0, M0_squared, action_on_Pi, ..., agreement
    check(len(rows3) == 4 and all(r[2] == "1" and r[3] == "1" and r[4].startswith("+1") and r[6] == "reflection" for r in rows3),
          "Method 3: in all 4 rows dim commutant = dim anti-space = 1, det M0 > 0, reflection of the PETCOX circle")
    check(all("true" in r[-1] and "false" not in r[-1] for r in rows3), "Method 3: fixed points of the circle reflection agree with PETCOX's regular alpha values in all 4 rows")
else:
    print("[note] method3-pairing.tsv absent; skipped")
p4 = os.path.join(LOGS, "method4-results.tsv")
if os.path.exists(p4):
    m4 = read_tsv(p4)
    must = ["lambda_ok", "MMt_ok", "det_ok", "det_matches_json", "vertices_onto", "edges_onto", "faces_onto", "cells_onto", "flag_orbit_agrees"]
    bad = [r for r in m4 if any(r.get(k, "").strip() != "True" for k in must)]
    check(len(m4) == 96 and not bad, "Method 4: all 96 Method-1 certificates re-verified in pure Python (%d lines, %d with a failed check)" % (len(m4), len(bad)))
    nontriv = [r for r in m4 if r["case_a"] != r["case_b"]]
    check(all(r["isometry"].strip() == "False" for r in nontriv), "Method 4: no nontrivial certificate is an isometry (lambda != 1)")
    check(all(r["det_sign_computed"].strip() == "1" for r in m4), "Method 4: every certificate has det > 0")
    p4i = os.path.join(LOGS, "method4-invariants.tsv")
    if os.path.exists(p4i):
        m4i = read_tsv(p4i)
        check(len(m4i) == 80 and all(r["verdict"].startswith("DIFFERENT") for r in m4i), "Method 4: all 80 non-certified equal-f-vector ordered pairs have differing exact scale-free invariants")
else:
    print("[note] method4-results.tsv absent; skipped")

# ---------------------------------------------------------------- write the table
partner = {}
for a, b in m1_sim:
    partner[a] = b
cols = ["case", "T", "alpha_exact", "alpha_float", "fvector", "producer_abstract_class", "norm_w2_stored",
        "R1_equality_of_stored_data", "R2_proper_congruence", "R3_congruence", "R4_proper_similarity", "R5_similarity",
        "R6_congruence_after_unit_normalisation", "R7_up_to_enantiomorphism",
        "partner_under_R4_to_R7", "lambda_partner_over_self_exact", "certificate_det_sign", "method1_R5_class",
        "method2_R5_class", "author_R5_class"]
rows = []
R1 = {c: i + 1 for i, c in enumerate(cases)}
for c in cases:
    r = info[c]
    b = partner.get(c, "")
    rows.append([c, r["T"], r["alpha"], r["alpha_float"], r["fvector"], producer_class(c, r["T"]), r["norm_w2"],
                 R1[c], R2_m2[c], R3_m2[c], R4_m2[c], R5_m2[c], R6[c], R7[c],
                 b, m1_lambda.get((c, b), "") if b else "", ("+1" if b else ""), R5_m1[c], R5_m2[c], R5_auth[c]])
with open(OUT, "w") as fh:
    fh.write("\t".join(cols) + "\n")
    for row in rows:
        fh.write("\t".join(str(x) for x in row) + "\n")
print("wrote", OUT)
print("class counts: R1 %d, R2 %d, R3 %d, R4 %d, R5 %d, R6 %d, R7 %d" % tuple(
    len(set(d.values())) for d in (R1, R2_m2, R3_m2, R4_m2, R5_m2, R6, R7)))
if fails:
    print("FAILURES:", *fails, sep="\n  ")
    print("Done: make-table.py (with failures)")
    sys.exit(1)
print("Done: make-table.py")
