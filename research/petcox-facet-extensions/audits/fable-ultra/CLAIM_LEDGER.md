# Claim ledger — fresh-session Fable 5.1 audit of `research/petcox-facet-extensions` @ `71ef1cda7ca927b090068c796bfdcc10ca097a2c`

Status vocabulary required by the task: **verified** / **verified only under additional
hypotheses** / **not verified** / **contradicted**.  Mapping to the
`mathematical-paper-audit` vocabulary: verified = `established` with `supporting-check`;
verified only under additional hypotheses = `established` only after a hypothesis or an
argument supplied by this audit (`candidate-proof-gap` on the supplied proof,
`local-error-repaired-downstream` or `unresolved-dependency` where indicated);
not verified = `unresolved` / `not-checked`; contradicted = `false-under-stated-interpretation`.
Severity of findings: fatal / major / minor / presentational (task scale).  "Supplied
proof" refers to what theory.md, RESULT.md and the scripts actually argue; "claim"
refers to the mathematical statement.  None of this is qualified-human verification.

Evidence pointers: `P:` producer file (rerun byte-identically in the disposable copy,
`logs/verify-rerun/`), `A:` audit script/log under `audits/fable-ultra/`,
`D:` derivation written in AUDIT.md, `S:` primary source (`logs/sources/SOURCES.md`).

## 1. Summary table

