#############################################################################
##
##  rolis-cube/compute.g
##
##  Chirality group of Roli's cube (Bracho, Hubard & Pellicer 2014), the
##  geometrically chiral skeletal 4-polytope of type {8,3,3} in R^4.
##
##  The group and the distinguished triple are transcribed VERBATIM from the
##  legacy scripts  cube.g  (matrix version)  and  combinatorially-chiral-cube.g
##  (Coxeter-group version); see legacy/PROVENANCE.md.
##
##  Run from computations/chirality-groups:   gap -q -A --quitonbreak rolis-cube/compute.g
##
#############################################################################

if not IsBound(CG) then Read("common/chirality-group.g"); fi;
if not IsBound(CG_PRINT_REPORT) then CG_PRINT_REPORT := true; fi;

if CG_PRINT_REPORT then
  Print("##########################################################\n");
  Print("# Roli's cube: chirality group computation\n");
  Print("##########################################################\n");
  CG.PrintEnvironment();
fi;

#############################################################################
##  1. The Coxeter group [4,3,3] exactly as in combinatorially-chiral-cube.g
#############################################################################
##  legacy (combinatorially-chiral-cube.g, lines 3-6):
##    f:=FreeGroup("E0","E1","E2","E3");
##    g:=f/[f.1^2,f.2^2,f.3^2,f.4^2,
##    (f.1*f.2)^4,(f.2*f.3)^3,(f.3*f.4)^3,
##    (f.1*f.3)^2,(f.1*f.4)^2,(f.2*f.4)^2];
ROLI := rec();
ROLI.f := FreeGroup("E0","E1","E2","E3");
ROLI.fpW := ROLI.f/[ROLI.f.1^2,ROLI.f.2^2,ROLI.f.3^2,ROLI.f.4^2,
  (ROLI.f.1*ROLI.f.2)^4,(ROLI.f.2*ROLI.f.3)^3,(ROLI.f.3*ROLI.f.4)^3,
  (ROLI.f.1*ROLI.f.3)^2,(ROLI.f.1*ROLI.f.4)^2,(ROLI.f.2*ROLI.f.4)^2];

## A faithful permutation representation of the finite Coxeter group.
ROLI.iso := IsomorphismPermGroup(ROLI.fpW);
ROLI.W   := Image(ROLI.iso);
ROLI.Egens := List(GeneratorsOfGroup(ROLI.fpW), x -> Image(ROLI.iso, x));
ROLI.E0 := ROLI.Egens[1]; ROLI.E1 := ROLI.Egens[2];
ROLI.E2 := ROLI.Egens[3]; ROLI.E3 := ROLI.Egens[4];

##  legacy (combinatorially-chiral-cube.g, lines 17-19):
##    S1:=E0*E1*E3*E2;
##    S2:=E2*E1;
##    S3:=E3*E2;
ROLI.S1 := ROLI.E0*ROLI.E1*ROLI.E3*ROLI.E2;
ROLI.S2 := ROLI.E2*ROLI.E1;
ROLI.S3 := ROLI.E3*ROLI.E2;
ROLI.gens := [ROLI.S1, ROLI.S2, ROLI.S3];
ROLI.G := Subgroup(ROLI.W, ROLI.gens);

## The rotation subgroup of the Coxeter group (products of two reflections).
ROLI.Wplus := Subgroup(ROLI.W, [ROLI.E0*ROLI.E1, ROLI.E1*ROLI.E2, ROLI.E2*ROLI.E3]);

#############################################################################
##  2. Geometric cross-check with the matrices of cube.g
#############################################################################
##  legacy (cube.g, lines 3-21): the four reflections of the 4-cube.
ROLI.R0 := [ [ -1, 0, 0, 0 ], [ 0, 1, 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ] ];
ROLI.R1 := [ [ 0, 1, 0, 0 ], [ 1, 0, 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ] ];
ROLI.R2 := [ [ 1, 0, 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 1, 0, 0 ], [ 0, 0, 0, 1 ] ];
ROLI.R3 := [ [ 1, 0, 0, 0 ], [ 0, 1, 0, 0 ], [ 0, 0, 0, 1 ], [ 0, 0, 1, 0 ] ];
ROLI.Rgens := [ROLI.R0, ROLI.R1, ROLI.R2, ROLI.R3];
ROLI.Gmat := Group(ROLI.Rgens);
##  legacy (cube.g, lines 25-27):  S1:=R0*R1*R3*R2; S2:=R2*R1; S3:=R3*R2;
ROLI.matS := [ROLI.R0*ROLI.R1*ROLI.R3*ROLI.R2, ROLI.R2*ROLI.R1, ROLI.R3*ROLI.R2];
ROLI.Qmat := Subgroup(ROLI.Gmat, ROLI.matS);
## E_i -> R_i is an isomorphism of the abstract Coxeter group onto the
## geometric symmetry group of the 4-cube, carrying (S1,S2,S3) to the
## matrices (S1,S2,S3) of cube.g.
ROLI.geo := GroupHomomorphismByImages(ROLI.W, ROLI.Gmat, ROLI.Egens, ROLI.Rgens);
ROLI.geo_ok := ROLI.geo <> fail and IsBijective(ROLI.geo)
               and List(ROLI.gens, g -> Image(ROLI.geo, g)) = ROLI.matS;
