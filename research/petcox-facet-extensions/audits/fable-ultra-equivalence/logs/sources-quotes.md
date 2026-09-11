# Primary-source quotations on normalisation, congruence, similarity and enantiomorphism

Audit `fable-ultra-equivalence`, task "sources-quotes".  Written 2026-09-10.

## Provenance and transcription conventions

Sources read (all read-only):

| tag | file | extraction |
|---|---|---|
| [PETCOX] | `/Users/daniel/dr/skeletal-polytopes/petcox.pdf` (Bracho, Hubard, Pellicer, *Chiral polyhedra in 3-dimensional geometries and from a Petrie-Coxeter construction*, author version dated January 19, 2021, 32 pp.) | PyPDF2 3.0.1 `PdfReader(...).pages[i].extract_text()`; raw text in `$SCRATCH/sources/petcox.txt`. PDF page numbers coincide with the printed page numbers. For pp. 20-28 a second pass with `visitor_text` was made (`$SCRATCH/sources/petcox-fixed-clean.txt`) in which the Computer Modern math glyphs that the plain extractor drops were restored from their font positions: CMSY `\x00` = minus sign, CMSY `p` = square root, CMSY `\x06` = plus-minus, CMSY `1` = infinity, CMSY `f`/`g` = braces, CMMI `\x1e` = phi (golden ratio). Superscripts (for example the `-1` of `phi^{-1}`) are flattened by both extractors and cannot be recovered; such places are marked. |
| [BHP] | `/Users/daniel/dr/skeletal-polytopes/chiral-4-polytope.pdf` (Bracho, Hubard, Pellicer, *A finite chiral 4-polytope in R^4*, DCG 52 (2014) 799-805, 7 pp.) | PyPDF2; raw text in `$SCRATCH/sources/chiral-4-polytope.txt`. PDF page i = printed page 798+i. Page numbers below are the printed ones. |
| [Thesis] | `$PRODUCER/../../two-chiral.tex` = `/private/tmp/claude-501/.../scratchpad/producer/two-chiral.tex` (Bracho, Gonzalez-Casanova, Hubard, *Two new chiral 4-polytopes of full rank*, manuscript, 653 lines) | read directly; references are `L<n>` = line number of the `.tex` file. |
| [SW] | `/Users/daniel/dr/skeletal-polytopes/schulte-asia-chiral.pdf` (Schulte, Weiss, *Chiral polytopes*, DIMACS 4 (1991) 493-516, 24 pp.) | PyPDF2; raw text in `$SCRATCH/sources/schulte-asia-chiral.txt`. The scan's OCR layer inserts spaces inside words ("Chira l Polytope s") and garbles Greek letters; PDF page i = printed page 492+i. Page numbers below are the printed ones. |
| [P-*] | producer documentation and scripts under `$PRODUCER` (git commit 71ef1cd): `RESULT.md`, `theory.md`, `README.md`, `source-notes.md`, `census.md`, `gap/compare.g`, `gap/roli-alpha-infinity.g`, `gap/lib.g` | read directly; references are `L<n>` = line number of the file. |

Transcription conventions, applied uniformly:

* Quotations are verbatim from the extracted text.  Two mechanical extraction defects are repaired **silently** because marking each occurrence would make the quotations unreadable: (a) the `fi`/`fl`/`ff` ligatures that PyPDF2 drops ("de ned", "re ection", " ag") are restored; (b) missing or doubled inter-word spaces produced by the extractor are regularised.  In [SW] the OCR's intra-word spaces are likewise removed silently.
* **Every other repair is shown in square brackets**: dropped mathematical symbols (minus signs, roots, Greek letters, sub/superscripts, set braces), which are restored from the glyph pass or from context; the bracket says what was done.  Where the original cannot be recovered with certainty this is stated inside the bracket.  Italics, bold and font changes are not reproduced.
* Nothing is paraphrased inside quotation marks.  Commentary is outside quotation marks and is labelled as such.
* Line references inside PDFs are not available from the extractor; page numbers are given, and for [Thesis] and the producer files exact line numbers.

---

## Q1. How [PETCOX] defines `(v,c)_alpha`, `PC_alpha(T)`, `H_alpha(T)`; normalisation; `S^3`; linearisation; which `alpha` give isomorphic polyhedra; the exceptional regular `alpha`

### Q1.1 The point `(v,c)_alpha` (distance definition, Section 3)

[PETCOX] p. 15:

> "Let T be a regular 4-polytope in X, let d be the distance between a vertex and the centre of any of the cells containing it, and let 0 < [alpha] < 1. For each vertex v and every cell c containing v we define the point (v,c)[_alpha] as the point in the line through v and the centre of c that is at distance [alpha]d from v and at distance (1 [-] [alpha])d from the centre of c."

### Q1.2 `PC_alpha(T)` (Section 3)

[PETCOX] pp. 15-16:

> "For any given [alpha] [in] (0,1), the rank 3 structure PC[_alpha](T) is then defined to have as its vertex set all points (v,c)[_alpha] for all cells c of T and all vertices v in c. Its edge set consists of line segments between (v,c)[_alpha] and (v',c)[_alpha] where there is an edge of c between v and v', as well as line segments between (v,c)[_alpha] and (v,c')[_alpha] where c and c' are cells sharing a face that contains v. The edge between the vertices (v,c)[_alpha] and (v',c)[_alpha] is chosen to be the line segment completely contained in c, whereas the edge between vertices (v,c)[_alpha] and (v,c')[_alpha] is chosen to be the line segment that intersects the face between c and c' (see Figure 2). Finally, the set of faces of PC[_alpha](T) is the set of squares ((v,c)[_alpha], (v',c)[_alpha], (v',c')[_alpha], (v,c')[_alpha]), where c and c' are cells of T sharing a face that contains the edge between v and v'."

[PETCOX] p. 16, Theorem 11: "For any [alpha] [in] (0,1) and any regular 4-polytope T of X, PC[_alpha](T) is a polyhedron in X."

[PETCOX] p. 17, Remark 12: "Given [alpha] [in] (0,1) and a regular 4-polytope T, if T[*] denotes the dual 4-polytope of T, then PC[_alpha](T) = PC[_{1-alpha}](T[*])."

[PETCOX] p. 17, Theorem 13: "For any [alpha] [in] (0,1) and any regular 4-polytope T of X, the symmetry group of T is isomorphic to a subgroup of index at most 2 of G(PC[_alpha](T)). Furthermore, PC[_alpha](T) is either regular or a 2-orbit polyhedron in class 2[_{0,2}]."

### Q1.3 `H_alpha(T)` (Section 3)

[PETCOX] p. 17:

> "Since the faces of PC[_alpha](T) are squares we can apply the halving operation [eta] to it. Furthermore, if the cells of T have type {p,q} then PC[_alpha](T) has type {4,2q} and PC[_alpha](T)[^eta] has type {2q,2q}. Since q [>=] 3, we can apply the facetting operation [phi] to PC[_alpha](T)[^eta]. For simplicity, we set
> H[_alpha](T) := (PC[_alpha](T)[^eta])[^phi]."

[The operation symbols `eta`, `phi` and the superscripts are dropped by the extractor; the extracted line reads `H(T) := (PC(T)):`.  The names "halving operation" and "facetting operation" are defined on pp. 13-14.]

[PETCOX] p. 18, Proposition 14: "Assume that for some [alpha] [in] (0,1) and some regular 4-polytope T of X, H[_alpha](T) is a polyhedron. Then H[_alpha](T) is either regular or chiral."

### Q1.4 Extension of `alpha` to all of `R`; which `alpha` give isomorphic polyhedra with the same symmetry group (p. 18-19)

[PETCOX] pp. 18-19:

> "In our definition of PC[_alpha](T) we required 0 < [alpha] < 1 because for these values, the vertex set of PC[_alpha](T) can be easily visualised as the vertices obtained by shrinking every cell of T. However, we are mainly interested in H[_alpha](T), and it is important to note that our definitions naturally extend to consider values of [alpha] in all of R. Let m be the line through the vertex v and the centre of the cell c that contains v. Then, if X [in] {E[^3], H[^3]}, the unique parametrization of m, proportional to distance, which yields v for [alpha] = 0 and the center of c for [alpha] = 1, defines (v,c)[_alpha] [in] m by the same formula using directed distances. This idea extends naturally to S[^3] and P[^3].
> Some values of [alpha] (particularly 0 and 1, but maybe more) result in distinct pairs (v,c) and (v',c') of incident vertex and cell of T, having the points (v,c)[_alpha] and (v',c')[_alpha] coincide and the "polyhedron" PC[_alpha](T) (or H[_alpha](T)), degenerates to a structure not satisfying Definition 1. However, for all other values of [alpha], the polyhedra PC[_alpha](T) (respectivelly, H[_alpha](T)) are isomorphic and have the same symmetry group, regardless of whether [alpha] [in] (0,1) or not.
> The polyhedrality of H[_alpha](T) will be discussed in the next section."

[Commentary: this is the only sentence in [PETCOX] that compares `H_alpha(T)` for different `alpha`; the relation asserted is "isomorphic and have the same symmetry group", nothing stronger.]

### Q1.5 Everything lives in `S^3`; Wythoff description; base edge and base face (Section 4, p. 19-20)

[PETCOX] p. 19:

> "In this section we work with each of the 6 convex regular polytopes of R[^4], and the 10 starry ones (see [10]). Given a finite regular 4-polytope T in R[^4] (centered at the origin), we first project it to S[^3] and we work with the projection that, abusing notation, we also denote by T. Given [alpha] [in] R, we shall describe H[_alpha](T) in the spirit of Wythoff's construction. We denote by V(T), E(T), F(T) and C(T) the set of vertices, edges, faces and cells of T, respectively.
> Note that the vertices of H[_alpha](T) are some of the vertices of PC[_alpha](T) and thus they are points in the set
> {(v,c)[_alpha] | v [in] V(T), c [in] C(T) and v is incident to c}   (1)
> described in Section 3. Since T is regular, its symmetry group is transitive on the vertex-cell incident pairs, and hence the vertices in the set in (1) can be described as the orbit under G(T) of the vertex [v-bar] := (v,c)[_alpha] corresponding to the vertex and cell of a base flag [Phi] := {v,e,f,c} of T. Since G(H[_alpha](T)) [>=] <S[_1],S[_2]>, where S[_1] and S[_2] are as in the proof of Proposition 14 (the "rotations" of the face and vertex, respectively), the vertices of H[_alpha](T) are the orbit of [v-bar] under G := <S[_1],S[_2]>.
> Likewise, the edges and faces of H[_alpha](T) are the orbits of the base edge [e-bar] and the base face [f-bar] of a base flag [Psi] = {[v-bar],[e-bar],[f-bar]}, where [e-bar] and [f-bar] are as follow. Since"

[PETCOX] p. 20 (continuing):

> "S[_1^{-1}] = [two symbols lost by the extractor; printed as "01" after a dropped operator, presumably the abstract rotation carrying the base flag to its (0,1)-adjacent flag], then S[_1^{-1}] sends [v-bar] to the other vertex of [e-bar], and thus [e-bar] is the line segment between [v-bar] and [v-bar]S[_1^{-1}], while [f-bar] is the orbit of {[v-bar],[e-bar]} under <S[_1]>.
> Since T is regular, there are symmetries of T fixing all but one of the elements of the base flag [Phi]. More precisely, there are symmetries R[_0], R[_1], R[_2] and R[_3] sending the base flag [Phi] = {v,e,f,c} to the flags {v',e,f,c}, {v,e',f,c}, {v,e,f',c} and {v,e,f,c'}, respectively. Following the proofs of Theorem 13 and Proposition 14, one can see that S[_1] and S[_2] can then be written in the following way:
> S[_1] = R[_0]R[_1]R[_3]R[_2],   (2)
> S[_2] = R[_2]R[_1].   (3)
> It is well known that the symmetries R[_0], R[_1], R[_2] and R[_3] are hyperplane reflections. Thus, S[_1] is a twist (or screw motion) and its only fixed point (in R[^4]) is the centre of the (finite) polytope but it is fixed-point free in S[^3]. On the other hand, S[_2] is a rotation on a line (great circle) of S[^3], which can be also seen as a translation on its polar line (the corresponding 2-planes are orthogonal in R[^4])."

### Q1.6 The linearisation of `alpha` and the normalisation `[x]` (p. 20-21)

[PETCOX] p. 20:

> "In what follows, we describe H[_alpha](T), for each classic regular 4-polytope T in S[^3]. The symmetries R[_0], R[_1], R[_2] and R[_3] of T, which will be presented as matrices, are determined as the reflections on the facets of a basic tetrahedron given by points v[_0], v[_1], v[_2], v[_3] [in] S[^3] which are the centroids of the elements of the base flag. Using these matrices we can obtain the type of each H[_alpha](T) and the core of S[_1]. Moreover, with the help of Lemma 7 and Theorem 9 we determine the values of [alpha] for which H[_alpha](T) is geometrically regular, otherwise it is chiral or a polyhedral complex. For computational simplicity, we linearize the meaning of the parameter [alpha], so that what we called (v,c)[_alpha] in terms of distance (which is angular in S[^3] and P[^3]) will now be (v,c)[_alpha] = [ (1 [-] [alpha])v[_0] + [alpha]v[_3] ]; where, by [ x ] we denote the normalization of x, i.e.,
> [x] := (1/[||]x[||])x."

[PETCOX] p. 21:

> "In each case it is convenient to work with various values of [alpha], however, There are four important cases: for [alpha] = 0, 1, 1/2, [infinity], (v,c)[_alpha] will respectively mean
> [v[_0]], [v[_3]], [ [v[_0]] + [v[_3]] ], [ [v[_3]] [-] [v[_0]] ]."

[Commentary: the printed basic tetrahedra are given with `v_i = [(...)]`, i.e. as normalised vectors in `S^3`, except where a coordinate vector is already a unit vector, e.g. `v_3 = (0,0,0,1)` for `{4,3,3}` (p. 23) and `v_3 = (1,0,0,0)` for `{5,3,3}` (p. 24).]

