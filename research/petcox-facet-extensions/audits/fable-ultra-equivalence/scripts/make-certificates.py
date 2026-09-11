#!/usr/bin/env python3
"""make-certificates.py -- assemble CERTIFICATES.md from the machine-generated certificate files.

Inputs (../logs/): method1-certificates.json, method1-pairs.tsv, method2-certificates.json,
method2-pairs.tsv, method2-classes.tsv, author-check-antiautomorphism.log, and optionally
method3-pairing.tsv / method4-results.tsv.  Output: ../CERTIFICATES.md.  Exits 1 if the three
independent certificate sources disagree on any pair.
"""
import csv, json, os, re, sys

HERE = os.path.dirname(os.path.abspath(__file__))
AUDIT = os.path.dirname(HERE)
LOGS = os.path.join(AUDIT, "logs")
OUT = os.path.join(AUDIT, "CERTIFICATES.md")
fails = []
def check(cond, msg):
    print(("[ok]   " if cond else "[FAIL] ") + msg)
    if not cond:
        fails.append(msg)

def tsv(name):
    with open(os.path.join(LOGS, name), newline="") as fh:
        return list(csv.DictReader(fh, delimiter="\t"))

m1c = json.load(open(os.path.join(LOGS, "method1-certificates.json")))
m1p = tsv("method1-pairs.tsv")
m2 = json.load(open(os.path.join(LOGS, "method2-certificates.json")))
m2c = m2["certificates"]
m2p = tsv("method2-pairs.tsv")
cls = {r["case"]: r for r in tsv("method2-classes.tsv")}
order = [r["case"] for r in tsv("method2-classes.tsv")]
auth = open(os.path.join(LOGS, "author-check-antiautomorphism.log")).read()

# author-check certificates: "PAIR a -> b: w_a M0 = c w_b with c = C exactly: true" followed by lambda/det lines
auth_pairs = {}
for m in re.finditer(r"PAIR (L3-\S+) -> (L3-\S+): w_a M0 = c w_b with c = (.*?) exactly: (\w+)\n\s+f-vectors (\[[^\]]*\]) (\[[^\]]*\]); M = M0/c: M M\^T = lambda I with lambda = (.*?) \(= \|w_b\|\^2/\|w_a\|\^2: (\w+)\), det M = (.*?) \(>0: (\w+)\)\n\s+structure: V (\w+) E (\w+) F (\w+) C (\w+); lambda = 1 \(isometry as stored\): (\w+)", auth):
    a, b, c, cexact, fva, fvb, lam, lamok, det, detpos, V, E, F, C, lam1 = m.groups()
    auth_pairs[frozenset((a, b))] = dict(a=a, b=b, c=c, cexact=cexact, lam=lam, lamok=lamok, det=det, detpos=detpos,
                                          V=V, E=E, F=F, C=C, lam1=lam1)
m0s = dict(re.findall(r"########## row (\S+) ##########\n.*?\nM0 = (\[.*?\])\n", auth, re.S))

# Method 1: coset-representing nontrivial certificates, keyed by unordered pair, keep both directions
m1_by_pair = {}
for c in m1c:
    if c["case_a"] != c["case_b"] and c.get("represents_own_coset"):
        m1_by_pair.setdefault(frozenset((c["case_a"], c["case_b"])), []).append(c)
m2_by_pair = {frozenset((c["case_a"], c["case_b"])): c for c in m2c}
pairs = sorted(m2_by_pair, key=lambda p: min(order.index(x) for x in p))
check(set(m1_by_pair) == set(m2_by_pair) == set(auth_pairs), "the three certificate sources certify the same 12 pairs")
check(len(pairs) == 12, "12 certified pairs")

m4 = None
p4 = os.path.join(LOGS, "method4-results.tsv")
if os.path.exists(p4):
    m4 = tsv(p4)

def mat_md(M):
    return "\n".join("    " + "  ".join("`%s`" % x for x in row) for row in M)

L = []
L.append("# Certificates\n")
L.append("All matrices act on row vectors from the right (`x -> x*M`, GAP convention); `E(n) = exp(2 pi i/n)`.  "
         "Every equation below was verified **exactly** in cyclotomic arithmetic by at least three independent programs "
         "(Method 1 in GAP, Method 2 in Sage `CyclotomicField(40)`, the author's GAP check; Method 4 re-verifies Method 1's "
         "matrices in a from-scratch `Q(zeta_40)` implementation over Python `Fraction`s).  Nothing is numerical; the "
         "decimal values are for orientation only.\n")
