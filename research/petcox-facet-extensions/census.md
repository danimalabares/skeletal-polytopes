# Census of the PETCOX families H_alpha(T) and their dual endpoints

Source: [PETCOX] Section 4 and the summary table on p. 28 (see source-notes.md).
Every entry below was recomputed exactly (GAP, cyclotomic arithmetic) from the
reflection groups constructed in `gap/polytopes.g`; the paper's printed data
were audited separately in `gap/census-audit.g` (log: `logs/census-audit.log`).

## 1. The ten duality classes

`G = <S1, S2>` with `S1 = R0R1R3R2`, `S2 = R2R1`.  `p, (p1,p2)` is the twist type
of `S1` (order `p`, rotation angles `2 pi p1/p` and `2 pi p2/p`), `q = ord(S2)`.
The index is `|Gamma^+(T)| / |G|`, where `Gamma^+(T) = W^+` is the rotation
group of `T`; the table header of the paper prints it as `[G : Gamma^+]`, but
the numbers are the index of `G` in `Gamma^+(T)` (a subgroup relation verified
in census-audit.g).  `m(T), m(T^*)` are the vertex-collapse multiplicities of
the facet at `alpha = 0` and `alpha = 1`; they equal the intersection defects
`|<S1,S2> cap <S2,S3> : <S2>|` of the canonical extensions of `T` and of
`T^*` (theory.md, Prop. C1).  The abstract facet `P_T` is the regular map
`P(G; S1,S2)` with `|Gamma(P_T)| = 2|G|`.

| row | `T` (alpha=0) | `T^*` (alpha=1) | type of `H_alpha(T)` | `|G|` | `|W(T)|` | index | collapse `(m(T), m(T^*))` | facet `(V,E,F)` | `P_T` | canonical extension of `T` / of `T^*` |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | {3,3,3} | {3,3,3} (self-dual) | {5/(1,2),3} | 60 | 120 | 1 | (4,4) | (20,30,12) | {5,3} dodecahedron, genus 0 | both fail (defect 4) |
| 2 | {4,3,3} | {3,3,4} | {8/(1,3),3} | 48 | 384 | 4 | (1,2) | (16,24,6) | {8,3}*96, genus 2 | `T`: Roli's cube {8,3,3}; `T^*`: fails (defect 2) |
| 3 | {3,4,3} | {3,4,3} (self-dual) | {12/(1,5),4} | 192 | 1152 | 3 | (2,2) | (48,96,16) | {12,4}*384e, genus 17 | both fail (defect 2) |
| 4 | {5,3,3} | {3,3,5} | {30/(1,11),3} | 1440 | 14400 | 5 | (1,4) | (480,720,48) | dual of Conder R97.10, type {30,3}, genus 97, Petrie 40 | `T`: class 2, {30/(1,11),3,3}; `T^*`: fails (defect 4) |
| 5 | {3,5,5/2} | {5/2,5,3} | {20/(1,9),5} | 1200 | 14400 | 6 | (2,2) | (240,600,60) | dual of Conder R151.11, type {20,5}, genus 151, Petrie 60 | both fail (defect 2) |
| 6 | {5,5/2,5} | {5,5/2,5} (self-dual) | {15/(1,4),5/2} | 7200 | 14400 | 1 | (12,12) | (1440,3600,480) | {15,5}, genus 841 | both fail (defect 12) |
| 7 | {5,3,5/2} | {5/2,3,5} | {12/(1,5),3} | 144 | 14400 | 50 | (1,1) | (48,72,12) | {12,3}*288, genus 7 | `T`: thesis {12/(1,5),3,5/2}; `T^*`: thesis {12/(1,5),3,5} |
| 8 | {3,3,5/2} | {5/2,3,3} | {30/(7,13),3} | 1440 | 14400 | 5 | (4,1) | (480,720,48) | dual of Conder R97.10, type {30,3}, genus 97, Petrie 40 | `T`: fails (defect 4); `T^*`: class 2, {30/(7,13),3,3} |
| 9 | {3,5/2,5} | {5,5/2,3} | {20/(3,7),5/2} | 1200 | 14400 | 6 | (2,2) | (240,600,60) | dual of Conder R151.11, type {20,5}, genus 151, Petrie 60 | both fail (defect 2) |
| 10 | {5/2,5,5/2} | {5/2,5,5/2} (self-dual) | {15/(2,7),5} | 7200 | 14400 | 1 | (12,12) | (1440,3600,480) | {15,5}, genus 841 | both fail (defect 12) |

