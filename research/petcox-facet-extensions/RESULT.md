# Result

## Direct answer

**Yes.  Besides Roli's cube and the two realisations of the thesis, twenty-one
further chiral skeletal 4-polytopes in `E^4` have PETCOX polyhedra
`H_alpha(T)` as their cells, and they are now classified completely.**

Up to congruence and enantiomorphism there are exactly **24 faithful,
geometrically chiral skeletal 4-polytopes in `E^4` whose cells are PETCOX
polyhedra**, and they realise exactly **6 abstract 4-polytopes**:

| class | Schlaefli type | f-vector | `|Gamma|` | vertex-figure | cells | `X(P)` | combinatorially | realisations | status |
|---|---|---|---|---|---|---|---|---|---|
| 1 | `{8,3,3}` | (16, 32, 12, 4) | 192 | `{3,3}` | `H_alpha({4,3,3})`, type `{8/(1,3),3}` | `C2` | chiral | 4, at `alpha = 0, 1/2, 2, oo` | `alpha = 0` is **Roli's cube** [BHP 2014]; the other three are apparently unpublished |
| 2 | `{30,3,3}` | (600, 1200, 120, 5) | 7200 | `{3,3}` | `H_alpha({5,3,3})` type `{30/(1,11),3}` and `H_alpha({5/2,3,3})` type `{30/(7,13),3}` | `SL(2,5)` | chiral | 4 | no published construction located, but **announced in unpublished work** of Hubard and Trejo and computed in a public GitHub GAP appendix with these exact invariants: **not claimed as new** (see Novelty) |
| 3 | `{12,3,5}` | (120, 720, 300, 50) | 7200 | `{3,5}` | `H_alpha({5,3,5/2})`, type `{12/(1,5),3}` | `SL(2,5)` | chiral | 4, two of them the **thesis** polytopes | `alpha = 0` and `alpha = 1` are the thesis `{12/(1,5),3,5/2}` and `{12/(1,5),3,5}`; the other two are apparently unpublished |
| 4 | `{12,3,3}` | (240, 480, 120, 20) | 2880 | `{3,3}` | `H_alpha({5,3,5/2})` | trivial | **directly regular** (combinatorially regular, geometrically chiral) | 4 | apparently unpublished |
| 5 | `{12,3,4}` | (48, 144, 48, 8) | 1152 | `{3,4}` | `H_alpha({5,3,5/2})` | `Q8` | chiral | 4 | the abstract polytope **is** Conder's chiral census entry of type `[4,3,12]` and order 1152 (identified exactly, conder-check.g); the realisations are apparently unpublished |
| 6 | `{12,3,5}` | (120, 720, 300, 50) | 7200 | `{3,5}` | `H_alpha({5,3,5/2})` | `SL(2,5)` | chiral | 4 | apparently unpublished; **not isomorphic to class 3** although it has the same type, f-vector and group order |

Every cell of every one of the 24 realisations is a geometrically chiral
PETCOX polyhedron (none of the admissible `alpha` is one of the exceptional
values at which `H_alpha(T)` becomes geometrically regular), and every one of
the 24 realisations is geometrically chiral: its full isometry group is
`Gamma`, which has two flag orbits with adjacent flags in different orbits
(theory.md Prop. D1).  Class 4 shows that geometric chirality does not require
combinatorial chirality, exactly as in [BHP] Theorem 1.

