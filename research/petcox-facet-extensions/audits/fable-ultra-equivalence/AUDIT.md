# Audit: geometric equivalence of the 24 stored PETCOX facet-extension realisations

Repository HEAD `ca649f260df19db0e3caad9e1b48932f872d361c`; producer commit
`71ef1cda7ca927b090068c796bfdcc10ca097a2c`; data `logs/alpha-survivors.g` of that commit (24 records).
Nothing was committed or pushed; no pre-existing file was modified.

## Direct answer

| question | answer |
|---|---|
| number of the 24 stored realisations up to **literal Euclidean congruence** (isometries of `E^4`, proper or improper, applied to the stored coordinates) | **24** |
| number up to **similarity** (`x -> cQx + b`, any `c > 0`; proper and improper give the same count) | **12** |
| number after the construction's **documented normalisation** (every vertex on the unit sphere `S^3`, PETCOX's `[x] = x/|x|`, the producer's own `theory.md` convention) up to congruence | **12** |
| the previous audit's "24 reduce to 12 up to congruence and enantiomorphism" | **the count 12 is correct; the wording is terminologically misleading** in two respects: (a) on the stored coordinates the certificates are similarities with `lambda = c^2 != 1` for every one of the 12 pairs, so the stored sets are *not* congruent and become congruent only after the unit-sphere normalisation; (b) every one of the 12 identifications is a **proper** isometry (a half-turn), so the paired realisations have the **same handedness** and "up to enantiomorphism" adds nothing to the geometric count |
| the producer's "exactly 24 faithful, geometrically chiral skeletal 4-polytopes in `E^4` ... up to congruence and enantiomorphism" (`RESULT.md`, `README.md`, `theory.md` Thm E6) | **false as a count**: the correct number is 12.  Within every one of the six abstract classes the four stored realisations fall into two pairs of properly similar (after normalisation: properly congruent) polytopes.  In particular "Roli's cube has four non-congruent chiral realisations ... no two of them are congruent even after reflection" is false: `alpha = 0` and `alpha = 1/2` are the same polytope up to a proper similarity, and so are `alpha = 2` and `alpha = oo`; the only correct non-congruence certificate in the producer's files (`alpha = 0` vs `alpha = oo`) is confirmed |

Classification of the previous audit's equivalence claims: see Section 8 (every pairing it proposes is
**verified only up to similarity** on the stored data, and **verified** as a proper congruence after
normalisation; none of its pairings is contradicted; two peripheral statements are - the direction of
one prose example and its remark that the pairing is not produced by the `rho_1`-type half-turn; none is
unresolved).

Verdict (Section 10): VERIFIED WITH CORRECTED TERMINOLOGY.

## 1. Scope, inputs, independence

* Audited: only the geometric equivalence of the 24 stored realisations and the resulting count.  The
  completeness theorem of the producer (that these 24 are *all* extensions) is out of scope here.
* Input: the 24 records `rec(case, T, alpha, ab = [t,1], S1, S2, X, w, ...)` of
  `research/petcox-facet-extensions/logs/alpha-survivors.g` at commit `71ef1cd`, read from a `git archive`
  extraction (never from the working tree).  Each record determines the stored realisation
  `P(S1,S2,X; w)`: vertices `w Gamma`, `Gamma = <S1,S2,X>`, base edge `{w, w S1^-1}`, base 2-face the
  cycle `w S1^k`, base cell its `<S1,S2>`-orbit, and the `Gamma`-orbits of these.
* Independence protocol (`PREREGISTRATION.md`, frozen before any comparison): no `AGENTS.md` exists;
  `audits/fable-ultra/` was not opened until Sections 2-7 below were complete; no script of the previous
  audit was read or reused; every implementation below was written from the preregistered specification,
  four of them (Methods 1-4) by independent workers who were forbidden to read the previous audit and
  the preregistration itself, and who did not read each other's code.

## 2. Definitions used (identical to `PREREGISTRATION.md` Section 2)

Two stored realisations are *equivalent under a class of maps* iff a map of the class carries the vertex
set onto the vertex set, the edge set onto the edge set, the 2-faces onto the 2-faces and the cells onto
the cells.  Coincidence of vertex sets alone is not equivalence.

