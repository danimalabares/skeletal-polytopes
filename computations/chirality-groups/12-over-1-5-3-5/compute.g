#############################################################################
##
##  12-over-1-5-3-5/compute.g
##
##  Chirality group of the skeletal 4-polytope {12/(1,5),3,5} of the
##  master's thesis / paper "Two new chiral 4-polytopes of full rank"
##  (Bracho, Gonzalez-Casanova, Hubard).
##
##  The group and the distinguished triple are transcribed VERBATIM from the
##  legacy scripts  abstract.g / combinatorially-chiral.g  (Coxeter-group
##  version, passing through P0,...,P3) and  geometric.g / chiral.g  (matrix
##  version); see legacy/PROVENANCE.md.
##
##  Run from computations/chirality-groups:
##      gap -q -A --quitonbreak 12-over-1-5-3-5/compute.g
##
#############################################################################

if not IsBound(CG) then Read("common/chirality-group.g"); fi;
if not IsBound(CG_PRINT_REPORT) then CG_PRINT_REPORT := true; fi;

if CG_PRINT_REPORT then
  Print("##########################################################\n");
  Print("# {12/(1,5),3,5}: chirality group computation\n");
  Print("##########################################################\n");
  CG.PrintEnvironment();
fi;

#############################################################################
##  1. The Coxeter group [3,3,5] exactly as in abstract.g
#############################################################################
##  legacy (abstract.g, lines 13-16 = combinatorially-chiral.g, lines 3-6):
##    f:=FreeGroup("E0","E1","E2","E3");
##    g:=f/[f.1^2,f.2^2,f.3^2,f.4^2,
##    (f.1*f.2)^3,(f.2*f.3)^3,(f.3*f.4)^5,
##    (f.1*f.3)^2,(f.1*f.4)^2,(f.2*f.4)^2];
TW := rec();
TW.f := FreeGroup("E0","E1","E2","E3");
TW.fpW := TW.f/[TW.f.1^2,TW.f.2^2,TW.f.3^2,TW.f.4^2,
  (TW.f.1*TW.f.2)^3,(TW.f.2*TW.f.3)^3,(TW.f.3*TW.f.4)^5,
  (TW.f.1*TW.f.3)^2,(TW.f.1*TW.f.4)^2,(TW.f.2*TW.f.4)^2];

TW.iso := IsomorphismPermGroup(TW.fpW);
TW.W   := Image(TW.iso);
TW.Egens := List(GeneratorsOfGroup(TW.fpW), x -> Image(TW.iso, x));
TW.E0 := TW.Egens[1]; TW.E1 := TW.Egens[2]; TW.E2 := TW.Egens[3]; TW.E3 := TW.Egens[4];

##  legacy (abstract.g, lines 31-34): generators of the star polytope {5/2,3,5}
##    P0:=E0;
##    P1:=E1*E2*E3*E2*E1*E0*E1*E2*E3*E2*E1;
##    P2:=E3;
##    P3:=E2;
TW.P0 := TW.E0;
TW.P1 := TW.E1*TW.E2*TW.E3*TW.E2*TW.E1*TW.E0*TW.E1*TW.E2*TW.E3*TW.E2*TW.E1;
TW.P2 := TW.E3;
TW.P3 := TW.E2;
TW.Pgens := [TW.P0, TW.P1, TW.P2, TW.P3];
TW.H := Subgroup(TW.W, TW.Pgens);

##  legacy (abstract.g, lines 43-45):
##    S1:=P0*P1*P3*P2;
##    S2:=P2*P1;
##    S3:=P3*P2;
TW.S1 := TW.P0*TW.P1*TW.P3*TW.P2;
TW.S2 := TW.P2*TW.P1;
TW.S3 := TW.P3*TW.P2;
TW.gens := [TW.S1, TW.S2, TW.S3];
TW.G := Subgroup(TW.W, TW.gens);

TW.Wplus := Subgroup(TW.W, [TW.E0*TW.E1, TW.E1*TW.E2, TW.E2*TW.E3]);

## String relations of the P_i (star polytope {5/2,3,5} has type {5,3,5}).
TW.P_orders := List(TW.Pgens, Order);
TW.P_products := [Order(TW.P0*TW.P1), Order(TW.P1*TW.P2), Order(TW.P2*TW.P3),
                  Order(TW.P0*TW.P2), Order(TW.P0*TW.P3), Order(TW.P1*TW.P3)];