All of `|G|`, the index, `p`, `(p1,p2)`, `q` and both collapse numbers agree
with the printed table for all ten rows [canonical.g: 275 checks;
alpha-locus.g: 290 checks].  The genus of `P_T` is `1 - (V - E + F)/2`; the
identifications with Hartley's atlas (`{8,3}*96`, `{12,4}*384e`, `{12,3}*288`)
and Conder's list (`R151.11`; `R97.9`, corrected here to `R97.10`) are the
paper's (p. 29); the genera computed here (2, 17, 7, 97, 151) are consistent
with those names (the number after `R` is the genus).  For rows 6 and 10 the paper gives no name; the map
has type `{15,5}`, 1440 vertices and genus 841.

Three caveats established by the literature audit (references.md), all
retrieved on 2026-09-07:

* Hartley's atlas covers only polytopes with at most 2000 flags, so the maps
  of rows 4, 5, 6, 8, 9, 10 (group orders 2880, 2400, 14400) have **no** atlas
  name.  In particular "{30,3}*2880" and "{20,5}*2400" do not exist; the
  identifiers to use are Conder's map labels.  The three atlas names of
  [PETCOX] p. 29 are confirmed verbatim: `{8,3}*96` = SmallGroup(96,193) with
  (V,E,F) = (16,24,6); `{12,3}*288` = SmallGroup(288,847) with (48,72,12);
  `{12,4}*384e` = SmallGroup(384,18044) with (48,96,16).
* Conder's map census is taken up to isomorphism **and duality** and lists
  only the orientation with the smaller face size first, so the PETCOX cells
  appear there as their duals.  The `{30,3}` cell of rows 4 and 8 is the dual
  of `R97.10 : Type {3,30}_40 Order 2880 mV = 2 mF = 1`, **not** of `R97.9`
  (`Type {3,30}_20`) as [PETCOX] p. 29 states: our cell has Petrie length 40
  and satisfies every defining relator of `R97.10`, while failing one relator
  of `R97.9` [conder-check.g].  The `{20,5}` cell of rows 5 and 9 is the dual
  of `R151.11 : Type {5,20}_60 Order 2400`, confirming the other half of the
  same sentence of [PETCOX].
* The correct URL of the map census is
  `https://www.math.auckland.ac.nz/~conder/RegularOrientableMaps301.txt`; the
  URL printed in [PETCOX] reference [6]
  (`.../OrientableRegularMaps301.txt`) returns HTTP 404.

Note that rows 4 and 8, 5 and 9, 6 and 10, and the two endpoints of row 7 are
Galois conjugate under `sqrt 5 -> -sqrt 5` (`{5,3,3} <-> {5/2,3,3}` etc.),
which is why they share `|G|`, the index and (in swapped order) the collapse
numbers, and why the abstract facets coincide (`R97.9`, `R151.11`).

### Petrie polygon lengths of the cells

Computed twice independently (as `2 ord(S1^2 S2^2)`, and as
`ord(rho_0 rho_1 rho_2)` in the full automorphism group realised as a
semidirect product `G . <rho_0>`), and validated against the published values
for `{8,3}*96`, `{12,3}*288`, `{12,4}*384e` and the dodecahedron
[conder-check.g]:

| row | cell type | Petrie length | Conder entry (dual orientation) |
|---|---|---|---|
| 1 | {5,3} | 10 | the dodecahedron |
| 2 | {8,3} | 12 | R2.1, `{3,8}_12`, order 96 |
| 3 | {12,4} | 24 | genus 17, order 384 (R17.11 or R17.12; not separated here) |
| 4, 8 | {30,3} | 40 | **R97.10**, `{3,30}_40`, order 2880 |
| 5, 9 | {20,5} | 60 | **R151.11**, `{5,20}_60`, order 2400 |
| 6, 10 | {15,5} | 30 | genus 841, order 14400; outside Conder's published range (genus <= 301) |
| 7 | {12,3} | 24 | R7.2, `{3,12}_24`, order 288 |