**The classification is complete**, not merely a survey of a search space:
theory.md Propositions B2, E1-E5 reduce the problem to finitely many exactly
solvable equations over `Q(sqrt 5)`, with no parent group assumed and no case
left open (alpha-complete.g: 226 assertions, 0 failures, and the final check
"number of polynomial factors with real roots that could not be solved
exactly" returns 0).

The working claim recorded in `zoom-5-sept.md` ("we cannot create another
chiral 4-polytope from any chiral polyhedra from petcox paper") is therefore
**refuted**, and refuted in a strong sense: not one but 21 further
realisations exist, in 4 further abstract isomorphism classes.

## The new abstract polytope of type {30,3,3} (class 2)

This is the one the research question pointed at, since [PETCOX] p. 25 says
"`H_0({5,3,3})` can be taken as facet of a chiral 4-polytope" without
constructing one.

* Facet type `{30/(1,11),3}` resp. `{30/(7,13),3}`, facet group of order 1440,
  cells with 480 vertices, 720 edges and 48 helical 30-gons.
* Abstract facet: the regular orientable map of type `{30,3}` and genus 97
  with 480 vertices, 720 edges, 48 faces, 2880 automorphisms and **Petrie
  polygon length 40**.  It has no name in Hartley's atlas, which stops at 2000
  flags.  In Conder's census of regular orientable maps it is **`R97.10`**
  (`Type {3,30}_40 Order 2880`), not `R97.9` (`Type {3,30}_20`) as stated in
  [PETCOX] p. 29: our cell satisfies every defining relator of `R97.10` and
  fails the last relator of `R97.9`, tested in the full automorphism group of
  order 2880, and independently its Petrie polygon length is 40 rather than 20
  (computed twice, and the same methods reproduce the published Petrie lengths
  of `{8,3}*96`, `{12,3}*288`, `{12,4}*384e` and the dodecahedron).  The
  `R151.11` identification made in the same sentence of [PETCOX], for the
  `{20,5}` cells, is confirmed by the same tests.  [conder-check.g, 47
  assertions.]
* Vertex-figure: the tetrahedron `{3,3}`.  So `P` has 5 cells, and each of the
  600 vertices lies in 4 of them.
* Rotation group `Gamma = [3,3,5]^+` of order 7200 for the two `alpha = 0`
  realisations (`Gamma` is a different, conjugate copy of a group of order
  7200 for the other two).
* f-vector `(600, 1200, 120, 5)`; 1-skeleton = that of the 120-cell for the
  `{5,3,3}` realisations and of the great grand stellated 120-cell for the
  `{5/2,3,3}` ones (same 600 vertices, different edges).
* Combinatorially chiral: the Schulte-Weiss mirror assignment does not extend
  (witness: `ord(S1^{-1}S3) = 30` versus `ord(S1S3) = 5`, and a certified
  presentation whose mirrored relator has order 6).
* Chirality group `X(P) = SL(2,5)` of order 120, `[Gamma : X] = 60`,
  `Gamma/X(P) = A5` with generator orders `(3,3,3)`, coset f-vector
  `(5,10,10,5)` and the intersection property: **the largest directly regular
  quotient of `P` is the 4-simplex `{3,3,3}`**, so `P` is a chiral 120-fold
  cover of the simplex.  The smallest directly regular cover has rotation
  group of order 864000.
* The four realisations, with `alpha` exact and numeric:
  `{5,3,3}` at `alpha = 0` and at `alpha ~ 0.304114`; `{3,3,5/2}` at
  `alpha = 1` (which is `H_0({5/2,3,3})`) and at `alpha ~ -6.93853`.  The
  exact values are in `logs/summary-rows.tsv` and `candidate-table.tsv`.

## The other new classes

* **Class 4, type `{12,3,3}`, f-vector (240,480,120,20), `|Gamma| = 2880`.**
  Directly regular as an abstract polytope (`X(P)` trivial, the mirror
  automorphism exists and is involutory) but geometrically chiral in `E^4`,
  with cells the chiral polyhedron `H_alpha({5,3,5/2})` of type `{12/(1,5),3}`
  and tetrahedral vertex-figures.  `Gamma` has structure
  `(SL(2,5) : (C2 x C2)) : S3`.  Four realisations, at
  `alpha ~ 1.81549, -0.070131, 0.20382, 3.03225`.  This is the exact analogue
  of [BHP] Theorem 1 one rank up: a combinatorially regular 4-polytope with a
  geometrically chiral realisation and geometrically chiral cells.
* **Class 5, type `{12,3,4}`, f-vector (48,144,48,8), `|Gamma| = 1152`.**
  Combinatorially chiral with `X(P) = Q8`; `Gamma/X(P) = S4 x S3` with
  generator orders `(6,3,4)`, coset f-vector `(6,18,12,8)` and the
  intersection property, so the largest directly regular quotient is a regular
  4-polytope of type `{6,3,4}` with 6 vertices.  Cells `H_alpha({5,3,5/2})`,
  vertex-figures octahedra.  Four realisations at
  `alpha ~ 1.49207, -0.255998, 0.329788, 4.90628`.
* **Class 6, type `{12,3,5}`, f-vector (120,720,300,50), `|Gamma| = 7200`,
  `X(P) = SL(2,5)`.**  Same type, f-vector, group order and chirality group as
  the thesis polytope (class 3), yet **not isomorphic** to it.  Two
  independent proofs: (i) no isomorphism of the rotation groups carries the
  distinguished triple of one to the triple of the other or to its mirror
  (compare.g); (ii) the orientation-independent word invariant differs, namely
  the multiset over the two flag orientations of
  `(ord(S1S3), ord(S1^{-1}S3), ord(S3S2S1), ord(S1S2S3^{-1}), ord(S1^2S3), ord(S1S3^2))`
  is `{(5,15,15,2,15,12), (15,5,5,2,10,15)}` for class 3 and
  `{(10,30,30,2,15,12), (30,10,10,2,10,30)}` for class 6 (summary.g).
  Four realisations at `alpha ~ -1, 0.618034, 2, 2.61803`.

## Roli's cube has four non-congruent chiral realisations

For `T = {4,3,3}` the complete list of admissible base vertices is
`alpha = 0, 1/2, 1, 2, -1, oo`, of which `alpha = 1` and `alpha = -1` fail the
intersection condition (defect 2, the vertex collapse of `H_1({4,3,3})`) and
the other four give faithful chiral 4-polytopes.  All four realise the same
abstract polytope, Roli's cube, and no two of them are congruent even after
reflection:

| `alpha` | vertex set | edges | note |
|---|---|---|---|
| 0 | the 16 vertices of the 4-cube | the 32 edges of the 4-cube | **Roli's cube** [BHP 2014]; the 2-faces are 12 of the 24 Petrie octagons of the 4-cube |
| `oo` | the same 16 vertices | the 32 main diagonals of the 8 cubic facets (pairs of vertices differing in three coordinates) | no element of `[4,3,3]` carries it to Roli's cube or to the mirror image of Roli's cube, and since every isometry preserving the vertex set lies in `[4,3,3]`, it is not congruent to either; its cells are a non-congruent realisation of the same abstract facet `{8,3}*96` |
| 1/2 | a 16-point orbit of a group of order 192 not contained in `[4,3,3]` | 32 | apparently unpublished |
| 2 | as for `alpha = 1/2` (different orbit) | 32 | apparently unpublished |

[roli-alpha-infinity.g: 10 assertions; alpha-complete.g; compare.g gives the
four congruence classes.]

## How the classification is obtained

1. **The base vertex is confined to a circle** (theory.md B1-B2):
   `Fix(S2) = span(v0, v3)`, so every base vertex is a PETCOX point
   `w_alpha`, and the cell of the extension is `H_alpha(T)`.
2. **The third generator is unique for each base vertex** (E1): writing
   `A = S2 X`, the relations say exactly that `A` is an involution inverting
   `S1`; such an `A` is a half-turn about a plane meeting the two invariant
   planes of the twist `S1` in lines, and it fixes `w = w_1 + w_2` iff those
   lines are `span(w_1)` and `span(w_2)`.  So `X = X_alpha` is a function of
   `alpha`, computed here as an explicit rational function of the projective
   parameter.
3. **The vertex-figure is a Platonic solid** (E2): `<S2, X>` fixes `w`, hence
   lies in an `SO(3)`; being finite, generated by two rotations of orders
   `q, m >= 3` with `S2X` an involution, and satisfying `<S2> cap <X> = 1`, it
   is `A4`, `S4` or `A5`.  Hence `ord(X) in {3,4,5}` and
   `1/2 + 1/q + 1/m > 1`.
4. **A trace equation** (E3): `X` fixes the base edge pointwise, so
   `tr(X) = 2 + 2 cos(2 pi k/m)`; clearing denominators gives a polynomial of
   degree at most 4 in the parameter, solved exactly (factorisation over
   `Q(sqrt 5)`, quadratics by radicals with the sign of the discriminant
   decided exactly, real roots of the rest counted by Sturm's theorem).
5. **Two obstructions** dispose of the residual roots: the quaternionic
   projection bound (E4), which forces `Gamma` into `[3,3,5]^+` or
   `+-[O x O]` when the vertex-figure is icosahedral or octahedral and hence
   bounds `|Gamma|` by 7200, and a Kronecker-Weber trace argument (E5), which
   kills the eight quadratic factors whose real roots are not cyclotomic.
6. Every surviving base vertex is then verified completely: relations,
   intersection condition, coset and orbit f-vectors, face stabilisers,
   diamond condition, orientation of the generators, connectedness,
   vertex-figure, spanning, faithfulness, geometric chirality, and the
   Schulte-Weiss mirror test with an explicit obstruction when it fails.

## Level 1 and Level 2 (the canonical and parent-group answers)

**Level 1, canonical extension `S3 = R3R2`** [canonical.g, 275 assertions].
`Gamma = W^+(T)` always, the base vertex is forced to `alpha = 0`, and the
extension exists iff `H_0(T)` has no vertex collapse.  Five of the twenty
endpoint records survive and eleven fail with a proved obstruction whose
defect equals the collapse multiplicity of the PETCOX table (four of the
remaining records are the second endpoint of a self-dual `T`, hence
duplicates):

| `T` | defect | result |
|---|---|---|
| {3,3,3}, {3,3,3}* | 4 | PROVED-OBSTRUCTION-CANONICAL |
| {4,3,3} | 1 | KNOWN-CONSTRUCTION (Roli's cube) |
| {3,3,4} | 2 | PROVED-OBSTRUCTION-CANONICAL |
| {3,4,3}, {3,4,3}* | 2 | PROVED-OBSTRUCTION-CANONICAL |
| {5,3,3} | 1 | PROVED-CONSTRUCTION (class 2) |
| {3,3,5} | 4 | PROVED-OBSTRUCTION-CANONICAL |
| {3,5,5/2}, {5/2,5,3} | 2 | PROVED-OBSTRUCTION-CANONICAL |
| {5,5/2,5}, {5,5/2,5}* | 12 | PROVED-OBSTRUCTION-CANONICAL |
| {5,3,5/2} | 1 | KNOWN-CONSTRUCTION (thesis {12/(1,5),3,5/2}) |
| {5/2,3,5} | 1 | KNOWN-CONSTRUCTION (thesis {12/(1,5),3,5}) |
| {3,3,5/2} | 4 | PROVED-OBSTRUCTION-CANONICAL |
| {5/2,3,3} | 1 | PROVED-CONSTRUCTION (class 2) |
| {3,5/2,5}, {5,5/2,3} | 2 | PROVED-OBSTRUCTION-CANONICAL |
| {5/2,5,5/2}, {5/2,5,5/2}* | 12 | PROVED-OBSTRUCTION-CANONICAL |

**Level 2, third generators inside finite parent groups** [parent-search.g,
37 assertions].  Exhaustive over `W(T)` for all 16 `T`, over `[3,3,5]` for an
embedded `{3,3,3}`, over `[3,4,3]` and `[[3,4,3]]` (order 2304) for `{4,3,3}`,
`{3,3,4}` and `{3,4,3}`, and over the normalisers `N_{O(4)}(G)` of the facet
groups (orders 120, 96, 384, 2880, 2400, 14400, 288, 2880, 2400, 14400,
computed from `Aut(G)` by exact intertwining; the four largest are reported
but not enumerated).  Findings: inside `W(T)` the only admissible third
generators are the canonical `R3R2` (`alpha = 0`), the dual canonical `R0R1`
(`alpha = 1`) and, for the cube row only, one further element at
`alpha = oo`; the embedded chiral dodecahedra `H_alpha({3,3,3})` admit third
generators of order 3 at `alpha = phi` and `alpha = -1/phi` whose abstract
polytope is the regular 120-cell but whose Wythoff realisation collapses five
abstract vertices onto each point (vertex stabiliser of order 60 instead of
12), so they are PROVED-OBSTRUCTION-IN-PARENT; nothing else survives.  Every
Level 2 survivor reappears in the Level 3 list, which is the completeness
check on the searches.

## Classification of every tested case

`candidate-table.tsv` has one row per tested case with these values:

* `KNOWN-CONSTRUCTION`: Roli's cube and the two thesis polytopes.
* `PROVED-CONSTRUCTION`: the 21 further realisations.
* `PROVED-OBSTRUCTION-CANONICAL`: the eleven canonical endpoints whose
  intersection defect equals the PETCOX vertex collapse.
* `PROVED-OBSTRUCTION-IN-PARENT`: every base vertex of the Level 3 list, and
  every parent-group element, that fails the intersection condition, gives a
  non-faithful realisation, has `ord(X) < 3`, or forces an infinite group.
* `DUPLICATE`: parent-search and Level 3 rows that are identical to, or the
  mirror image of, an earlier row; and the four self-dual second endpoints.
* `COMPUTATIONAL-EVIDENCE-ONLY`: none.
* `UNRESOLVED`: none in the geometric classification.  See the limits below
  for the two abstract questions that remain open.

## Novelty

The literature audit (references.md) found no published construction of any
finite chiral 4-polytope in `E^4` other than Roli's cube, in any of arXiv,
zbMATH, Crossref, OpenAlex, Semantic Scholar, DBLP, Google Scholar, Conder's
and Hartley's censuses, the two 2020/2025 monographs, or the authors' own
pages.  Accordingly the wording used above is **apparently unpublished**, not
"new".  Two caveats:

1. **Prior art that is announced but not public.**  Hubard and Schulte,
   *Two-Orbit Polytopes*, arXiv:2604.00185 (31 March 2026), cite
   J. Bracho, D. Gonzalez-Casanova and I. Hubard, *Two new chiral 4-polytopes
   of full rank*, as "In preparation" (their reference [1]) and
   I. Hubard and B. Trejo, *A family of skeletal chiral 3- and 4-polytopes in
   `R^4`*, as "Preprint" (their reference [31]).  A UNAM PAPIIT project report
   (IN109023, final report for 2023) describes the Hubard-Trejo work as a
   classification of the chiral skeletal polyhedra whose 1-skeleton lies in
   the graph of a convex regular 4-polytope, together with a determination of
   which of them extend to chiral 4-polytopes in `E^4`.  Since
   `H_0({5,3,3})` lies on the 1-skeleton of the 120-cell, that preprint is
   the most likely overlap with class 2 here.  Neither item could be
   retrieved.
2. **Class 2 in particular must not be claimed as new.**  The audit found a
   public GitHub GAP appendix belonging to Trejo's doctoral thesis that
   computes an object with exactly the invariants of class 2: f-vector
   (600, 1200, 120, 5), group order 7200, cell rotation group of order 1440
   and vertex-figure group of order 12.  Together with the 2023 conference
   abstract (a classification of the chiral polyhedra with helical faces whose
   skeleton lies in the skeleton of a convex regular 4-polytope, which is the
   family containing `H_0({5,3,3})`) and the PAPIIT report, the correct
   statement is: **the extension of `H_0({5,3,3})` to a chiral 4-polytope is
   announced as achieved in the unpublished Hubard-Trejo work and computed in
   public in that GAP appendix**; this report reproduces it independently,
   proves that it is complete, and adds its abstract invariants (chirality
   group `SL(2,5)`, largest directly regular quotient the 4-simplex, the
   second realisation from `{5,3,3}` and the two from `{3,3,5/2}`).
3. **Abstract versus geometric novelty.**  The abstract polytopes of classes 1
   and 5 are inside Conder's published census of chiral polytopes with up to
   4000 flags (maximum group order 2000), and both were **identified exactly**
   here [conder-check.g]: class 1 is the entry "Chiral 4-polytope with group
   of order 192 NSD Type [ 3, 3, 8 ]" and class 5 is "Chiral 4-polytope with
   group of order 1152 NSD Type [ 4, 3, 12 ]"; in each case the
   dual-and-mirror variant of our distinguished triple satisfies every one of
   Conder's relators and the group orders agree.  Classes 2, 3, 4 and 6 have
   14400, 14400, 5760 and 14400 flags and are beyond every published census,
   which therefore cannot speak to them either way.  What is new in all six
   cases is the **geometric** statement: a faithful, geometrically chiral
   realisation in `E^4` whose cells are PETCOX polyhedra.

## Unresolved limits

1. Abstract existence of chiral 4-polytopes whose cells are the PETCOX maps of
   types `{5,3}`, `{12,4}` (genus 17), `{20,5}` (genus 151) or `{15,5}`
   (genus 841) is not decided.  What is decided (theory.md E6) is that none of
   them can be realised faithfully in `E^4` with PETCOX cells.
2. Novelty: for class 2 the construction is announced in unpublished
   Hubard-Trejo work and computed in a public GitHub GAP appendix, so it is
   not claimed as new; for classes 4 and 6 and for the further realisations of
   classes 1 and 3 the wording is "apparently unpublished", since absence of a
   publication is not proof of novelty and two relevant manuscripts could not
   be obtained.
3. The bodies of Pellicer's 2025 monograph (Chapter 6, Appendix C) and
   McMullen's 2020 monograph could not be retrieved, so it is not known
   whether either discusses these facets or announces a further finite chiral
   4-polytope in `E^4`.
4. Of the seven distinct abstract cells, five are identified with a named
   census entry (the dodecahedron; `{8,3}*96` = Conder R2.1; `{12,3}*288` =
   R7.2; the `{30,3}` cell = R97.10; the `{20,5}` cell = R151.11).  The
   `{12,4}` cell of genus 17 (group order 384) is `{12,4}*384e` in Hartley's
   atlas but was not separated from the two same-type genus-17 entries
   R17.11 and R17.12 of Conder's map census, and the `{15,5}` cell of genus
   841 lies beyond Conder's published range (genus at most 301), so it has no
   census name.

## Reproduction

    cd research/petcox-facet-extensions && ./verify.sh
