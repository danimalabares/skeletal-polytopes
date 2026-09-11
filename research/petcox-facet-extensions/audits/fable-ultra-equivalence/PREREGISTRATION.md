# Preregistration: geometric equivalence of the 24 stored PETCOX facet-extension realisations

Written 2026-09-10 before any pairwise comparison was run.  Repository HEAD
`ca649f260df19db0e3caad9e1b48932f872d361c` (branch `main`, working tree clean
apart from the untracked `zoom-5-sept.md`).  Producer commit
`71ef1cda7ca927b090068c796bfdcc10ca097a2c`, extracted with `git archive` into a
disposable scratch directory; nothing under `audits/fable-ultra/` has been
read at the time of writing.  No `AGENTS.md` exists anywhere in the tree.

## 1. Objects under audit

The producer's Level-3 run (`gap/alpha-complete.g`) wrote
`logs/alpha-survivors.g`, which contains exactly 24 records
`rec(case, T, alpha, ab = [t, 1], S1, S2, X, w, ...)`.  These are the 24
"faithful, geometrically chiral skeletal 4-polytopes in E^4 whose cells are
PETCOX polyhedra" of `RESULT.md`.  Each record determines a *stored
realisation*

    P(S1, S2, X; w) :  V = w . Gamma,  Gamma = <S1, S2, X>  (GAP row convention v*M),
                       base edge  e = { w, w S1^-1 },
                       base 2-face f = e <S1>  (vertex cycle w S1^k),
                       base cell   c = f <S1, S2>,
                       edges/faces/cells = the Gamma-orbits of e, f, c.

Facts read off the producer files that matter here:

* `S1, S2` are the PETCOX generators `R0R1R3R2`, `R2R1` of the regular
  polytope `T` from `gap/polytopes.g`; they are the SAME matrices for all
  records with the same `T`.  Rows `{5,3,5/2}` (16 records), `{4,3,3}` (4),
  `{5,3,3}` (2), `{3,3,5/2}` (2).
