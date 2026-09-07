# Theory: extension conditions, the admissible alpha, and chirality

Notation.  `T` is one of the sixteen regular convex or star 4-polytopes in
`E^4` (centred at the origin, projected to `S^3`), `W = <R0,R1,R2,R3>` its
symmetry group (a finite Coxeter group), `v0` the base vertex, `v3` the
centroid of the base cell, and `Pi = span(v0, v3)`.  The PETCOX facet
generators are

    S1 = R0 R1 R3 R2,    S2 = R2 R1,    G = <S1, S2>,

`S1` a twist of order `p` with rotation angles `2 pi p1/p` and `2 pi p2/p` on
its two invariant planes `E1, E2`, and `S2` a rotation of order `q` with
`Fix(S2) = Pi`.  The PETCOX point is
`w_alpha = (v,c)_alpha = [(1-alpha) v0^ + alpha v3^]` (unit vectors, `alpha` in
`R u {oo}`); projectively `w(t) = t v0 + v3`, with `t = oo` giving `alpha = 0`
and `t = 0` giving `alpha = 1`.  All statements below are verified exactly for
all sixteen `T` by the scripts named in brackets; no floating-point value
enters a decision.

## A. What an extension is

A chiral or directly regular skeletal 4-polytope `P` in `E^4` whose cells are
congruent to `H_alpha(T)` is, after moving it by an isometry, the Wythoff
realisation of a Schulte-Weiss polytope `P(Gamma; S1, S2, X)` for some third
generator `X` and some base vertex `w`:

* `X` is an isometry of `E^4` with `(S2 X)^2 = (S1 S2 X)^2 = 1`;
* the rank-4 intersection condition holds, `<S1> cap <S2> = <S2> cap <X> = 1`
  and `<S1,S2> cap <S2,X> = <S2>` ([SW] Lemma 11), so that [SW] Theorem 1
  produces an abstract polytope `P(Gamma)` with rotation group
  `Gamma = <S1,S2,X>`, facets `P(G; S1,S2)` and vertex-figures `P(<S2,X>)`;
* `w` is fixed by `S2` and `X` and moved by `S1`, and the realisation is
  faithful: the geometric stabilisers of the base vertex, edge, 2-face and
  cell in `Gamma` are exactly `<S2,X>`, `<X, S1S2>`, `<S1, S2X>`, `<S1,S2>`.

Choosing the base flag in the other flag orbit of the cell replaces
`(S1,S2)` by `(S1^{-1}, S1^2 S2)` and describes the same polytope; reflecting
the whole polytope replaces `H_alpha(T)` by its mirror image.  So, up to
congruence and enantiomorphism, every extension is a triple `(S1, S2, X)`
with the PETCOX matrices `S1, S2` kept fixed.  The orientation of every
triple is certified by the flag tests `F_i . S_i = F'_i` of [SW] p. 496
[lib.g `PX.FlagChecks`].

## B. The base vertex lies on the PETCOX circle

**Lemma B1.**  `Fix(S2) = Pi`.  `S2 = R2 R1` is a rotation whose pointwise
fixed space is the intersection of the mirrors of `R1` and `R2`, a 2-plane
containing both `v0` and `v3`.  [alpha-locus.g: `dim Fix(S2) = 2` and
`Fix(S2) = span(v0,v3)` for all 16 `T`.]

**Corollary B2.**  Every Wythoff base vertex of every extension lies on the
great circle `Pi cap S^3`, i.e. it is a PETCOX point `w_alpha` for some
projective `alpha`.  Conversely the cell of the extension is then
`H_alpha(T)`, because PETCOX define `H_alpha(T)` as the Wythoff polyhedron of
`<S1,S2>` at `w_alpha` (p. 19-20).  Antipodal base vertices give centrally
symmetric, hence congruent, polytopes.