## 2. Combinatorial regularity of every facet

For all ten rows the rank-3 mirror assignment `S1 -> S1^{-1}, S2 -> S1^2 S2`
extends to an involutory automorphism of `G` (GAP `GroupHomomorphismByImages`,
bijectivity and involutivity checked): the abstract polyhedra `P_T` are
directly regular, confirming [PETCOX] Theorem 9 / p. 28 (statement 1 of the
task) for the whole census [census-audit.g, `abstract facet P_T is
combinatorially regular` for all rows].  Geometrically, wherever `H_0(T)` or
`H_1(T)` is a polyhedron (rows 2, 4, 7, 8) it is chiral: the unique isometry
that could act as `rho_0` on the base face is `S1S2S3`, which is not in `G`
[alpha-locus.g `H_0 ... geometrically chiral`, canonical.g].

## 3. Exceptional (geometrically regular) values of alpha

Computed from the base vertices printed in the paper for the regular cases
(transported to the paper's own tetrahedron, in the paper's convention for
`v3`), and verified: at each such point the facet is a polyhedron and the true
`rho_1` (the unique isometry fixing the base vertex and base face and swapping
the two neighbours of the base vertex in the face; PETCOX Lemma 3) is a
half-turn that preserves the facet [census-audit.g].

| row | `T` | regular alpha (paper convention) | numerically | alpha in the centroid convention |
|---|---|---|---|---|
| 1 | {3,3,3} | 1/2, oo | 0.5, oo | same |
| 2 | {4,3,3} | 2 - sqrt 3, 2 + sqrt 3 | 0.26795, 3.73205 | same |
| 3 | {3,4,3} | 1/2, oo | 0.5, oo | same |
| 4 | {5,3,3} | 1/(1 - phi(2 - sqrt 2)), 1/(1 + phi(2 + sqrt 2)) | 19.1653, 0.15327 | same |
| 5 | {3,5,5/2} | the paper prints the row-4 data (discrepancy D1); see RESULT.md for the values recomputed from the normaliser of `G` | | |
| 6 | {5,5/2,5} | 1/2, oo | 0.5, oo | same |
| 7 | {5,3,5/2} | 1/(2 + 3 phi +- sqrt 6 phi^2) | 0.075375, 2.26627 | same |
| 8 | {3,3,5/2} | 1/(1 + phi(+-1 - 1/sqrt 2)) | 0.67847, -0.56749 | 1.90082, 0.26580 (paper's `v3` is the antipodal pole, note N1) |
| 9 | {3,5/2,5} | +- sqrt((2 + phi)/5) | +-0.85065 | same |
| 10 | {5/2,5,5/2} | 1/2, oo | 0.5, oo | same |

The paper states the values `1/2, oo` explicitly only for rows 1 and 3; the
others are read off from the printed vertices.  None of the regular values is
`0` or `1`, so every canonical endpoint facet is geometrically chiral, and none
of the regular values coincides with an admissible base vertex of any
extension found in the parent searches (RESULT.md).

The half-turns realising these regular cases never lie in `W(T)`
[alpha-locus.g: "elements of W inverting S1 and S2 ... fixing a point of the
circle: none"]; they lie in the normaliser `N_{O(4)}(G)` computed in
parent-search.g (e.g. `|N| = 96` for row 2, `384` for row 3).

## 4. Audit of the printed data (census-audit.g)

Verified for all ten rows: the printed basic tetrahedron defines mirrors
generating a group of the right order with the expected geometric marks and
f-vector (exception D1); the printed `S1` equals `R0R1R3R2` and the printed
`S2` equals `R2R1` in the row-vector convention used here (exception D1);
`#(G)` and the index column; the printed regular base vertices lie on the
circle `span(v0, v3)` and the facet is regular there.

Discrepancies found (all recorded in `logs/census-audit.log`):

* **D1 (p. 25, row {3,5,5/2}).**  The printed basic tetrahedron
  `v0 = [(phi^2, 1, -phi^-2, 0)], v1 = [(phi, phi^-1, 0, 0)], v2 = [(2+phi, 1, 0, phi^-1)], v3 = (1,0,0,0)`,
  the printed matrix `S1`, the printed regular vertices and the printed `R`
  coincide with those of the `{5,3,3}` paragraph; the mirrors of that
  tetrahedron generate the polytope with marks `{5,3,3}` and f-vector
  `(600,1200,720,120)`, not `{3,5,5/2}`.  The printed `S2` differs from the
  `{5,3,3}` one in a single sign and equals neither `R2R1` nor its transpose
  for the printed tetrahedron.  The table row for `{3,5,5/2}` itself (type
  `{20/(1,9),5}`, `|G| = 1200`, index 6, collapse `(2,2)`) is correct, as
  recomputed from an independently derived `{3,5,5/2}`.
* **D2 (p. 26, row {5,3,5/2}).**  The printed matrix
  `R = +-(1/(2 sqrt 6)) (...)` is not orthogonal as printed (its fourth row
  `(-phi^-2, 2 phi^-1, phi-3, 1)` has squared norm about 4.6 instead of 24);
  the true `rho_1` at both printed regular vertices is computed in
  `logs/census-audit.log` (rows differ from the printed ones).  The printed
  regular vertices themselves are correct: the facet is regular there.
* **D3 (p. 22-23, row {3,3,3}).**  The single printed matrix `R` (with
  `+-`) is the true `rho_1` at the vertex for `alpha = 1/2` but not (in either
  sign) at the vertex for `alpha = oo`, where the true `rho_1` is a different
  half-turn (given in the log).  Both facets are regular.
* **N1 (p. 26-27, row {3,3,5/2}).**  The printed `v3 = [(phi^-1, -1, phi, 2)]`
  is the antipode of the centroid direction of the base cell (their inner
  product with `v0 = [(1,1,1,-1)]` is `sqrt 5 - 3 < 0`, whereas the centroid
  `c` always satisfies `<v0,c> = |c|^2 > 0`).  This is a convention choice
  (the far pole of the cell's small sphere), not an error; it relabels `alpha`
  by `alpha -> alpha/(2 alpha - 1)`.  For all other rows the printed `v3` is
  the centroid direction.
* **H1 (p. 28, table header).**  `[G : Gamma^+]` should be read as
  `[Gamma^+(T) : G]`.

## 5. Vertex counts of the facets at the endpoints

`(|V|, |E|, |F|)` of the Wythoff polyhedron of `G` at `alpha = 0` and
`alpha = 1`, versus the abstract `(|G|/q, |G|/2, |G|/p)` [alpha-locus.g]:

| `T` | `H_0(T)` geometric | `H_1(T)` geometric | abstract |
|---|---|---|---|
| {3,3,3} | (5,10,6) | (5,10,6) | (20,30,12) |
| {4,3,3} | (16,24,6) | (8,24,6) | (16,24,6) |
| {3,4,3} | (24,96,16) | (24,96,16) | (48,96,16) |
| {5,3,3} | (480,720,48) | (120,720,48) | (480,720,48) |
| {3,5,5/2} | (120,600,60) | (120,600,60) | (240,600,60) |
| {5,5/2,5} | (120,720,240) | (120,720,240) | (1440,3600,480) |
| {5,3,5/2} | (48,72,12) | (48,72,12) | (48,72,12) |
| {3,3,5/2} | (120,720,48) | (480,720,48) | (480,720,48) |
| {3,5/2,5} | (120,600,60) | (120,600,60) | (240,600,60) |
| {5/2,5,5/2} | (120,720,240) | (120,720,240) | (1440,3600,480) |

At a collapsed endpoint only vertices merge (rows 2, 4, 5, 8, 9: edges and
faces stay distinct) except for rows 1, 6, 10, where edges and faces merge as
well.