#############################################################################
##  2. Geometric cross-check with the matrices of geometric.g / chiral.g
#############################################################################
##  legacy (geometric.g, lines 12-33)
TW.phi := (1 + Sqrt(5)) / 2;          # golden ratio ("rho" in geometric.g)
TW.R0 := (1/2) * [ [TW.phi, 1, 0, -1 + TW.phi],
                   [1, 1 - TW.phi, 0, -TW.phi],
                   [0, 0, 2, 0],
                   [-1 + TW.phi, -TW.phi, 0, 1] ];
TW.R1 := [ [1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, -1] ];
TW.R2 := (1/2) * [ [2, 0, 0, 0],
                   [0, TW.phi, -1, TW.phi - 1],
                   [0, -1, 1 - TW.phi, TW.phi],
                   [0, TW.phi - 1, TW.phi, 1] ];
TW.R3 := [ [1, 0, 0, 0], [0, 1, 0, 0], [0, 0, -1, 0], [0, 0, 0, 1] ];
TW.Rgens := [TW.R0, TW.R1, TW.R2, TW.R3];
TW.Gmat := Group(TW.Rgens);
##  legacy (geometric.g, lines 37-46)
TW.mP0 := TW.R0;
TW.mP1 := TW.R1*TW.R2*TW.R3*TW.R2*TW.R1*TW.R0*TW.R1*TW.R2*TW.R3*TW.R2*TW.R1;
TW.mP2 := TW.R3;
TW.mP3 := TW.R2;
TW.matS := [TW.mP0*TW.mP1*TW.mP3*TW.mP2, TW.mP2*TW.mP1, TW.mP3*TW.mP2];
## E_i -> R_i is an isomorphism of the abstract Coxeter group [3,3,5] onto
## the geometric symmetry group of the 600-cell, carrying the abstract
## (S1,S2,S3) to the matrices (S1,S2,S3) of geometric.g.
TW.geo := GroupHomomorphismByImages(TW.W, TW.Gmat, TW.Egens, TW.Rgens);
TW.geo_ok := TW.geo <> fail and IsBijective(TW.geo)
             and List(TW.gens, g -> Image(TW.geo, g)) = TW.matS;
## Wythoff data of geometric.g: base vertex w0 fixed by P1,P2,P3 (hence by
## S2,S3), not by P0; base edge {w0, w0 S1^-1} = {w0, w0 P0}, fixed by S3 and
## swapped by S1 S2 = P0 P3; 120 vertices.
TW.v0 := [1,0,0,0];
TW.w0 := TW.v0*(TW.R0*TW.R1*TW.R2*TW.R1*TW.R2*TW.R3*TW.R2*TW.R1*TW.R3*TW.R2*TW.R3*TW.R2*TW.R1*TW.R2*TW.R3*TW.R2*TW.R1);
TW.wythoff_ok :=
     TW.w0*TW.mP1 = TW.w0 and TW.w0*TW.mP2 = TW.w0 and TW.w0*TW.mP3 = TW.w0
 and TW.w0*TW.mP0 <> TW.w0
 and TW.w0*TW.matS[2] = TW.w0 and TW.w0*TW.matS[3] = TW.w0 and TW.w0*TW.matS[1] <> TW.w0
 and TW.w0*TW.matS[1]^-1 = TW.w0*TW.mP0
 and (TW.w0*TW.mP0)*TW.matS[3] = TW.w0*TW.mP0
 and TW.w0*(TW.matS[1]*TW.matS[2]) = TW.w0*TW.mP0
 and Length(Orbit(Group(TW.matS), TW.w0, OnPoints)) = 120;