**Proposition B3 (canonical extension).**  For `S3 = R3 R2` one has
`Fix(S2) cap Fix(S3) = span(v0)`, so the only admissible base vertices are
`+-v0^`: `alpha = 0`.  For the canonical third generator of the dual,
`R0 R1`, the fixed locus is `span(v3)`: `alpha = 1`, which is
`H_1(T) = H_0(T^*)`.  Moreover `S1 S3^{-1} = R0 R1`, so
`<S1,S2,S3> = <R0R1, R1R2, R2R3> = W^+`.  [alpha-locus.g, canonical.g.]

**Proposition B4.**  The elements of `W` fixing `Pi` pointwise form
`<R1,R2>` (order `2q`), whose rotations are `<S2>`.  So no element of `W`
outside `<S2>` fixes the whole circle.  [alpha-locus.g.]

## C. Nondegeneracy of the cell equals the intersection condition

Let `w = v0` (`alpha = 0`).  The stabiliser of `v0` in `Gamma = W^+` is
`<R1,R2,R3>^+ = <S2,S3>`, so the stabiliser of `v0` in the facet group is
`G cap <S2,S3>`, and the number of abstract cell vertices collapsing onto the
geometric point `v0` is

    m(T) := |G cap <S2,S3> : <S2>| = |<S1,S2> cap <S2,S3> : <S2>|,

the defect of the intersection condition.

**Proposition C1.**  The canonical extension of `T` yields an abstract
polytope if and only if `m(T) = 1`, i.e. if and only if `H_0(T)` has no
vertex collapse.  The column "Colapses at alpha = (0,1)" of [PETCOX] p. 28 is
exactly the pair `(m(T), m(T^*))`.  [canonical.g and alpha-locus.g verify
`m(T)` against the table for all 20 endpoint records.]

So eleven of the twenty canonical endpoints fail for a provable reason, and
the five with `m(T) = 1` satisfy all hypotheses of [SW] Theorem 1.

## D. Geometric chirality from spanning 2-faces

**Proposition D1.**  Let `P` be a faithful Wythoff realisation of `P(Gamma)`
in `E^4` such that the vertices of the base 2-face `f` span `E^4`.  Then
`G(P) = Gamma` and `P` is geometrically chiral.

*Proof.*  `Gamma <= G(P)` has exactly two orbits on the flags of `P` (even and
odd, [SW] proof of Theorem 1) and adjacent flags lie in different orbits.  Let
`g` be a symmetry of `P`.  If `g` maps the base flag `Phi` to an even flag,
compose with an element of `Gamma` to get a symmetry fixing `Phi`; an
automorphism of a polytope fixing a flag is the identity, so `g'` fixes every
vertex, hence `g' = 1` because the vertex set spans `E^4`; thus `g` is in
`Gamma`.  If `g` maps `Phi` to an odd flag, compose with an element of `Gamma`
to get `g'` with `g'(Phi) = Phi^3` (the 3-adjacent flag is odd and `Gamma` is
transitive on odd flags).  Then `g'` fixes the vertex, the edge and the 2-face
of `Phi`; as an automorphism of the polygon `f` fixing one of its flags it
fixes `f` pointwise, so it fixes the vertices of `f`, which span `E^4`; hence
`g' = 1`, contradicting `Phi^3 != Phi`.  So `G(P) = Gamma`, which is not
flag-transitive.  QED

For every candidate in this study the vertices of the base 2-face span `E^4`
(the faces are helical, with two nontrivial twist angles).  As a cross-check
the unique linear isometry acting on `f` as the flag-reversing reflection
`w S1^k -> w S1^{-k-1}` is computed exactly: it equals `S1 S2 S3`, lies in
`Gamma`, and maps the base cell `c` to `c^{S3}` [canonical.g, alpha-complete.g].

Remark.  D1 also shows that no *regular* skeletal 4-polytope can have 2-faces
whose vertices span `E^4`: `rho_3` would have to fix such a 2-face pointwise.
This is the geometric reason why the PETCOX cells occur only in chiral
4-polytopes.  Note that "chiral" here is geometric: `P` may be
combinatorially regular (directly regular) and still geometrically chiral,
exactly as in [BHP] Theorem 1; both cases occur below.