## Wythoff data of cube.g: base vertex v = (1,1,1,1) is fixed by S2, S3, not S1;
## the base edge {v, v S1^-1} is the cube edge {v, v R0}, fixed by S3 and
## swapped by S1 S2.
ROLI.v := [1,1,1,1];
ROLI.wythoff_ok :=
     ROLI.v*ROLI.matS[2] = ROLI.v and ROLI.v*ROLI.matS[3] = ROLI.v
 and ROLI.v*ROLI.matS[1] <> ROLI.v
 and ROLI.v*ROLI.matS[1]^-1 = ROLI.v*ROLI.R0
 and (ROLI.v*ROLI.R0)*ROLI.matS[3] = ROLI.v*ROLI.R0
 and ROLI.v*(ROLI.matS[1]*ROLI.matS[2]) = ROLI.v*ROLI.R0
 and Length(Orbit(ROLI.Qmat, ROLI.v, OnPoints)) = 16;

#############################################################################
##  3. The computation
#############################################################################
ROLI.res := CG.ComputeChiralityGroup(ROLI.G, ROLI.gens, ["S1","S2","S3"]);
ROLI.res.W_order := Size(ROLI.W);
ROLI.res.G_is_Wplus := ( ROLI.G = ROLI.Wplus );
ROLI.res.geo_ok := ROLI.geo_ok;
ROLI.res.wythoff_ok := ROLI.wythoff_ok;
ROLI.res.flag := CG.GeometricFlagData(ROLI.matS, ROLI.v);
ROLI.res.S1S2_is_E0E3 := ( ROLI.S1*ROLI.S2 = ROLI.E0*ROLI.E3 );

## Independent construction of the hemi-4-cube's groups: [4,3,3]/{+-I} is the
## automorphism group of {4,3,3}/2 (order 192) and the images of the Coxeter
## rotations E0E1, E1E2, E2E3 generate its rotation subgroup (order 96).
ROLI.Zw := Centre(ROLI.W);
ROLI.natW := NaturalHomomorphismByNormalSubgroup(ROLI.W, ROLI.Zw);
ROLI.HZ := Image(ROLI.natW);
ROLI.HZrot := Subgroup(ROLI.HZ, List([ROLI.E0*ROLI.E1, ROLI.E1*ROLI.E2, ROLI.E2*ROLI.E3],
                                     x -> Image(ROLI.natW, x)));
ROLI.res.Zw_is_central_inversion := ( Size(ROLI.Zw) = 2
                                      and Image(ROLI.geo, ROLI.Zw) = Group(-IdentityMat(4)) );
ROLI.res.hemi_orders := [ Size(ROLI.HZ), Size(ROLI.HZrot) ];
ROLI.hemihom := GroupHomomorphismByImages(ROLI.res.quotient, ROLI.HZ, ROLI.res.quotient_gens,
                                          List(ROLI.gens, x -> Image(ROLI.natW, x)));
ROLI.res.quotient_is_hemi_rotation_group := ( ROLI.hemihom <> fail and IsInjective(ROLI.hemihom)
                                              and Image(ROLI.hemihom) = ROLI.HZrot );
ROLI.res.S1S2S3_is_E0E2 := ( ROLI.S1*ROLI.S2*ROLI.S3 = ROLI.E0*ROLI.E2 );