| # | relation | maps | count on the 24 |
|---|---|---|---|
| R1 | equality of stored data | identity | 24 (also: no two stored vertex sets coincide) |
| R2 | proper congruence | `x -> xQ + b`, `det Q = +1` | 24 |
| R3 | congruence | `x -> xQ + b`, `Q^T Q = I` | 24 |
| R4 | proper similarity | `x -> xQc + b`, `det Q = +1`, `c > 0` | 12 |
| R5 | similarity | `x -> xQc + b`, `c > 0` | 12 |
| R6 | congruence after normalising every vertex to `S^3` (PETCOX `[x]`) | R3 on `w/|w|` | 12 |
| R7 | "up to enantiomorphism" (R6 plus identification of a realisation with its mirror image) | | 12 |

*The scale problem.*  A realisation and its rescaling `lambda P` are never congruent for `lambda != 1`,
so "finitely many up to congruence" is meaningful only once the scale is fixed.  The scale *is* fixed by
the definition of the objects being classified: a PETCOX polyhedron `H_alpha(T)` has its vertices on
`S^3` ([PETCOX] p. 19-21: "we first project it to `S^3`", `(v,c)_alpha = [(1-alpha)v0 + alpha v3]` with
`[x] := (1/||x||) x`), so a 4-polytope whose cells are congruent to PETCOX polyhedra has all its
vertices on a sphere of radius 1 about its centroid.  On such data congruence and similarity coincide
(a similarity between two finite sets on the unit sphere about the common centroid `0` has `c = 1`), so
the finite classification intended by "up to congruence" is R6, and R6 = R5.  The producer, however,
stores `w = t v0 + v3` with **unnormalised** `v0, v3` (`lib.g` header, `alpha-complete.g` l. 217), so
its stored realisations lie on spheres of different radii (cube family: `|w|^2 = 3, 3/4, 1, 4`).
Therefore any map between two stored realisations is a similarity with `lambda = |w_b|^2/|w_a|^2`, and a
certificate with `M M^T = lambda I`, `lambda != 1`, is exactly what an honest comparison of the *stored*
data must produce.  It becomes an isometry of the *normalised* data through `M' = M |w_a|/|w_b|`,
`M' M'^T = lambda |w_a|^2 / |w_b|^2 I = I`, an identity that is verified exactly and needs no square root.

*Enantiomorphism.*  [BHP] p. 801 and 803 use "enantiomorphic" for mirror images ("any reflection ...
sends one colouring to the other"; "the two enantiomorphic forms of `Q`"); [SW] use it for the two
mirror-image forms of a chiral polytope, whose distinguished generators differ by
`(s1, s2, s3) -> (s1^-1, s1^2 s2, s3)`; the producer's `compare.g` prints "MIRROR IMAGE ...:
enantiomorphic realisations".  So "up to congruence and enantiomorphism" means: identify `P` with `gP`
for every isometry `g`, improper ones included.  That is R3 on the stored data and R6 = R7 on the
normalised data.  All sources are quoted verbatim in `logs/sources-quotes.md` (Section 8 below also
records what the previous audit meant by the phrase).

## 3. Methods and agreement

Four independent implementations plus the author's own check, all exact (no floating point in any
decision), all run from a clean command by `scripts/run-all.sh` (transcripts in `logs/`):