The same argument applied to the cell shows that the cell has no
`rho_0`-type symmetry, so the cells are geometrically chiral, while the
rank-3 mirror automorphism `S1 -> S1^{-1}, S2 -> S1^2 S2` does exist: the
cells are combinatorially regular but geometrically chiral, as stated in
[PETCOX] p. 28 [census-audit.g for all ten rows].

## E. The complete (Level 3) analysis: all isometries of E^4

Put `A := S2 X`.

**Proposition E1 (the third generator is unique for each base vertex).**
(i) `(S2X)^2 = (S1S2X)^2 = 1` if and only if `A^2 = 1` and `A S1 A = S1^{-1}`.
(ii) `X` fixes `w` if and only if `X` fixes the base edge `{w, w S1^{-1}}`
pointwise, if and only if `A` fixes `w`.
(iii) Every `A` with `A S1 A = S1^{-1}` preserves the two invariant planes
`E1, E2` of `S1` and acts on each as a line reflection; hence `A` is the
half-turn about the 2-plane `span(l1, l2)` with `l_i` a line of `E_i`, and
`det A = 1`, so `det X = 1`.
(iv) If `w = w_1 + w_2` with `0 != w_i` in `E_i`, then `A` fixes `w` iff
`l_i = span(w_i)`.  Hence `A`, and therefore `X = S2^{-1} A`, is **unique**.

*Proof.*  (i) `A^2 = 1` is `(S2X)^2 = 1`; given that, `(S1 A)^2 = 1` is
equivalent to `A S1 A = S1^{-1}`.  (ii) `S2` fixes `w`, so `w X = w` iff
`w A = w`.  From `S1 S2 S1 = S2^{-1}` (a consequence of `(S1S2)^2 = 1`) one
gets `S1^{-1} X S1 = S2^2 X`, so `w S1^{-1} X = w S1^{-1}` iff `w X = w`;
and `w S1^{-1}` is the second endpoint of the base edge
`e = w<S1S2> = {w, w S1^{-1}}`.  (iii) In complex terms `S1` has eigenvalues
`e^{+-i theta_1}, e^{+-i theta_2}` with `theta_2 != +- theta_1` for all ten
families (verified: the index pairs are `(1,2), (1,3), (1,5), (1,11), (1,9),
(1,4), (1,5), (7,13), (3,7), (2,7)` modulo `p = 5,8,12,30,20,15,12,30,20,15`,
and in each case `p1 + p2 != 0 mod p` and `p1 != p2`).  Conjugation by `A`
sends the `lambda`-eigenspace of `S1` to its `lambda^{-1}`-eigenspace, so `A`
preserves each real invariant plane and acts on it antiholomorphically, i.e.
as a line reflection; two line reflections give `det A = +1` and `A^2 = 1`.
(iv) `A` fixes `w = w_1 + w_2` iff it fixes each `w_i` (the `E_i` are
`A`-invariant and mutually orthogonal), i.e. iff `l_i = span(w_i)`.  QED
[alpha-complete.g verifies (i)-(iv) for every candidate; the invariant planes,
their orthogonality and the non-opposite angle condition are checked for all
ten families, as is the fact that the PETCOX circle avoids `E1` and `E2`, so
the exceptional case `w_i = 0` never occurs.]

So the extension problem is reduced to a problem in one real variable: the
third generator is the function `X_alpha = S2^{-1} A_alpha` of the base vertex,
where `A_alpha` is the half-turn about `span(w_1, w_2)`, and

    A_alpha = 2 ( w_1^T w_1 / |w_1|^2 + w_2^T w_2 / |w_2|^2 ) - I

is a rational function of the projective parameter `t` with denominator
`d1 d2`, `d_i = |w_i|^2` a quadratic in `t`.  (In the 5-coordinate model of
the simplex, add the term `h^T h / |h|^2` for the fixed all-ones direction.)

