#############################################################################
##
##  controls.g  --  the three control cases, reproduced from the legacy
##  definitions and compared with the constructions of polytopes.g:
##
##   (1) Roli's cube (Bracho-Hubard-Pellicer 2014): cube.g matrices, S1 =
##       R0R1R3R2, S2 = R2R1, S3 = R3R2, base vertex (1,1,1,1).
##   (2) {12/(1,5),3,5} of the thesis: geometric.g words P0 = R0,
##       P1 = R1R2R3R2R1R0R1R2R3R2R1, P2 = R3, P3 = R2 for {5/2,3,5},
##       base vertex w0 = (1,0,0,0) * (R0R1R2R1R2R3R2R1R3R2R3R2R1R2R3R2R1).
##   (3) {12/(1,5),3,5/2} of the thesis: dual.g / geometric-dual.g, Q_i =
##       P_{3-i}, base vertex = centroid of the base cell of {5/2,3,5}.
##
##  and the statement of petcox.pdf p.25 about H_0({5,3,3}) (control 4).
##  Each is verified with PX.FullVerify and shown to be W-conjugate to the
##  corresponding record of polytopes.g.
##
#############################################################################

if not IsBound(PX) then Read("lib.g"); fi;
if not IsBound(PX.T) or Length(RecNames(PX.T)) = 0 then Read("polytopes.g"); PX.BuildAll(); PX.SetupRows(); fi;

## conjugacy of two ordered quadruples of mirrors inside W
PX.ConjugateQuadruples := function(Wmat, R1, R2)
  local ps, g;
  ps := PX.PermSetup(Wmat);
  g := RepresentativeAction(ps.P, List(R1, ps.im), List(R2, ps.im), OnTuples);
  if g = fail then return fail; fi;
  return PreImagesRepresentative(ps.iso, g);
end;

#############################################################################
##  (1) Roli's cube
#############################################################################
Print("\n############ CONTROL 1: Roli's cube (cube.g / combinatorially-chiral-cube.g) ############\n");
R0 := [ [ -1, 0, 0, 0 ], [ 0, 1, 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ] ];
R1 := [ [ 0, 1, 0, 0 ], [ 1, 0, 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ] ];
R2 := [ [ 1, 0, 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 1, 0, 0 ], [ 0, 0, 0, 1 ] ];
R3 := [ [ 1, 0, 0, 0 ], [ 0, 1, 0, 0 ], [ 0, 0, 0, 1 ], [ 0, 0, 1, 0 ] ];
S1 := R0*R1*R3*R2; S2 := R2*R1; S3 := R3*R2;
Tc := PX.T.("{4,3,3}");
PX.CHECK("Roli: cube.g reflections coincide with the {4,3,3} record", [R0,R1,R2,R3] = Tc.R);
PX.CHECK("Roli: cube.g triple coincides with the canonical triple", [S1,S2,S3] = PX.CanonicalTriple(Tc));
PX.CHECK("Roli: base vertex (1,1,1,1) is the record's v0", Tc.v0 = [1,1,1,1]);
roli := PX.FullVerify(Tc, [S1,S2,S3], [1,1,1,1], "CONTROL Roli's cube");
PX.CHECKEQ("Roli: f-vector (BHP: 16 vertices, 32 edges, 12 octagons, 4 facets)", roli.fvector_geometric, [16,32,12,4]);
PX.CHECKEQ("Roli: facet f-vector (BHP: each facet {8,3} has 16 vertices, 24 edges, 6 faces)", roli.facet.fvector, [16,24,6]);
PX.CHECKEQ("Roli: type {8,3,3}", roli.orders, [8,3,3]);
PX.CHECK("Roli: BHP twist of a 2-face = 1-step and 3-step 8-fold rotations", [1,3] in roli.twist.pairs);
PX.CHECK("Roli: geometrically chiral (BHP Theorem 2)", roli.geometrically_chiral);
PX.CHECK("Roli: combinatorially chiral (legacy mirror test fails)", not roli.mirror.directly_regular);
PX.CHECK("Roli: facets geometrically chiral but combinatorially regular (BHP Theorem 1)",
         roli.facet.geometrically_regular = false and roli.facet_abstract.mirror.directly_regular);