L.append("## How to read a similarity certificate\n")
L.append("A certificate for the ordered pair `a -> b` is a `4 x 4` matrix `M` with\n\n"
         "* `M M^T = lambda I` exactly, where `lambda = |w_b|^2 / |w_a|^2` is the ratio of the squared norms of the stored base vertices (all vertices of one realisation have the same norm);\n"
         "* `det M = + lambda^2` exactly (so `M` is a **proper** similarity: `M = c Q` with `c = sqrt(lambda) > 0`, `Q in SO(4)`; the translation part is `b = 0` because both vertex sets have centroid `0`);\n"
         "* `x -> x M` maps the stored vertex set of `a` **onto** that of `b`, the edge set onto the edge set, the set of 2-faces onto the set of 2-faces and the set of cells onto the set of cells (each face as the set of its vertices/edges);\n"
         "* `M^-1 {S1, S2, X_a} M` lies in `Gamma_b` and `M {S1, S2, X_b} M^-1` lies in `Gamma_a`, so `M` conjugates the distinguished group `Gamma_a` onto `Gamma_b`; the conjugated triple `(M^-1 S1 M, M^-1 S2 M, M^-1 X_a M)` is `Gamma_b`-conjugate to the **mirror triple** `(S1^-1, S1^2 S2, X_b)`, i.e. the base flag of `a` is carried to an odd flag of `b` (Method 1, exact).\n\n"
         "Consequences.  (i) As **stored**, `a` and `b` are similar with ratio `c = sqrt(lambda) != 1`; they are **not** congruent.  "
         "(ii) After the PETCOX normalisation `w -> w/|w|` (every vertex on the unit sphere `S^3`), the matrix `M' = M |w_a|/|w_b|` satisfies "
         "`M' M'^T = lambda |w_a|^2/|w_b|^2 I = I` exactly, so the normalised realisations are **properly congruent**: same handedness, "
         "not mirror images.  (iii) The pair of stored *generating triples* `(S1,S2,X_a)` and `(S1,S2,X_b)` are enantiomorphic labellings of one and the same geometric polytope.\n")
L.append("## The twelve similarity certificates\n")
for k, p in enumerate(pairs, 1):
    m2cert = m2_by_pair[p]
    a, b = m2cert["case_a"], m2cert["case_b"]
    ap = auth_pairs[p]
    m1s = m1_by_pair[p]
    m1ab = [c for c in m1s if c["case_a"] == a and c["case_b"] == b]
    m1ab = m1ab[0] if m1ab else m1s[0]
    ra, rb = cls[a], cls[b]
    L.append("### %d. `%s`  (alpha = %s)  ~  `%s`  (alpha = %s)\n" % (k, a, ra["alpha"], b, rb["alpha"]))
    L.append("* row `T = %s`, f-vector `%s`, `|Gamma| = %s`; stored `|w_a|^2 = %s` (~%s), `|w_b|^2 = %s` (~%s)." %
             (ra["T"], ra["fvector"], ra["gamma_order"], ra["norm_w2"], ra["norm_w2_float"], rb["norm_w2"], rb["norm_w2_float"]))
    L.append("* **Method 1 certificate** (`%s -> %s`, flag-anchored `%s` candidate, hits the intended flag of `b`): `lambda = %s` (~%s), `det M = %s` (`= +lambda^2`, sign %+d), conjugated triple orientation: `%s`.\n\n    M =\n%s\n" %
             (m1ab["case_a"], m1ab["case_b"], m1ab["candidate"], m1ab["lambda"], m2cert["lambda_float"] if m1ab["case_a"] == a else "1/(%s)" % m2cert["lambda_float"],
              m1ab["det"], m1ab["det_sign"], m1ab["triple_orientation"], mat_md(m1ab["M"])))
    chk = m1ab["checks"]
    L.append("    exact checks: traversal %s, `M M^T = lambda I` %s, `det = +-lambda^2` %s, vertices %s, edges %s, 2-faces %s, cells %s, "
             "`M^-1 S1 M, M^-1 S2 M, M^-1 X_a M in Gamma_b` %s/%s/%s, `M S1 M^-1, M S2 M^-1, M X_b M^-1 in Gamma_a` %s/%s/%s.\n" %
             (chk["traversal"], chk["MMt_eq_lambda_I"], chk["det_eq_pm_lambda2"], chk["vertices"], chk["edges"], chk["faces"], chk["cells"],
              chk["conj_S1a_in_Gamma_b"], chk["conj_S2a_in_Gamma_b"], chk["conj_Xa_in_Gamma_b"],
              chk["conj_S1b_in_Gamma_a"], chk["conj_S2b_in_Gamma_a"], chk["conj_Xb_in_Gamma_a"]))
    c2 = m2cert["checks"]
    L.append("* **Method 2 certificate** (`%s -> %s`, `M = B_a^-1 B_b` from the canonical minimising bases; independent Sage arithmetic): `lambda = %s` (~%.6f), `det M = %s`, sign %+d; checks `M M^T = lambda I` %s, `det = sign lambda^2` %s, vertices %s, edges %s, faces %s, cells %s; exhaustive count of similarities fixing `w_a -> w_b`: %s (det signs `%s`).\n\n    M =\n%s\n" %
             (m2cert["case_a"], m2cert["case_b"], m2cert["lambda_gap"], m2cert["lambda_float"], m2cert["det_M_gap"], m2cert["det_sign"],
              c2["MMt_eq_lambdaI"], c2["det_eq_sign_lambda2"], c2["vertices_mapped"], c2["edges_mapped"], c2["faces_mapped"], c2["cells_mapped"],
              m2cert["exhaustive_n_similarities_fixing_w"], m2cert["exhaustive_det_signs"], mat_md(m2cert["M_gap"])))
    L.append("* **Author's check** (`%s -> %s`): `M = M0 / c` with `M0` the anti-automorphism realiser of the row (below) and `c = %s` (exact: `w_a M0 = c w_b` is %s); `lambda = %s` (`= |w_b|^2/|w_a|^2`: %s), `det M = %s` (`> 0`: %s); structure carried onto `b`: vertices %s, edges %s, 2-faces %s, cells %s; `lambda = 1` (isometry as stored): **%s**.\n" %
             (ap["a"], ap["b"], ap["c"], ap["cexact"], ap["lam"], ap["lamok"], ap["det"], ap["detpos"], ap["V"], ap["E"], ap["F"], ap["C"], ap["lam1"]))
    if m4 is not None:
        rows = [r for r in m4 if {r.get("case_a"), r.get("case_b")} == {a, b}]
        if rows:
            L.append("* **Method 4 re-verification** (pure Python `Q(zeta_40)`): %d certificate line(s) for this pair, fields: %s\n" %
                     (len(rows), "; ".join(", ".join("%s=%s" % (kk, vv) for kk, vv in r.items() if kk not in ("M",)) for r in rows[:2])))