**Proposition E2 (the vertex-figure is a Platonic solid).**  The
vertex-figure group `<S2, X>` fixes `w`, and `S2, X` are rotations, so
`<S2,X>` lies in the `SO(3)` of the 3-space `w^perp`.  It is finite (the
symmetry group of a discrete polytope in `E^4` is a discrete, hence finite,
subgroup of `O(4)`), is generated by two rotations of orders `q, m >= 3`
whose product `S2 X` is an involution, and satisfies `<S2> cap <X> = 1`.  If
`<S2,X>` were cyclic then `S2` and `X` would be powers of one rotation and
`S2 X` the unique involution, forcing `<S2> <= <X>` or `<X> <= <S2>` and
violating `<S2> cap <X> = 1`; if it were dihedral, both `S2` and `X` (of order
`>= 3`) would lie in its cyclic subgroup and the same argument applies.
Hence `<S2,X>` is `A4`, `S4` or `A5`, so

    (q, m) in { (3,3), (3,4), (4,3), (3,5), (5,3) },
    equivalently  1/2 + 1/q + 1/m > 1,

`m = ord(X)` is 3, 4 or 5, and the vertex-figure is a Platonic solid.
[alpha-complete.g checks the group type for every surviving candidate and
excludes the impossible `(q,m)` a priori.]

**Proposition E3 (the trace equation).**  `X` fixes the plane
`span(w, w S1^{-1})` pointwise and rotates the orthogonal plane by an angle
`theta`, so `tr(X) = 2 + 2 cos(theta)` (plus 1 in the 5-coordinate simplex
model), and `ord(X) = m` forces

    tr(X_alpha) = 2 + 2 cos(2 pi k / m),   gcd(k,m) = 1,  1 <= k <= m/2.

Clearing the denominator `d1 d2` turns this into a polynomial equation of
degree at most 4 in `t`, solved exactly: factorisation over `Q(sqrt 5)`,
linear factors read off, quadratic factors by radicals with the sign of the
discriminant decided exactly in `Q(sqrt 5)` and its square root taken in a
cyclotomic field, and the real roots of every remaining factor counted
exactly by Sturm's theorem.  [alpha-complete.g.]

**Proposition E4 (quaternionic projection bound).**  Write
`SO(4) = (S^3 x S^3)/{+-1}`, `(a,b)` acting by `x -> a x b^{-1}`; the
stabiliser of a point of `S^3` is a diagonal `{(a,a)}/{+-1} = SO(3)`.  By E2
the vertex-figure group lifts to a diagonal copy of `2T`, `2O` or `2I`, so
both projections of the preimage of a finite `Gamma` contain `2T`, `2O` or
`2I`.  Among the finite subgroups of `S^3` (cyclic, binary dihedral, `2T`,
`2O`, `2I`) the only inclusions between these three are `2T < 2O` and
`2T < 2I`, so a finite `Gamma` is conjugate into `(2X x 2Y)/{+-1}` with
`X, Y` in `{T,O,I}`.  Consequences:

* `|Gamma| <= |(2I x 2I)/{+-1}| = 7200`, so a vertex orbit of more than 7200
  points proves `Gamma` infinite, hence non-discrete, hence not the symmetry
  group of a skeletal polytope;
* if the vertex-figure group is `A5` then both projections are `2I` and
  `Gamma` is conjugate into `[3,3,5]^+` of order 7200, whose element orders
  are `1,2,3,4,5,6,10,12,15,20,30`;
* if the vertex-figure group is `S4` then both projections are `2O` and
  `Gamma` is conjugate into `+-[O x O]` of order 1152, whose element orders
  are `1,2,3,4,6,8,12,24`.

Since `ord(S1) = p` is one of `5, 8, 12, 30, 20, 15`, this excludes a priori:
the icosahedral case for `T = {4,3,3}` and `{3,3,4}` (`p = 8` is not an
element order of `[3,3,5]^+`), and the octahedral case whenever `p` is
`5, 20, 30` or `15` (not element orders of `+-[O x O]`).
[alpha-complete.g computes both order sets and applies the exclusions.]