#############################################################################
##  (2) {12/(1,5),3,5}: geometric.g / abstract.g
#############################################################################
Print("\n############ CONTROL 2: {12/(1,5),3,5} (geometric.g, abstract.g) ############\n");
rho := (1 + Sqrt(5)) / 2;
R0 := (1/2) * [ [rho, 1, 0, -1 + rho], [1, 1 - rho, 0, -rho], [0, 0, 2, 0], [-1 + rho, -rho, 0, 1] ];
R1 := [ [1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, -1] ];
R2 := (1/2) * [ [2, 0, 0, 0], [0, rho, -1, rho - 1], [0, -1, 1 - rho, rho], [0, rho - 1, rho, 1] ];
R3 := [ [1, 0, 0, 0], [0, 1, 0, 0], [0, 0, -1, 0], [0, 0, 0, 1] ];
PX.CHECK("thesis: 600-cell reflections coincide with PX.H4.R600", [R0,R1,R2,R3] = PX.H4.R600);
g600 := Group([R0,R1,R2,R3]);
PX.CHECKEQ("thesis: |[3,3,5]|", Size(g600), 14400);
P0 := R0; P1 := R1*R2*R3*R2*R1*R0*R1*R2*R3*R2*R1; P2 := R3; P3 := R2;
Print("orders of P_{i-1}P_i: ", [Order(P0*P1), Order(P1*P2), Order(P2*P3)], "; commuting pairs: ",
      [P0*P2 = P2*P0, P0*P3 = P3*P0, P1*P3 = P3*P1], "\n");
PX.CHECK("thesis: P_i are involutions with string orders (5,3,5) and commuting non-adjacent pairs",
         ForAll([P0,P1,P2,P3], x -> x^2 = IdentityMat(4)) and [Order(P0*P1), Order(P1*P2), Order(P2*P3)] = [5,3,5]
         and P0*P2 = P2*P0 and P0*P3 = P3*P0 and P1*P3 = P3*P1);
PX.CHECK("thesis: <P_i> = [3,3,5]", Group([P0,P1,P2,P3]) = g600);
v0 := [1,0,0,0];
w0 := v0*(R0*R1*R2*R1*R2*R3*R2*R1*R3*R2*R3*R2*R1*R2*R3*R2*R1);
PX.CHECK("thesis: w0 fixed by P1,P2,P3 and moved by P0", w0*P1 = w0 and w0*P2 = w0 and w0*P3 = w0 and w0*P0 <> w0);
Tleg := PX.MakePolytope("{5/2,3,5}(thesis)", [P0,P1,P2,P3], w0, fail);
sdl := PX.SchlaefliData(Tleg);
PX.CHECKEQ("thesis: geometric marks of <P_i> with base vertex w0", sdl.marks, [5/2,3,5]);
PX.CHECKEQ("thesis: f-vector of {5/2,3,5}", PX.FVectorOfT(Tleg), [120,720,720,120]);
Tmine := PX.T.("{5/2,3,5}");
g := PX.ConjugateQuadruples(g600, Tmine.R, Tleg.R);
PX.CHECK("thesis: (P0,P1,P2,P3) is conjugate in [3,3,5] to the mirrors of the {5/2,3,5} record", g <> fail);
if g <> fail then
  PX.CHECK("thesis: the conjugating element maps v0 of the record to +-w0", Tmine.v0*g = w0*PX.Parallel(Tmine.v0*g, w0));
fi;
S1 := P0*P1*P3*P2; S2 := P2*P1; S3 := P3*P2;
thesis1 := PX.FullVerify(Tleg, [S1,S2,S3], w0, "CONTROL {12/(1,5),3,5} (thesis, legacy generators)");
PX.CHECKEQ("thesis: orders (12,3,5)", thesis1.orders, [12,3,5]);
PX.CHECKEQ("thesis: f-vector (120,720,300,50)", thesis1.fvector_geometric, [120,720,300,50]);
PX.CHECKEQ("thesis: |Gamma| = 7200", thesis1.gamma_order, 7200);
PX.CHECKEQ("thesis: facet group order 144 (H_1({5,3,5/2}) = H_0({5/2,3,5}))", thesis1.G_order, 144);
PX.CHECK("thesis: faces are 12-gons of twist type (1,5)", thesis1.twist.p = 12 and [1,5] in thesis1.twist.pairs);
PX.CHECK("thesis: vertex-figures are icosahedra {3,5}", thesis1.vf.vf_face_size = 3 and thesis1.vf.vf_vertex_degree = 5 and thesis1.vf.counts_match);
PX.CHECK("thesis: geometrically chiral", thesis1.geometrically_chiral);
PX.CHECK("thesis: combinatorially chiral", not thesis1.mirror.directly_regular);
## legacy stabiliser statements of geometric.g (there tested only up to isomorphism; here as subgroups)
PX.CHECK("thesis: geometric stabilisers equal the face groups <S2,S3>, <S1S2,S3>, <S1,S2S3>, <S1,S2>", thesis1.stab.all);