### Q1.7 Section 4's statements about the exceptional (geometrically regular) `alpha`, for each `T`

[PETCOX] p. 20 (general statement): "with the help of Lemma 7 and Theorem 9 we determine the values of [alpha] for which H[_alpha](T) is geometrically regular, otherwise it is chiral or a polyhedral complex."

`{3,3,3}` — [PETCOX] p. 22: "The type of H[_alpha]({3,3,3}) is {5/[(]1,2[)],3}. It is combinatorially isomorphic to the dodecahedron, {5,3}, and it takes over the 20 vertices of PC[_alpha]({3,3,3}). For [alpha] = 1/2, [infinity], H[_alpha]({3,3,3}) is regular, and for all other [alpha] [!=] 0, 1 it is a chiral polyhedron (see Figure 5). For [alpha] = 0, 1 it collapses: groups of 4 vertices merge, corresponding to the two oriented families of 5 embedded tetrahedra in {5,3}."  pp. 22-23: "The basic vertices for the regular cases are [(1,0,0,0,[-]1)] (for [alpha] = 1/2) and [(3,[-]2,[-]2,[-]2,3)] (for [alpha] = [infinity]) with respective "reflection" matrices R = [+-] (1/5) ( [5x5 matrix] )."

`{4,3,3}` and `{3,3,4}` — [PETCOX] p. 23: "Taking as the basic tetrahedron for {4,3,3}: v[_0] = [(1,1,1,1)], v[_1] = [(0,1,1,1)], v[_2] = [(0,0,1,1)], v[_3] = (0,0,0,1), the generators of G become: [matrices S_1, S_2]. The general H[_alpha]({4,3,3}) has type {8/[(]1,3[)],3}. In this case, for [alpha] = 0 no vertices come together, so we still have a chiral polyhedron H[_0]({4,3,3}), which was taken as facet of a chiral 4-polytope in S[^3] (or R[^4]) in [3]. See Figure 6."  Figure 6 caption: "H[_0]({4,3,3}/2) is a chiral polyhedron in P[^3] with the combinatorial structure of the cube {4,3}. Antipodal points on the 2-sphere are to be identified."  pp. 23-24: "The basic vertices for the regular cases are [(1,1,1,[sqrt]3)] and [(1,1,1,[-][sqrt]3)] with respective "reflection" matrices R = [+-] (1/[sqrt]3) ( [4x4 matrix] )."