| method | idea | arithmetic | result |
|---|---|---|---|
| author's check (`author-check-antiautomorphism.g`) | solve `M S1 = S1^-1 M`, `M S2 = S2^-1 M`; the solution space is one-dimensional, spanned by `M0`; its action on the PETCOX circle pairs the base vertices; verify `M0/c` carries `a` onto `b` | GAP cyclotomics | 12 pairs, all proper, all `lambda != 1` |
| Method 1 (`method1-flag-search.g`) | any similarity sends the base flag of `a` to a flag of `b`; `Gamma_b` has exactly two flag orbits (verified: `2|Gamma_b|` flags, free action), so up to `Gamma_b` only two candidate maps exist (determined by the traversal of the base 2-face); verify both exactly; **independently** enumerate all Gram-consistent ordered 4-tuples of vertices of `b` (exhaustive) | GAP cyclotomics | 576 ordered pairs: 448 differ in f-vector; of the 128 with equal f-vector, 48 (24 with `a = b`) are similar with exactly `|Gamma_b|` similarities each, 80 have **no** similarity; det sign always `+1`; 12 classes under similarity, 24 under isometry |
| Method 2 (`method2-canonical.sage`, `method2-verify-certificates.g`) | canonical form of the weighted incidence/distance structure: minimum over admissible bases at `w` of (Gram data, canonically sorted vertex list, full Gram matrix, edges, faces, cells), raw and scale-free, oriented and unoriented; a complete invariant | Sage `CyclotomicField(40)` (FLINT), re-verified in GAP | classes: raw-unoriented 24, raw-oriented 24, scale-free-unoriented 12, scale-free-oriented 12; explicit `M = B_a^-1 B_b` for the 12 pairs, all proper; 40 non-similar equal-f-vector pairs have 0 Gram-compatible bases |
| Method 3 (`method3-anti-automorphism.g`) | structural explanation and independent pairing prediction via the anti-automorphism realiser `M0` (normalised exactly to an orthogonal matrix), its Moebius action on the parameter `t`, fixed points | GAP cyclotomics | all 4 rows: commutant and anti-automorphism space one-dimensional, `det M0 = +1`, `M0^2 = I`, reflection of the PETCOX circle, fixed points equal to PETCOX's regular `alpha` values; the predicted pairing is the same 12 pairs, each verified as a structure map with `det > 0` and `M0^-1 X_a M0 in Gamma_b`; 0 self-check failures |
| Method 4 (`method4-verify-certificates.py`) | from-scratch `Q(zeta_40)` arithmetic over Python `Fraction`s (reduction modulo `Phi_40`); re-parses the data, rebuilds the 24 realisations, re-verifies every Method-1 certificate | pure Python | 96/96 certificates re-verified (`lambda`, `M M^T = lambda I`, `det = +lambda^2`, vertices/edges/faces/cells onto, flag orbits), 0 failures, 2855 exact checks; all 80 non-certified equal-f-vector ordered pairs distinguished by exact scale-free invariants (edge inner products differ) |
| previous-audit check (`previous-audit-check.g`) | exact re-verification of the twelve matrices `g` printed by `audits/fable-ultra/`, and the test whether each lies in the coset `(M0/c) Gamma_b` | GAP cyclotomics | 12/12 exact proper similarities, `lambda != 1` for all, all in the half-turn coset (Section 8) |

`scripts/make-table.py` checks that the partitions of Methods 1, 2, 3 and the author's check coincide
under every relation, that Method 4 verified every certificate, and writes `EQUIVALENCE-TABLE.tsv`;
`scripts/make-certificates.py` checks that the three certificate sources certify the same 12 pairs and
writes `CERTIFICATES.md`.  All of this is run from a clean command by `scripts/run-all.sh`
(`REPRODUCIBILITY.md`).

## 4. Results

The 12 classes under R4 = R5 = R6 = R7 (each of size 2; `lambda = |w_b|^2/|w_a|^2` exact, decimal for
orientation; every certificate proper):

| producer class | pair | `lambda` (a -> b) |
|---|---|---|
| 1 `{8,3,3}` (Roli's cube) | `L3-{4,3,3}-6` (alpha = 0, Roli's cube) ~ `L3-{4,3,3}-1` (alpha = 1/2) | 3/4 |
| 1 | `L3-{4,3,3}-2` (alpha = 2) ~ `L3-{4,3,3}-3` (alpha = oo) | 4/3 |
| 2 `{30,3,3}` | `L3-{5,3,3}-8` (alpha = 0) ~ `L3-{5,3,3}-3` (alpha ~ 0.3041) | ~8.972 |
| 2 | `L3-{3,3,5/2}-1` (alpha = 1) ~ `L3-{3,3,5/2}-4` (alpha ~ -6.939) | 2 |
| 3 `{12,3,5}` (thesis) | `L3-{5,3,5/2}-16` (alpha = 0, thesis `{12/(1,5),3,5/2}`) ~ `L3-{5,3,5/2}-15` (alpha ~ 0.1459) | ~10.28 |
| 3 | `L3-{5,3,5/2}-9` (alpha = 1, thesis `{12/(1,5),3,5}`) ~ `L3-{5,3,5/2}-12` (alpha ~ -5.854) | 6/5 |
| 4 `{12,3,3}` | `L3-{5,3,5/2}-1` (alpha ~ 1.815) ~ `L3-{5,3,5/2}-4` (alpha ~ 3.032) | ~1.035 |
| 4 | `L3-{5,3,5/2}-2` (alpha ~ -0.0701) ~ `L3-{5,3,5/2}-3` (alpha ~ 0.2038) | ~0.0923 |
| 5 `{12,3,4}` | `L3-{5,3,5/2}-5` (alpha ~ 1.492) ~ `L3-{5,3,5/2}-8` (alpha ~ 4.906) | ~1.075 |
| 5 | `L3-{5,3,5/2}-6` (alpha ~ -0.2560) ~ `L3-{5,3,5/2}-7` (alpha ~ 0.3298) | ~0.3552 |
| 6 `{12,3,5}` | `L3-{5,3,5/2}-10` (alpha = -1) ~ `L3-{5,3,5/2}-11` (alpha ~ 0.6180) | 2/3 |
| 6 | `L3-{5,3,5/2}-13` (alpha = 2) ~ `L3-{5,3,5/2}-14` (alpha ~ 2.618) | ~1.019 |