#############################################################################
##  4. Report
#############################################################################
if CG_PRINT_REPORT then
  Print("\n|[4,3,3]| = ", ROLI.res.W_order, "\n");
  Print("Gamma = <S1,S2,S3> equals the rotation subgroup [4,3,3]^+: ", ROLI.res.G_is_Wplus, "\n");
  Print("E_i -> R_i is an isomorphism [4,3,3] -> <R0,R1,R2,R3> carrying (S1,S2,S3) to cube.g's matrices: ",
        ROLI.res.geo_ok, "\n");
  Print("Wythoff base-flag data of cube.g consistent (v fixed by S2,S3; e={v,vS1^-1}={v,vR0}; 16 vertices): ",
        ROLI.res.wythoff_ok, "\n");
  Print("S1 S2 = E0 E3: ", ROLI.res.S1S2_is_E0E3, ";  S1 S2 S3 = E0 E2: ", ROLI.res.S1S2S3_is_E0E2, "\n");
  Print("geometric f-vector (orbits of v, e, f, c under the matrix group) = ", ROLI.res.flag.fvector,
        ";  edges per 2-face = ", ROLI.res.flag.face_sizes[1], ", 2-faces per cell = ", ROLI.res.flag.face_sizes[2], "\n");
  Print("orientation checks F_i.S_i = F'_i for i=1,2,3: ", [ROLI.res.flag.orient1, ROLI.res.flag.orient2, ROLI.res.flag.orient3],
        ";  (-S1,S2,S3) violates the orientation of S1: ", ROLI.res.flag.minusS1_fails,
        ";  face stabilisers <S2,S3>, <S3,S1S2>, <S1,S2S3>, <S1,S2>: ", ROLI.res.flag.stabilisers_ok, "\n");
  CG.PrintReport(ROLI.res, "Roli's cube  {8,3,3}  (Gamma = [4,3,3]^+, |Gamma| = 192)");
  Print("\n--- Identification by explicit isomorphisms ---\n");
  Print("X(P) ~= Q8: ",        CG.IsIsomorphicToStandard(ROLI.res.X, "Q8"), "\n");
  Print("X(P) ~= C2^3: ",      CG.IsIsomorphicToStandard(ROLI.res.X, "C2^3"), "\n");
  Print("X(P) ~= C2 x C4: ",   CG.IsIsomorphicToStandard(ROLI.res.X, "C2xC4"), "\n");
  Print("X(P) ~= C8: ",        CG.IsIsomorphicToStandard(ROLI.res.X, "C8"), "\n");
  Print("X(P) ~= C2: ",        CG.IsIsomorphicToStandard(ROLI.res.X, "C2"), "\n");
  Print("Z([4,3,3]) = {+-I} of order 2: ", ROLI.res.Zw_is_central_inversion,
        ";  |[4,3,3]/{+-I}| = ", ROLI.res.hemi_orders[1],
        ", its rotation subgroup <E0E1,E1E2,E2E3>/{+-I} has order ", ROLI.res.hemi_orders[2], "\n");
  Print("S_i -> S_i{+-I} embeds Gamma/X(P) onto the rotation subgroup of [4,3,3]/{+-I} (hemi-4-cube): ",
        ROLI.res.quotient_is_hemi_rotation_group, "\n");
  Print("Gamma/X(P) ~= S4: ",  CG.IsIsomorphicToStandard(ROLI.res.quotient, "S4"), "\n");
  Print("Gamma/X(P) ~= SL(2,3): ", CG.IsIsomorphicToStandard(ROLI.res.quotient, "SL(2,3)"), "\n");
  Print("Gamma/X(P) ~= GL(2,3): ", CG.IsIsomorphicToStandard(ROLI.res.quotient, "GL(2,3)"), "\n");
  Print("Gamma ~= Gamma/X x X ? (IsomorphismGroups): ",
        IsomorphismGroups(ROLI.G, DirectProduct(ROLI.res.quotient, ROLI.res.X)) <> fail, "\n");
  Print("X(P) abelian: ", IsAbelian(ROLI.res.X), ";  X(P) is a 2-group: ",
        IsPrimePowerInt(Size(ROLI.res.X)) and Size(ROLI.res.X) mod 2 = 0,
        ";  exponent(X(P)) = ", Exponent(ROLI.res.X),
        ";  |Z(X(P))| = ", Size(Centre(ROLI.res.X)),
        ";  number of involutions in X(P) = ", Number(ROLI.res.X, x -> Order(x) = 2), "\n");
  Print("X(P) contains the centre of Gamma (|Z(Gamma)| = ", Size(Centre(ROLI.G)), "): ",
        IsSubgroup(ROLI.res.X, Centre(ROLI.G)), "\n");
  Print("X(P) = O_2(Gamma)? ", ROLI.res.X = PCore(ROLI.G, 2), ";  X(P) = Fitting(Gamma)? ",
        ROLI.res.X = FittingSubgroup(ROLI.G), ";  X(P) = derived subgroup? ",
        ROLI.res.X = DerivedSubgroup(ROLI.G), "\n");
  CG.PrintWords(ROLI.res, CG.SmallGens(ROLI.res.X), "generators of X(P) as words in S1,S2,S3:");
  CG.PrintWords(ROLI.res, [ROLI.res.defect_A], "defect element A as a word:");
  Print("\nDone: Roli's cube.\n");
fi;