#############################################################################
##  (3) {12/(1,5),3,5/2}: dual.g / geometric-dual.g / abstract-dual.g
#############################################################################
Print("\n############ CONTROL 3: {12/(1,5),3,5/2} (dual.g, geometric-dual.g) ############\n");
Q0 := P0; Q1 := P1; Q2 := P2; Q3 := P3;
D0 := Q3; D1 := Q2; D2 := Q1; D3 := Q0;
## base vertex: centroid of the base cell of {5/2,3,5} (geometric-dual.g averages over a transversal)
rt := RightTransversal(Group([Q0,Q1,Q2]), Group([Q1,Q2]));
u0 := Sum(List(rt, t -> w0*t))/Length(rt);
PX.CHECK("dual thesis: u0 fixed by D1,D2,D3 and moved by D0", u0*D1 = u0 and u0*D2 = u0 and u0*D3 = u0 and u0*D0 <> u0);
Tlegd := PX.MakePolytope("{5,3,5/2}(thesis)", [D0,D1,D2,D3], u0, fail);
PX.CHECKEQ("dual thesis: geometric marks", PX.SchlaefliData(Tlegd).marks, [5,3,5/2]);
vRSd := [rho/2,1/2,0,1/2-rho/2];      # base vertex used in dual.g for {5,3,5/2}
Print("dual.g base vertex ", vRSd, ": fixed by D1,D2,D3: ", [vRSd*D1 = vRSd, vRSd*D2 = vRSd, vRSd*D3 = vRSd],
      "; parallel to the centroid u0: ", PX.Parallel(vRSd, u0), "\n");
PX.CHECK("dual thesis: dual.g base vertex is fixed by D1,D2,D3 (a legitimate Wythoff point of {5,3,5/2})",
         vRSd*D1 = vRSd and vRSd*D2 = vRSd and vRSd*D3 = vRSd);
Tmined := PX.T.("{5,3,5/2}");
g := PX.ConjugateQuadruples(g600, Tmined.R, Tlegd.R);
PX.CHECK("dual thesis: (D0,D1,D2,D3) conjugate in [3,3,5] to the mirrors of the {5,3,5/2} record", g <> fail);
S1 := D0*D1*D3*D2; S2 := D2*D1; S3 := D3*D2;
thesis2 := PX.FullVerify(Tlegd, [S1,S2,S3], u0, "CONTROL {12/(1,5),3,5/2} (thesis, legacy dual generators)");
PX.CHECKEQ("dual thesis: orders (12,3,5)", thesis2.orders, [12,3,5]);
PX.CHECKEQ("dual thesis: f-vector (120,720,300,50)", thesis2.fvector_geometric, [120,720,300,50]);
PX.CHECK("dual thesis: geometrically chiral", thesis2.geometrically_chiral);
PX.CHECK("dual thesis: combinatorially chiral", not thesis2.mirror.directly_regular);
ps600 := PX.PermSetup(g600);
cmp := PX.CompareTriples(Subgroup(ps600.P, List([P0*P1*P3*P2, P2*P1, P3*P2], ps600.im)), List([P0*P1*P3*P2, P2*P1, P3*P2], ps600.im),
                         Subgroup(ps600.P, List([S1,S2,S3], ps600.im)), List([S1,S2,S3], ps600.im));
Print("thesis: the two abstract polytopes: isomorphic (same orientation / mirror) = ", cmp.isomorphic_same_orientation, " / ", cmp.isomorphic_mirror, "\n");
PX.CHECK("thesis: {12/(1,5),3,5} and {12/(1,5),3,5/2} are the same abstract polytope (thesis Sec. 6)", cmp.isomorphic);
## the legacy base vertex of chiral.g / dual.g
vRS := [rho/2,-(1/2),0,1/2-rho/2];
Print("chiral.g base vertex vRS = ", vRS, "; fixed by P1,P2,P3: ", [vRS*P1 = vRS, vRS*P2 = vRS, vRS*P3 = vRS], "\n");
PX.CHECK("chiral.g: its base vertex is a multiple of w0 (same Wythoff point)", PX.Parallel(vRS, w0) <> fail);

#############################################################################
##  (4) The statement of petcox.pdf p.25: H_0({5,3,3}) can be taken as a facet
##  of a chiral 4-polytope (verified by canonical.g; recorded here for the
##  control list) and the {4,3,3} statement of p.23 (Roli's cube).
#############################################################################
Print("\n############ CONTROL 4: petcox.pdf statements ############\n");
T := PX.T.("{5,3,3}"); S := PX.CanonicalTriple(T);
c4 := PX.FullVerify(T, S, T.v0, "CONTROL H_0({5,3,3}) as a facet (petcox.pdf p.25)");
PX.CHECK("petcox p.25: H_0({5,3,3}) is the facet of a chiral 4-polytope (canonical extension)", c4.skeletal_polytope and c4.geometrically_chiral);
PX.CHECKEQ("petcox p.25: H_0({5,3,3}) has no vertex collapse (facet vertices 1440/3)", c4.facet.fvector[1], 480);
T := PX.T.("{3,3,5}"); S := PX.CanonicalTriple(T);
ps := PX.PermSetup(T.W); ipd := PX.IntersectionData(ps.P, List(S, ps.im));
PX.CHECKEQ("petcox p.25: H_1({5,3,3}) = H_0({3,3,5}) has four vertices coming together", ipd.defect, 4);

PX.Summary("controls.g");
if PX.nfail > 0 then QuitGap(1); fi;
Print("Done: controls.g\n");