Every other pair with equal f-vector (40 unordered pairs, including the four cross-row pairs `{5,3,3}`
vs `{3,3,5/2}` of class 2) has an exhaustive non-existence certificate from both Method 1 and Method 2
(`CERTIFICATES.md`, last table).  No `lambda` equals 1, so R2 = R3 = 24.  No improper equivalence
exists anywhere: the exhaustive enumerations found only `det > 0`, so all 24 realisations are
geometrically chiral with full similarity group `Gamma` (no improper symmetry), and no stored
realisation is the mirror image of another.  R1: all 24 stored data sets are distinct; no two stored
vertex sets coincide.  (Vertex sets that coincide *up to scale* do occur - e.g. `alpha = 1/2` with
`alpha = 2` and `alpha = oo` with `alpha = 0` in the cube family, and `{5,3,3}` with `{3,3,5/2}` - but
these are precisely **not** the similar pairs: the similar pairs have different vertex sets.  This is the
concrete form of "coinciding vertex sets do not prove equivalence".)

## 5. Why exactly these pairs, and why they are proper

For each row `T` the linear system `M S1 = S1^-1 M`, `M S2 = S2^-1 M` has a one-dimensional solution
space (and the commutant of `<S1,S2>` is one-dimensional, so the only isometries centralising the cell
group are `+-I`).  Its spanning matrix `M0` satisfies `M0 M0^T = mu I`, `M0^2 = mu I` and
`det M0 = +mu^2` in all four rows (cube: `M0 = [[0,-1,1,1],[-1,1,0,1],[1,0,-1,1],[1,1,1,0]]`, `mu = 3`).
So `M0/sqrt(mu)` is a **half-turn about a 2-plane**, hence proper.  It inverts `S2`, so it preserves
`Pi = Fix(S2) = span(v0, v3)`, the plane of the PETCOX circle, and acts there as a reflection (trace 0);
its two fixed points on the projective circle are exactly the values of `alpha` at which PETCOX report
`H_alpha(T)` to be geometrically regular (cube `2 -+ sqrt 3`, i.e. the printed base vertices
`[(1,1,1,+-sqrt 3)]`, `{5,3,3}` 0.15327/19.1653, `{5,3,5/2}` 0.075375/2.26627, `{3,3,5/2}`
0.26580/1.90082 in the centroid convention) - which is what `M0` is: the "reflection" `R` of PETCOX
Lemma 3 realising the missing `rho_1`.  For the base vertices of the stored realisations, which are not
fixed, `M0` maps `w_a` to a multiple `c w_b` of exactly one other stored base vertex of the row, and
`M0/c` carries the whole realisation `a` onto `b` (vertices, edges, 2-faces, cells; exact).

