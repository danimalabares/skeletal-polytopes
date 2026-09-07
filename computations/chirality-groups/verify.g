#############################################################################
##
##  verify.g  --  assertions for the two chirality-group computations.
##
##  Every claimed order, equality, quotient property and isomorphism stated
##  in README.md is re-derived from scratch here and checked.  A failed check
##  is reported as "FAIL" and the script exits with status 1 (QuitGap); a
##  runtime error exits non-zero under --quitonbreak.  A GAP *syntax* error
##  only truncates the file and exits 0, which is why run.sh additionally
##  scans the transcripts for "Syntax error" and for the final sentinels.
##
##  Run from computations/chirality-groups:   gap -q -A --quitonbreak verify.g
##
#############################################################################

CG_PRINT_REPORT := false;
Read("common/chirality-group.g");
Read("rolis-cube/compute.g");
Read("12-over-1-5-3-5/compute.g");

VERIFY := rec(npass := 0, nfail := 0, failed := []);
CHECK := function(name, value)
  if value = true then
    VERIFY.npass := VERIFY.npass + 1;
    Print("PASS  ", name, "\n");
  else
    VERIFY.nfail := VERIFY.nfail + 1;
    Add(VERIFY.failed, name);
    Print("FAIL  ", name, "   (got ", value, ")\n");
  fi;
end;

CHECKEQ := function(name, actual, expected)
  if actual = expected then
    VERIFY.npass := VERIFY.npass + 1;
    Print("PASS  ", name, " = ", expected, "\n");
  else
    VERIFY.nfail := VERIFY.nfail + 1;
    Add(VERIFY.failed, name);
    Print("FAIL  ", name, "   (expected ", expected, ", got ", actual, ")\n");
  fi;
end;

Print("GAP version: ", GAPInfo.Version, "\n\n");