**Proposition E5 (Kronecker-Weber trace obstruction).**  Every element of a
finite subgroup of `GL(4,C)` has trace a sum of four roots of unity, hence
lying in a cyclotomic field.  Suppose the parameter `t` is a root of an
irreducible quadratic over `K = Q(sqrt 5)` whose discriminant `D` has
`K(sqrt D)` not abelian over `Q`; equivalently (Kronecker-Weber) `sqrt D` lies
in no cyclotomic field; equivalently the norm `D sigma(D)` is not a square in
`K`.  If some element `g` of `Gamma` has `tr(g) = c0 + c1 t` with `c0, c1` in
`K` and `c1 != 0`, then `K(tr g) = K(sqrt D)`, so `tr(g)` lies in no
cyclotomic field (a cyclotomic `tr(g)` would put `sqrt D` in the abelian, hence
cyclotomic, compositum `K . Q(tr g)`).  Therefore `Gamma` is infinite and
there is no polytope.  [alpha-complete.g: for the eight quadratic factors
whose roots are real but not cyclotomic, the traces `tr(g X)` for
`g` in `{S1, S1^2, S2, S1S2, S1^3}` are computed exactly in `K[t]/(f)` and one
with `c1 != 0` is exhibited in every case.]

**Theorem E6 (completeness).**  Propositions B2, E1, E2, E3 together with the
exact solution of the trace equations and the obstructions E4, E5 determine,
for each of the ten PETCOX families, the complete finite list of base vertices
`w` on the PETCOX circle that admit a third generator, and hence the complete
list of chiral or directly regular skeletal 4-polytopes in `E^4` with cells
`H_alpha(T)`, up to congruence and enantiomorphism.  No parent group is
assumed and no case is left open: every polynomial factor arising was either
solved exactly or proved to have no real roots (Sturm) or eliminated by E4 or
E5.  [alpha-complete.g: 226 assertions, 0 failures; the final check
"number of polynomial factors with real roots that could not be solved
exactly" is 0.]  The resulting list is in RESULT.md and
candidate-table.tsv.

## F. Parent-group searches (Level 2) as an independent check

For fixed `(S1,S2)` and a finite group `PARENT` containing them, every element
`X` of `PARENT` was tested for the relations, a fixed line in `Pi` (which
fixes `alpha`), `ord(X) >= 3`, the edge condition, the intersection condition
and the full realisation.  Parents: `W(T)` for all 16 `T`; `[3,3,5]` for an
embedded `{3,3,3}`; `[3,4,3]` and `[[3,4,3]]` (order 2304) for `{4,3,3}`,
`{3,3,4}`, `{3,4,3}`; and the normaliser `N_{O(4)}(G)` of each facet group,
computed exactly from `Aut(G)` by solving the intertwining equations
`X S_i = phi(S_i) X` (the kernel of `N -> Aut(G)` is the centraliser
`C_{O(4)}(G) = {+-I}`, because the commutant of `G` in the matrix algebra is
one-dimensional, which is verified for all ten families; hence
`|N| = 2 |Inn(G)| r` with `r` the number of realised outer classes).
[parent-search.g.]  These searches recover exactly the base vertices of the
Level 3 list that happen to lie in the parent, and nothing else, which is a
useful independent check; by Theorem E6 they are not needed for completeness.

## G. Abstract (non-geometric) extensions

The abstract cells `P_T` are regular maps (census.md).  Since they are
directly regular, [SW] Proposition 12 and Theorem 3 imply that a class
`<P_T, Q>^ch` with directly regular `Q` has no universal chiral member (the
natural candidate, the universal regular `{P_T, Q}`, is regular), so abstract
chiral 4-polytopes with cells `P_T` are proper quotients of that universal
regular polytope.  The constructions below show that such quotients exist for
`P_T` of types `{8,3}`, `{12,3}` and `{30,3}`.  Whether abstract chiral
4-polytopes exist with cells `P_T` of types `{5,3}`, `{12,4}`, `{20,5}` or
`{15,5}` is not decided here; what is decided (Theorem E6) is that none of
them can be realised faithfully in `E^4` with PETCOX cells.