Why nothing else can occur (the argument is verified computationally at every step by Methods 1-3): a
similarity `n` with `n(P_a) = P_b` maps cells to cells and normalises the cell group `G = <S1,S2>`
(the full symmetry group of a cell is `G`); after composing with an element of `G` it fixes the base
vertex and base edge correspondence, so it normalises `<S2>` and preserves `Pi`; it maps the base flag of
the cell of `a` either to the base flag of the cell of `b` - then it centralises `G`, so `n = +-I` and
`a = b` - or to the 2-adjacent flag, whose distinguished generators are `(S2^-1 S1^-1 S2, S2^-1)`; then
`S2 n` inverts both generators, i.e. `S2 n = +-M0`.  Hence two stored realisations of a row are similar
iff `+-M0` maps one base vertex to a multiple of the other.  Since `M0` is proper, all identifications are
proper; since `M0` fixes no stored base vertex (the fixed points are the regular values, which are not
among the 24), every realisation is chiral.  At the level of *generating triples*, `M0/c` conjugates
`(S1, S2, X_a)` to a `Gamma_b`-conjugate of the **mirror triple** `(S1^-1, S1^2 S2, X_b)` (Method 1,
exact): the two stored triples are enantiomorphic labellings (base flags in opposite flag orbits) of one
and the same geometric polytope.  This is the only sense in which "enantiomorphism" enters, and it is
combinatorial, not geometric.

## 6. Special checks required by the task

* **Roli's cube (`alpha = 0`) versus `alpha = 1/2`.**  Similar as stored with `lambda = 3/4`
  (`M = M0/2`, `M M^T = (3/4) I`, `det M = 9/16 > 0`); **properly congruent** after normalisation (same
  handedness); not congruent as stored.  Three independent certificates in `CERTIFICATES.md` No. 1.
* **The other pairing in Roli's class: `alpha = 2` versus `alpha = oo`.**  Similar with `lambda = 4/3`
  (`M = M0/(-3/2)`), proper; not congruent as stored.  `CERTIFICATES.md` No. 2.
* **`alpha = 0` versus `alpha = oo`** (the producer's `roli-alpha-infinity.g`): **not** similar
  (exhaustive: 384 Gram-consistent tuples, 0 structure maps; Method 2: 0 Gram-compatible bases).  The
  producer's certificate for this one pair is correct.  The same holds for `(0, 2)`, `(1/2, 2)`,
  `(1/2, oo)`.
* **Every proposed duplicate pair in all six abstract classes**: the 12 pairs of Section 4, each with
  three independent explicit certificates; each abstract class of four splits into exactly two pairs; no
  identification across abstract classes (impossible anyway) and none across the two rows of class 2.
* **Literally congruent, merely similar, or congruent only after a stated normalisation?**  Merely
  similar as stored (`lambda != 1` in all 12 cases, ranging from about 0.09 to about 10.3); congruent
  exactly after the unit-sphere normalisation that PETCOX and the producer's `theory.md` both state.
* **Same or opposite handedness?**  Same: every certificate has `det > 0`, the exhaustive searches found
  no improper similarity, and the identifying map is a half-turn.
* **Thesis polytopes.**  The two thesis realisations (`alpha = 0` and `alpha = 1` of `{5,3,5/2}`, i.e.
  `{12/(1,5),3,5/2}` and `{12/(1,5),3,5}`) are **not** equivalent to each other under any relation; each
  is properly similar to one of the producer's "apparently unpublished" realisations (`alpha ~ 0.1459`
  and `alpha ~ -5.854` respectively).  So class 3 contributes 2, not 4, and the two thesis polytopes
  remain distinct.
* **Is "12 realisations" valid under the terminology of the stated theorem?**  The producer's theorem
  counts "up to congruence and enantiomorphism".  With the scale fixed by the definition of a PETCOX
  polyhedron (vertices on `S^3`) that relation is R6 = R7, and the correct number is 12, not 24.  Read
  literally on the producer's stored coordinates, "congruence" gives 24, but that reading makes the
  theorem's count depend on an arbitrary unnormalised scale and is not the intended statement.

## 7. Where the producer's reasoning failed

* `theory.md` Section A asserts that "up to congruence and enantiomorphism, every extension is a triple
  `(S1,S2,X)` with the PETCOX matrices `S1, S2` kept fixed" - correct - but then treats distinct triples
  as distinct polytopes.  The triples `(S1,S2,X_a)` and `(S1,S2,X_b)` with `w_b = w_a M0/c` describe the
  same polytope with base flags in opposite orbits; the producer's own uniqueness theorem E1 (the third
  generator is determined by the base vertex) combined with the anti-automorphism realiser `M0` forces
  this.