#############################################################################
##  3. The computation
#############################################################################
TW.res := CG.ComputeChiralityGroup(TW.G, TW.gens, ["S1","S2","S3"]);
TW.res.W_order := Size(TW.W);
TW.res.H_is_W := ( TW.H = TW.W );
TW.res.P_orders := TW.P_orders;
TW.res.P_products := TW.P_products;
TW.res.G_is_Wplus := ( TW.G = TW.Wplus );
TW.res.geo_ok := TW.geo_ok;
TW.res.wythoff_ok := TW.wythoff_ok;
TW.res.flag := CG.GeometricFlagData(TW.matS, TW.w0);
TW.res.S1S2_is_P0P3 := ( TW.S1*TW.S2 = TW.P0*TW.P3 );
TW.res.S1S2S3_is_P0P2 := ( TW.S1*TW.S2*TW.S3 = TW.P0*TW.P2 );
## The two normal subgroups of order 120 of [3,3,5]^+ ~= (SL(2,5) x SL(2,5))/C2
## are the images of the two SL(2,5) factors (left and right multiplication
## by unit icosians).  Record which one X(P) is, via the centraliser of X.
TW.res.X_centraliser_order := Size(Centralizer(TW.G, TW.res.X));
TW.res.X_centraliser_is_other_normal_120 :=
    Centralizer(TW.G, TW.res.X) in TW.res.m3.all
    and Size(Centralizer(TW.G, TW.res.X)) = 120
    and Centralizer(TW.G, TW.res.X) <> TW.res.X;

## Geometric meaning of X(P): [3,3,5]^+ acts on R^4 = H (quaternions) as
## x -> a x b with a, b unit icosians; the two normal subgroups of order 120
## are the left and the right multiplications.  A rotation of R^4 is a
## Clifford translation (isoclinic rotation, all points moved by the same
## angle) iff  m + m^T  is a scalar matrix (both rotation angles coincide).
TW.IsClifford := function(m)
  local sym, d;
  # m orthogonal:  m + m^T = 2 cos(theta) I  iff both rotation angles equal theta.
  sym := m + TransposedMat(m);
  d := DiagonalOfMat(sym);
  return IsDiagonalMat(sym) and Length(Set(d)) = 1;
end;
TW.res.X_is_clifford := ForAll(TW.res.X, g -> TW.IsClifford(Image(TW.geo, g)));
TW.res.C_is_clifford := ForAll(Centralizer(TW.G, TW.res.X), g -> TW.IsClifford(Image(TW.geo, g)));
TW.res.G_not_all_clifford := not ForAll(GeneratorsOfGroup(TW.G), g -> TW.IsClifford(Image(TW.geo, g)));

## Gamma ~= (SL(2,5) x SL(2,5)) / <(-1,-1)>  (explicit isomorphism).
TW.SL := CG.StandardGroup("SL(2,5)");
TW.D2 := DirectProduct(TW.SL, TW.SL);
TW.z  := First(Elements(Centre(TW.SL)), x -> Order(x) = 2);
TW.Zdiag := Subgroup(TW.D2, [Image(Embedding(TW.D2,1), TW.z) * Image(Embedding(TW.D2,2), TW.z)]);
TW.CentralProduct := TW.D2 / TW.Zdiag;
TW.res.G_is_central_product := ( Size(TW.CentralProduct) = 7200
                                 and IsomorphismGroups(TW.G, TW.CentralProduct) <> fail );