#############################################################################
##  Shared sanity checks for a result record
#############################################################################
CommonChecks := function(tag, res, expected)
  local s;
  s := res.strings;
  CHECKEQ(Concatenation(tag, ": |Gamma|"), res.order, expected.order);
  CHECKEQ(Concatenation(tag, ": orders of S1,S2,S3"), s.orders, expected.orders);
  CHECK(Concatenation(tag, ": (S1S2)^2 = (S2S3)^2 = (S1S2S3)^2 = 1"), s.holds);
  CHECK(Concatenation(tag, ": S3S2S1 is NOT an involution (convention check), order = ", String(expected.ord_S3S2S1)),
        s.ord_S3S2S1 = expected.ord_S3S2S1 and expected.ord_S3S2S1 <> 2);
  CHECK(Concatenation(tag, ": rank-4 intersection property"), res.intersection_property);
  CHECKEQ(Concatenation(tag, ": abstract f-vector"), res.fvector, expected.fvector);
  CHECK(Concatenation(tag, ": mirror assignment does NOT extend to an automorphism of Gamma"),
        res.mirror_automorphism = fail);
  CHECKEQ(Concatenation(tag, ": ord(S1^-1 S3)"), s.ord_S1invS3, expected.ord_S1invS3);
  CHECKEQ(Concatenation(tag, ": ord(S1 S3)"), s.ord_S1S3, expected.ord_S1S3);
  CHECK(Concatenation(tag, ": presentation on (S1,S2,S3) certified (relators hold, coset enumeration gives |Gamma|)"),
        res.pres.certified);
  CHECK(Concatenation(tag, ": fp generators correspond to S1,S2,S3"),
        List(res.gens, x -> Image(res.pres.iso, x)) = GeneratorsOfGroup(Range(res.pres.iso)));
  CHECK(Concatenation(tag, ": W^+ relators are the first three relators"),
        res.pres.relators{[1..3]} = CG.WPlusRelators(res.pres.fgens));
  CHECK(Concatenation(tag, ": mirror substitution is involutory on words"),
        ForAll(res.pres.relators, r ->
          MappedWord(MappedWord(r, res.pres.fgens, CG.MirrorImages(res.pres.fgens)),
                     res.pres.fgens, CG.MirrorImages(res.pres.fgens)) = r));
  CHECK(Concatenation(tag, ": mirrored W^+ relators evaluate to 1 in Gamma (triviality in W^+ itself is a theorem)"),
        ForAll(res.m1.images{[1..3]}, IsOne));
  CHECKEQ(Concatenation(tag, ": Method 1: |X_1|"), Size(res.m1.X), expected.Xorder);
  CHECKEQ(Concatenation(tag, ": Method 2: |Mix| (= |Gamma|*|X|)"), Size(res.m2.Mix), expected.order*expected.Xorder);
  CHECK(Concatenation(tag, ": Method 2: both projections of Mix are surjective"),
        res.m2.proj1_surjective and res.m2.proj2_surjective);
  CHECK(Concatenation(tag, ": Method 2: X_2 (ker of projection onto mirror factor) = X_1 as subgroups"), res.agree_12);
  CHECK(Concatenation(tag, ": Method 2: X_2-bar (ker of projection onto first factor) = X_1 as subgroups"), res.agree_2bar);
  CHECK(Concatenation(tag, ": Method 2: kernel via explicit homomorphism agrees"), res.agree_2hom);
  CHECK(Concatenation(tag, ": Method 3: smallest N with mirror-invariant Gamma/N equals X_1"), res.agree_13);
  CHECK(Concatenation(tag, ": Method 3: every mirror-invariant N contains X"), res.invariant_all_contain_X);
  CHECK(Concatenation(tag, ": Method 3: mirror-invariant N are closed under intersection"),
        res.invariant_closed_under_intersection);
  CHECKEQ(Concatenation(tag, ": normal subgroup orders of Gamma (sorted)"), SortedList(List(res.m3.all, Size)), expected.normal_orders);
  CHECKEQ(Concatenation(tag, ": orders of mirror-invariant N (sorted)"), SortedList(List(res.m3.invariant, Size)), expected.invariant_orders);
  CHECK(Concatenation(tag, ": X(P) is normal in Gamma"), res.X_normal);
  CHECKEQ(Concatenation(tag, ": [Gamma : X(P)]"), res.index, expected.index);
  CHECKEQ(Concatenation(tag, ": IdGroup(X(P))"), res.X_desc.idgroup, expected.X_id);
  CHECKEQ(Concatenation(tag, ": IdGroup(Gamma/X(P))"), res.quotient_desc.idgroup, expected.Q_id);
  CHECK(Concatenation(tag, ": X(P) ~= ", expected.X_name, " (explicit IsomorphismGroups)"),
        CG.IsIsomorphicToStandard(res.X, expected.X_name));
  CHECK(Concatenation(tag, ": Gamma/X(P) admits the mirror automorphism"), res.quotient_mirror <> fail);
  CHECKEQ(Concatenation(tag, ": Gamma/X(P) generator orders"), res.quotient_gens_orders, expected.quotient_orders);
  CHECK(Concatenation(tag, ": Gamma/X(P) generators satisfy the string relations"), res.quotient_strings_hold);
  CHECKEQ(Concatenation(tag, ": Gamma/X(P) coset f-vector"), res.quotient_fvector, expected.quotient_fvector);
  CHECKEQ(Concatenation(tag, ": Gamma/X(P) has the intersection property"), res.quotient_ip, expected.quotient_ip);
  CHECKEQ(Concatenation(tag, ": Mix generator orders"), res.mix_gens_orders, expected.orders);
  CHECK(Concatenation(tag, ": Mix generators satisfy the string relations"), res.mix_strings_hold);
  CHECK(Concatenation(tag, ": Mix admits the mirror automorphism (directly regular)"), res.mix_mirror <> fail);
  CHECK(Concatenation(tag, ": Mix has the intersection property (P_W is a polytope)"), res.mix_ip);
  CHECKEQ(Concatenation(tag, ": Mix coset f-vector"), res.mix_fvector, expected.mix_fvector);
  CHECK(Concatenation(tag, ": combinatorially chiral (X nontrivial)"), not res.directly_regular);
  CHECK(Concatenation(tag, ": NOT totally chiral (X <> Gamma)"), not res.totally_chiral);
  CHECK(Concatenation(tag, ": defect A = (S1 S3)^ord(S1^-1 S3) has order ", String(expected.defectA_order)),
        Order(res.defect_A) = expected.defectA_order);
  CHECK(Concatenation(tag, ": normal closure of defect A equals X(P)"), res.defect_A_generates_X);
  CHECK(Concatenation(tag, ": defect B = (S1^-1 S3)^ord(S1 S3) is trivial"), IsOne(res.defect_B));
  CHECK(Concatenation(tag, ": Z(Gamma) has order 2 and lies in X(P)"),
        Size(Centre(res.G)) = 2 and IsSubgroup(res.X, Centre(res.G)));
  CHECK(Concatenation(tag, ": all mirrored relators evaluate into X(P)"),
        ForAll(res.m1.images, x -> x in res.X));
end;