| id | claim (normalised) | status | supplied proof | finding | evidence |
|---|---|---|---|---|---|
| **SCOPE-1** | Every faithful, geometrically chiral skeletal 4-polytope `P` in `E^4` whose cells are congruent to some `H_alpha(T)` (`T` one of the 16 regular 4-polytopes, `alpha ∈ R∪{∞}`) is, after an isometry and possibly a reflection, the Wythoff realisation of `P(<S1,S2,X>)` at a base vertex `w`, with `S1,S2` the fixed PETCOX matrices of `T` and `X` a **linear** isometry (theory.md §A) | verified only under additional hypotheses → **established** with the audit's supplement | incomplete: `X` is taken to be a matrix without argument; `Γ` finite asserted, not proved | minor (F3) | D §2.1; A `misc-audit.g (e)` |
| **SCOPE-2** | The base vertex lies on the PETCOX circle `Fix(S2)∩S^3 = span(v0,v3)∩S^3`; antipodal vertices give congruent polytopes; the other flag orbit gives the same polytope; so `alpha` is a complete parameter (B1–B2, §A) | verified | succeeds | – | P `alpha-locus.g` (290 pass); D §2.1 |
| **SCOPE-3** | No such `P` is geometrically regular (2-face vertices span `E^4`, Prop. D1) | verified | succeeds | – | D §2.2; A `congruence-audit.g` (2-face span = 4 and `R = S1S2S3 ∈ Γ` for all 24) |
| **SCOPE-4** | The classification includes infinite (discrete) polytopes: none exist | verified (consequence of SCOPE-1: `Γ ⊂ O(4)`, discreteness ⇒ finite) | not addressed explicitly | minor (part of F3) | D §2.1 |
| **E1** | For each `w` on the circle there is exactly one `X` with `(S2X)^2=(S1S2X)^2=1` fixing `w`, namely `S2^{-1}A`, `A` the half-turn about `span(w1,w2)`; `det X = 1` | verified | succeeds (hypotheses `θ2 ≠ ±θ1`, `w_i ≠ 0` verified) | – | D §2.3; A `l3-audit.g` (planes, angles, circle avoids planes, `A` conditions at every root) |
| **E2a** | `<S2,X>` is finite and is `A4`, `S4` or `A5` | verified | succeeds (cyclic/dihedral exclusion loosely argued; tightened in D §2.4) | presentational | D §2.4 |
| **E2b** | Hence `(q,m) ∈ {(3,3),(3,4),(4,3),(3,5),(5,3)}`, i.e. `1/2+1/q+1/m > 1`, and the cases `(5,5)`, `(4,4)` need not be examined (theory.md E2; `alpha-complete.g` `TargetsFor`) | **contradicted** as a proof step; the excluded case `(5,5)` **does** occur as a finite vertex-figure group | fails | **major** (F1): fatal for the supplied completeness proof, repaired by the audit | A `misc-audit.g (a)`, `five-five-audit.g`, `l3-audit.g` rows 5,6,9,10 |
| **E2c** | No extension has a `(5,5)` vertex figure | verified (by the audit, not by the producer) | absent | – | A `l3-audit.g`: 12 exact base vertices with `<S2,X> ≅ A5` (great-dodecahedral vertex figure), all fail the intersection condition (defect 2 or 12); the two irreducible quartic factors with real roots are killed by non-abelian trace fields (`five-five-audit.g`) |
| **E3** | `tr X_w = 2+2cos(2πk/m)` gives a polynomial of degree ≤ 4 in `t`, solved exactly over `Q(√5)`; every real root is found | verified | succeeds | – | A `l3-audit.g`: independent Sturm counts equal exact-roots + KW-killed for all spherical targets; all 55 producer roots reproduced |
| **E4** | Quaternionic bound: finite `Γ` with polyhedral vertex-figure group lies in `(2X×2Y)/±1`, `|Γ| ≤ 7200`; icosahedral case ⇒ `Γ ⊂ [3,3,5]^+`; octahedral ⇒ `±[O×O]`; element orders as listed | verified | succeeds | – | D §2.5; A `misc-audit.g (b)` |
| **E5** | Kronecker–Weber trace obstruction kills the eight quadratic factors with non-cyclotomic real roots | verified | succeeds | – | A `l3-audit.g` (own implementation, same 8 factors killed) |
| **E6** | **Completeness**: the 24 listed base vertices are all the base vertices on the ten PETCOX circles admitting a third generator, hence the list of chiral or directly regular skeletal 4-polytopes with PETCOX cells is complete up to congruence and enantiomorphism | verified only under additional hypotheses → **established** after the audit's supplement (E2c, SCOPE-1) | **incomplete** (E2b, SCOPE-1) | major (F1), minor (F3) | A `l3-audit.g` summary: 24 survivors, identical to producer's; D §2 |
| **C-EXIST** | Each of the 24 listed realisations is a faithful skeletal 4-polytope with the stated type, f-vector, `|Γ|`, PETCOX cell type, vertex-figure; relations and intersection condition hold | verified | succeeds | – | P `alpha-complete.g`, `compare.g`, `summary.g`; A `congruence-audit.g` §per-realisation (all 24), `l3-audit.g` |
| **C-GEOMCHIRAL** | Each of the 24 is geometrically chiral (`G(P) = Γ`, two flag orbits) | verified | succeeds (Prop. D1) | – | A `congruence-audit.g`: 2-face span 4, `R = S1S2S3` moves the base cell |
| **C-CELLCHIRAL** | Every cell of every realisation is a geometrically chiral (not regular) PETCOX polyhedron; no `alpha` is an exceptional value | verified | succeeds | – | A `congruence-audit.g` (`facet_regular = false`, no vertex collapse, all 24) |
| **C-ABSTRACT** | Classes 1,2,3,5,6 are combinatorially chiral; class 4 is directly regular (mirror automorphism exists) | verified | succeeds | – | A `congruence-audit.g` (mirror test), `l3-audit.g` |
| **C-CLASSES** | The 24 fall into exactly 6 abstract isomorphism classes (up to enantiomorphism) with 4 realisations each, with the stated (type, f-vector, `|Γ|`) | verified (independent code: 6 classes, 4 stored realisations each, generator-preserving isomorphism in one of the two orientations) | succeeds (generator-preserving isomorphism, both orientations) | – | P `compare.g`, `summary.g`; A `congruence-audit.g` |
| **C-3vs6** | Classes 3 and 6 (`{12,3,5}`, `(120,720,300,50)`, `|Γ| = 7200`) are not isomorphic | verified (no generator-preserving isomorphism in either orientation, nor duality; groups abstractly isomorphic; orientation-free order invariant differs) | succeeds | – | P `compare.g`, `summary.g` word invariant; A `congruence-audit.g` |
| **C-CONG** | **Exactly 24** up to congruence and enantiomorphism: no two of the 24 are congruent or mirror-congruent | **contradicted**: in every abstract class the four listed realisations fall into exactly **two** congruence classes; the correct count is **12**, not 24.  Certified by explicit similarities `g` (`congruence-certify.log`) that map vertices, edges, 2-faces, cells and conjugate the symmetry groups; e.g. `alpha = 1/2` is a rotated, rescaled copy of Roli's cube (`alpha = 0`, det > 0: same handedness), and `alpha = 2` of the `alpha = ∞` polytope | **incomplete**: `compare.g` decides congruence only for pairs on the same `W`-invariant vertex set (identity or one reflection `R0`); pairs with the same Gram multiset in different positions (e.g. `alpha = 1/2` vs Roli's cube) are declared distinct without an isometry search | **fatal** (F2: the headline count is false) | P `compare.g` header + `compare.log` lines 162–171; A `congruence-audit.g`, `congruence-quick.g`, `congruence-certify.g` |
| **C-XP** | Chirality groups `C2, SL(2,5), SL(2,5), 1, Q8, SL(2,5)` for classes 1–6 | verified (own mix computation: `|Mix| = |Γ||X|`, `X ≅ C2, SL(2,5), SL(2,5), 1, Q8, SL(2,5)`) | succeeds (three methods) | – | P `summary.g`, `chirality-group.g`; A `congruence-audit.g` (mix) |
| **C-ROLI4** | Roli's cube has four pairwise non-congruent chiral realisations `alpha = 0, 1/2, 2, ∞`; `alpha = ∞` uses the 32 main diagonals of the cubic facets | **contradicted**: `alpha = 1/2 ≅ alpha = 0` (Roli's cube) and `alpha = 2 ≅ alpha = ∞` by proper similarities (det 9/16 = (√3/2)^4 > 0); Roli's cube has exactly **two** non-congruent realisations (`alpha = 0` and `alpha = ∞`, the pair correctly separated by `roli-alpha-infinity.g`); the '16-point orbit of a group of order 192 not contained in [4,3,3]' at `alpha = 1/2` is the vertex set of a rotated 4-cube | incomplete for `(0,1/2)`, `(0,2)`, `(∞,1/2)`, `(∞,2)`, `(1/2,2)` (same Gram multiset, only "vertex sets differ" argued) | part of F2 (fatal) | P `roli-alpha-infinity.g` (pair `0,∞` proved); A `congruence-audit.g`, `congruence-certify.g` |
| **C-L1** | Level 1: canonical `S3 = R3R2` gives exactly the five extensions; eleven endpoints fail with defect equal to the PETCOX collapse number | verified | succeeds | – | P `canonical.g` (275 pass), `alpha-locus.g`; A `l3-audit.g` `t = ∞` roots |
| **C-L2** | Level 2 parent searches recover exactly the Level-3 base vertices inside each parent | verified (rerun; not re-implemented, not needed for completeness) | succeeds | – | P `parent-search.g` (37 pass) |
| **C-TABLE** | `candidate-table.tsv` (106 rows) is a faithful presentation of the runs | verified (regenerated byte-identically) | – | presentational (label `PROVED-OBSTRUCTION-IN-PARENT` also used for Level-3 rows where no parent is involved) | `logs/verify-rerun/candidate-table.regenerated.tsv` |
| **C-VERIFY** | `verify.sh` passes | verified (1087 PASS, 0 FAIL, 17 min) | – | – | `logs/verify-rerun/verify-stdout.txt` |
| **SRC-R97** | The `{30,3}` cell is Conder's `R97.10` (`{3,30}_40`), not `R97.9` (`{3,30}_20`) as PETCOX p. 29 states; its Petrie length is 40 | verified (`inspected-primary`) | succeeds | – | S Conder file lines 12683–12689 verbatim; A `printed-data-audit.g` (both transcribed presentations have order 2880 and Petrie lengths 20 and 40; cell satisfies R97.10, fails R97.9) |
| **SRC-R151** | The `{20,5}` cell is `R151.11` (`{5,20}_60`), confirming PETCOX | verified (`inspected-primary`) | succeeds | – | S lines 24067–24073; P `conder-check.g` |
| **SRC-D1** | PETCOX p. 25 prints for `{3,5,5/2}` the tetrahedron, `S1`, regular vertices and `R` of the `{5,3,3}` paragraph; its `S2` differs in one sign and is not orthogonal | verified (rendered page; independent transcription) | succeeds | – | A `printed-data-audit.g` |
| **SRC-D2** | PETCOX p. 26 matrix `R = ±(1/2√6)(…)` for `{5,3,5/2}` is not orthogonal as printed (row 4 norm² ≈ 0.19); the printed regular vertices are correct | verified | succeeds | – | A `printed-data-audit.g` |
| **SRC-H1** | PETCOX p. 28 header `[G:Γ+]` is reversed; column = `[Γ+(T):G]` | verified | succeeds | – | A `printed-data-audit.g`; rendered p. 28 |
| **SRC-ATLAS** | `{8,3}*96 = SmallGroup(96,193)`, `{12,3}*288 = SmallGroup(288,847)`, `{12,4}*384e = SmallGroup(384,18044)` with the stated `(V,E,F)` and Petrie lengths; the cells **are** these entries | verified (`inspected-primary` + `IdGroup`) | producer confirmed the atlas data only; identity of the cell with `384e` (vs `384a`, same `(V,E,F)` and Petrie length) was asserted from PETCOX | minor (presentational: now proved) | S atlas pages; A `atlas-id-audit.g` |
| **SRC-CONDERCH** | Roli's cube = Conder's chiral `[3,3,8]` order 192 NSD entry; class 5 = `[4,3,12]` order 1152 NSD entry; classes 2,3,4,6 exceed the census | verified (`inspected-primary` for the entries; relator tests rerun) | succeeds | – | S ByType lines 7637–7638, 8073–8074 verbatim; P `conder-check.g` (49 pass) |
| **SRC-URL** | PETCOX ref. [6] URL returns 404; correct file `RegularOrientableMaps301.txt` | verified | – | – | S (HTTP 404 observed) |
| **SRC-DOI** | PETCOX = DCG 66 (2021) 1025–1052, DOI 10.1007/s00454-021-00317-0 | verified (Crossref) | – | – | S |
| **NOV-2** | Class 2 must not be claimed as new: the extension of `H_0({5,3,3})` is announced in unpublished Hubard–Trejo work and computed in a public GitHub GAP appendix | verified (`inspected-primary`): the appendix A.5.5 constructs, from the 120-cell, `<S1,S2,S3>` of order 7200 with `|<S1,S2>| = 1440`, `|<S2,S3>| = 12`, IP checked, "600 vertices, 1200 edges, 120 faces, and 5 cells" (two `S3` choices); PAPIIT IN109023 and arXiv:2604.00185 ref. [31] confirm the announcement | – | – | S SOURCES.md |
| **NOV-REST** | Classes 4, 5, 6 and the non-canonical realisations of classes 1–3 are "apparently unpublished" | not verified (not verifiable by search; the producer's hedged wording is appropriate; the Trejo appendix covers only convex `T` and only `S3 ∈ <R2,R3>`) | – | – | S; P `references.md` |
| **NOV-ARXIV** | Hubard–Schulte arXiv:2604.00185 cites [1] Bracho–González-Casanova–Hubard "In preparation" and [31] Hubard–Trejo "Preprint" | verified (`inspected-primary`) | – | – | S |
| **PROV-LOGS** | "logs/: complete machine-generated transcripts of every run" (README) are part of the frozen result | **contradicted** for the commit: all eleven `logs/*.log` are git-ignored (`.gitignore:17 *.log`) and absent from `71ef1cd`; they exist only in the working tree (and were regenerated identically here) | – | major (F4, provenance, not mathematics) | `git ls-files`, `git check-ignore` |
| **PROV-SHA** | `logs/SHA256SUMS` lists the sources with hashes | verified only under additional hypotheses: 17/18 match after expanding `~`; the entry for `computations/chirality-groups/common/chirality-group.g` does **not** match the file at HEAD (or at any commit in its history) | – | minor (F5) | `shasum -c` transcript in AUDIT.md |
| **PROV-ZOOM** | RESULT.md quotes the untracked `zoom-5-sept.md` | not verified (file deliberately not read by this audit) | – | presentational | – |

## 2. Detailed records for the load-bearing claims

### E2b / E2c — the (5,5) vertex-figure case (finding F1)

```yaml
claim_id: E2b
title: spherical-triangle inequality restricts (q,m)
location: {file: theory.md, statement: "Proposition E2", excerpt: "Hence <S2,X> is A4, S4 or A5, so (q, m) in { (3,3), (3,4), (4,3), (3,5), (5,3) }, equivalently 1/2 + 1/q + 1/m > 1"}
          {file: gap/alpha-complete.g, statement: "PX.TargetsFor", excerpt: "because 1/2 + 1/q + 1/m <= 1 makes <S2,X> infinite, contradicting Prop. E2"}
normalized_claim:
  hypotheses: ["<S2,X> finite subgroup of SO(3), S2 of order q>=3, X of order m>=3, (S2 X)^2 = 1, <S2> cap <X> = 1"]
  conclusion: "1/2 + 1/q + 1/m > 1"
proof_obligation: "the inequality characterises FINITE triangle groups Delta(2,q,m); a finite <S2,X> is a finite QUOTIENT of Delta(2,q,m), which exists for (5,5): A5"
diagnostic_class: candidate-proof-gap (on the completeness proof); the printed inference is false
supplied_proof_state: fails
claim_state (E2b as stated): false-under-stated-interpretation — counterexample a=(1,2,3,4,5), b=(1,2,3,5,4) in A5: orders 5,5, ab involution, <a> cap <b> = 1, <a,b> = A5, P(A5;a,b) = {5,5} with (12,30,12) faces (great dodecahedron / small stellated dodecahedron)
claim_state (E2c, "no (5,5) extension"): established by this audit —
  evidence:
    - kind: exact-computation, locator: audits/fable-ultra/logs/audit-runs/l3-audit.log rows 5,6,9,10 targets m=5:
      12 exact base vertices (3 per row) have <S2,X> ≅ A5 of order 60 and finite Γ of order 7200 with the relations, but the intersection condition fails (defect 2 for {3,5,5/2},{3,5/2,5}; defect 12 for {5,5/2,5},{5/2,5,5/2}); coset f-vectors (120,720,180,6) resp. (120,720,240,1)
    - kind: exact-computation, locator: five-five-audit.log: the two irreducible quartic factors with 4 real roots (rows 6 and 9, k=2) have tr(S1 X) with minimal polynomial of degree 8 and Galois group (C2^4):C2 (non-abelian) => tr not in Q^ab => Γ infinite
    - kind: exact-computation, locator: five-five-audit.log: in A5 the number of ordered pairs of same-class order-5 elements with involutory product is 0 (different classes: 120), an independent reason why the k=2 targets of rows 6,9 (S2 of angle 4π/5) cannot give a finite <S2,X>
checks_against_finding: ["the producer's excluded pairs (4,4), (4,5), (5,4), m>=6 are genuinely impossible for finite subgroups of SO(3) (misc-audit.g (c), element orders); only (5,5) was wrongly excluded"]
dependencies: {direct_consumers: [E6, C-CONG], downstream_impact: "E6 as supplied is not a proof; with E2c the theorem stands", bypasses: "none in the producer's text"}
repair: {state: complete-within-analysis, proposal: "replace the inequality by the classification of finite quotients of Delta(2,q,m) in SO(3) (A4, S4, A5 with any generating pair), add the (5,5) targets to alpha-complete.g, and settle irreducible factors with real roots by the trace-field Galois test or the A5 class argument", trigger_rechecked: true, downstream_rechecked: [E6]}
confidence: high (exact certificates; two independent routes for the quartics)
```

### C-CONG — congruence classes (finding F2)

```yaml
claim_id: C-CONG
location: {file: gap/compare.g, statement: "header and geometric-level test", excerpt: "two candidates living in the same Coxeter group W with the same vertex set are congruent iff one is the image of the other under an element of W ... reduces to the test 'identical, or the image under one reflection R0'"}
          {file: RESULT.md, statement: "Roli's cube has four non-congruent chiral realisations ... no two of them are congruent even after reflection"}
normalized_claim: {conclusion: "the 24 realisations are pairwise non-congruent and pairwise non-mirror-congruent"}
proof_obligation: "for pairs with the same Gram multiset but different vertex sets (compare.log lines 162-171 and 95 further pairs) exclude every isometry of E^4, not only elements of W"
diagnostic_class: candidate-proof-gap
supplied_proof_state: incomplete (the R0 argument is valid only when both polytopes live on the same W-invariant vertex set with Sym(V) = W and Γ = W^+; it was applied correctly to the pair (0,∞) of Roli's cube and to the canonical thesis pairs, but not to alpha = 1/2, 2 or to the Level-3 realisations outside W)
claim_state: false-under-stated-interpretation (the interpretation being the producer's own: polytopes normalised to S^3, i.e. congruence up to scale, exactly what compare.g's rescaling implements)
evidence:
  - kind: exact-computation, locator: audits/fable-ultra/logs/audit-runs/congruence-audit.log and congruence-quick.log (two implementations, same result): for each abstract class the four realisations split as {a1,a2},{a3,a4} with explicit structure-preserving similarities inside each pair (12 or 24 or 60 of them = |Stab(w)| times the number of extra symmetries of the vertex set), and the two pairs separated by the scale-free invariants (edge inner product, 2-face profile, vertex-figure profile)
  - kind: exact-computation, locator: congruence-certify.log: one certificate matrix g per congruent pair, checked on V, E, F, C and on the groups (g^-1 Gamma_a g = Gamma_b), with its determinant sign and its relation to the rho_1 half-turn of the PETCOX family
pairs (producer labels; alpha values): class 1 {0, 1/2}, {infinity, 2}; class 2 {5,3,3}:{0, 0.3041}, {3,3,5/2}:{1, -6.9385}; class 3 (thesis) {0, 0.1459}, {1, -5.8541}; class 4 {1.8155, 3.0322}, {-0.0701, 0.2038}; class 5 {-0.2560, 0.3298}, {1.4921, 4.9063}; class 6 {-1, 0.6180}, {2, 2.6180}
consequence: RESULT.md's headline "exactly 24", "4 realisations per class", "Roli's cube has four non-congruent chiral realisations", and the novelty attributions to the second member of each pair are false; the corrected statement is 12 realisations, 2 per abstract class
confidence: high (two independent implementations; explicit certificates; the self-checks recover the vertex stabiliser and the known mirror congruence)
```

### SCOPE-1 — linearity and finiteness (finding F3, minor)

```yaml
claim_id: SCOPE-1
location: {file: theory.md, statement: "Section A / Prop. E2", excerpt: "X is an isometry of E^4 ... It is finite (the symmetry group of a discrete polytope in E^4 is a discrete, hence finite, subgroup of O(4))"}
proof_obligation: "show X fixes the centre of the base cell (so Γ ⊂ O(4)) and that Γ is finite"
supplied_proof_state: incomplete (both asserted)
claim_state: established (AUDIT.md §2.1): write X(x) = xM + b; A = S2X affine with A^2 = 1 and A S1 A = S1^{-1} forces b S1 = b, and S1 has no nonzero fixed vector (misc-audit.g (e)), so b = 0; then Γ ⊂ O(4), the vertices of the base 2-face span E^4 (E1 hypotheses), the vertex set is finite by discreteness, and Γ acts faithfully on it, so Γ is finite
diagnostic_class: candidate-proof-gap (routine, closable)
confidence: high
```

### PROV-LOGS — transcripts absent from the commit (finding F4)

```yaml
claim_id: PROV-LOGS
location: {file: README.md, excerpt: "`logs/` | complete machine-generated transcripts of every run"; file: RESULT.md, excerpt: "[alpha-complete.g: 226 assertions, 0 failures ...]"}
evidence: git ls-files research/petcox-facet-extensions/logs/ lists only SHA256SUMS, the .tsv/.g data files, environment.txt and literature/; git check-ignore -v -> .gitignore:17:*.log; git status --ignored shows the 11 .log files as '!!'
claim_state: false-under-stated-interpretation for "the frozen commit contains the transcripts"; the working-tree transcripts were regenerated byte-identically by this audit, so the mathematical content is unaffected
repair: {proposal: "add a negation rule `!research/petcox-facet-extensions/logs/*.log` to .gitignore (or rename to .txt) and commit; hash the transcripts in logs/SHA256SUMS with repository-relative paths", state: speculative}
```