#############################################################################
##  4. Report
#############################################################################
if CG_PRINT_REPORT then
  Print("\n|[3,3,5]| = ", TW.res.W_order, "\n");
  Print("orders of P0,P1,P2,P3 = ", TW.res.P_orders,
        ";  orders of P0P1,P1P2,P2P3,P0P2,P0P3,P1P3 = ", TW.res.P_products, "\n");
  Print("<P0,P1,P2,P3> = [3,3,5] (the star polytope {5/2,3,5} has the same group): ", TW.res.H_is_W, "\n");
  Print("Gamma = <S1,S2,S3> equals the rotation subgroup [3,3,5]^+: ", TW.res.G_is_Wplus, "\n");
  Print("E_i -> R_i is an isomorphism [3,3,5] -> <R0,R1,R2,R3> carrying (S1,S2,S3) to geometric.g's matrices: ",
        TW.res.geo_ok, "\n");
  Print("Wythoff base-flag data of geometric.g consistent (w0 fixed by P1,P2,P3,S2,S3; e={w0,w0 S1^-1}={w0,w0 P0}; 120 vertices): ",
        TW.res.wythoff_ok, "\n");
  Print("S1 S2 = P0 P3: ", TW.res.S1S2_is_P0P3, ";  S1 S2 S3 = P0 P2: ", TW.res.S1S2S3_is_P0P2, "\n");
  Print("geometric f-vector (orbits of w0, e, f, c under the matrix group) = ", TW.res.flag.fvector,
        ";  edges per 2-face = ", TW.res.flag.face_sizes[1], ", 2-faces per cell = ", TW.res.flag.face_sizes[2], "\n");
  Print("orientation checks F_i.S_i = F'_i for i=1,2,3: ", [TW.res.flag.orient1, TW.res.flag.orient2, TW.res.flag.orient3],
        ";  (-S1,S2,S3) violates the orientation of S1: ", TW.res.flag.minusS1_fails,
        ";  face stabilisers <S2,S3>, <S3,S1S2>, <S1,S2S3>, <S1,S2>: ", TW.res.flag.stabilisers_ok, "\n");
  CG.PrintReport(TW.res, "{12/(1,5),3,5}  (Gamma = [3,3,5]^+, |Gamma| = 7200)");
  Print("\n--- Identification by explicit isomorphisms ---\n");
  Print("X(P) ~= SL(2,5): ",      CG.IsIsomorphicToStandard(TW.res.X, "SL(2,5)"), "\n");
  Print("X(P) ~= A5: ",           CG.IsIsomorphicToStandard(TW.res.X, "A5"), "\n");
  Print("X(P) ~= S5: ",           CG.IsIsomorphicToStandard(TW.res.X, "S5"), "\n");
  Print("X(P) ~= C2: ",           CG.IsIsomorphicToStandard(TW.res.X, "C2"), "\n");
  Print("Gamma/X(P) ~= A5: ",     CG.IsIsomorphicToStandard(TW.res.quotient, "A5"), "\n");
  Print("Gamma/X(P) ~= SL(2,5): ",CG.IsIsomorphicToStandard(TW.res.quotient, "SL(2,5)"), "\n");
  Print("Gamma/X(P) ~= A5 x A5: ",CG.IsIsomorphicToStandard(TW.res.quotient, "A5xA5"), "\n");
  Print("X(P) perfect: ", IsPerfectGroup(TW.res.X), ";  |Z(X(P))| = ", Size(Centre(TW.res.X)),
        ";  X(P)/Z(X(P)) ~= A5: ", IsomorphismGroups(TW.res.X/Centre(TW.res.X), AlternatingGroup(5)) <> fail,
        ";  number of involutions in X(P) = ", Number(TW.res.X, x -> Order(x) = 2), "\n");
  Print("Gamma/X(P) simple: ", IsSimpleGroup(TW.res.quotient), "\n");
  Print("Gamma ~= (SL(2,5) x SL(2,5)) / <(-1,-1)> (explicit IsomorphismGroups): ", TW.res.G_is_central_product, "\n");
  Print("Gamma perfect: ", IsPerfectGroup(TW.G), ";  |Z(Gamma)| = ", Size(Centre(TW.G)),
        ";  X(P) contains Z(Gamma): ", IsSubgroup(TW.res.X, Centre(TW.G)), "\n");
  Print("|C_Gamma(X(P))| = ", TW.res.X_centraliser_order,
        ";  C_Gamma(X(P)) is the other normal subgroup of order 120: ",
        TW.res.X_centraliser_is_other_normal_120, "\n");
  Print("Gamma = X(P) * C_Gamma(X(P)) with intersection of order ",
        Size(Intersection(TW.res.X, Centralizer(TW.G, TW.res.X))), ": ",
        ClosureGroup(TW.res.X, Centralizer(TW.G, TW.res.X)) = TW.G, "\n");
  Print("every element of X(P) acts on R^4 as a Clifford translation (isoclinic rotation): ",
        TW.res.X_is_clifford, ";  same for C_Gamma(X(P)): ", TW.res.C_is_clifford,
        ";  not all of Gamma: ", TW.res.G_not_all_clifford, "\n");
  CG.PrintWords(TW.res, CG.SmallGens(TW.res.X), "generators of X(P) as words in S1,S2,S3:");
  CG.PrintWords(TW.res, [TW.res.defect_A], "defect element A as a word:");
  Print("\nDone: {12/(1,5),3,5}.\n");
fi;