* `gap/compare.g` never searches for an isometry.  For two candidates with the same scale-free Gram
  multiset it (i) looks for a *parallel* pair of vertices to fix a rational rescaling and (ii) tests only
  whether the structures are then *identical* or *mirror images under the single reflection `R0` of
  `W(T)`*.  Realisations related by an isometry outside `W(T)` (as all 12 pairs are: `M0` is not in
  `W(T)`) are reported as different classes.  So the claimed "four congruence classes" of Roli's cube
  rest on a certificate only for `(0, oo)`; for the other five pairs `compare.g` provides no
  non-congruence certificate at all, and for two of them the claim is false.
* `RESULT.md`'s description "`alpha = 1/2`: a 16-point orbit of a group of order 192 not contained in
  `[4,3,3]`" is literally true and is exactly what a rotated copy `M0/2 (Roli's cube)` looks like: its
  group is the conjugate `(M0/2)^-1 W^+ (M0/2)`, not contained in `[4,3,3]` because `M0` is not.

## 8. The previous audit (`audits/fable-ultra/`), read only after Sections 2-7 were complete

The previous audit (`AUDIT.md`, `CLAIM_LEDGER.md`, `scripts/congruence-{audit,quick,certify}.g`,
`logs/audit-runs/congruence-*.log`, dated 2026-09-09) found the producer's count wrong by an
"actual isometry search" (four-point basis matching, base vertex to base vertex) and printed one
certificate matrix `g` per pair with `g g^T = lambda I`.  Its twelve matrices were transcribed
mechanically from its transcript (`scripts/extract-previous-audit-certificates.py`) and re-verified
exactly here (`scripts/previous-audit-check.g`, `logs/previous-audit-check.log`).

What it meant by "up to enantiomorphism": its ledger entry C-CONG states the interpretation explicitly,
"polytopes normalised to `S^3`, i.e. congruence up to scale, exactly what `compare.g`'s rescaling
implements", and its transcript labels every pair "CONGRUENT up to scale ... lambda = ...".  Its prose,
however, says "two congruence classes", "congruent copies of the same handedness" and "12 realisations
up to congruence and enantiomorphism" without the qualifier.

| previous audit's claim | classification | evidence |
|---|---|---|
| In every abstract class the four realisations fall into exactly two "congruence classes"; total 12, two per class | **verified only up to similarity** on the stored data (`lambda != 1` in all 12 pairs, so they are not congruent as stored); **verified** as congruence after the unit-sphere normalisation | Sections 3-4; `previous-audit-check.log` lines `lambda <> 1` (12 PASS) |
| The twelve specific pairs (class 1 `{0,1/2}`, `{oo,2}`; class 2 `{0, 0.3041}`, `{1, -6.9385}`; class 3 `{0, 0.1459}`, `{1, -5.8541}`; class 4 `{1.8155, 3.0322}`, `{-0.0701, 0.2038}`; class 5 `{-0.2560, 0.3298}`, `{1.4921, 4.9063}`; class 6 `{-1, 0.6180}`, `{2, 2.6180}`) | **verified** (identical to the partition found here by four independent methods) | `EQUIVALENCE-TABLE.tsv`, `CERTIFICATES.md` |
| Each printed certificate `g` satisfies `g g^T = lambda I`, maps `V, E, F, C` of `a` onto those of `b` and conjugates `Gamma_a` onto `Gamma_b` | **verified** exactly for all 12 matrices | `previous-audit-check.log` (12 PASS each) |
| All twelve certificates are proper (`det g > 0`): same handedness, "not merely enantiomorphs" | **verified** (and strengthened: the exhaustive enumerations here show no improper similarity exists at all) | Methods 1, 2, 4; `previous-audit-check.log` `det g = +lambda^2` (12 PASS) |
| "The `alpha = 1/2` realisation is a rotated, rescaled copy of Roli's cube" | **verified**; this is the accurate wording | `CERTIFICATES.md` No. 1 |
| The two pairs of a class are separated by the edge inner product and the 2-face profile | **verified** (Method 4: the scale-free edge inner products differ for all 80 non-certified equal-f-vector ordered pairs; Methods 1 and 2: exhaustive non-existence) | `logs/method4-invariants.tsv` |
| Roli's cube has exactly two non-congruent realisations (`alpha = 0, oo`); the thesis class has two (the two thesis polytopes) | **verified** after normalisation (as stored: four non-congruent, two non-similar) | Section 6 |
| Prose example: "`g = 1/2 [[1,0,-1,1],...]` maps the `alpha = 1/2` polytope onto the `alpha = 0` one, with `g g^T = 3/4 I`" | **contradicted as to direction** (immaterial): with `lambda = |w_b|^2/|w_a|^2 = 3/4` the map goes from `alpha = 0` (`|w|^2 = 4`) to `alpha = 1/2` (`|w|^2 = 3`), which is what its own transcript records (`L3-{4,3,3}-6 vs L3-{4,3,3}-1`, `w_a g = w_b`) | `previous-audit-check.log` |
| "A first guess at the mechanism - that `g` is the `rho_1`-type half-turn normalising the cell group - is false for every pair ... identifying the geometric reason for the pairing is left open" | **contradicted in substance** (its test asked whether `g` *equals* a scalar multiple of the half-turn, but `g` is defined only up to `Gamma_b`): every one of its twelve `g` lies in the coset `(M0/c) Gamma_b` of exactly that half-turn (12/12 PASS), and the geometric reason is Section 5: `M0` reflects the PETCOX circle about the axis through the regular base vertices | `previous-audit-check.log` `MECHANISM` lines; Method 3 |
| "12 realisations up to congruence and enantiomorphism" | count **verified**; terminology **misleading**: "congruence" holds only after the `S^3` normalisation (its own ledger says so; its headline prose does not), and "enantiomorphism" plays no role because every identification is proper | Sections 2, 4, 5 |