* The stored base vertex is `w = t v0 + v3` with the producer's
  **unnormalised** `v0`, `v3` (`lib.g` header; `alpha-complete.g` line 217).
  Consequently the stored vertex sets lie on spheres of *different radii*
  even within one family (cube family: `|w|^2 = 3, 3/4, 1, 4` for
  `alpha = 1/2, 2, oo, 0`).  The PETCOX parameter `alpha` is defined with unit
  vectors (`theory.md` line 14; `source-notes.md` quoting [PETCOX] p. 20,
  "`(v,c)_alpha = [(1-alpha) v0 + alpha v3]` where by `[x]` we denote the
  normalization of `x`").
* The producer's geometric deduplication (`gap/compare.g`) tests, for two
  records with the same scale-free Gram multiset, only whether after a
  rescaling by a rational factor found from a *parallel* pair of vertices the
  structures are identical or are mirror images under the single reflection
  `R0` of `W(T)`.  It never searches for a general isometry of `E^4`.  The
  claim "no two of the four cube realisations are congruent even after
  reflection" therefore rests on a certificate only for the pair
  `(alpha = 0, alpha = oo)` (`roli-alpha-infinity.g`, exhaustive over `W`);
  the other pairs have no certificate of non-congruence in the producer
  files.

## 2. Definitions (fixed now, used verbatim in EQUIVALENCE-TABLE.tsv)

All maps are affine maps of `E^4`, `x -> x Q c + b` in row convention
(`Q^T Q = I`, `c > 0`).  Two stored realisations `P, P'` are *equivalent under
a class of maps* iff some map of the class carries the vertex set onto the
vertex set, the edge set onto the edge set, the set of 2-faces onto the set of
2-faces and the set of cells onto the set of cells (each face as the set of
its vertices).  Vertex-set coincidence alone is not equivalence.

| # | relation | maps allowed | scale | orientation |
|---|---|---|---|---|
| R1 | equality of stored data | identity only | fixed | - |
| R2 | proper congruence | `x -> xQ + b`, `det Q = +1` | `c = 1` | preserved |
| R3 | congruence | `x -> xQ + b`, `det Q = +-1` | `c = 1` | either |
| R4 | proper similarity | `x -> xQc + b`, `det Q = +1` | any `c > 0` | preserved |
| R5 | similarity | `x -> xQc + b`, `det Q = +-1` | any `c > 0` | either |
| R6 | congruence after the documented normalisation | as R3 applied to the *normalised* data `w -> w/|w|` (every vertex on the unit sphere `S^3`, which is the PETCOX convention `[x]` and the producer's `theory.md` convention) | `c = 1` on normalised data | either; the proper/improper sub-count is reported too |
| R7 | "up to enantiomorphism" | R6 together with the identification of a realisation with its mirror image; the phrase is defined in Section 3 after checking the sources | - | either |

For R1 I will additionally report *vertex-set* equality of stored data
separately from full-structure equality, because the producer notes that
`alpha = 0` and `alpha = oo` of the cube family have the same 16 vertices up
to scale but different edges.

Because every `Gamma` is a finite group fixing the origin and the base 2-face
spans `E^4`, the vertex centroid of every realisation is the origin.  Any
similarity between two realisations therefore fixes the origin: `b = 0`
always, and the certificates reduce to a matrix `M = cQ` with
`M M^T = c^2 I`.  This will be verified, not assumed (a check that the sum of
the vertices is `0` is part of the reconstruction).

## 3. What "congruence", "similarity" and "enantiomorphism" must mean here

* *Congruence* = equivalence under isometries (`c = 1`).  A map with
  `M M^T = lambda I`, `lambda <> 1`, is not a congruence of the stored
  coordinate sets.  I will never call such a pair "congruent as stored".
* *Similarity* = equivalence under `x -> xQc + b`.
* Every realisation has infinitely many pairwise non-congruent rescalings
  `P -> lambda P`.  A finite count "up to congruence" is therefore
  meaningful only after fixing the scale.  The scale fixed by the definition
  of a PETCOX polyhedron is `|w| = 1` (vertices on `S^3`); a 4-polytope whose
  cells are *congruent to* PETCOX polyhedra necessarily has all vertices on a
  sphere of radius 1 about its centroid.  On unit-normalised data,
  congruence and similarity coincide (a similarity between two finite sets on
  the unit sphere about the common centroid `0` has `c = 1`).  So R6 is the
  mathematically intended finite classification, and R6 = R5 restricted to
  the normalised data.  This equality will be verified on the data, not
  assumed.
* *Enantiomorphism*.  In [SW] and in the producer's files the enantiomorph of
  a chiral polytope is its mirror image; for a Wythoff realisation it is the
  realisation of the mirror triple `(S1^-1, S1^2 S2, S3)`.  "Up to congruence
  and enantiomorphism" in `RESULT.md`/`theory.md` therefore means: identify
  `P` with `gP` for every isometry `g`, proper or improper.  That is R3 (on
  stored data) or R6 (on normalised data).  I will check this reading against
  [PETCOX] pp. 19-21, [BHP] and the thesis before finalising, and record the
  exact quotations.

## 4. Algorithms (three independent methods; the first two must agree on every pair)

### Method 1 (GAP, exact, explicit certificates): flag-anchored isometry/similarity search

For every ordered pair `(P_a, P_b)` of stored realisations with equal
f-vector (pairs with different f-vectors are trivially inequivalent):

1. Reconstruct both from the stored `(S1,S2,X,w)` with my own orbit code (not
   the producer's `lib.g`, not the previous audit's scripts).
2. The base 2-face of `P_a` is the vertex cycle `p_k = w_a S1^k`
   (`k = 0..p-1`), spanning `E^4` (checked).  Any similarity `M` from `P_a`
   to `P_b` maps the base flag of `P_a` to a flag of `P_b`; `Gamma_b` acts on
   the flags of `P_b` with exactly two orbits (checked by counting: `|Gamma_b|`
   equals the number of flags divided by 2 and the action on flags is free),
   so after composing with an element of `Gamma_b` the image flag is either
   the base flag `(w_b, e_b, f_b, c_b)` or its 2-adjacent flag
   `(w_b, e_b, f_b', c_b)` where `f_b' = f_b S2` is the other 2-face of `c_b`
   at `e_b`.  The traversal of `f_a` starting at `w_a` away from `e_a` is
   `w_a S1^k`; the two possible image traversals are `w_b S1^k` (even) and
   `w_b S1^-k S2` (odd).  Each determines a unique linear map `M` (solve on
   four independent vertices of the face).
3. For each of the two candidates: check exactly `M M^T = lambda I`
   (`lambda = |w_b|^2/|w_a|^2`), record `det M` (sign), check that `M` maps
   the vertex set, edge set, 2-face set and cell set of `P_a` onto those of
   `P_b`, and check that `M^-1 Gamma_a M = Gamma_b` (generators of `Gamma_a`
   conjugate into `Gamma_b`, equal orders).  Also record how the triple
   `(S1,S2,X_a)` is conjugated (same orientation or the mirror triple).
4. As an independent exhaustive cross-check that does not use the flag-orbit
   argument, a Gram-pruned depth-first search over ordered 4-tuples of
   vertices of `P_b` matching the exact inner products of
   `(w_a, w_a S1, w_a S1^2, w_a S1^3)` up to the scale `lambda`; every
   solution `M` is verified as in step 3.  This finds *all* similarities, so
   its output is either the same certificates or a proof that none exists.

A pair is R5-equivalent iff some candidate passes; R4 iff one with
`det M > 0` passes; R2/R3 additionally require `lambda = 1`.  Non-equivalence
certificate: the exhaustive search of step 4 returning no admissible `M`, or a
differing exact invariant (Section 4, Method 2).

### Method 2 (Sage, exact number field `Q(zeta_40)`): canonical form of the weighted incidence/distance structure

Independent re-parsing of `alpha-survivors.g` in Sage (FLINT arithmetic in
`CyclotomicField(40)`, no GAP), independent orbit computation, then for each
realisation the canonical form

    CF(P) = min over ordered 4-tuples b = (v0, v1, v2, v3) of vertices with
            v1, v2, v3 edge-neighbours of v0 and b linearly independent,
            of  ( Gram(b) ,  the list of all vertices sorted by the exact
                  4-tuple (u.v0, u.v1, u.v2, u.v3) ,  the full Gram matrix in
                  that order ,  edges / 2-faces / cells in that order ).

Exact real numbers are replaced by integer labels through one global
dictionary ordered by the real embedding, so that the labels are a function
of the value only.  Two versions of the inner products: raw (`u.v`) for
R2/R3, and scale-free (`u.v / w.w`) for R4/R5/R6.  Two versions of the
tuple: with `sign det[v0;v1;v2;v3]` appended (oriented; classes under proper
maps) and without (classes under all maps).  Equality of canonical forms is
a complete invariant: the Gram matrix of a spanning set determines the point
configuration up to `O(4)`, and the incidence lists are carried along.  By
vertex-transitivity of `Gamma` (checked), `v0` may be fixed to the base
vertex.

### Method 3 (GAP, exact, structural explanation): the anti-automorphism realiser

Solve the linear system `M S1 = S1^-1 M`, `M S2 = S2^-1 M` for `M` in the
16-dimensional space of `4 x 4` matrices.  Expectation: the solution space is
one-dimensional, spanned by an orthogonal matrix `m0` (`m0 m0^T = I`) with
`m0^2 = +-I`, so `{+-m0}` is the full set of isometries inverting both
generators.  Argument (to be verified on the data, all statements checked):
a similarity `n` with `n(P_a) = P_b` normalises `G = <S1,S2>` (cells go to
cells, and `Sym(H_alpha) = G`), can be composed with an element of `G` so as
to map `w_a` to `w_b` and the base edge to the base edge, hence normalises
`<S2>` and preserves `Pi = Fix(S2) = span(v0, v3)`; it maps the base flag of
the cell to the base flag of `H_b` (then `n` centralises `G`, so `n = +-I`,
impossible for `alpha <> beta`) or to its 2-adjacent flag, whose
distinguished generators are `(S2^-1 S1^-1 S2, S2^-1)`; then `m := S2 n`
inverts both `S1` and `S2`.  Conversely if `m0` maps `w_a` to `+-w_b` (as
unit vectors) then `m0` (or `S2^-1 m0`) carries `P_a` onto `P_b` by the
uniqueness of the third generator (producer Prop. E1, re-verified).  Hence

    P_a ~ P_b (R5)   <=>   m0 . [w_a] = [w_b]   on the projective circle
                            Pi cap S^3 / {+-1}.

`m0` inverts `S2`, so it acts on `Pi^perp` as a line reflection; on `Pi` it
acts as an element of `O(2)`.  If that element is a reflection then
`det m0 = +1` (a half-turn about a 2-plane) and the paired realisations are
**properly** congruent after normalisation; its two fixed points on the
projective circle are exactly the `alpha` at which `H_alpha(T)` is
geometrically regular ([PETCOX] Section 4).  If it were a rotation then
`det m0 = -1`.  Method 3 outputs the Moebius transformation of the projective
parameter `t`, the predicted pairing of the 24 `alpha` values, the fixed
points (to be compared with the PETCOX regular values `2 +- sqrt 3` for the
cube, etc.), and `det m0`.

### Method 4 (Python, `Fraction` arithmetic in `Q(zeta_40)` written from scratch): certificate re-verification

Every certificate `(M, lambda, det)` produced by Method 1 is re-verified in a
third arithmetic system: exact `M M^T = lambda I`, exact images of all
vertices, edges, 2-faces, cells, exact `lambda = |w_b|^2/|w_a|^2`.

## 5. Expected certificates (hypotheses, to be tested)

H1. Stored data: 24 distinct records (R1 = 24 classes).  Some vertex sets may
    coincide up to a scalar (cube family `alpha = 0` vs `oo`).
H2. R2 and R3 on stored data: 24 classes, because within each abstract class
    the stored `|w|^2` differ between the members that are similar
    (this depends on the data and will simply be read off).
H3. R4 = R5 = R6 = R7: **12 classes**, each abstract class of 4 splitting into
    two pairs, via the half-turn `m0` acting on the PETCOX circle as the
    reflection whose axis passes through the geometrically regular base
    vertices.  For the cube: the regular values `2 +- sqrt 3` sit at
    `15 deg` and `105 deg` from `v0` (with `v3` at `60 deg`), so the reflection
    `theta -> 30 deg - theta` pairs `alpha = 0 <-> 1/2` and `alpha = 2 <-> oo`
    (and the two failing values `1 <-> -1`).  Expected `lambda` for
    `(0, 1/2)`: `|w_{1/2}|^2 / |w_0|^2 = 3/4`; for `(2, oo)`: `1/(3/4) = 4/3`.
H4. `det m0 = +1` in every family: the pairs are related by **proper**
    isometries after normalisation, so they have the **same** handedness; the
    words "up to enantiomorphism" play no role in the reduction from 24 to 12.
    Combinatorially, the certificate maps even flags of `P_a` to odd flags
    of `P_b`, i.e. it conjugates `(S1,S2,X_a)` to a `Gamma_b`-conjugate of the
    mirror triple `(S1^-1, S1^2 S2, X_b)`: the two *triples* are
    enantiomorphic generator systems of one and the same geometric polytope.
H5. Roli's cube (`alpha = 0`) and `alpha = 1/2`: similar as stored with
    `lambda = 3/4`, properly congruent after normalisation; `alpha = 0` vs
    `alpha = oo`: not similar (same vertex set up to scale, different edge
    lengths), confirming the producer's `roli-alpha-infinity.g`.
H6. No cross-class similarities (different abstract polytopes cannot be
    similar) and no similarity between the `{5,3,3}` and `{3,3,5/2}` members
    of class 2 (different cell twist types `(1,11)` vs `(7,13)`).
H7. The producer's statement "24 up to congruence and enantiomorphism" is
    therefore expected to be **false** as a count (the correct number is 12),
    while the previous audit's "12 up to congruence" is expected to be
    correct only after the unit-sphere normalisation (on the stored data the
    certificates are similarities with `lambda <> 1`), and its "and
    enantiomorphism" is expected to be unnecessary (the pairs are properly
    congruent).  These expectations are exactly what the computation decides;
    if any of H3-H5 fails the verdict changes accordingly.

## 6. Independence protocol

* Producer files are read from the `git archive` of `71ef1cd`; the working
  tree of HEAD is not modified.
* `audits/fable-ultra/` is not opened until Methods 1-4 have produced their
  results and this file is frozen (its SHA-256 goes into the manifest).
* No script from the previous audit is copied or adapted; every script in
  `scripts/` is written from this specification.