L.append("## The anti-automorphism realisers `M0` (author's check)\n")
L.append("For each row `T`, `M0` spans the one-dimensional space of matrices with `M0 S1 = S1^-1 M0` and `M0 S2 = S2^-1 M0`; "
         "`M0 M0^T = mu I`, `M0^2 = mu I`, `det M0 = +mu^2`, so `M0/sqrt(mu)` is a half-turn about a 2-plane (proper).  "
         "Its restriction to the PETCOX circle `Pi = Fix(S2)` is a reflection whose fixed points are exactly the geometrically regular "
         "values of alpha printed in PETCOX Section 4.\n")
for T, M0 in m0s.items():
    L.append("* row `%s`: `M0 = %s`" % (T, M0))
L.append("")
L.append("## Non-equivalence certificates\n")
L.append("* **Different f-vector** (448 ordered pairs, i.e. 224 unordered): trivially inequivalent under every relation.\n")
L.append("* **Equal f-vector, not similar** (40 unordered pairs): Method 1 enumerated **all** ordered 4-tuples of vertices of `b` whose exact Gram matrix equals `lambda` times that of the anchor `(w_a, w_a S1, w_a S1^2, w_a S1^3)` and found that **none** of them induces a structure map (`exhaustive_similarities = 0`), which exhausts every similarity `a -> b`; Method 2 found **zero** Gram-compatible neighbour triples at `w_b` (and distinct canonical forms), independently.  These 40 pairs are listed in `logs/method1-pairs.tsv` (verdict `R5-similar=no`) and `logs/method2-pairs.tsv` (`eq_scalefree_unoriented = no`, `n_gram_compatible = 0`).  They include the 4 cross-row pairs `{5,3,3}` vs `{3,3,5/2}` (same f-vector `(600,1200,120,5)`, same `|Gamma| = 7200`) and, inside each abstract class of four, the four pairs other than the two certified ones.\n")
L.append("* **Not congruent as stored** (all 276 unordered pairs): for the 12 similar pairs `lambda != 1` exactly (Methods 1, 2 and the author's check); for the rest, not even similar.  Hence 24 congruence classes.\n")
L.append("* **No improper equivalences anywhere**: every similarity found by the exhaustive enumerations has `det > 0` (Method 1: det-sign set `{+1}` for all 48 similar ordered pairs including `a = b`; Method 2: `sim_det_signs = +`).  In particular every one of the 24 realisations is geometrically chiral (its full similarity group is `Gamma`, of order `|Gamma|`, with no improper element), and no stored realisation is the mirror image of another.\n")
nonsim = [r for r in m1p if r["case_a"] != r["case_b"] and r["verdict"].startswith("R5-similar=no")]
L.append("### The 40 non-similar equal-f-vector pairs (unordered), with Method 1's exhaustive tuple counts\n")
L.append("| a | b | f-vector | Gram-consistent 4-tuples enumerated | similarities found | Method 2 Gram-compatible triples |")
L.append("|---|---|---|---|---|---|")
seen = set()
m2look = {frozenset((r["case_a"], r["case_b"])): r for r in m2p}
for r in nonsim:
    key = frozenset((r["case_a"], r["case_b"]))
    if key in seen:
        continue
    seen.add(key)
    q = m2look.get(key, {})
    L.append("| `%s` | `%s` | `%s` | %s | %s | %s |" % (r["case_a"], r["case_b"], r["fvector"], r["exhaustive_tuples"], r["exhaustive_similarities"], q.get("n_gram_compatible", "?")))
check(len(seen) == 40, "40 non-similar unordered pairs with equal f-vector (found %d)" % len(seen))
with open(OUT, "w") as fh:
    fh.write("\n".join(L) + "\n")
print("wrote", OUT)
if fails:
    print("FAILURES:", fails)
    print("Done: make-certificates.py (with failures)")
    sys.exit(1)
print("Done: make-certificates.py")