None of its equivalence claims is unresolved.  Its refutation of the producer's "24" stands.

## 9. What the repository proves and what is mathematically intended

* Proved by the producer at commit `71ef1cd`: 24 distinct records, i.e. 24 pairs `(alpha, T)`, each
  giving a faithful geometrically chiral realisation; that the stored data of no two coincide; that
  `(0, oo)` in the cube family are not congruent.  Not proved there: that the 24 are pairwise
  non-congruent (false for 12 pairs after normalisation) or non-similar (false for 12 pairs as stored).
* Proved here: the 24 stored realisations form exactly 12 classes under similarity, equivalently under
  congruence after the PETCOX normalisation, equivalently under proper congruence after normalisation;
  24 classes under congruence of the stored coordinates; no two are mirror images; all 12 identifications
  are half-turns.
* Intended finite statement (the one the theorem should assert): *up to congruence there are exactly 12
  faithful geometrically chiral skeletal 4-polytopes in `E^4` whose cells are (congruent to) PETCOX
  polyhedra `H_alpha(T)` on `S^3`, two in each of the six abstract classes; each is geometrically chiral
  and none is congruent to the mirror image of another, so the count is the same whether or not mirror
  images are identified.*  Equivalently: 12 up to similarity for polytopes of arbitrary scale.  The
  conclusion "12" is therefore valid, but the words "up to congruence" require the normalisation to be
  stated, and "up to enantiomorphism" is superfluous.

## 10. Verdict

The previous audit's central equivalence claim - the 24 stored realisations reduce to 12, two per
abstract class, by the twelve pairings it lists, with proper certificates - is **correct in
substance**: the pairings, the certificates, the count 12 and the same-handedness statement are all
confirmed here by four independent exact implementations and an exhaustive search.  Its wording needs
two corrections: (1) on the stored coordinates the certificates are **similarities** with
`lambda = c^2 != 1` (never congruences), and they become **congruences** only after the unit-sphere
normalisation that defines PETCOX polyhedra - so "12 up to congruence" is true of the normalised
polytopes and false of the stored coordinate sets, of which there are 24 congruence classes;
(2) "and enantiomorphism" is superfluous: all twelve identifications are proper half-turns, no
stored realisation is the mirror image of another, and the only enantiomorphism involved is the
combinatorial one between the two stored generating triples of a single polytope.  The producer's
"exactly 24 up to congruence and enantiomorphism" is false as a count.

**VERIFIED WITH CORRECTED TERMINOLOGY**