#############################################################################
##  Roli's cube
#############################################################################
Print("\n=== Roli's cube ===\n");
CHECK("Roli: |[4,3,3]| = 384", ROLI.res.W_order = 384);
CHECK("Roli: Gamma = [4,3,3]^+", ROLI.res.G_is_Wplus);
CHECK("Roli: E_i -> R_i isomorphism onto cube.g matrices, carrying (S1,S2,S3)", ROLI.res.geo_ok);
CHECK("Roli: Wythoff base-flag data of cube.g", ROLI.res.wythoff_ok);
CHECKEQ("Roli: geometric f-vector (matrix-group orbits) equals the coset f-vector", ROLI.res.flag.fvector, [16,32,12,4]);
CHECKEQ("Roli: edges per 2-face and 2-faces per cell", ROLI.res.flag.face_sizes, [8,6]);
CHECK("Roli: orientation e.S1 = F'_1 (other edge of f at v), with diamond condition", ROLI.res.flag.orient1);
CHECK("Roli: orientation f.S2 = F'_2 (other 2-face of c at e), with diamond condition", ROLI.res.flag.orient2);
CHECK("Roli: orientation c.S3 = F'_3 (other cell at f), with diamond condition", ROLI.res.flag.orient3);
CHECK("Roli: (-S1,S2,S3) violates the orientation of S1", ROLI.res.flag.minusS1_fails);
CHECK("Roli: geometric face stabilisers are <S2,S3>, <S3,S1S2>, <S1,S2S3>, <S1,S2>", ROLI.res.flag.stabilisers_ok);
CHECK("Roli: S1 S2 = E0 E3 and S1 S2 S3 = E0 E2", ROLI.res.S1S2_is_E0E3 and ROLI.res.S1S2S3_is_E0E2);
CommonChecks("Roli", ROLI.res, rec(
  order := 192, orders := [8,3,3], ord_S3S2S1 := 4, fvector := [16,32,12,4],
  ord_S1invS3 := 4, ord_S1S3 := 8, Xorder := 2, index := 96,
  normal_orders := [1,2,8,8,8,32,96,192], invariant_orders := [2,8,32,96,192],
  X_id := [2,1], Q_id := [96,227], X_name := "C2", quotient_orders := [4,3,3],
  quotient_fvector := [8,16,12,4], quotient_ip := true, mix_fvector := [32,64,24,8],
  defectA_order := 2));
CHECK("Roli: X(P) = Z(Gamma)", ROLI.res.X = Centre(ROLI.G));
CHECK("Roli: X(P) = <S1^4>", ROLI.res.X = Subgroup(ROLI.G, [ROLI.S1^4]));
CHECK("Roli: S1^4 is the central inversion -I of R^4",
      Image(ROLI.geo, ROLI.S1^4) = -IdentityMat(4));
CHECKEQ("Roli: IdGroup(Gamma)", ROLI.res.G_desc.idgroup, [192,1494]);
CHECK("Roli: Z([4,3,3]) = {+-I} has order 2", ROLI.res.Zw_is_central_inversion);
CHECKEQ("Roli: |[4,3,3]/{+-I}| and |rotation subgroup of [4,3,3]/{+-I}|", ROLI.res.hemi_orders, [192, 96]);
CHECK("Roli: S_i -> S_i{+-I} embeds Gamma/X(P) onto the rotation subgroup of [4,3,3]/{+-I} (hemi-4-cube)",
      ROLI.res.quotient_is_hemi_rotation_group);
CHECK("Roli: normal subgroups containing X with NON-mirror-invariant quotient have orders [8,8]",
      List(ROLI.res.contains_X_but_not_invariant, Size) = [8,8]);
CHECK("Roli: Gamma is not isomorphic to (Gamma/X) x X",
      IsomorphismGroups(ROLI.G, DirectProduct(ROLI.res.quotient, ROLI.res.X)) = fail);

#############################################################################
##  {12/(1,5),3,5}
#############################################################################
Print("\n=== {12/(1,5),3,5} ===\n");
CHECK("12: |[3,3,5]| = 14400", TW.res.W_order = 14400);
CHECK("12: <P0,P1,P2,P3> = [3,3,5]", TW.res.H_is_W);
CHECK("12: P_i involutions with (P0P1,P1P2,P2P3,P0P2,P0P3,P1P3) of orders (5,3,5,2,2,2)",
      TW.res.P_orders = [2,2,2,2] and TW.res.P_products = [5,3,5,2,2,2]);