[Commentary: for `{4,3,3}` the paper prints only the two regular base vertices, not a value of `alpha`; the values `alpha = 2 -+ sqrt 3` are the producer's derivation, quoted in Q6 below (census.md L114). No sentence of the form "H_alpha({4,3,3}) is regular at alpha = ..." exists in the paper.]

`{3,4,3}` — [PETCOX] p. 24: "A basic tetrahedron for the selfdual regular polytope {3,4,3} is: v[_0] = (1,0,0,0), v[_1] = [(3,1,1,1)], v[_2] = [(2,1,1,0)], v[_3] = [(1,1,0,0)]. The type of H[_alpha]({3,4,3}) is {12/[(]1,5[)],4}, it becomes regular at [alpha] = 1/2, [infinity] (see Figure 7) and the generators of G are: [matrices]. The basic vertices for the regular cases are [(1 + [sqrt]2, 1, 0, 0)] and [(1 [-] [sqrt]2, 1, 0, 0)] with respective "reflection" matrices R = [+-] (1/[sqrt]2) ( [4x4 matrix] )."  Figure 7 caption (p. 25): "The regular H[_{1/2}]({3,4,3}) and H[_infinity]({3,4,3}) which is not a polyhedron because pairs of vertices collapse."

`{5,3,3}` and `{3,3,5}` — [PETCOX] pp. 24-25: "A basic tetrahedron for the regular polytope {5,3,3} is: v[_0] = [ ([phi]2, 1, [-][phi][^{-2}], 0) ], v[_1] = [ ([phi], [-]1, 0, 0) ], v[_2] = [ (2 + [phi], 1, 0, [-]1) ], v[_3] = (1,0,0,0), where [phi] denotes the golden ratio. The generators of G, which is of order 1440, are: [matrices]."  p. 25: "The type of H[_alpha]({5,3,3}) is {30/[(]1,11[)],3}, and for [alpha] = 0 no vertices identify, so that H[_0]({5,3,3}) can be taken as facet of a chiral 4-polytope, but not H[_1]({5,3,3}) in which four vertices come together. The basic vertices for the regular cases are [(1 [-] 2[phi] + 2[sqrt]2, [-][phi], [phi][-]1, 0)] and [(1 [-] 2[phi] [-] 2[sqrt]2, [-][phi], [phi][-]1, 0)], with respective "reflection" matrices R = [+-] (1/(2[sqrt]2)) ( [4x4 matrix] )."  [In the `v_0` line the extractor printed `(2;1;  2;0)`: the exponents of `phi` are lost; "[phi][-]1" may be `phi - 1` or `phi^{-1}`, the superscript being unrecoverable.]

`{3,5,5/2}` — [PETCOX] p. 25: "For {3,5,5/2} the type of H[_alpha] is {20/[(]1,9[)],5}. Vertices that collapse at [alpha] = 0, 1 are 2, 2 respectivelly. The group G is of order 1200. For the basic tetrahedron {v[_0] = [ ([phi]2, 1, [-][phi][^{-2}], 0) ], v[_1] = [ ([phi], [-]1, 0, 0) ], v[_2] = [ (2 + [phi], 1, 0, [-]1) ], v[_3] = (1,0,0,0)}, the generators S[_1], S[_2] of G and the reflection matrices that extend the regular case are [three matrices]" p. 26: "with respective basic vertices for the regular cases: [(1 [-] 2[phi] + 2[sqrt]2, [-][phi], [phi][-]1, 0)] and [(1 [-] 2[phi] [-] 2[sqrt]2, [-][phi], [phi][-]1, 0)]."  [Commentary: these printed data coincide with those of the `{5,3,3}` paragraph; see census.md D1, quoted in Q6.]

`{5,5/2,5}` — [PETCOX] p. 26: "For {5,5/2,5} the type of H[_alpha] is {15/[(]1,4[)],5/2}. Vertices that collapse at [alpha] = 0, 1 are 12, 12 respectively. The group G is of order 7200. For the basic tetrahedron {v[_0] = (1,0,0,0), v[_1] = [ (2 + [phi], 1, 0, [phi][-]1) ], v[_2] = [ ([phi]2, 1, [-][phi][-]1, [-][phi][-]2) ], v[_3] = [ ([phi], 1, 0, [-][phi][-]1) ]}, the generators S[_1], S[_2] and the reflection matrices that extend the regular case are [three matrices], with respective basic vertices for the regular cases: [(2 + [phi], 1, 0, [-][phi][-]1)] and [(2 [-] [phi], [-]1, 0, [phi][-]1)]."

`{5,3,5/2}` — [PETCOX] p. 26: "For {5,3,5/2} the type of H[_alpha] is {12/[(]1,5[)],3}; it remains a polyhedron at [alpha] = 0, 1. The group G is of order 144. For the basic tetrahedron {v[_0] = (1,0,0,0), v[_1] = [ (2 + [phi], 1, 0, [phi][-]1) ], v[_2] = [ (2[phi], [phi], [-]1, [-][phi][-]1) ], v[_3] = [ (1,1,1,[-]1) ]}, the generators S[_1], S[_2] of G and the reflection matrices that extend the regular case are [three matrices], with respective basic vertices for the regular cases: [(3 + 3[phi] + 2[sqrt]6[phi], [phi][-]1, [phi][-]1, [-][phi][-]1))] and [(3 + 3[phi] [-] 2[sqrt]6[phi], [phi][-]1, [phi][-]1, [-][phi][-]1))]. See Figure 9."  [The scope of the root sign and the exponents of `phi` are not recoverable from the extraction.]  Figure 9 caption (p. 27): "One regular H[_alpha]({5,3,5/2}) with a highlighted face at the ecuator."

`{3,3,5/2}` — [PETCOX] pp. 26-27: "For {3,3,5/2} the type of H[_alpha] is {30/[(]7,13[)],3}. Vertices that collapse at [alpha] = 0, 1 are 4, 1 respectivelly. The group G is of order 1440. For the basic tetrahedron {v[_0] = [ (1,1,1,[-]1) ], v[_1] = [ (2[phi], [phi], [-]1, [-][phi][-]1) ], v[_2] = [ (2[phi][-]1, [-]1, [-]1, 1 [-] 2[phi]) ], v[_3] = [ ([phi][-]1, [-]1, [phi], 2[phi]) ]}, the generators S[_1], S[_2] and the reflection matrices that extend the regular case are [three matrices], with respective basic vertices for the regular cases: [(1 [-] [phi] + [sqrt]2, [-][phi] + [sqrt]2, [sqrt]2, [-]1 + 2[phi] [-] [sqrt]2)] and [(1 [-] [phi] [-] [sqrt]2, [-][phi] [-] [sqrt]2, [-][sqrt]2, [-]1 + 2[phi] + [sqrt]2)]."

`{3,5/2,5}` — [PETCOX] p. 27: "For {3,5/2,5} the type of H[_alpha] is {20/[(]3,7[)],5/2}. Vertices that collapse at [alpha] = 0, 1 are 2, 2 respectivelly. The group G is of order 1200. For the basic tetrahedron {v[_0] = [ (1,1,1,[-]1) ], v[_1] = [ (2[phi], [phi], [-]1, 1 [-] [phi]) ], v[_2] = [ (2[phi][-]1, [-]1, [-]1, 1 [-] 2[phi]) ], v[_3] = [ ([phi], [-]1, 0, 1 [-] [phi]) ]}, the generators S[_1], S[_2] and the reflection matrices that extend the regular case are [three matrices], with basic vertices for the regular cases: [([sqrt](2+[phi]) [-] 1, 2[phi] + [sqrt](2+[phi]), [phi] + [sqrt](2+[phi]), 1 [-] [phi] [-] [sqrt](2+[phi]))] and [([-][sqrt](2+[phi]) [-] 1, 2[phi] [-] [sqrt](2+[phi]), [phi] [-] [sqrt](2+[phi]), 1 [-] [phi] + [sqrt](2+[phi]))], respectivelly. See Figure 10."  [The grouping under the root sign is inferred; the extractor prints `√2+φ`.]  Figure 10 caption (p. 28): "Around a vertex and a face of H[_{3/5}]({3,5/2,5}) of type {20/[(]3,7[)],5/2}."

`{5/2,5,5/2}` — [PETCOX] p. 27: "For {5/2,5,5/2} the type of H[_alpha] is {15/[(]2,7[)],5}. Vertices that collapse at [alpha] = 0, 1 are 12, 12 respectivelly. The group G is of order 7200. For the basic tetrahedron {v[_0] = [ (1,1,1,[-]1) ], v[_1] = [ (2[phi], [phi], [-]1, [-][phi][-]1) ], v[_2] = [ ([phi] + 2, 1, 0, [-][phi][-]1) ], v[_3] = [ ([phi][-]1, [phi], 0, 1) ]}, the generators S[_1], S[_2] and the reflection matrices that extend the regular case are [three matrices], with respective basic vertices for the regular cases: [(1, [phi], [phi][-]1, 0)] and [([phi][-]1, [-]1, [phi], [-]2[phi])]."

Summary table — [PETCOX] p. 28: "Summary of chiral polyhedra from the regular polytopes. Polytope T | Type of H[_alpha](T) | #(G) | [G : [Gamma][^+]] | Colapses at [alpha] = (0,1)"; rows: "{3,3,3} {5/[(]1,2[)],3} 60 1 (4,4); {4,3,3} {8/[(]1,3[)],3} 48 4 (1,2); {3,4,3} {12/[(]1,5[)],4} 192 3 (2,2); {5,3,3} {30/[(]1,11[)],3} 1440 5 (1,4); {3,5,5/2} {20/[(]1,9[)],5} 1200 6 (2,2); {5,5/2,5} {15/[(]1,4[)],5/2} 7200 1 (12,12); {5,3,5/2} {12/[(]1,5[)],3} 144 50 (1,1); {3,3,5/2} {30/[(]7,13[)],3} 1440 5 (4,1); {3,5/2,5} {20/[(]3,7[)],5/2} 1200 6 (2,2); {5/2,5,5/2} {15/[(]2,7[)],5} 7200 1 (12,12)".

[PETCOX] p. 28 (after the table):

> "The groups G given in the above table refer to the isometry groups of the chiral polyhedra H[_alpha](T). As we showed, these polyhedra are combinatorially regular, and thus the groups G are their rotational subgroups. For each polytope T, we shall denote by P[_T] the (regular) abstract polytope H[_alpha](T). In other words, H[_alpha](T) is a realisation in E[^4] of P[_T], and while for all [alpha] the elements of [Gamma][^+](P[_T]) are symmetries of H[_alpha](T), only for specific values of [alpha] we get that all the elements of the full automorphism group [Gamma](P[_T]) are symmetries of H[_alpha](T).
> One can observe that when T = {3,3,3} we obtain that P[_T] is a regular polyhedron of Schlaefli type {5,3} with [Gamma][^+](P[_T]) having 60 elements. Moreover, the isometry R [not in] [Gamma][^+](P[_T]) and thus, P[_T] is a dodecahedron, implying that H[_alpha](T) is a chiral realisation of the dodecahedron in E[^4]."

[PETCOX] p. 29:

> "Finally, in the cases when the symmetry group G of the chiral polyhedra H[_alpha](T) has size 7,200, we note that G is precisely the orientation preserving subgroup of the Coxeter group [3,3,5]. In the two choices of T where this occurs, the symmetry group of the regular member of the family {H[_alpha](T)} is <G,R[_0]>, where the symmetry R[_0] maps the base flag of H[_alpha](T) to its 0-adjacent flag. Since S[_1] is a twist, R[_0] must be a half-turn, and hence it preserves orientation. According to the classification in [13, Section 21], there is no finite group of orientation preserving isometries of E[^4] that contains the orientation preserving subgroup of [3,3,5] as a subgroup of index 2. Hence in those two cases R[_0] [in] G, and the polyhedra are non-orientably regular. The chiral members of these family are orientable double covers of the regular ones, which is the same phenomenon that occurs with the chiral polyhedra in E[^3] in the family P[_3](c,d) (see [26])."

---

## Q2. Do the sources define "congruent", "similar", "enantiomorphic", "mirror image", "up to congruence"? Every occurrence of the listed words

### Q2.1 [PETCOX]

Word-by-word findings (search of the full extracted text, case-insensitive, with the fi/fl ligature defect taken into account):

* **congruen\*** — no occurrence anywhere in the paper.
* **similar\*** — occurs only in the non-technical sense "Similarly, ..." / "A similar argument shows ..." (pp. 4, 6, 7, 17, 18). No geometric use.
* **enantiomorph\*** — no occurrence.
* **mirror** — no occurrence.
* **"same polyhedron"**, **"different polyhedra"** — no occurrence of either phrase. The closest are p. 10 ("continuous family of different P[_lambda]") and p. 19 ("the polyhedra ... are isomorphic and have the same symmetry group"), quoted below.
* **isometr\*** — occurrences quoted below (pp. 2, 4, 5, 6, 7, 9, 15, 28, 29).
* **reflection** in the orientation / mirror sense — pp. 1-2, 5, 6, 7, quoted below.

Quotations:

p. 1: "The symmetry of a skeletal polyhedron is measured by the number of orbits of flags (triples of incident vertex, edge and face) under the action of the symmetry group. Those with only one flag-orbit are called regular, and in a combinatorial sense they have maximal symmetry by reflections. Chiral polyhedra are those with maximal (combinatorial) symmetry by rotations but none by reflections and have two flag-orbits." (pp. 1-2)

p. 2: "Throughout this section we assume that the ambient space X is either the Euclidean space E[^3], the hyperbolic space H[^3] or the projective space P[^3] which we understand as elliptic geometry, that is, the 3-sphere S[^3] with antipodal points identified. These three spaces are orientable, and any of their isometries is a product of at most 4 plane reflections. Therefore the isometries that are products of 1 or 3 reflections reverse orientation, whereas those that are products of an even number of reflections preserve orientation.
Most of what we do also holds for the 3-sphere S[^3], however, some of the proofs would need adjustment, as in contrast to the other three spaces, lines on the sphere intersect in two antipodal points. However, one can recover polygons and polyhedra in S[^3] by lifting P[^3] to S[^3]." (pp. 2-3)

p. 3: "Polyhedra in X defined as above are realisations of abstract polyhedra in the sense of [23, Section 2A]. To any polyhedron P in X we may assign the partially ordered set consisting of vertices, edges and faces ordered by inclusion. Two elements are said to be incident if they are comparable in the partially ordered set. The ordered set is known as the abstract polyhedron associated to P."

p. 4: "A symmetry of P is an isometry of X that preserves P. We denote the group of symmetries of P by G(P). An automorphism of P is a bijection of the vertices, edges and faces that preserves the incidence; that is, automorphisms are bijections preserving the structure as abstract polyhedron. The group of automorphisms of P is denoted by [Gamma](P) and it acts freely on the flags (see [23, Proposition 2A4]). Every symmetry of a polyhedron induces an automorphism, but in general not every automorphism can be realised by a symmetry. However, an automorphism may be realised by more than one isometry."

p. 4 (Section 2.1): "The polyhedron P is said to be regular (resp. combinatorially regular) whenever G(P) (resp. [Gamma](P)) acts transitively on the flags. ... The polyhedron P is said to be chiral (resp. combinatorially chiral) whenever G(P) (resp. [Gamma](P)) induces two orbits on the flags with the property that adjacent flags belong to different orbits."

p. 5: "If P is planar then there may be more than one isometry acting like the automorphism [sigma][_1] (or [sigma][_2]). For example, in the hemicube (naturally realised in P[^3]) the automorphism [sigma][_1] can be realised by a 4-fold rotation around the line through the centre of the base face f, perpendicular to f. However, the rotatory reflection of order 4 with respect to the plane [Pi] containing the vertices and to the line perpendicular to [Pi] at the centre of the base face also acts like [sigma][_1]."

p. 6 (Proposition 2 and after): "there is a unique S[_1] [in] G(P) acting as [sigma][_1] with respect to [Phi]; there is a unique S[_2] [in] G(P) acting as [sigma][_2] with respect to [Phi]" ... "Note that if P is planar, then the above proof shows that there are exactly two symmetries of P acting as [sigma][_1] and two symmetries acting as [sigma][_2]. In each case, one of the symmetries can be obtained from the other by multiplying it by the reflection on the plane [Pi] (with P [subset] [Pi]). In this case, we shall abuse notation and denote by S[_1] and S[_2] the symmetries of the plane [Pi] that act as described above. Hence they are also unique (as isometries of [Pi])."

p. 7, Lemma 3: "Let P be a regular or chiral polyhedron in X. Then P is regular if and only if there exists an isometry R of X preserving the base vertex v, the vertex-figure at v and the base face f, but interchanging the two neighbours of v in f."  Proof, p. 7: "Since X is an orientable space, we have that S[_1] preserves the orientation if and only if any of its conjugates preserves the orientation."

p. 10 (definition of flexible): "We say that a polyhedron P is flexible if there exists a real [epsilon] > 0 and a continuous family of different P[_lambda], with [lambda] [in] ([-][epsilon],[epsilon]), such that P[_0] = P, G(P[_lambda]) = G(P), for all [lambda], and every P[_lambda] is combinatorially isomorphic to P. For example, if P is a Platonic solid in X, with vertices embedded in a small sphere, then P is flexible since we can fix the centre of the small sphere and continuously increase or decrease the radius of the sphere without changing the symmetry group or the combinatorics of P.
Chiral polyhedra in X with helical faces, are also flexible. To see this, let P be a chiral polyhedron with helical faces in X and let S[_1] and S[_2] be the generators of G(P) (by Proposition 2 they are unique). ... If v is the base vertex of P, then S[_2] is a rotation on the line [ell] through v and the centre of its vertex-figure. For each point x [in] [ell] in an [epsilon]-neighbourhood of v we can construct a polyhedron P[_x] combinatorially isomorphic to P. The vertices of P[_x] are the points of x<S[_1],S[_2]>. ... By construction, it is clear that S[_1] and S[_2] are symmetries of P[_x]. On the other hand, if we take x in such a way that the distance between v and x is very small, then x and its vertex-figure do not lie on the same plane, implying that P[_x] is also a chiral polytope, so we have that G(P) = G(P[_x]), and thus P is flexible."

p. 15 (definition of regular 4-polytope): "A regular 4-polytope with planar faces in X [in] {S[^3],P[^3],E[^3],H[^3]} is a collection of regular isometric polyhedra, called cells, satisfying: ..."

p. 19: (already quoted in Q1.4) "However, for all other values of [alpha], the polyhedra PC[_alpha](T) (respectivelly, H[_alpha](T)) are isomorphic and have the same symmetry group, regardless of whether [alpha] [in] (0,1) or not."

p. 28: (already quoted in Q1.7) "The groups G given in the above table refer to the isometry groups of the chiral polyhedra H[_alpha](T). ... H[_alpha](T) is a realisation in E[^4] of P[_T] ..." and "the isometry R [not in] [Gamma][^+](P[_T])".

p. 29: (already quoted) "the symmetry group of the regular member of the family {H[_alpha](T)} is <G,R[_0]>" ... "there is no finite group of orientation preserving isometries of E[^4] that contains ..." ... "The chiral members of these family are orientable double covers of the regular ones".

**Answer to the specific question.** [PETCOX] never says that `H_alpha(T)` for two different `alpha` are congruent, and never uses the words congruent, similar (geometrically), enantiomorphic or mirror image. It treats the `H_alpha(T)`, `alpha` varying, as (i) "the polyhedra ... isomorphic and ... the same symmetry group" (p. 19), (ii) members of "the family {H[_alpha](T)}" with "the regular member" and "the chiral members" (p. 29), (iii) realisations "in E[^4] of P[_T]" (p. 28), and (iv) — in the general flexibility discussion — "a continuous family of different P[_lambda]" with `G(P_lambda) = G(P)` and `P_lambda` "combinatorially isomorphic to P" (p. 10). No statement identifies two of them geometrically.

### Q2.2 [BHP]

Word-by-word findings: **congruen\*** — none. **similar\*** — one non-technical occurrence (p. 801). **enantiomorph\*** — two occurrences (pp. 801, 803). **mirror** — none. **isometr\*** — pp. 801, 802, 804. **reflection** — pp. 799, 801, 802, 803. **"same polyhedron"/"different polyhedra"** — none; "same" occurs in "the same geometric symmetry group" (p. 803), "the same as the 1-skeleton" (p. 802), "the same as its colouring" (p. 802).

Quotations:

p. 799 (abstract and introduction): "In this paper, we give an example of a chiral 4-polytope in projective 3-space. This example naturally yields a finite chiral 4-polytope in euclidean 4-space, giving a counterexample to a theorem previously published in the literature [Theorem 11.2 of McMullen (Discrete Comput Geom 32(1):1-35, 2004)]." ... "Regular polytopes have maximum degree of symmetry, with their automorphism group being as big as possible. Chiral polytopes have maximum possible rotational symmetry, but no reflections. (See [9] for formal definitions of these concepts.)"

p. 801: "It is well known that the hemi-hypercube {4,3,3}/2 is a regular 4-polytope in the projective space. Note that symmetries of the hemi-hypercube correspond not only to the colour respecting automorphisms of the graph, but also to the isometries of P[^3] that preserve the graph.
Now consider the graph K[_{4,4}] embedded in P[^3] as fixed, and observe that it admits two colourings as in Fig. 3. We shall refer to these colourings as chiral colourings. Note that the chiral colourings are enantiomorphic, in the sense that any reflection on a projective plane that preserves the embedding of K[_{4,4}] sends one colouring to the other. They are combinatorially equivalent to the colouring of Figs. 1 and 2, because all its bi-coloured cycles are squares. (In fact, they correspond to the Petrie polygons of the hemi-hypercube.)"

p. 801: "We now analyse these new 4-polytopes. It should be clear that what we say about one of them can be similarly said about the other, and hence we use the one on the left of Fig. 3."

p. 802, Theorem 1: "Let Q be the 4-polytope of type {4,3,3} in the projective space constructed above. Then Q is a combinatorially regular 4-polytope isomorphic to the hemi-hypercube {4,3,3}/2 but is geometrically chiral, with geometrically chiral facets."  Proof: "The 1-skeleton of Q is exactly the same as the 1-skeleton of the hemi-hypercube P and every isometry of P[^3] that preserves such graph is a symmetry of P, then every symmetry of Q is a symmetry of P. Recall that P has 192 symmetries. ... Consequently, all 96 orientation preserving elements of the symmetry group of P belong also to the symmetry group of Q. Observe that the reflection with respect to the plane perpendicular to the four edges with a given colour in the regular colouring (Fig. 2) does not preserve colours in the chiral colouring and hence, it is not a symmetry of Q. This implies that Q has precisely 96 symmetries."

p. 803: "The arguments on the previous two paragraphs also imply that the facets are geometrically chiral, although they are combinatorially regular."

p. 803: "We end this section by pointing out that the two enantiomorphic forms of Q are indeed the two polytopes arising from the diagrams in Fig. 3."

p. 804: "Hence, the two components of the above isometry are a 1-step 8-fold rotation followed by a perpendicular 3-step 8-fold rotation."

**Answer.** [BHP] uses "enantiomorphic" twice, both times in the geometric sense: two objects are enantiomorphic when "any reflection ... that preserves the embedding of K[_{4,4}] sends one ... to the other" (p. 801), and "the two enantiomorphic forms of Q" are the two polytopes of Fig. 3 (p. 803). "Congruent" and "mirror image" do not occur.

### Q2.3 [Thesis]

Word-by-word findings (grep of the `.tex`): **congruen\*** — none. **similar\*** — none. **enantiomorph\*** — none. **mirror** — one occurrence, meaning the hyperplane of a reflection (L495-496). **isometr\*** — L231, L410-414. **reflection** — hyperplane reflections only (L147, L167, L445, L463, L492, L496, L499, L527). **"same"** — L460, L472, L524-525, L554, L612. **"different"** — L235, L245 (non-geometric).

L231-L237 (Section 2): "A \textit{symmetry} of $\mathcal{P}$ is an isometry of $\mathbb{E}^4$ that preserves it set-wise. The group of symmetries of $\mathcal{P}$ will be denoted by $G(\mathcal{P})$. We call $\mathcal{P}$ \textit{regular} if $G(\mathcal{P})$ acts transitively on the set of flags, and \textit{chiral} if $G(\mathcal{P})$ induces two orbits on flags so that adjacent flags are on different orbits. In fact, whether $\mathcal{P}$ is regular or chiral, its symmetry group acts transitively on the sets of vertices, edges, faces and cells."

L410-L414: "We also expect automorphisms to correspond with isometries of $\mathbb{E}^4$. A realization is \textit{symmetric} when every automorphism of $\mathcal{P}$ induces a permutation of $V_0$, which in turn determines a unique isometry of $\mathbb{E}^4$ (if the vertex set affinely spans $\mathbb{E}^4$). Then these isometries are an euclidean representation of $\Gamma(\mathcal{P})$."

L495-L497: "The mirror of the reflection $P_i$ is the hyperplane through the origin and the $w_j$ such that $j\neq i$."

L460-L461: "Our first chiral polytope will have the same vertices and edges as the star 4-polytope $\left\{\frac{5}{2},3,5\right\}$."

L472-L473: "Further, the vertices of $\left\{\frac{5}{2},3,5\right\}$ must be the same as those of $\{3,3,5\}$ (\cite[p. 212]{ARP})."

L524-L525: "Symmetry follows from the fact the vertex-set of both $\{3,3,5\}$ and $\left\{\frac{5}{2},3,5\right\}$ is the same."

L553-L554: "For a realization by Wythoff's construction define the base vertex to be the same as the one that was used for $\left\{\frac{5}{2},3,5\right\}$."

L610-L613: "Analogue definitions for the $S_i$ as in the last section also satisfy Equations \ref{equation-string-chiral} and \ref{equation-chiral-int}, so that we have another abstract 4-polytope that is, in fact, the same as the (abstract) one constructed before."

**Answer.** The thesis never uses congruent, similar, enantiomorphic or mirror image; the only geometric identification it makes between its two polytopes is the abstract one at L610-613.

### Q2.4 [SW]

Word-by-word findings (search after collapsing the OCR's intra-word spaces, patterns `enantiomorph`, `enan`, `antio`, `mirr`, `mirror`, `image`): **enantiomorph\*** — no occurrence in the paper. **mirror** — no occurrence. **congruen\*** — none. **similar** — non-technical ("A similar remark", pp. 497, 500, 501, 504). **isometr\*** — none (the paper is purely combinatorial). **reflection** — pp. 493, 494 (quoted in Q5). **"right-handed or left-handed"** — p. 493 (quoted in Q5). The relevant passages (orientation of generators, mirror substitution of Theorem 1(c), "two ways how chiral n-polytopes can occur") are quoted in Q5.

### Q2.5 Producer documentation

The producer's texts use "congruence", "enantiomorphism", "mirror image" freely; all occurrences are quoted in Q6.

---

## Q3. [BHP]: how the polytope is defined; `S^3` or `R^4`; coordinates; the facets' "Wythoff space of chiral realizations" (p. 805)

p. 800: "Our approach follows [2,3], where a vertex-transitive realisation of a finite polytope in R[^{n+1}] naturally corresponds to a projective polytope in P[^n]. Hence, to give a chiral 4-polytope of full rank we construct a chiral 4-polytope in the projective space P[^3]."

p. 800 (Section 2): "In this section we construct a chiral 4-polytope of Schlaefli type {4,3,3} [9, pp. 29, 30]. To this end, we start by considering the complete bipartite graph K[_{4,4}]. As it is shown in Fig. 1, we can colour the edges of K[_{4,4}] with 4 colours in such a way that two edges of the same colour are not incident, so that each colour induces a perfect matching in the graph. We label the vertices of the graph v[_0], v[_1], v[_2], v[_3], u[_0], u[_1], u[_2], u[_3] as in the figure.
It is not difficult to see that with the colouring of K[_{4,4}] given in Fig. 1, we can obtain a colourful 4-polytope P in the sense of [1] (and hence, K[_{4,4}] is the 1-skeleton of P). In fact, the 2-faces of P are the 4-cycles of K[_{4,4}] that have exactly two colours. Hence, each of the alternating squares of two given colours is a 2-face of P. The facets of P are defined by the subgraphs coloured with exactly three colours. Then, we can see that P has 4 facets and each of them is a cube. (In fact, we observe that the graph Q[_3] of the cube is precisely K[_{4,4}] minus a perfect matching.) The automorphisms of P are all the colour respecting automorphisms of K[_{4,4}], that is, all the automorphisms of K[_{4,4}] that induce a permutation on the colours (see [1]).
Therefore, P is isomorphic to the hemi-hypercube {4,3,3}/2 shown in Fig. 2, and hence we view P as living in the projective 3-space. (Recall that the hemi-hypercube in P[^3] can be understood as the quotient of the hypercube {4,3,3} in R[^4] by the central inversion of R[^4] that identifies antipodal points of the hypercube. In fact the vertices of {4,3,3}/2, in homogeneous coordinates, have all entries [+-]1, and the edges are the geodesics between two vertices that differ in one entry. Furthermore, the four colours of our embedding of K[_{4,4}] correspond to the four coordinates, or directions.) Observe that there is an edge between opposite vertices of a given facet of {4,3,3}/2. In fact, the edge has precisely the colour that is missing in that cube (see Fig. 2)."

p. 801: "Now consider the graph K[_{4,4}] embedded in P[^3] as fixed, and observe that it admits two colourings as in Fig. 3. ... A simple inspection shows that the two chiral colourings have the following properties: (a) each colour has an edge in each direction (is transversal to the regular colouring), and (b) each 2-face of the regular hemi-hypercube has the four colours. It is not hard to see that any of these properties defines the chiral colourings."

p. 801-802: "As before, we regard this new 4-polytope Q as a colourful polytope: the 2-faces of Q are the 4-cycles of exactly two colours and the facets are determined by the subgraphs with exactly 3 colours. Hence, we see that the 2-faces are again 4-gons, that we see now as helices in the projective space (see Fig. 4). In fact, each of the 2-faces of Q corresponds to a Petrie polygon of P (see [9, p. 163]).
We note that the edge colouring of K[_{4,4}] in Q is the same as its colouring in P. Hence P and Q are combinatorially isomorphic. On the other hand, the 2-faces of Q are Petrie polygons of the hemicube P and vice-versa."

p. 803 (the facet and its Wythoff family): "As it was kindly pointed out to us by Peter McMullen, the facet of Q is interesting in its own right. It is a chiral projective realization of the cube {4,3} with helical faces which is not rigid, in the sense that it belongs to a continuous family of such realizations. To see this, consider the facet in Fig. 4. Its geometric symmetry group sends the edges of the deleted colour (the thin black ones) among themselves. Thus, the vertices may slide simultaneously along the lines of their corresponding deleted edges to give a family of realizations of the cube parametrized by the projective line and sharing the same geometric symmetry group. Four of these realizations are outstanding. Two become vertex unfaithful when the two vertices of each deleted edge (corresponding to a combinatorially antipodal pair in the cube) coincide in its midpoint or in its polar point in the corresponding line (which is a vertex of the hemi-crosspolytope). And two realizations become geometrically regular. They arise when a vertex and its three neighbours lie in a plane, so that the (combinatorial) reflections fixing a vertex are then realized by the 2-fold rotations along its edges."

p. 803 (Section 3, the lift to `S^3 subset R^4`): "In the previous section we gave an example of a chiral 4-polytope Q in P[^3]. We now take the double cover [Q-hat] of Q, in the sphere S[^3] [subset] R[^4].
Each of the vertices and edges of Q lift to two copies of them, and K[_{4,4}] lifts into the graph G, the 1-skeleton of the hypercube {4,3,3}. We label the vertices of G as [v-tilde] and [-][v-tilde], where v is a vertex of Q in such a way that the sets of vertices {[v-tilde] | v [in] V(Q)} and {[-][v-tilde] | v [in] V(Q)} are the vertex sets of two disjoint cubes of {4,3,3}. The 4-gons of Q lift into 8-gons of [Q-hat], implying that [Q-hat] has Schlaefli type {8,3,3}. Figure 6 shows a 2-face of [Q-hat] and its two incident facets. Each of the 4 facets is of type {8,3}, has 16 vertices, 24 edges and 6 faces. We note that [Q-hat] is again a colourful polytope and hence every symmetry of [Q-hat] induces a permutation of the colours of the graph G. Using Fig. 5 it is straightforward to see that [Q-hat] is not regular." (pp. 803-804)

p. 804: "Finally, the polytope [Q-hat] is chiral. This can be seen with arguments analogous to those in the previous section, using the symmetry group of the 4-cube {4,3,3} instead of that of the hemi-cube. Furthermore, it is not difficult to see that the 2-faces of [Q-hat] are helices in R[^4] and that the stabiliser of the pair consisting of the 2-face and any of the 3-faces in Fig. 6, is generated by the permutation of the vertices of [Q-hat] given by ([v-tilde][_0], [u-tilde][_0], [-][v-tilde][_1], [-][u-tilde][_1], [-][v-tilde][_0], [-][u-tilde][_0], [v-tilde][_1], [u-tilde][_1])([u-tilde][_2], [v-tilde][_2], [-][u-tilde][_3], [v-tilde][_3], [-][u-tilde][_2], [-][v-tilde][_2], [u-tilde][_3], [-][v-tilde][_3]), implying that the 1-step rotation in that 2-face is also the 3-step rotation in the other red-green 2-face. Hence, the two components of the above isometry are a 1-step 8-fold rotation followed by a perpendicular 3-step 8-fold rotation. We have established the following theorem.
Theorem 2 The polytope [Q-hat] is a chiral 4-polytope of full rank."

pp. 804-805: "Of course, the facet of [Q-hat] is also of interest. Its underlying graph is the Generalized Petersen graph GP(8,3), and, as it follows from our discussion in the previous section, its Wythoff space of chiral realizations is of dimension 2 with two of its realizations being geometrically regular."

**Summary for Q3.** [BHP] defines the polytope combinatorially (a colourful polytope on `K_{4,4}`) and then places it in `P^3` on the hemi-hypercube, whose vertices "in homogeneous coordinates, have all entries [+-]1" (p. 800); the Euclidean object is "the double cover [Q-hat] of Q, in the sphere S[^3] [subset] R[^4]" whose 1-skeleton is that of "the hypercube {4,3,3}" (p. 803). No explicit Cartesian coordinates for the vertices of `Q-hat`, no normalisation and no metric statement about two realisations of `Q-hat` appear. The facet's Wythoff family is described as "a family of realizations of the cube parametrized by the projective line and sharing the same geometric symmetry group" (p. 803) and as a "Wythoff space of chiral realizations ... of dimension 2 with two of its realizations being geometrically regular" (p. 805).  [Commentary: the two statements about the same family use different dimension counts — "parametrized by the projective line" (one parameter) on p. 803 and "of dimension 2" on p. 805; the paper gives no reconciliation. A Wythoff space of dimension 2 in `R^4` containing the origin is a 2-plane, whose set of directions is a projective line, which is consistent if p. 805 counts the linear dimension including scale and p. 803 counts projective classes. This reading is the auditor's, not the paper's.]

---

## Q4. [Thesis]: definitions of symmetry / regular / chiral; statements about the two polytopes being the same or different; coordinates and normalisation; the sentence of Section 6

### Q4.1 Section 2 definitions

L184-L203 (skeletal polyhedron): "A \textit{skeletal polyhedron} in $\mathbb{E}^4$ consists of \textit{vertices} (points in $\mathbb{E}^4$), \textit{edges} (segments between vertices) and \textit{faces} (cycles on the graph determined by the vertices and edges) such that: ... every edge belongs to two faces, ... the graph determined by the vertices and edges is connected, ... every compact subset of $\mathbb{E}^4$ meets finitely many edges, and ... the \textit{vertex-figure}, defined as follows, is a connected graph. For any vertex $v$, the vertices of the vertex-figure are the neighbours of $v$ and the edges are segments joining any two neighbours that are both in some face."

L206-L214 (skeletal 4-polytope): "A \textit{skeletal 4-polytope} in $\mathbb{E}^4$ consits of vertices, edges, faces and \textit{cells} (skeletal polyhedra), such that ... every face belongs to two cells, ... the graph determined by the vertices and the edges is connected, ... every compact subset of $\mathbb{E}^4$ meets finitely many edges, and ... the vertex-figure at every vertex is a skeletal polyhedron."

L231-L237 (symmetry, regular, chiral): quoted in Q2.3: "A \textit{symmetry} of $\mathcal{P}$ is an isometry of $\mathbb{E}^4$ that preserves it set-wise. ... We call $\mathcal{P}$ \textit{regular} if $G(\mathcal{P})$ acts transitively on the set of flags, and \textit{chiral} if $G(\mathcal{P})$ induces two orbits on flags so that adjacent flags are on different orbits."

L316-L318 (abstract chiral): "An abstract 4-polytope $\mathcal{P}$ is called \textit{chiral} if $\Gamma(\mathcal{P})$ induces two orbits on flags and two adjacent flags are in different orbits."

L370-L383 (combinatorial regularity criterion): "In this construction we may distinguish chiral from regular abstract 4-polytopes as follows. $\Gamma^+(\mathcal{P})$ is of index 2 in $\Gamma(\mathcal{P})$ if and only if there exists an involutory automorphism $\rho:\Gamma\to \Gamma$ such that
$\rho(\sigma_1)=\sigma_1^{-1},\quad \rho(\sigma_2)=\sigma_1^2\sigma_2\quad\text{and}\quad \rho(\sigma_3)=\sigma_3,$
in which case $\mathcal{P}$ cannot be chiral \cite[Theorem 1]{egon-asia-chiral}."

### Q4.2 Realizations and Wythoff's construction (Section 3.2)

L391-L396: "A \textit{realization} of an abstract polytope $\mathcal{P}$ is a map $\beta$ from the set of abstract 0-faces $\mathcal{P}_0$ into $\mathbb{E}^4$, so that the set $V_0:=\mathcal{P}_0\beta$ is the set of geometric vertices. All other geometric faces are defined by functions from the set of abstract $i$-faces $\mathcal{P}_i$ to some nested power set of the geometric vertex set: edges are sets of vertices, faces are sets of edges and so on."

L406-L408: "Of course, we expect the number of $i$-faces of the abstract and geometric structures to be the same. A realization is \textit{faithful} if every $\beta_i$ is a bijection."

L428-L435: "Now let $\langle S_1,S_2,S_3\rangle$ be a representation of the automorphism group, or rotation subgroup, of a chiral or regular abstract 4-polytope, respectively. For a geometric base vertex choose any point that is fixed by $S_2$ and $S_3$ but not by $S_1$. The orbit of this point is the geometric vertex-set of a realization. For a geometric flag we define the base edge as $e=v\langle S_1S_2\rangle$, or equivalently, as $e=\{v,vS_1^{-1}\}$ since $S_1^{-1}=R_1R_0$ when $\mathcal{P}$ is regular. Define the base face as $f=e\langle S_1\rangle$ and the base cell as $c=f\langle S_1,S_2\rangle$."

L441-L455 (classical / star polytopes; the only "unit vectors"): "Following Section 7D from \cite{ARP}, we say a faithfully realized abstract 4-polytope is \textit{classical} if every geometric $i$-face has dimension $i$ (its affine hull is $i$-dimensional). For any such geometric regular polytope, we may write its generating hyperplane reflections as $R_i=\{x\in\mathbb{E}^4|\langle x,u_i\rangle=0\}$ for some unit vectors $u_i$."

### Q4.3 Coordinates and normalisation used; `S^3`

The thesis prints no coordinates. The base vertex and mirrors are given by words:

L493-L497: "Call the base vertex $w_0$, the centroid of the base edge $w_1$, the centroid of the base face $w_2$ and the centroid of the base cell $w_3$. The mirror of the reflection $P_i$ is the hyperplane through the origin and the $w_j$ such that $j\neq i$."

L499-L503: "There is a choice of base flag for $\{3,3,5\}$ for which the generating reflections $R_0$ to $R_3$ satisfy the following relations, that we shall use as definitions: $P_0=R_0,\qquad P_2=R_3,\qquad P_3=R_2$, $P_1=R_1R_2R_3R_2R_1R_0R_1R_2R_3R_2R_1$".

L520-L522: "Using a particular realization of $\{3,3,5\}$, we may explicitly find the base vertex for $\left\{\frac{5}{2},3,5\right\}$. Then Wythoff's construction yields a realization that we expect to be faithful and symmetric."

L553-L554: "For a realization by Wythoff's construction define the base vertex to be the same as the one that was used for $\left\{\frac{5}{2},3,5\right\}$."

L606-L607: "and apply Wythoff's construction on the centroid of the base cell of $\left\{\frac{5}{2},3,5\right\}$."

L615: "Wythoff's construction on the base vertex then yields a symmetric and faithful realization of a chiral 4-polytope".

The sphere `S^3` appears only in figure captions and in the introduction: L155: "chiral polyhedra with helical faces in $\mathbb{S}^3$ \cite{petcox}"; L485 (Figure 1 caption): "The base cell of $\left\{\frac{5}{2},3,5\right\}$ projected to the 3-sphere $\mathbb{S}^3$ and then to $\mathbb{R}^3$ by stereographic projection from the antipode of its centroid which is a vertex of $\left\{3,3,5\right\}$."; L575 (Figure caption): "Stereographic projections of a face of $\left\{\frac{12}{1,5},3,5\right\}$ depicted as a ribbon from the cycle in the 1-skeleton to the axis of its rotation, which is in $\mathbb{R}^3\cap\mathbb{S}^3$, with the base face of $\left\{\frac{5}{2},3,5\right\}$".

[Commentary: the thesis nowhere states that its vertices lie on `S^3`; the word "projected to the 3-sphere" in the caption L485 indicates that the figures, not necessarily the polytopes, are normalised.]

### Q4.4 Statements relating the two constructed polytopes

L117-L125 (abstract): "Using GAP scripts we confirm that the natural rotation about the base edges of two of the chiral polyhedra listed in \cite{petcox} generate, in each case, a chiral 4-polytope in $\mathbb{E}^4$. Furthermore, both resulting polytopes are shown to be combinatorially chiral."

L158-L163 (introduction): "Specifically, we show that a natural rotation about the base edge in two previously studied spherical polyhedra successfully produces, in each case, a chiral 4-polytope. Moreover, we establish that their combinatorial structures are also chiral, a property not shared by their facets, which remain combinatorially regular."

L560-L569 (Section 5): "The definitions of $S_1$ and $S_2$ are as in \cite{petcox}, so that the cells are copies of the chiral polyhedron denoted as $H_1(\left\{5,3,\frac{5}{2}\right\})$. In fact, chirality in our 4-polytope follows from the chirality of the cells, since any symmetry sending a flag to its $i$-th adjacent is also a symmetry of the cell.
We have shown this structure to have 120 vertices, 720 edges, 300 faces and 50 cells. Every face has 12 vertices and edges arranged in helical fashion as shown in \cite{petcox} (see Figure \ref{fig:12}). In virtue of such arrangement we denote this polytope by $\left\{\frac{12}{1,5},3,5\right\}$."

L594-L597: "Further, it was found that there exists no automorphism $\rho$ of the group generated by the $S_i$ that satisfies Equation \ref{equation-combinatorially-chiral}, so that the abstract polytope associated to $\left\{\frac{12}{1,5},3,5\right\}$ is combinatorially chiral."

L602-L618 (Section 6, in full): "For the dual star polytope $\left\{5,3,\frac{5}{2}\right\}$ we simply define $Q_0=P_3,\qquad Q_1=P_2\qquad Q_2=P_1,\quad\text{and}\quad Q_3=P_0$ and apply Wythoff's construction on the centroid of the base cell of $\left\{\frac{5}{2},3,5\right\}$. This yields a realization of $\left\{5,3,\frac{5}{2}\right\}$.
Analogue definitions for the $S_i$ as in the last section also satisfy Equations \ref{equation-string-chiral} and \ref{equation-chiral-int}, so that we have another abstract 4-polytope that is, in fact, the same as the (abstract) one constructed before.
Wythoff's construction on the base vertex then yields a symmetric and faithful realization of a chiral 4-polytope whose cells are copies of $H_0(\left\{5,3,\frac{5}{2}\right\})$ from \cite{petcox}. We call it $\left\{\frac{12}{1,5},3,\frac{5}{2}\right\}$."

**Summary for Q4.** The thesis states that the two constructions give "the same" abstract polytope (L612) and gives the two realisations different names, `{12/(1,5),3,5}` (L569) and `{12/(1,5),3,5/2}` (L618), with cells "copies of" `H_1({5,3,5/2})` (L562) and `H_0({5,3,5/2})` (L617) respectively. It makes no statement — neither "congruent", nor "different geometrically", nor "mirror" — about the geometric relation between the two realisations; the word "copies" (L561, L616) is not defined.

---

## Q5. [SW]: "enantiomorphic", mirror image, distinguished generators `(sigma_1^{-1}, sigma_1^2 sigma_2, sigma_3, ...)`

**Negative finding.** The words "enantiomorphic", "enantiomorphism" and "mirror" do not occur in the 1991 paper (search of the full OCR text after collapsing intra-word spaces, for `enantiomorph`, `enan`, `antio`, `mirr`, `mirror`, `image`: no hit for any of them except "homomorphic image" on p. 513). The paper is combinatorial and never mentions isometries. What it does contain is the following.

p. 493 (introduction): "A honeycomb is called twisted if it is not symmetrical by reflection. For a detailed discussion of twisted honeycombs the reader is referred to Coxeter [3]. Many interesting twisted honeycombs arise from identifying points along right-handed or left-handed Petrie-polygons in hyperbolic tessellations. Accordingly, twisted honeycombs occur in right-handed or left-handed varieties. By contrast, if a honeycomb is symmetrical by reflection, then it is said to be reflexible.
In recent years the term "chiral" has been used for geometrical figures which are symmetrical by rotation but not by (hyperplane) reflection. In this sense twisted honeycombs are chiral (or irreflexible) honeycombs."

p. 494: "Here regularity means that the automorphism group of [P] is transitive on the flags of [P]. Abstract regular polytopes are symmetrical by reflection and thus may be called reflexible."

p. 495 (definition of chiral): "Now let [P] be any polytope of rank n [>=] 3, and again let [Phi] := {F[_{-1}], F[_0], ..., F[_n]} be a base flag of [P]. We call [P] chiral (or irreflexible) if [P] is not regular, but there still exist automorphisms [sigma][_1], ..., [sigma][_{n-1}] of [P] such that [sigma][_i] fixes all faces in [Phi] \ {F[_{i-1}], F[_i]} and cyclically permutes consecutive i-faces of [P] in the (polygonal) rank 2 section F[_{i+1}]/F[_{i-2}] of [P]."

p. 495 (directly regular): "A regular n-polytope [P] is called directly regular if its rotation subgroup A[^+]([P]) is of index 2 in A([P])."

p. 496 (orientation of the generators — the closest the paper comes to the two forms): "In dealing with chiral polytopes some care is necessary in handling the automorphisms [sigma][_i]. The definition of chirality leaves us with the possibility of replacing a [sigma][_i] by its inverse if need be. For reasons which become clear below, we assume that the [sigma][_i]'s have been so chosen that the following property is satisfied. For i = 0, ..., n [-] 1, denote by F'[_i] the i-face of [P] with F[_{i-1}] < F'[_i] < F[_{i+1}] and F'[_i] [!=] F[_i]. Then we require that the "orientation" of the [sigma][_i]'s is such that [sigma][_i](F'[_i]) = F[_i] for i = 1, ..., n [-] 1; this implies [sigma][_i](F[_{i-1}]) = F'[_{i-1}]. We call the corresponding set [sigma][_1], ..., [sigma][_{n-1}] of automorphisms the distinguished generators of A([P]). This notation is justified by the subsequent results."

p. 497, Proposition 1: "A([P]) has precisely two orbits on the flags. One is the set of even flags of [P], the other the set of odd flags. In particular, the flags of [P] adjacent to [Phi] are odd flags."

p. 500 (the inverting automorphism, in the self-duality discussion): "and thus [omega][sigma][_i][omega] = [sigma][_{n-i}^{-1}] for all i; it follows that there exists an involutory group automorphism A([P]) [->] A([P]) with [sigma][_i] [->] [sigma][_{n-i}^{-1}] for all i." [OCR: "co<7.co - c~\{" and "a. \-> <j~\"; the indices are reconstructed from the surrounding argument on p. 500, which concerns dualities, not mirror images.]

p. 507, Theorem 1(c) (the mirror substitution): "(c) [P] is directly regular if and only if there exists an involutory group automorphism [rho]: A [->] A such that [rho]([sigma][_1]) = [sigma][_1^{-1}], [rho]([sigma][_2]) = [sigma][_1^2][sigma][_2], and [rho]([sigma][_i]) = [sigma][_i] for i = 3, ..., n [-] 1."  [OCR: "p{ox) = ax , p(a2) = oxa2, and p{at) = a. for i = 3"; the exponents `-1` and `2` are restored from the proof on p. 509, next quotation, and agree with [Thesis] L370-383 and producer `lib.g` L19-20.]

p. 509 (proof of Theorem 1(c)): "Note first that the "orientation" of the generators is such that [sigma][_i]([Phi]) = [Phi][^{i-1,i}]; in fact, in the section A[^{i+1}]/A[^{i-2}] we have A[^{i-1}], [sigma][_i]A[^{i-1}] < A[^i]. Now assume that [P] is actually regular. Let [rho][_0], ..., [rho][_{n-1}] be the distinguished generators of A([P]) with [rho][_i]([Phi]) = [Phi][^i] for each i. Then [sigma][_i] = [rho][_{i-1}][rho][_i] for i = 1, ..., n [-] 1. Define the group automorphism [rho]: A [->] A by [rho]([phi]) := [rho][_0][phi][rho][_0]. Then
[rho]([sigma][_2]) = [rho][_0][sigma][_2][rho][_0] = [rho][_0][rho][_1][rho][_2][rho][_0] = [rho][_0][rho][_1][rho][_0][rho][_2] = ([rho][_0][rho][_1])[^2][rho][_1][rho][_2] = [sigma][_1^2][sigma][_2],
and
[rho]([sigma][_i]) = [rho][_0][sigma][_i][rho][_0] = [rho][_0][rho][_{i-1}][rho][_i][rho][_0] = [rho][_{i-1}][rho][_i] = [sigma][_i] for i [>=] 3."

p. 507 (proof of Theorem 1, the two flag orbits of `P(A)`): "As the base flag of [P] we take [Phi] := {A[^{-1}], A[^0], ..., A[^n]}. By Lemma 7(a) the only flag of [P] which is 0-adjacent to [Phi] is [Phi][^0] := {A[^{-1}], [sigma][_1][sigma][_2]A[^0], A[^1], ..., A[^n]}. The group A has precisely two orbits on the flags, one represented by [Phi] and the other by [Phi][^0]."

p. 511 (Section 6 — the two ways a chiral polytope can occur, the paper's own pointer to "oriented" polytopes): "For chiral polytopes the definition of "class" is more complicated and involves the notion of an "oriented chiral (or directly regular) polytope"; for more details see our forthcoming paper "Chiral Groups and Projective Linear Groups". This refined notion takes care of the two ways how chiral n-polytopes can occur as the isomorphism types of the facets and vertex figures of a chiral (n + 1)-polytope. If [P][_1] and [P][_2] are oriented chiral or directly regular polytopes, we write <[P][_1], [P][_2]>[^{ch}] for the class of all chiral (n + 1)-polytopes [P] with (oriented) facets [P][_1] and vertex figures [P][_2]."

p. 514 (proof of Theorem 3, an involutory automorphism corresponding to conjugation by `rho_1`): "First we construct an involutory group automorphism [alpha]: A [->] A which would correspond to conjugation with [rho][_1] in the group of [P](A). We define [alpha] on the generator of A by [alpha]([sigma][_1]) = [sigma][_1^{-1}], [alpha]([sigma][_2]) = [sigma][_2^{-1}] [OCR "o2l"; exponent uncertain], [alpha]([sigma][_3]) = [sigma][_2^{?}][sigma][_3] [OCR "G2G3"; an exponent may be lost], and [alpha]([sigma][_i]) = [sigma][_i] for i = 4, ..., n."

**Summary for Q5.** [SW] 1991 supplies: the definition of chiral via the `sigma_i` (p. 495), the fixed "orientation" convention `sigma_i(F'_i) = F_i` that removes the freedom "of replacing a `sigma_i` by its inverse" (p. 496), the two flag orbits (p. 497, p. 507), the direct-regularity criterion `rho(sigma_1) = sigma_1^{-1}, rho(sigma_2) = sigma_1^2 sigma_2, rho(sigma_i) = sigma_i` (p. 507, proof p. 509), and the remark that a chiral polytope can occur "in two ways" as facet type, handled by "oriented" polytopes in a forthcoming paper (p. 511). The phrase "two enantiomorphic forms" is [BHP]'s (p. 803), not [SW]'s.

---

## Q6. The producer's documentation and scripts

### Q6.1 RESULT.md

L5-L7: "**Yes.  Besides Roli's cube and the two realisations of the thesis, twenty-one further chiral skeletal 4-polytopes in `E^4` have PETCOX polyhedra `H_alpha(T)` as their cells, and they are now classified completely.**"

L9-L11: "Up to congruence and enantiomorphism there are exactly **24 faithful, geometrically chiral skeletal 4-polytopes in `E^4` whose cells are PETCOX polyhedra**, and they realise exactly **6 abstract 4-polytopes**:"

L22-L28: "Every cell of every one of the 24 realisations is a geometrically chiral PETCOX polyhedron (none of the admissible `alpha` is one of the exceptional values at which `H_alpha(T)` becomes geometrically regular), and every one of the 24 realisations is geometrically chiral: its full isometry group is `Gamma`, which has two flag orbits with adjacent flags in different orbits (theory.md Prop. D1).  Class 4 shows that geometric chirality does not require combinatorial chirality, exactly as in [BHP] Theorem 1."

L71-L73: "* Combinatorially chiral: the Schulte-Weiss mirror assignment does not extend (witness: `ord(S1^{-1}S3) = 30` versus `ord(S1S3) = 5`, and a certified presentation whose mirrored relator has order 6)."

L87-L89: "* **Class 4, type `{12,3,3}`, f-vector (240,480,120,20), `|Gamma| = 2880`.**  Directly regular as an abstract polytope (`X(P)` trivial, the mirror automorphism exists and is involutory) but geometrically chiral in `E^4`,"

L105-L112: "Two independent proofs: (i) no isomorphism of the rotation groups carries the distinguished triple of one to the triple of the other or to its mirror (compare.g); (ii) the orientation-independent word invariant differs, namely the multiset over the two flag orientations of `(ord(S1S3), ord(S1^{-1}S3), ord(S3S2S1), ord(S1S2S3^{-1}), ord(S1^2S3), ord(S1S3^2))` is `{(5,15,15,2,15,12), (15,5,5,2,10,15)}` for class 3 and `{(10,30,30,2,15,12), (30,10,10,2,10,30)}` for class 6 (summary.g)."

L115-L132 (the Roli's-cube section, in full): "## Roli's cube has four non-congruent chiral realisations
For `T = {4,3,3}` the complete list of admissible base vertices is `alpha = 0, 1/2, 1, 2, -1, oo`, of which `alpha = 1` and `alpha = -1` fail the intersection condition (defect 2, the vertex collapse of `H_1({4,3,3})`) and the other four give faithful chiral 4-polytopes.  All four realise the same abstract polytope, Roli's cube, and no two of them are congruent even after reflection:
| `alpha` | vertex set | edges | note |
| 0 | the 16 vertices of the 4-cube | the 32 edges of the 4-cube | **Roli's cube** [BHP 2014]; the 2-faces are 12 of the 24 Petrie octagons of the 4-cube |
| `oo` | the same 16 vertices | the 32 main diagonals of the 8 cubic facets (pairs of vertices differing in three coordinates) | no element of `[4,3,3]` carries it to Roli's cube or to the mirror image of Roli's cube, and since every isometry preserving the vertex set lies in `[4,3,3]`, it is not congruent to either; its cells are a non-congruent realisation of the same abstract facet `{8,3}*96` |
| 1/2 | a 16-point orbit of a group of order 192 not contained in `[4,3,3]` | 32 | apparently unpublished |
| 2 | as for `alpha = 1/2` (different orbit) | 32 | apparently unpublished |
[roli-alpha-infinity.g: 10 assertions; alpha-complete.g; compare.g gives the four congruence classes.]"

L161-L165: "6. Every surviving base vertex is then verified completely: relations, intersection condition, coset and orbit f-vectors, face stabilisers, diamond condition, orientation of the generators, connectedness, vertex-figure, spanning, faithfulness, geometric chirality, and the Schulte-Weiss mirror test with an explicit obstruction when it fails."

L222-L223: "* `DUPLICATE`: parent-search and Level 3 rows that are identical to, or the mirror image of, an earlier row; and the four self-dual second endpoints."

L269-L271: "in each case the dual-and-mirror variant of our distinguished triple satisfies every one of Conder's relators and the group orders agree."

[No sentence of RESULT.md contains "unit vector", "normalis", "[x]", "scale", "rescal" or "parallel".]

### Q6.2 theory.md

L11-L18: "`S1` a twist of order `p` with rotation angles `2 pi p1/p` and `2 pi p2/p` on its two invariant planes `E1, E2`, and `S2` a rotation of order `q` with `Fix(S2) = Pi`.  The PETCOX point is `w_alpha = (v,c)_alpha = [(1-alpha) v0^ + alpha v3^]` (unit vectors, `alpha` in `R u {oo}`); projectively `w(t) = t v0 + v3`, with `t = oo` giving `alpha = 0` and `t = 0` giving `alpha = 1`.  All statements below are verified exactly for all sixteen `T` by the scripts named in brackets; no floating-point value enters a decision."

L20-L34: "## A. What an extension is
A chiral or directly regular skeletal 4-polytope `P` in `E^4` whose cells are congruent to `H_alpha(T)` is, after moving it by an isometry, the Wythoff realisation of a Schulte-Weiss polytope `P(Gamma; S1, S2, X)` for some third generator `X` and some base vertex `w`:
* `X` is an isometry of `E^4` with `(S2 X)^2 = (S1 S2 X)^2 = 1`;
* the rank-4 intersection condition holds, ... ;
* `w` is fixed by `S2` and `X` and moved by `S1`, and the realisation is faithful: the geometric stabilisers of the base vertex, edge, 2-face and cell in `Gamma` are exactly `<S2,X>`, `<X, S1S2>`, `<S1, S2X>`, `<S1,S2>`."

L36-L42: "Choosing the base flag in the other flag orbit of the cell replaces `(S1,S2)` by `(S1^{-1}, S1^2 S2)` and describes the same polytope; reflecting the whole polytope replaces `H_alpha(T)` by its mirror image.  So, up to congruence and enantiomorphism, every extension is a triple `(S1, S2, X)` with the PETCOX matrices `S1, S2` kept fixed.  The orientation of every triple is certified by the flag tests `F_i . S_i = F'_i` of [SW] p. 496 [lib.g `PX.FlagChecks`]."

L46-L49: "**Lemma B1.**  `Fix(S2) = Pi`.  `S2 = R2 R1` is a rotation whose pointwise fixed space is the intersection of the mirrors of `R1` and `R2`, a 2-plane containing both `v0` and `v3`."

L51-L56: "**Corollary B2.**  Every Wythoff base vertex of every extension lies on the great circle `Pi cap S^3`, i.e. it is a PETCOX point `w_alpha` for some projective `alpha`.  Conversely the cell of the extension is then `H_alpha(T)`, because PETCOX define `H_alpha(T)` as the Wythoff polyhedron of `<S1,S2>` at `w_alpha` (p. 19-20).  Antipodal base vertices give centrally symmetric, hence congruent, polytopes."

L109-L113: "For every candidate in this study the vertices of the base 2-face span `E^4` (the faces are helical, with two nontrivial twist angles).  As a cross-check the unique linear isometry acting on `f` as the flag-reversing reflection `w S1^k -> w S1^{-k-1}` is computed exactly: it equals `S1 S2 S3`, lies in `Gamma`, and maps the base cell `c` to `c^{S3}` [canonical.g, alpha-complete.g]."

L115-L120: "Remark.  D1 also shows that no *regular* skeletal 4-polytope can have 2-faces whose vertices span `E^4`: `rho_3` would have to fix such a 2-face pointwise.  This is the geometric reason why the PETCOX cells occur only in chiral 4-polytopes.  Note that "chiral" here is geometric: `P` may be combinatorially regular (directly regular) and still geometrically chiral, exactly as in [BHP] Theorem 1; both cases occur below."

L122-L126: "The same argument applied to the cell shows that the cell has no `rho_0`-type symmetry, so the cells are geometrically chiral, while the rank-3 mirror automorphism `S1 -> S1^{-1}, S2 -> S1^2 S2` does exist: the cells are combinatorially regular but geometrically chiral, as stated in [PETCOX] p. 28 [census-audit.g for all ten rows]."

L136-L139: "(iii) Every `A` with `A S1 A = S1^{-1}` preserves the two invariant planes `E1, E2` of `S1` and acts on each as a line reflection; hence `A` is the half-turn about the 2-plane `span(l1, l2)` with `l_i` a line of `E_i`, and `det A = 1`, so `det X = 1`."

L152-L155: "Conjugation by `A` sends the `lambda`-eigenspace of `S1` to its `lambda^{-1}`-eigenspace, so `A` preserves each real invariant plane and acts on it antiholomorphically, i.e. as a line reflection; two line reflections give `det A = +1` and `A^2 = 1`."

L250-L252: "`w` on the PETCOX circle that admit a third generator, and hence the complete list of chiral or directly regular skeletal 4-polytopes in `E^4` with cells `H_alpha(T)`, up to congruence and enantiomorphism."

L265-L270: "and the normaliser `N_{O(4)}(G)` of each facet group, computed exactly from `Aut(G)` by solving the intertwining equations `X S_i = phi(S_i) X` (the kernel of `N -> Aut(G)` is the centraliser `C_{O(4)}(G) = {+-I}`, because the commutant of `G` in the matrix algebra is"

[theory.md contains no "[x]", "scale", "rescal" or "parallel".]

### Q6.3 README.md

L10-L13: "Short answer (details in `RESULT.md`): **yes, and the answer is now complete.** Up to congruence and enantiomorphism there are exactly **24** faithful, geometrically chiral skeletal 4-polytopes in `E^4` whose cells are PETCOX polyhedra, realising exactly **6** abstract 4-polytopes:"

L51: "| `gap/lib.g` | library: reflections, polytope records, exact `alpha`, twist types, intersection condition, Schulte-Weiss mirror test with obstruction, Wythoff structures, stabiliser/diamond/orientation checks, the spanning-face chirality test, comparison of triples |"

L59: "| `gap/roli-alpha-infinity.g` | the geometry of the second realisation of Roli's cube (`alpha = oo`): its edges are the main diagonals of the cubic facets of the 4-cube, and it is congruent neither to Roli's cube nor to its mirror image |"

L60: "| `gap/compare.g` | deduplication of all candidates up to isomorphism, enantiomorphism, duality and congruence |"

L93-L96: "* "Extension" means a Wythoff realisation of a Schulte-Weiss polytope `P(<S1,S2,X>)` with the PETCOX generators `S1 = R0R1R3R2`, `S2 = R2R1` kept fixed (theory.md, Section A, explains why this loses nothing up to congruence and enantiomorphism)."

### Q6.4 source-notes.md

L43-L47 (the producer's quotation of PETCOX p. 19): "...satisfying Definition 1.  However, for all other values of `alpha`, the polyhedra `PC_alpha(T)` (respectively, `H_alpha(T)`) are isomorphic and have the same symmetry group, regardless of whether `alpha` is in `(0,1)` or not.""

L61-L65: "* p. 20: "For computational simplicity, we linearize the meaning of the parameter `alpha`, so that [...] `(v,c)_alpha = [(1-alpha) v0 + alpha v3]`; where, by `[x]` we denote the normalization of `x`."  p. 21: "for `alpha = 0, 1, 1/2, infinity`, `(v,c)_alpha` will respectively mean `[v0], [v3], [[v0]+[v3]], [[v3]-[v0]]`.""

L95-L99: "* p. 28: "The groups `G` given in the above table refer to the isometry groups of the chiral polyhedra `H_alpha(T)`.  As we showed, these polyhedra are combinatorially regular, and thus the groups `G` are their rotational subgroups.  For each polytope `T`, we shall denote by `P_T` the (regular) abstract polytope `H_alpha(T)`.""

L105-L108: ""Since `S1` is a twist, `R0` must be a half-turn, and hence it preserves orientation."  For the two rows with `|G| = 7200` the regular member is non-orientably regular and the chiral members are orientable double covers."

L158-L160: "* Theorem 2 (p. 804): "The polytope `hat Q` is a chiral 4-polytope of full rank."  p. 805: the facet's "Wythoff space of chiral realizations is of dimension 2 with two of its realizations being geometrically regular"."

L164: "* p. 496: orientation convention `sigma_i(F'_i) = F_i`."

L193-L197: "* Matrices act on row vectors from the right (GAP).  The distinguished generators of every triple are checked to be in the [SW] orientation by the flag tests `F_i . S_i = F'_i` (lib.g, `PX.FlagChecks`), exactly as in `computations/chirality-groups/README.md` Section 2; consequently the mirror substitution of Theorem 1(c) is `S1 -> S1^{-1}, S2 -> S1^2 S2, S3 -> S3`."

L198-L200: "* `v3` is the centroid of the base cell (average of its vertices).  Because `c` is the orthogonal projection of `v0` onto the fixed line of the cell group, `<v0, c> = |c|^2 > 0`: the centroid direction is never antipodal to"

[source-notes.md contains no "congruen", "enantiomorph", "unit vector", "scale", "rescal" or "parallel".]

### Q6.5 census.md

L92-L100: "For all ten rows the rank-3 mirror assignment `S1 -> S1^{-1}, S2 -> S1^2 S2` extends to an involutory automorphism of `G` (GAP `GroupHomomorphismByImages`, bijectivity and involutivity checked): the abstract polyhedra `P_T` are directly regular, confirming [PETCOX] Theorem 9 / p. 28 (statement 1 of the task) for the whole census [census-audit.g, `abstract facet P_T is combinatorially regular` for all rows].  Geometrically, wherever `H_0(T)` or `H_1(T)` is a polyhedron (rows 2, 4, 7, 8) it is chiral: the unique isometry that could act as `rho_0` on the base face is `S1S2S3`, which is not in `G` [alpha-locus.g `H_0 ... geometrically chiral`, canonical.g]."

L104-L109: "Computed from the base vertices printed in the paper for the regular cases (transported to the paper's own tetrahedron, in the paper's convention for `v3`), and verified: at each such point the facet is a polyhedron and the true `rho_1` (the unique isometry fixing the base vertex and base face and swapping the two neighbours of the base vertex in the face; PETCOX Lemma 3) is a half-turn that preserves the facet [census-audit.g]."

L111-L122 (the producer's table of exceptional `alpha`): "| row | `T` | regular alpha (paper convention) | numerically | alpha in the centroid convention | ... | 1 | {3,3,3} | 1/2, oo | 0.5, oo | same | | 2 | {4,3,3} | 2 - sqrt 3, 2 + sqrt 3 | 0.26795, 3.73205 | same | | 3 | {3,4,3} | 1/2, oo | 0.5, oo | same | | 4 | {5,3,3} | 1/(1 - phi(2 - sqrt 2)), 1/(1 + phi(2 + sqrt 2)) | 19.1653, 0.15327 | same | | 5 | {3,5,5/2} | the paper prints the row-4 data (discrepancy D1); see RESULT.md for the values recomputed from the normaliser of `G` | | | | 6 | {5,5/2,5} | 1/2, oo | 0.5, oo | same | | 7 | {5,3,5/2} | 1/(2 + 3 phi +- sqrt 6 phi^2) | 0.075375, 2.26627 | same | | 8 | {3,3,5/2} | 1/(1 + phi(+-1 - 1/sqrt 2)) | 0.67847, -0.56749 | 1.90082, 0.26580 (paper's `v3` is the antipodal pole, note N1) | | 9 | {3,5/2,5} | +- sqrt((2 + phi)/5) | +-0.85065 | same | | 10 | {5/2,5,5/2} | 1/2, oo | 0.5, oo | same |"

L124-L128: "The paper states the values `1/2, oo` explicitly only for rows 1 and 3; the others are read off from the printed vertices.  None of the regular values is `0` or `1`, so every canonical endpoint facet is geometrically chiral, and none of the regular values coincides with an admissible base vertex of any extension found in the parent searches (RESULT.md)."

L130-L133: "The half-turns realising these regular cases never lie in `W(T)` [alpha-locus.g: "elements of W inverting S1 and S2 ... fixing a point of the circle: none"]; they lie in the normaliser `N_{O(4)}(G)` computed in parent-search.g (e.g. `|N| = 96` for row 2, `384` for row 3)."

L137-L142: "Verified for all ten rows: the printed basic tetrahedron defines mirrors generating a group of the right order with the expected geometric marks and f-vector (exception D1); the printed `S1` equals `R0R1R3R2` and the printed `S2` equals `R2R1` in the row-vector convention used here (exception D1); `#(G)` and the index column; the printed regular base vertices lie on the circle `span(v0, v3)` and the facet is regular there."

[census.md contains no "congruen", "enantiomorph", "unit vector", "[x]", "scale", "rescal" or "parallel".]

### Q6.6 gap/compare.g (180 lines) — header, the geometric decision code, and what it does and does not test

Header, L1-L23 (in full):

```
##  compare.g  --  deduplication of all candidates (canonical extensions and
##  parent-search survivors) up to isomorphism, enantiomorphism, duality and
##  congruence.
##
##  Abstract level: two triples define isomorphic abstract polytopes iff a
##  group isomorphism maps the distinguished generators to the distinguished
##  generators (same base-flag orbit) or to their mirror images
##  (S1^-1, S1^2 S2, S3) (the other orbit).  Duality: generators to
##  (S3^-1, S2^-1, S1^-1) (or mirrored).
##
##  Geometric level: (i) the sorted multiset of normalised inner products of
##  the vertex set is a congruence invariant; (ii) two candidates living in
##  the same Coxeter group W with the same vertex set are congruent iff one
##  is the image of the other under an element of W (the symmetry group of the
##  vertex set); since both are invariant under W^+ this reduces to the test
##  "identical, or the image under one reflection R0"; the latter means that
##  the two realisations are mirror images (enantiomorphs).
##
##  Reads ../logs/parent-survivors.g written by parent-search.g.
```

The Gram invariant, L68-L75:

```
PX.NormalisedGram := function(V)
  local i, j, l, n;
  l := [];
  for i in [1..Length(V)] do for j in [i+1..Length(V)] do
    Add(l, (V[i]*V[j])/((V[i]*V[i])));   # all vertices have the same norm (one orbit)
  od; od;
  return Collected(l);
end;
```

The geometric decision, L104-L136 (in full):

```
    cmp := PX.CompareTriples(a.G, a.s, b.G, b.s);
    geom := "different vertex Gram invariant";
    if a.gram = b.gram then
      geom := "congruent vertex sets (same Gram invariant)";
      # rescale b to a (the Wythoff base vertices are unnormalised); the factor
      # is found without square roots, from a pair of parallel vertices
      lam := fail;
      for u in b.Wy.V do
        lam := PX.Parallel(a.Wy.V[1], u);
        if lam <> fail then break; fi;
      od;
      if lam = fail then
        bst := b.st; geom := Concatenation(geom, "; no vertex of b is parallel to a vertex of a, so the vertex sets differ");
      else
        bst := PX.ApplyToStructure(b.st, lam*IdentityMat(a.dim));
      fi;
      if bst.V = a.st.V then
        if a.st.E = bst.E and a.st.F = bst.F and a.st.C = bst.C then
          geom := "IDENTICAL geometric polytope";
        else
          # mirror image under a reflection of the common W?
          R0 := PX.T.(a.T).R[1];
          if PX.T.(b.T).R[1] in Group(PX.T.(a.T).R) then
            im := PX.ApplyToStructure(a.st, R0);
            if im.V = bst.V and im.E = bst.E and im.F = bst.F and im.C = bst.C then
              geom := "MIRROR IMAGE (b = a.R0, a reflection of W): enantiomorphic realisations";
            else
              geom := "same vertex set, different edge/face/cell structure (not identical, not mirror images under R0)";
            fi;
          fi;
        fi;
      fi;
    fi;
```

The grouping into "congruence classes", L152-L162:

```
  ## geometric classes within the abstract class
  geoms := [];
  for c in mem do
    placed := false;
    for gcl in geoms do
      rel := First(c.geom_relation, r -> r.other = gcl[1]);
      if rel <> fail and (rel.geom = "IDENTICAL geometric polytope" or StartsWith(rel.geom, "MIRROR IMAGE")) then Add(gcl, c.case); placed := true; break; fi;
    od;
    if not placed then Add(geoms, [c.case]); fi;
  od;
  Print("   congruence classes up to enantiomorphism (identical or mirror-image realisations): ", geoms, "\n");
```

L167-L168 (comment): "## The expected picture: three abstract classes (Roli's cube {8,3,3}; the thesis polytope {12,3,5}; the new {30,3,3}), ## the thesis class and the new class each with two non-congruent realisations."

**What compare.g tests (read off the code, L97-L145 and L152-L162).**  For each ordered pair `(a,b)` of candidates with the same ambient dimension, the same generator orders, the same f-vector and the same `|Gamma|`:

1. Abstract: `PX.CompareTriples(a.G, a.s, b.G, b.s)` (a `lib.g` function, not read here) returns `isomorphic`, `isomorphic_same_orientation`, `isomorphic_mirror`, `dual`.
2. Geometric, step (i): `PX.NormalisedGram` — the multiset `Collected` of the ratios `(V[i]*V[j])/(V[i]*V[i])` over unordered pairs `i<j` of vertices. Because each inner product is divided by `V[i]*V[i]`, this multiset is unchanged by any scalar rescaling `V -> lam V` and by any orthogonal map; it is therefore an invariant of the vertex set under **similarities**, not only under congruences (the comment at L13-L14 calls it "a congruence invariant", which is true but weaker than what the code computes). If the Gram invariants differ the pair is labelled `"different vertex Gram invariant"` and no further geometric test is made.
3. Geometric, step (ii), only when the Gram invariants agree: a scalar `lam` is sought such that `a.Wy.V[1] = lam * u` for **some** vertex `u` of `b` (`PX.Parallel`, lib.g L708-L714: `lam := u[i]/v[i]` for the first nonzero coordinate, then `u = lam*v` is checked). `lam` may be any nonzero cyclotomic, including negative. If no vertex of `b` is parallel to `a`'s first vertex, the label is `"congruent vertex sets (same Gram invariant); no vertex of b is parallel to a vertex of a, so the vertex sets differ"` and `bst := b.st` unscaled; otherwise **all of `b`'s vertices, edges, faces and cells are multiplied by `lam`** (`PX.ApplyToStructure(b.st, lam*IdentityMat(a.dim))`).
4. If after this rescaling `bst.V = a.st.V` as sets, then if also `E`, `F`, `C` agree as sets the label is `"IDENTICAL geometric polytope"`; otherwise a **single** matrix is tried, `R0 := PX.T.(a.T).R[1]` (the first generating reflection of the Coxeter group of `a`'s parent regular polytope), and only under the condition `PX.T.(b.T).R[1] in Group(PX.T.(a.T).R)`: if `a.st` mapped by `R0` equals `bst` in `V`, `E`, `F`, `C` the label is `"MIRROR IMAGE (b = a.R0, a reflection of W): enantiomorphic realisations"`, else `"same vertex set, different edge/face/cell structure (not identical, not mirror images under R0)"`. If the condition on `R[1]` fails the label stays `"congruent vertex sets (same Gram invariant)"`.
5. The printed "congruence classes up to enantiomorphism" (L162) are built (L153-L161) by putting `c` into an existing class only when its relation to that class's **first** member is exactly `"IDENTICAL geometric polytope"` or begins with `"MIRROR IMAGE"`; every other outcome starts a new class.

**What compare.g does NOT test.**

* It never searches for an isometry, or a similarity, outside the set `{lam*I, lam*R0}`: no other element of `W(T)`, no element of `W(T)^+`, no element of the normaliser `N_{O(4)}(Gamma)`, and nothing outside `W(T)`, is ever applied. In particular a pair with the same Gram invariant but with `bst.V <> a.st.V` after the one rescaling (label `"no vertex of b is parallel ..."` or, when `V[1]` happens to be parallel to a `b`-vertex yet the sets differ, the bare label `"congruent vertex sets (same Gram invariant)"`) is placed in a **new** geometric class without any attempt to rotate `b` onto `a`; "non-congruent" in that case is not established by this script.
* The premise stated in the header, "since both are invariant under W^+" (L17), is not checked in the code; it presupposes that both candidates are invariant under `W(T)^+` and share the vertex set. For candidates whose group `Gamma` is "not contained in `[4,3,3]`" (RESULT.md L128) the premise does not hold, and the script does not verify it.
* `"IDENTICAL geometric polytope"` means equality of the four incidence-set structures **after multiplying `b` by the scalar `lam`**, i.e. equality up to the homothety `x -> lam x` with `lam` possibly negative (so possibly up to the central inversion `-I`, which in `E^4` is a proper isometry). It is not equality of the stored data (the comment at L108 states that "the Wythoff base vertices are unnormalised").
* `"MIRROR IMAGE"` means `b` (rescaled) equals the image of `a` under the one specific reflection `R0` of the parent Coxeter group; enantiomorphs related by any other improper isometry would not be recognised as mirror images by this test.
* The determinant sign of any map, and the value of `lam`, are never reported.
* The only exhaustive isometry search in the producer's scripts is in `roli-alpha-infinity.g` (below), for one pair and one group `W = [4,3,3]`.

### Q6.7 gap/roli-alpha-infinity.g (112 lines)

Header, L3-L15: "roli-alpha-infinity.g  --  the second candidate of the {4,3,3} family found by parent-search.g and by alpha-complete.g: the third generator at alpha = infinity (base vertex [v3^ - v0^], another vertex of the 4-cube).  compare.g shows that it is abstractly the enantiomorph of Roli's cube and lives on the same 16 vertices, but is neither identical to Roli's cube nor its image under the reflection R0.  This script determines its geometry precisely: * edges and 2-faces versus those of Roli's cube and of the 4-cube; * congruence of its cells H_oo({4,3,3}) with H_0({4,3,3}) (or its mirror); * whether any isometry of E^4 maps it to Roli's cube or to its mirror image (the symmetry group of the 16 vertices is [4,3,3], so this is a finite check); * the two twist orientations of the octagons."

L39-L41: "winf := Xinf.ab[1]*T.v0 + Xinf.ab[2]*T.v3; Print("base vertex at alpha = infinity: ", winf, "  (a multiple of ", winf/winf[4], ")\n"); PX.CHECK("the alpha = infinity base vertex is a vertex of the 4-cube", winf/winf[4] in Orbit(W, [1,1,1,1], OnPoints));"

L46-L47: "roli := PX.Wythoff4([S1,S2,S3], T.v0); Pinf := PX.Wythoff4([S1,S2,Xinf.X], winf/winf[4]);"  [Commentary: the second polytope is built at the rescaled base vertex `winf/winf[4]`, a vertex of the cube with coordinates `+-1`, not at `winf` itself.]

L64-L68: "## mirror image of Roli under R0 ... Print("faces of Roli.R0 among Petrie polygons: ", ..., "; equal to alpha=oo faces: ", mirrorF = Fi, ...); Print("Roli faces + mirror faces = all Petrie polygons: ", Union(Fr, mirrorF) = petrieAll, "\n");"

L69-L73: "## twist orientation: the octagon's rotation S1 vs its mirror; compare the "handedness" via the sign of a 4x4 determinant of 4 consecutive vertices ... Print("handedness of base octagon: Roli ", hand(roli, S1), ", alpha=oo ", hand(Pinf, S1), "\n");"

L74-L80: "## Is the alpha=oo polytope congruent to Roli's cube or to its mirror image?  Any isometry preserving the vertex set lies in W. ... found := Filtered(AsList(W), g -> img(Cr, g) = Ci); Print("elements g of W = [4,3,3] with Roli.g = (alpha=oo polytope): ", Length(found), "\n"); PX.CHECK("the alpha=oo polytope is congruent neither to Roli's cube nor to its mirror image", Length(found) = 0);"

L81-L87: "## its cells versus H_0({4,3,3}): congruent (possibly via a reflection)? ... cells_conj := Filtered(AsList(W), g -> Set(List(cellR, f -> ...)) in Ci); ... PX.CHECK("the cells of the alpha=oo polytope are NOT congruent to those of Roli's cube: H_oo({4,3,3}) is a different realisation of the same abstract facet", Length(cells_conj) = 0);"

L88-L92: "## the two cells are Wythoff polyhedra of the SAME group <S1,S2> at two ## different base vertices of the same circle, so they are isomorphic as ## abstract polyhedra (PETCOX p.19) but not congruent. PX.CHECK("both cells are Wythoff polyhedra of the same facet group <S1,S2> with the same distinguished generators", Group([S1,S2]) = Group([S1,S2]));"  [Commentary: the assertion at L91-L92 compares a group with itself and is tautologically true.]

L93-L95: "Print("edge inner products (vertices normalised to |v|^2 = 4): Roli ", Set(List(Er, e -> e[1]*e[2])), " (cube edges, differing in one coordinate), alpha=oo ", Set(List(Ei, e -> e[1]*e[2])), " (main diagonals of the cubic facets, differing in three coordinates)\n");"

L102: "PX.CHECK("abstractly the enantiomorph of Roli's cube", cmp.isomorphic_mirror and not cmp.isomorphic_same_orientation);"

**What this script tests.** For the single pair (Roli's cube at `alpha = 0`, the `alpha = oo` candidate), both built on the 16 vertices `(+-1,+-1,+-1,+-1)`, it enumerates **all** 384 elements `g` of `W = [4,3,3]` (reflections included, so improper isometries are covered) and checks whether `g` carries the cell set of one onto the cell set of the other (L78-L80), and separately whether any `g` carries one cell onto some cell of the other (L83-L87). The claim that this exhausts all isometries rests on the comment "Any isometry preserving the vertex set lies in W" (L74), which is not itself verified in the script. No scaling question arises because both are built at vertices of norm 2.

### Q6.8 gap/lib.g (1193 lines) — header and the normalisation-related functions

Header, L6-L22 (in full):

```
##  Conventions.
##   * Matrices act on ROW vectors from the right (GAP convention): v*M.
##     A product A*B therefore means "A first, then B".
##   * A regular 4-polytope T is stored as a record with fields
##       name, R (4 hyperplane reflections R[1..4] = R_0..R_3), W (matrix
##       group), dim (ambient dimension, 4 or 5), v0 (base vertex, exact,
##       unnormalised), v3 (normalised-direction representative of the
##       centroid of the base cell, exact, unnormalised), hyper (for the
##       simplex: the all-ones vector spanning the orthogonal complement of
##       the 4-space; otherwise fail).
##   * The PETCOX facet generators (paper eq. (2),(3)) are
##       S1 = R0 R1 R3 R2,   S2 = R2 R1,
##     and the canonical third generator is S3 = R3 R2.
##   * Schulte-Weiss orientation: (S1 S2)^2 = (S2 S3)^2 = (S1 S2 S3)^2 = 1,
##     mirror substitution S1 -> S1^-1, S2 -> S1^2 S2, S3 -> S3.
##
##  Everything is exact: entries lie in cyclotomic fields (Sqrt(5) etc.).
```

L169-L171: "## Build the record from four reflections and a base vertex direction v0. ## v3 := the centroid of the base cell (average of the orbit of v0 under ## <R0,R1,R2>), exact and unnormalised.  name is a string."

L244-L248: "## PETCOX alpha of the direction a*v0 + b*v3 (v0, v3 unnormalised): ## with unit vectors, w = a|v0| v0^ + b|v3| v3^, so ##   alpha = b|v3| / (a|v0| + b|v3|)  (projective; alpha = infinity if the ## denominator vanishes).  Returns a record with exact alpha when the norm ## ratio rho = |v0|/|v3| is a cyclotomic, otherwise a float, plus flags."

L276-L284: "## The PETCOX base vertex direction for a given alpha (needs unit vectors; ## returns an exact vector when the norms are cyclotomic, else fail) PX.BaseVertexAtAlpha := function(T, alpha) ... n0 := PX.SqrtCyc(T.v0*T.v0); n3 := PX.SqrtCyc(T.v3*T.v3); if n0 = fail or n3 = fail then return fail; fi; if alpha = infinity then return T.v3/n3 - T.v0/n0; fi; return (1-alpha)*T.v0/n0 + alpha*T.v3/n3; end;"

`PX.Wythoff4`, L464-L492 (the realisation used by compare.g): "## by S = [S1,S2,S3] with base vertex w.  Returns a record with vertex list ## (exact vectors), and edges/faces/cells as index structures, plus the ## permutation action of Gamma on the vertices. PX.Wythoff4 := function(S, w) ... V := Orbit(Gm, w, OnPoints); ... e := Set([pos(w), pos(w*S[1]^-1)]); f := Set(Orbit(Group(S1p), e, OnSets)); c := Set(Orbit(Group(S1p, S2p), f, OnSetsSets)); Ed := Orbit(Pv, e, OnSets); Fa := Orbit(Pv, f, OnSetsSets); Ce := Orbit(Pv, c, PX.OnSetsSetsSets); ... fvector := [Length(V), Length(Ed), Length(Fa), Length(Ce)], ..."  [Commentary: `w` is used as given, without normalisation; the vertex set is the orbit of the unnormalised `w`.]

`PX.Parallel`, L707-L714: "## u = lambda v ?  returns lambda, or fail PX.Parallel := function(u, v) local i, lam; i := First([1..Length(v)], k -> v[k] <> 0); lam := u[i]/v[i]; if u = lam*v then return lam; fi; return fail; end;"

`PX.NormalisedGram` is defined in compare.g (L68-L75, quoted above), not in lib.g.

L1164-L1168 (the only "scale"): "## Scale a matrix X0 that intertwines the generators so that it becomes an ## orthogonal matrix, or return fail.  In the 5-coordinate simplex model the ## solution kills the fixed all-ones direction, so X0 X0^T is a multiple of ## the projection onto the 4-space; the scaled matrix is completed by the ## projection onto the fixed direction."  L1169-L1177: "PX.OrthogonaliseIntertwiner := function(X0, hyper) ... c := X0*TransposedMat(X0); if c <> c[1][1]*IdentityMat(d) or c[1][1] = 0 then return fail; fi; sq := PX.SqrtCyc(c[1][1]); if sq = fail then return fail; fi; return X0/sq;"

**Summary of the producer's stated normalisation.** `lib.g` L11-L13 and L171 state that `v0` and `v3` are stored "exact, unnormalised"; L244-L248 and L276-L277 state that PETCOX's `alpha` refers to the "unit vectors" `v0^`, `v3^`; compare.g L108 states that "the Wythoff base vertices are unnormalised" and rescales one candidate onto the other by a scalar before comparing; theory.md L14 states the PETCOX point with "(unit vectors, ...)". No document states the norm of the stored `w` of `alpha-survivors.g`.

---

## Reading: what the sources support as the intended meaning of the seven relations

All statements below are the auditor's reading; the evidence is the quotations above.

1. **Equality of stored data** (the records of `alpha-survivors.g` agree entry by entry after building `V, E, F, C` from `S1, S2, X, w`).  No source defines or uses this relation. [PETCOX] works exclusively with normalised vectors on `S^3` (p. 19 "we first project it to S[^3]"; p. 20 "[x] := (1/||x||)x"), so for [PETCOX] "the same point" means the same unit vector. The producer states that its stored `v0`, `v3` are "unnormalised" (lib.g L12-L13) and that "the Wythoff base vertices are unnormalised" (compare.g L108), and its "IDENTICAL geometric polytope" verdict is reached only **after** multiplying one candidate by a scalar `lam` (compare.g L110-L118). Hence equality of stored data is stricter than anything the producer claims and is not the relation behind any published statement; a failure of raw equality between two stored realisations is not, by itself, in conflict with any source.

2. **Proper congruence** (an isometry of `E^4` with `det = +1`).  None of the four primary sources names it. The orientation distinction is present in all of them: [PETCOX] p. 2 separates isometries that "reverse orientation" from those that "preserve orientation" and p. 29 argues with "orientation preserving isometries of E[^4]"; [BHP] p. 801 defines enantiomorphic colourings through "any reflection ... sends one colouring to the other"; [SW] p. 493 has "right-handed or left-handed varieties". The producer's phrase "up to congruence and enantiomorphism" (RESULT.md L9, README L11, theory.md L39, L252) and the sentence "no two of them are congruent even after reflection" (RESULT.md L121-L122) read most naturally with "congruent" = proper congruence and "enantiomorphism"/"after reflection" adding the improper isometries; but the producer's operational class in compare.g L162 ("congruence classes up to enantiomorphism (identical or mirror-image realisations)") merges the two, and theory.md L56 calls centrally symmetric polytopes "congruent" via `-I`, which in `E^4` is proper. So the sources support proper congruence as the finer of the producer's two levels, without ever isolating it by name.

3. **Congruence** (any isometry of `E^4`).  Supported as the natural meaning of the producer's "congruent" in theory.md L22-L23 ("congruent to `H_alpha(T)` is, after moving it by an isometry") and in the roli-alpha-infinity.g search over all of `W = [4,3,3]`, reflections included (L74-L80), whose passing assertion is worded "congruent neither to Roli's cube nor to its mirror image" — i.e. there "congruent" excludes the mirror and the disjunction covers all of `W`. The primary sources define "symmetry" as "an isometry of X that preserves P" ([PETCOX] p. 4; [Thesis] L231) but never define congruence between two distinct polyhedra. [PETCOX] never asserts congruence between different `H_alpha(T)`; its only relation between them is "isomorphic and have the same symmetry group" (p. 19).

4. **Proper similarity** and 5. **Similarity** (`x -> x M`, `M M^T = lambda I`, with or without `det M > 0`).  No primary source mentions similarity; [PETCOX] eliminates scale by fiat through the normalisation `[x]` (p. 20) and the projection to `S^3` (p. 19), and in `S^3`/`P^3` there are no non-isometric similarities, so the question does not arise there. The producer's code, however, implements similarity: `PX.NormalisedGram` (compare.g L68-L75) is a similarity invariant (ratios of inner products), and "IDENTICAL geometric polytope" is decided after the homothety `x -> lam x` (compare.g L110-L122) with `lam` unrestricted in sign. Thus, within the producer's own work, the operative equivalence between two stored realisations is a similarity by a scalar (possibly negative) times, at most, the single reflection `R0`; general similarities (with a rotation part) are never searched by compare.g. The distinction proper/improper similarity is supported only through the producer's "mirror image" label (compare.g L129).

6. **Congruence after the documented normalisation** (rescale every vertex set to `S^3`, then look for an isometry).  This is the relation the sources actually intend for "the same polyhedron/polytope": [PETCOX] p. 19-21 (everything on `S^3`, `(v,c)_alpha = [(1-alpha)v0 + alpha v3]`), theory.md L14 ("(unit vectors, ...)"), lib.g L244-L248 ("with unit vectors, w = a|v0| v0^ + b|v3| v3^"), compare.g L108-L118 (rescaling before comparison). Since every stored realisation is a single `Gamma`-orbit, all its vertices have one common norm, and rescaling to `S^3` is the same as the producer's scalar `lam` up to the sign of `lam`; so "IDENTICAL geometric polytope" in compare.g is equality of normalised structures up to `+-1`, and "MIRROR IMAGE" is equality after one further reflection `R0`. Any claim of *non*-congruence after normalisation is supported by the producer's code only where an exhaustive isometry search was made (roli-alpha-infinity.g, one pair, `W = [4,3,3]`), or where the Gram invariant differs (compare.g L105), which is a valid obstruction to similarity and hence to congruence.

7. **Up to enantiomorphism** (identify a realisation with its mirror image).  Two distinct meanings are supported. *Geometric*: [BHP] p. 801 ("any reflection ... sends one colouring to the other") and p. 803 ("the two enantiomorphic forms of Q"); theory.md L36-L39 ("reflecting the whole polytope replaces `H_alpha(T)` by its mirror image. So, up to congruence and enantiomorphism, ..."); compare.g L18-L19 and L129 ("mirror images (enantiomorphs)", "MIRROR IMAGE (b = a.R0, a reflection of W)"); roli-alpha-infinity.g L64-L68, L102. *Combinatorial*: [SW] p. 496 (the freedom "of replacing a [sigma][_i] by its inverse", fixed by the orientation convention), p. 507 Theorem 1(c) (the substitution `sigma_1 -> sigma_1^{-1}, sigma_2 -> sigma_1^2 sigma_2, sigma_i -> sigma_i`), p. 511 ("the two ways how chiral n-polytopes can occur"); [Thesis] L370-L383; compare.g L7-L11 ("mirror images (S1^-1, S1^2 S2, S3) (the other orbit)"); census.md L92-L94; lib.g L19-L20. The word "enantiomorphic" itself occurs, among the primary sources, only in [BHP]; [SW] 1991 does not use it. The producer's headline count "24 ... up to congruence and enantiomorphism" (RESULT.md L9) therefore identifies a realisation with its geometric mirror image, and — by compare.g L158 — the only mirror image it recognises is the image under the parent's reflection `R0`.

Done: sources-quotes.md
