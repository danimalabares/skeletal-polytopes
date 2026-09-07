# Source notes: exact statements and citations

All page numbers refer to the local files listed below (the published PDF of
PETCOX and the AMS reprint of Schulte and Weiss).  Quotations are verbatim
except for the reconstruction of mathematical symbols that the PDF text
layer flattens (marked with square brackets).

## Principal sources and SHA-256 hashes (computed 2026-09-06)

| file | SHA-256 | what it is |
|---|---|---|
| `~/dr/skeletal-polytopes/petcox.pdf` | `462428270b44ef53deceec14835fafa9379824bb145b0cb2326d68c6a24347d5` | J. Bracho, I. Hubard, D. Pellicer, *Chiral polyhedra in 3-dimensional geometries and from a Petrie-Coxeter construction*, author version dated January 19, 2021, 32 pp. Published: Discrete Comput. Geom. **66** (2021), no. 3, 1025-1052, DOI 10.1007/s00454-021-00317-0 (verified against Crossref, Springer and zbMATH Zbl 1475.52019; the local file is byte-identical in content to the author copy on Bracho's UNAM page). No arXiv version exists. Cited below as [PETCOX]. |
| `~/github/skeletal-polytopes/two-chiral.tex` | `8cdc0a6b4dd0f2502683f63cc3c4594bbd955187b3249dd642be8627ff2f345e` | J. Bracho, D. Gonzalez-Casanova, I. Hubard, *Two new chiral 4-polytopes of full rank*, manuscript. Byte-identical to `~/github/daniel/skeletal-polytopes/my-masters-thesis.tex` (same hash). Cited as [Thesis]. |
| `~/dr/skeletal-polytopes/schulte-asia-chiral.pdf` | `899f7d24ed07b2e74bde389a14a2a25cc1182f282ad42208ee8bfd3921fe81b3` | E. Schulte, A. I. Weiss, *Chiral polytopes*, DIMACS Ser. 4 (1991) 493-516. Cited as [SW]. |
| `~/dr/skeletal-polytopes/schulte-chiral1.pdf` | `ed0ab4bf971fc1062d680b63858ddbe728deda58377d3c2faea2dd0a862e8b9c` | E. Schulte, *Chiral polyhedra in ordinary space, I* (DCG 32, 2004). Consulted only for context. |
| `~/dr/skeletal-polytopes/schulte-chiral2.pdf` | `3dda2e279f61412d316cd2c6db66d397d4fd921c42ab6f89dfdfca1c79c64968` | E. Schulte, *Chiral polyhedra in ordinary space, II* (DCG 34, 2005). Context only. |
| `~/dr/skeletal-polytopes/chiral-4-polytope.pdf` | `437e4ae4249fbe6e7d851b0b5111589201ba0c0a6b3f78f3c1897469cf58a5ea` | J. Bracho, I. Hubard, D. Pellicer, *A finite chiral 4-polytope in R^4*, DCG 52 (2014) 799-805, DOI 10.1007/s00454-014-9631-4. Cited as [BHP]. |
| legacy GAP scripts (`~/github/daniel/skeletal-polytopes/`) | `abstract.g 89dcbdb1…4fb7`, `chiral.g 752fcf2a…d9d4a`, `combinatorially-chiral-cube.g c52b9fc9…3ebb`, `combinatorially-chiral.g f17258fc…1c4`, `cube.g 5bea8f62…4261`, `geometric.g ed02a17b…09be`, `dual.g a5556338…4958`, `geometric-dual.g b363134a…8666`, `abstract-dual.g df35a331…cb39` | full hashes in `logs/SHA256SUMS` |

The repository has no `AGENTS.md`; `git status` at the start showed only the
untracked note `zoom-5-sept.md`, which records the working hypothesis "we
cannot create another chiral 4-polytope from any chiral polyhedra from petcox
paper".  Nothing outside `research/petcox-facet-extensions/` was modified.

## [PETCOX] Bracho, Hubard, Pellicer 2021

* Section 3, p. 15: definition of `PC_alpha(T)` for a regular 4-polytope `T`
  with planar faces and `0 < alpha < 1`: the point `(v,c)_alpha` is "the point in
  the line through `v` and the centre of `c` that is at distance `alpha d` from
  `v` and at distance `(1-alpha) d` from the centre of `c`".
* Remark 12, p. 17: "if `T*` denotes the dual 4-polytope of `T`, then
  `PC_alpha(T) = PC_{1-alpha}(T*)`."  Hence `H_alpha(T) = H_{1-alpha}(T*)`.
* Theorem 13, p. 17: `PC_alpha(T)` is regular or a 2-orbit polyhedron in class
  `2_{0,2}`.  Definition p. 17: `H_alpha(T) := (PC_alpha(T)^eta)^phi` (halving,
  then facetting).
* Proposition 14, p. 18: "Assume that for some `alpha` in `(0,1)` and some
  regular 4-polytope `T` of `X`, `H_alpha(T)` is a polyhedron.  Then
  `H_alpha(T)` is either regular or chiral."  Its proof produces the
  symmetries `S2 = RT` and `S1 = T'R'TR`.
* p. 19: "our definitions naturally extend to consider values of `alpha` in all
  of `R`. [...] Some values of `alpha` (particularly 0 and 1, but maybe more)
  result in distinct pairs `(v,c)` and `(v',c')` of incident vertex and cell of
  `T`, having the points `(v,c)_alpha` and `(v',c')_alpha` coincide and the
  'polyhedron' `PC_alpha(T)` (or `H_alpha(T)`), degenerates to a structure not
  satisfying Definition 1.  However, for all other values of `alpha`, the
  polyhedra `PC_alpha(T)` (respectively, `H_alpha(T)`) are isomorphic and have
  the same symmetry group, regardless of whether `alpha` is in `(0,1)` or not."
* p. 20, equations (2), (3): `S1 = R0 R1 R3 R2`, `S2 = R2 R1`, where `R0,...,R3`
  are the reflections of `T` sending the base flag to its `i`-adjacent flags.
  "Since `T` is regular, the symmetry group is transitive on the vertex-cell
  incident pairs, and hence the vertices [...] can be described as the orbit
  under `G(T)` of the vertex `(v,c)_alpha` [...]. Since `G(H_alpha(T)) >= <S1,S2>`
  [...] the vertices of `H_alpha(T)` are the orbit of `bar v` under
  `G := <S1,S2>`."  (p. 19-20.)  The base edge is the segment between `bar v`
  and `bar v S1^{-1}`; the base face is the orbit of the base edge under `<S1>`.
* p. 20: `S1` "is a twist (or screw motion) and its only fixed point (in `R^4`)
  is the centre of the (finite) polytope but it is fixed-point free in `S^3`.
  On the other hand, `S2` is a rotation on a line (great circle) of `S^3`".
  Type notation `{p/(p1,p2), q}`: `2 pi p1/p` and `2 pi p2/p` are the rotation
  angles of `S1` on its two invariant planes.
* p. 20: "For computational simplicity, we linearize the meaning of the
  parameter `alpha`, so that [...] `(v,c)_alpha = [(1-alpha) v0 + alpha v3]`;
  where, by `[x]` we denote the normalization of `x`."  p. 21: "for
  `alpha = 0, 1, 1/2, infinity`, `(v,c)_alpha` will respectively mean
  `[v0], [v3], [[v0]+[v3]], [[v3]-[v0]]`."
* p. 22 ({3,3,3}): type `{5/(1,2),3}`, combinatorially the dodecahedron; "For
  `alpha = 1/2, infinity`, `H_alpha({3,3,3})` is regular, and for all other
  `alpha != 0, 1` it is a chiral polyhedron [...]. For `alpha = 0, 1` it
  collapses: groups of 4 vertices merge".
* p. 23 ({4,3,3}): "The general `H_alpha({4,3,3})` has type `{8/(1,3),3}`. In
  this case, for `alpha = 0` no vertices come together, so we still have a
  chiral polyhedron `H_0({4,3,3})`, which was taken as facet of a chiral
  4-polytope in `S^3` (or `R^4`) in [3]."  ([3] = [BHP].)  This is
  statement 2 of the task.
* p. 24 ({3,4,3}): type `{12/(1,5),4}`, "it becomes regular at
  `alpha = 1/2, infinity`".
* p. 25 ({5,3,3}): "The type of `H_alpha({5,3,3})` is `{30/(1,11),3}`, and for
  `alpha = 0` no vertices identify, so that `H_0({5,3,3})` can be taken as
  facet of a chiral 4-polytope, but not `H_1({5,3,3})` in which four vertices
  come together."  This is statement 3 of the task.  No 4-polytope is
  constructed or named there.
* p. 25-27: data for one member of each dual pair of star polytopes.  The
  paragraph for `{3,5,5/2}` (p. 25) prints the same basic tetrahedron, the
  same regular base vertices and the same matrix `R` as the `{5,3,3}` paragraph
  (p. 24-25); see census.md, discrepancy D1.  For `{3,3,5/2}` (p. 26):
  "Vertices that collapse at `alpha = 0, 1` are 4, 1 respectively.  The group
  `G` is of order 1440."  The endpoint `alpha = 1` of this row is
  `H_1({3,3,5/2}) = H_0({5/2,3,3})`, which the paper does not mention as a
  possible facet.
* p. 28, summary table: columns "Polytope `T`", "Type of `H_alpha(T)`", "#(G)",
  "[G : Gamma^+]", "Colapses at `alpha = (0,1)`".  The values in the fourth
  column are `1, 4, 3, 5, 6, 1, 50, 5, 6, 1`; census.md shows they equal
  `|Gamma^+(T)| / |G|`, the index of `G = <S1,S2>` in the rotation group of `T`
  (so the header reads the index in the opposite direction from its value).
* p. 28: "The groups `G` given in the above table refer to the isometry groups
  of the chiral polyhedra `H_alpha(T)`.  As we showed, these polyhedra are
  combinatorially regular, and thus the groups `G` are their rotational
  subgroups.  For each polytope `T`, we shall denote by `P_T` the (regular)
  abstract polytope `H_alpha(T)`."  Together with Theorem 9 (p. 10: "If `P` is
  a chiral polyhedron in `X` with helical faces, then it is combinatorially
  regular") this is statement 1 of the task; census-audit.g verifies it
  independently for all ten rows (rank-3 mirror automorphism exists).
* p. 29: identifications `{8,3}*96`, `{12,4}*384e`, `{12,3}*288` (Hartley's
  atlas) and `R97.9` of type `{30,3}` for `T = {5,3,3}, {3,3,5/2}`, `R151.11`
  of type `{20,5}` for `T = {3,5,5/2}, {3,5/2,5}` (Conder's list).  "Since
  `S1` is a twist, `R0` must be a half-turn, and hence it preserves
  orientation."  For the two rows with `|G| = 7200` the regular member is
  non-orientably regular and the chiral members are orientable double covers.
  The three atlas names are confirmed verbatim (references.md Section 5), but
  the `R97.9` identification does not hold: the `{30,3}` cell is Conder's
  `R97.10` (`Type {3,30}_40 Order 2880`).  It satisfies every defining relator
  of `R97.10` and fails the last relator of `R97.9`, tested in the full
  automorphism group of order 2880, and its Petrie polygon length is 40 where
  `R97.9` has 20 [conder-check.g].  The `R151.11` identification of the same
  sentence is confirmed by the same tests.  Note also that the URL of Conder's list printed in [PETCOX]
  reference [6] returns HTTP 404; the correct file name is
  `RegularOrientableMaps301.txt`.
* p. 29: Mathematica sources at
  `https://www.matem.unam.mx/~roli/PetrieCoxeter.html` (local copies of these
  notebooks exist in `~/dr/otros/tesina-maestria/PetCoxMath/`, not used here).

## [Thesis] Bracho, Gonzalez-Casanova, Hubard (two-chiral.tex)

* Abstract: "the natural rotation about the base edges of two of the chiral
  polyhedra listed in [PETCOX] generate, in each case, a chiral 4-polytope in
  `E^4`.  Furthermore, both resulting polytopes are shown to be
  combinatorially chiral."
* Section 3.1: `sigma_i := rho_{i-1} rho_i`; relations (eq.
  `equation-chiral-rels`), intersection condition (eq. `equation-chiral-int`,
  the three conditions of [SW, Lemma 11]); face groups
  `Gamma^0 = <s2,s3>, Gamma^1 = <s3, s1 s2>, Gamma^2 = <s1, s2 s3>, Gamma^3 = <s1,s2>`;
  criterion `rho(s1) = s1^{-1}, rho(s2) = s1^2 s2, rho(s3) = s3` [SW, Thm 1].
* Section 3.2: Wythoff base edge `e = v<S1 S2> = {v, v S1^{-1}}`, base face
  `e<S1>`, base cell `f<S1,S2>`.
* Section 4: `P0 = R0`, `P1 = R1R2R3R2R1R0R1R2R3R2R1`, `P2 = R3`, `P3 = R2`
  generate the group of the star polytope `{5/2,3,5}` inside `[3,3,5]`.
* Section 5: `S1 = P0P1P3P2`, `S2 = P2P1`, `S3 = P3P2`;
  `S1^12 = S2^3 = S3^5 = (S1S2)^2 = (S1S2S3)^2 = (S2S3)^2 = Id`; 120 vertices,
  720 edges, 300 faces, 50 cells; "the cells are copies of the chiral
  polyhedron denoted as `H_1({5,3,5/2})`"; the polytope `{12/(1,5),3,5}`;
  "there exists no automorphism `rho` [...] so that the abstract polytope
  [...] is combinatorially chiral."
* Section 6: `Q_i = P_{3-i}`, Wythoff on the centroid of the base cell of
  `{5/2,3,5}`: "another abstract 4-polytope that is, in fact, the same as the
  (abstract) one constructed before", realised with cells `H_0({5,3,5/2})`,
  named `{12/(1,5),3,5/2}`.  This is statement 4 of the task.

## [BHP] Bracho, Hubard, Pellicer 2014

* Theorem 1 (p. 802): the projective polytope `Q` of type `{4,3,3}` is
  combinatorially regular, isomorphic to the hemi-hypercube `{4,3,3}/2`, but
  geometrically chiral, with geometrically chiral facets; `|G(Q)| = 96`.
* Section 3 (p. 803-804): the double cover `hat Q` in `S^3 subset R^4`
  ("Roli's cube" in [Thesis]) has Schlaefli type `{8,3,3}`; "Each of the 4
  facets is of type `{8,3}`, has 16 vertices, 24 edges and 6 faces"; the
  2-face/3-face stabiliser is generated by "a 1-step 8-fold rotation followed
  by a perpendicular 3-step 8-fold rotation" (twist type `(1,3)`).
* Theorem 2 (p. 804): "The polytope `hat Q` is a chiral 4-polytope of full
  rank."  p. 805: the facet's "Wythoff space of chiral realizations is of
  dimension 2 with two of its realizations being geometrically regular".

## [SW] Schulte, Weiss 1991

* p. 496: orientation convention `sigma_i(F'_i) = F_i`.
* Proposition 6 (p. 499): stabilisers of the base faces `A_{F0} = <s2,...>`,
  `A_{Fi} = <{s_j : j != i, i+1} u {s_i s_{i+1}}>`, `A_{F_{n-1}} = <s1,...,s_{n-2}>`.
* Section 5, (10) and (14): the relations `s_i^{p_i} = (s_i ... s_j)^2 = 1`
  and the intersection property `A_I cap A_J = A_{I cap J}`.
* Theorem 1 (p. 507): for a group `A = <s1,...,s_{n-1}>` with (10) and (14),
  the poset `P(A)` is a chiral or directly regular `n`-polytope with
  `A^+(P) = A` and distinguished generators `s_i` (part (a)); its facets and
  vertex-figures are `P(<s1,...,s_{n-2}>)` and `P(<s2,...,s_{n-1}>)` (part
  (b)); "`P` is directly regular if and only if there exists an involutory
  group automorphism `rho : A -> A` such that `rho(s1) = s1^{-1}`,
  `rho(s2) = s1^2 s2`, and `rho(s_i) = s_i` for `i = 3,...,n-1`" (part (c)).
  In the proof: `A` has precisely two orbits on the flags of `P(A)`, one
  represented by the base flag and the other by its 0-adjacent flag.
* Lemma 11 (p. 511): in rank 4 the intersection property (14) is equivalent
  to `<s1> cap <s2> = 1 = <s2> cap <s3>` and `<s1,s2> cap <s2,s3> = <s2>`.
* Section 6 (p. 511-515): universal polytopes.  Proposition 12: for regular
  `P1, P2` the universal `{P1,P2}` is directly regular iff both are.
  Theorem 2 (p. 513): if `P1, P2` are (oriented) chiral or directly regular,
  not both directly regular, and the class `<P1,P2>^ch` is nonempty, then the
  universal chiral `{P1,P2}^ch` exists (free product with amalgamation).
  Theorem 3 (p. 514): if `P1, P2` are directly regular and `<P1,P2>^ch` or
  `<P1,P2>` is nonempty then the universal regular `{P1,P2}` exists and
  covers every member of both classes; "for directly regular `P1` and `P2`
  the class `<P1,P2>^ch` does not contain a 'universal' member (since the
  natural candidate for this object, `{P1,P2}`, is directly regular)" (p. 512).

## Conventions adopted here (and why)

* Matrices act on row vectors from the right (GAP).  The distinguished
  generators of every triple are checked to be in the [SW] orientation by the
  flag tests `F_i . S_i = F'_i` (lib.g, `PX.FlagChecks`), exactly as in
  `computations/chirality-groups/README.md` Section 2; consequently the mirror
  substitution of Theorem 1(c) is `S1 -> S1^{-1}, S2 -> S1^2 S2, S3 -> S3`.
* `v3` is the centroid of the base cell (average of its vertices).  Because
  `c` is the orthogonal projection of `v0` onto the fixed line of the cell
  group, `<v0, c> = |c|^2 > 0`: the centroid direction is never antipodal to
  the vertex.  The paper's printed `v3` for `{3,3,5/2}` is the antipode of the
  centroid (census.md, note N1); this only relabels `alpha` by the Moebius map
  `alpha -> alpha/(2 alpha - 1)`, which fixes 0 and 1 and swaps `1/2` and
  `infinity`.