CHECK("12: Gamma = [3,3,5]^+", TW.res.G_is_Wplus);
CHECK("12: E_i -> R_i isomorphism onto geometric.g matrices, carrying (S1,S2,S3)", TW.res.geo_ok);
CHECK("12: Wythoff base-flag data of geometric.g", TW.res.wythoff_ok);
CHECKEQ("12: geometric f-vector (matrix-group orbits) equals the coset f-vector", TW.res.flag.fvector, [120,720,300,50]);
CHECKEQ("12: edges per 2-face and 2-faces per cell", TW.res.flag.face_sizes, [12,12]);
CHECK("12: orientation e.S1 = F'_1 (other edge of f at w0), with diamond condition", TW.res.flag.orient1);
CHECK("12: orientation f.S2 = F'_2 (other 2-face of c at e), with diamond condition", TW.res.flag.orient2);
CHECK("12: orientation c.S3 = F'_3 (other cell at f), with diamond condition", TW.res.flag.orient3);
CHECK("12: (-S1,S2,S3) violates the orientation of S1", TW.res.flag.minusS1_fails);
CHECK("12: geometric face stabilisers are <S2,S3>, <S3,S1S2>, <S1,S2S3>, <S1,S2>", TW.res.flag.stabilisers_ok);
CHECK("12: S1 S2 = P0 P3 and S1 S2 S3 = P0 P2", TW.res.S1S2_is_P0P3 and TW.res.S1S2S3_is_P0P2);
CommonChecks("12", TW.res, rec(
  order := 7200, orders := [12,3,5], ord_S3S2S1 := 5, fvector := [120,720,300,50],
  ord_S1invS3 := 5, ord_S1S3 := 15, Xorder := 120, index := 60,
  normal_orders := [1,2,120,120,7200], invariant_orders := [120,7200],
  X_id := [120,5], Q_id := [60,5], X_name := "SL(2,5)", quotient_orders := [2,3,5],
  quotient_fvector := [1,6,15,10], quotient_ip := false, mix_fvector := [14400,86400,36000,6000],
  defectA_order := 3));
CHECK("12: Gamma/X(P) ~= A5 (explicit IsomorphismGroups)", CG.IsIsomorphicToStandard(TW.res.quotient, "A5"));
CHECK("12: Gamma/X(P) is simple", IsSimpleGroup(TW.res.quotient));
CHECK("12: X(P) is perfect with centre of order 2 and X/Z(X) ~= A5",
      IsPerfectGroup(TW.res.X) and Size(Centre(TW.res.X)) = 2
      and IsomorphismGroups(TW.res.X/Centre(TW.res.X), AlternatingGroup(5)) <> fail);
CHECK("12: X(P) has a unique involution", Number(TW.res.X, x -> Order(x) = 2) = 1);
CHECK("12: C_Gamma(X(P)) is the other normal subgroup of order 120", TW.res.X_centraliser_is_other_normal_120);
CHECK("12: Gamma = X(P) C_Gamma(X(P)) with X cap C = Z(Gamma)",
      ClosureGroup(TW.res.X, Centralizer(TW.G, TW.res.X)) = TW.G
      and Intersection(TW.res.X, Centralizer(TW.G, TW.res.X)) = Centre(TW.G));
CHECK("12: Gamma is perfect", IsPerfectGroup(TW.G));
CHECK("12: every element of X(P) acts on R^4 as a Clifford translation (isoclinic rotation)",
      TW.res.X_is_clifford);
CHECK("12: every element of C_Gamma(X(P)) acts on R^4 as a Clifford translation too",
      TW.res.C_is_clifford);
CHECK("12: the centre of X(P) acts on R^4 as {+-I}",
      Image(TW.geo, Centre(TW.res.X)) = Group(-IdentityMat(4)));
CHECK("12: Gamma contains rotations that are not Clifford translations", TW.res.G_not_all_clifford);
CHECK("12: Gamma ~= (SL(2,5) x SL(2,5)) / <(-1,-1)> (explicit IsomorphismGroups)", TW.res.G_is_central_product);
CHECK("12: |Gamma| = 7200 has no IdGroup; StructureDescription is report-only", TW.res.G_desc.idgroup = fail);

#############################################################################
##  Summary
#############################################################################
Print("\n==========================================================\n");
Print("VERIFICATION SUMMARY: ", VERIFY.npass, " passed, ", VERIFY.nfail, " failed\n");
if VERIFY.nfail > 0 then
  Print("FAILED CHECKS:\n");
  Print(VERIFY.failed, "\n");
  Print("==========================================================\n");
  if IsBoundGlobal("QuitGap") then
    QuitGap(1);
  else
    Error("VERIFICATION FAILED");
  fi;
else
  Print("ALL CHECKS PASSED\n");
  Print("==========================================================\n");
fi;
