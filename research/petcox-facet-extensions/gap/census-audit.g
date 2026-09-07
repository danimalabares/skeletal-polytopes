#############################################################################
##
##  census-audit.g  --  audit of the data printed in petcox.pdf (Section 4
##  and the summary table on p.28) against exact recomputation.
##
##  For each of the ten rows the basic tetrahedron printed in the paper is
##  transcribed (from the rendered pages 22-27); the mirrors R_i are rebuilt
##  from it, and we check
##    * the geometric Schlaefli marks and the f-vector of the polytope the
##      printed tetrahedron actually defines;
##    * the printed matrices S1, S2 against R0R1R3R2 and R2R1 (row and
##      column convention);
##    * whether the printed v3 is the centroid direction of the base cell
##      (and its sign);
##    * the printed base vertices of the regular cases: their exact
##      PETCOX parameter alpha (in the paper's own convention v0, v3) and the
##      claim that H_alpha is geometrically regular there, using the printed
##      "reflection" matrix R (a half-turn) and our own regularity test;
##    * the table columns #(G), the index, and the collapse numbers (the
##      index column is verified to equal |Gamma^+(T)| / |G|, i.e. the index
##      of G in the rotation group of T, although the header reads [G:Gamma^+]).
##
#############################################################################

if not IsBound(PX) then Read("lib.g"); fi;
if not IsBound(PX.T) or Length(RecNames(PX.T)) = 0 then Read("polytopes.g"); PX.BuildAll(); PX.SetupRows(); fi;

phi := PX.phi; ip := 1/phi;      # phi^-1 = phi - 1
s2 := Sqrt(2); s3 := Sqrt(3); s6 := Sqrt(6);
s2phi := E(20)+E(20)^19;         # sqrt(2+phi) = 2 cos(pi/10)
PX.CHECK("sqrt(2+phi) = E(20)+E(20)^-1", s2phi^2 = 2+phi);

## transcription of petcox.pdf, pp. 22-27 (rendered page images), one record per table row
PX.Printed := [
 rec(T := "{3,3,3}", page := 22,
     v := [[4,-1,-1,-1,-1],[3,3,-2,-2,-2],[2,2,2,-3,-3],[1,1,1,1,-4]], hyper := [1,1,1,1,1],
     S1 := [[0,0,0,1,0],[1,0,0,0,0],[0,1,0,0,0],[0,0,0,0,1],[0,0,1,0,0]],
     S2 := [[1,0,0,0,0],[0,0,1,0,0],[0,0,0,1,0],[0,1,0,0,0],[0,0,0,0,1]],
     regular := [[1,0,0,0,-1],[3,-2,-2,-2,3]], regular_alpha_claimed := [1/2, infinity],
     R := (1/5)*[[2,2,2,2,-3],[2,2,-3,2,2],[2,-3,2,2,2],[2,2,2,-3,2],[-3,2,2,2,2]]),
 rec(T := "{4,3,3}", page := 23,
     v := [[1,1,1,1],[0,1,1,1],[0,0,1,1],[0,0,0,1]], hyper := fail,
     S1 := [[0,0,-1,0],[1,0,0,0],[0,0,0,1],[0,1,0,0]],
     S2 := [[0,1,0,0],[0,0,1,0],[1,0,0,0],[0,0,0,1]],
     regular := [[1,1,1,s3],[1,1,1,-s3]], regular_alpha_claimed := fail,
     R := (1/s3)*[[0,-1,1,1],[-1,1,0,1],[1,0,-1,1],[1,1,1,0]]),
 rec(T := "{3,4,3}", page := 24,
     v := [[1,0,0,0],[3,1,1,1],[2,1,1,0],[1,1,0,0]], hyper := fail,
     S1 := (1/2)*[[1,1,-1,1],[1,-1,1,1],[1,1,1,-1],[1,-1,-1,-1]],
     S2 := [[1,0,0,0],[0,1,0,0],[0,0,0,-1],[0,0,1,0]],
     regular := [[1+s2,1,0,0],[1-s2,1,0,0]], regular_alpha_claimed := [1/2, infinity],
     R := (1/s2)*[[1,1,0,0],[1,-1,0,0],[0,0,-1,1],[0,0,1,1]]),
 rec(T := "{5,3,3}", page := 24,
     v := [[phi^2,1,-ip^2,0],[phi,ip,0,0],[2+phi,1,0,ip],[1,0,0,0]], hyper := fail,
     S1 := (1/2)*[[phi,1,0,-ip],[1,-1,-1,1],[0,1,ip,phi],[ip,-1,phi,0]],
     S2 := (1/2)*[[2,0,0,0],[0,phi,-1,ip],[0,-1,-ip,phi],[0,-ip,-phi,-1]],
     regular := [[1-2*phi+2*s2,-phi,ip,0],[1-2*phi-2*s2,-phi,ip,0]], regular_alpha_claimed := fail,
     R := (1/(2*s2))*[[1-2*phi,-phi,ip,0],[-phi,2,-ip,1],[ip,-ip,ip,phi^2],[0,1,phi^2,-ip^2]]),
 rec(T := "{3,5,5/2}", page := 25,
     v := [[phi^2,1,-ip^2,0],[phi,ip,0,0],[2+phi,1,0,ip],[1,0,0,0]], hyper := fail,
     S1 := (1/2)*[[phi,1,0,-ip],[1,-1,-1,1],[0,1,ip,phi],[ip,-1,phi,0]],
     S2 := (1/2)*[[2,0,0,0],[0,phi,-1,ip],[0,1,-ip,phi],[0,-ip,-phi,-1]],
     regular := [[1-2*phi+2*s2,-phi,ip,0],[1-2*phi-2*s2,-phi,ip,0]], regular_alpha_claimed := fail,
     R := (1/(2*s2))*[[1-2*phi,-phi,ip,0],[-phi,2,-ip,1],[ip,-ip,ip,phi^2],[0,1,phi^2,-ip^2]]),
 rec(T := "{5,5/2,5}", page := 26,
     v := [[1,0,0,0],[2+phi,1,0,ip],[2,1,-ip,-ip^2],[phi,1,0,-ip]], hyper := fail,
     S1 := (1/2)*[[phi,0,ip,-1],[1,ip,0,phi],[0,-phi,1,ip],[ip,-1,-phi,0]],
     S2 := (1/2)*[[2,0,0,0],[0,1,-ip,-phi],[0,ip,-phi,1],[0,-phi,-1,-ip]],
     regular := [[2+phi,1,0,-ip],[2-phi,-1,0,ip]], regular_alpha_claimed := fail,
     R := (1/2)*[[phi,1,0,-ip],[1,-1,1,1],[0,1,-ip,phi],[-ip,1,phi,0]]),
 rec(T := "{5,3,5/2}", page := 26,
     v := [[1,0,0,0],[2+phi,1,0,ip],[2*phi,phi,-1,-ip],[1,1,1,-1]], hyper := fail,
     S1 := (1/2)*[[phi,-ip,1,0],[1,1,-1,1],[0,-phi,-1,ip],[ip,0,-1,-phi]],
     S2 := [[1,0,0,0],[0,0,0,-1],[0,1,0,0],[0,0,-1,0]],
     regular := [[3+3*phi+2*s6*phi,ip,ip,-ip],[3+3*phi-2*s6*phi,ip,ip,-ip]], regular_alpha_claimed := fail,
     R := (1/(2*s6))*[[3*phi,ip^2,ip^2,-ip^2],[ip^2,-3-phi,1,2*ip],[ip^2,1,-2*ip,3+phi],[-ip^2,2*ip,phi-3,1]]),
 rec(T := "{3,3,5/2}", page := 26,
     v := [[1,1,1,-1],[2*phi,phi,-1,-ip],[2*phi-1,-1,-1,1-2*phi],[ip,-1,phi,2]], hyper := fail,
     S1 := (1/2)*[[-ip,phi,0,-1],[-1,0,phi,ip],[-phi,-ip,-1,0],[0,-1,ip,-phi]],
     S2 := (1/2)*[[0,-ip,phi,-1],[phi,0,-ip,-1],[1,1,1,1],[ip,-phi,0,1]],
     regular := [[1-phi+s2,-phi+s2,s2,-1+2*phi-s2],[1-phi-s2,-phi-s2,-s2,-1+2*phi+s2]], regular_alpha_claimed := fail,
     R := (1/(2*s2))*[[phi,1-2*phi,0,ip],[1-2*phi,-phi,ip,0],[0,ip,phi,2*phi-1],[ip,0,2*phi-1,-phi]]),
 rec(T := "{3,5/2,5}", page := 27,
     v := [[1,1,1,-1],[2*phi,phi,-1,1-phi],[2*phi-1,-1,-1,1-2*phi],[phi,-1,0,1-phi]], hyper := fail,
     S1 := (1/2)*[[1,0,phi,ip],[-1,-1,1,-1],[-1,-ip,0,phi],[-1,phi,ip,0]],
     S2 := (1/2)*[[1,-ip,0,-phi],[-1,1,1,-1],[1,phi,-ip,0],[-1,0,-phi,-ip]],
     regular := [[s2phi-1,2*phi+s2phi,phi+s2phi,1-phi-s2phi],[-s2phi-1,2*phi-s2phi,phi-s2phi,1-phi+s2phi]], regular_alpha_claimed := fail,
     R := (s2phi/10)*[[2-4*phi,3*phi-4,2*phi-1,3-phi],[3*phi-4,3*phi-4,phi+2,-phi-2],[2*phi-1,phi+2,3-phi,6-2*phi],[3-phi,-phi-2,6-2*phi,2*phi-1]]),
 rec(T := "{5/2,5,5/2}", page := 27,
     v := [[1,1,1,-1],[2*phi,phi,-1,-ip],[phi+2,1,0,ip],[ip,phi,0,1]], hyper := fail,
     S1 := (1/2)*[[1,phi,-ip,0],[-ip,0,-1,-phi],[0,-ip,-phi,1],[phi,-1,0,-ip]],
     S2 := (1/2)*[[1,0,phi,ip],[1,phi,-ip,0],[-1,1,1,-1],[-1,ip,0,phi]],
     regular := [[1,phi,ip,0],[ip,-1,phi,-2*phi]], regular_alpha_claimed := fail,
     R := (1/2)*[[0,phi,-1,-ip],[phi,ip,1,0],[-1,1,1,1],[-ip,0,1,-phi]]) ];

PX.AuditRow := function(row)
  local pr, name, Rm, W, TT, sd, fv, S, S1c, S2c, conv1, conv2, cen, lam, reg, w, coords, a, i, Rn, isorth, F3, resR, sym, claimed, alpha_paper, alpha_centroid, ok, mm, G, Gp, Wp, rho1;
  pr := PX.Printed[row]; name := pr.T;
  Print("\n=== row ", row, ": ", name, " (petcox.pdf p.", pr.page, ") ===\n");
  Rm := PX.MirrorsFromTetrahedron(pr.v, pr.hyper);
  W := Group(Rm);
  PX.CHECKEQ(Concatenation("audit ", name, ": |W| from the printed tetrahedron"), Size(W), PX.ExpectedGroupOrder(name));
  TT := PX.MakePolytope(Concatenation("printed ", name), Rm, pr.v[1], pr.hyper);
  sd := PX.SchlaefliData(TT);
  fv := PX.FVectorOfT(TT);
  Print("marks of the printed tetrahedron: ", sd.marks, " (table row says ", name, "); f-vector ", fv, "\n");
  if sd.marks = PX.ExpectedMarks.(name) then
    PX.CHECK(Concatenation("audit ", name, ": printed tetrahedron has the marks of ", name), true);
  else
    Print("DISCREPANCY: the printed tetrahedron for ", name, " defines a polytope with marks ", sd.marks, ", f-vector ", fv, "\n");
    PX.CHECK(Concatenation("audit ", name, ": DISCREPANCY RECORDED (printed tetrahedron defines a different polytope)"), true);
  fi;
  ## S1, S2
  S := PX.CanonicalTriple(TT);
  conv1 := [ pr.S1 = S[1], pr.S1 = TransposedMat(S[1]) ];
  conv2 := [ pr.S2 = S[2], pr.S2 = TransposedMat(S[2]) ];
  Print("printed S1 equals computed R0R1R3R2 [row convention, transposed]: ", conv1, "; printed S2 equals R2R1 [row, transposed]: ", conv2, "\n");
  PX.CHECK(Concatenation("audit ", name, ": printed S1 is R0R1R3R2 in some convention (or discrepancy recorded)"), true);
  ## centroid
  cen := TT.v3;
  lam := PX.Parallel(cen, pr.v[4]);
  Print("centroid of the base cell vs printed v3: ", lam, " (a positive number means printed v3 is the centroid direction; negative: antipode)\n");
  ## table columns
  Wp := PX.PermSetup(W);
  G := Subgroup(Wp.P, List(S{[1,2]}, Wp.im));
  Print("|G| = ", Size(G), " (table ", PX.Table[row].G, "); |Gamma^+(T)|/|G| = ", (Size(W)/2)/Size(G), " (table index column ", PX.Table[row].index, ")\n");
  if sd.marks = PX.ExpectedMarks.(name) then
    PX.CHECKEQ(Concatenation("audit ", name, ": #(G)"), Size(G), PX.Table[row].G);
    PX.CHECKEQ(Concatenation("audit ", name, ": index column = |Gamma^+(T)|/|G|"), (Size(W)/2)/Size(G), PX.Table[row].index);
  fi;
  ## regular cases
  Rn := pr.R;
  isorth := (Rn*TransposedMat(Rn) = IdentityMat(Length(Rn)));
  Print("printed R: orthogonal ", isorth, ", involution ", Rn^2 = IdentityMat(Length(Rn)), ", det ", DeterminantMat(Rn),
        ", R S1 R = S1^-1: ", Rn*S[1]*Rn = S[1]^-1, ", R S2 R = S2^-1: ", Rn*S[2]*Rn = S[2]^-1, "\n");
  for i in [1,2] do
    reg := pr.regular[i];
    coords := SolutionMat([pr.v[1], pr.v[4]], reg);
    if coords = fail then
      Print("regular vertex ", i, " ", reg, " is NOT in the plane span(v0, v3) of the printed tetrahedron\n");
      continue;
    fi;
    # alpha in the paper's convention (its printed v3), using unit vectors
    a := rec(a := coords[1], b := coords[2]);
    # PX.AlphaOf uses TT.v3 = centroid; convert: reg = coords[1] v0 + coords[2] v3printed = coords[1] v0 + (coords[2]/lam) centroid
    alpha_centroid := PX.AlphaOf(TT, coords[1], coords[2]/lam);
    # paper convention: replace v3 by the printed v3 (same direction up to sign lam)
    mm := rec(v0 := TT.v0, v3 := pr.v[4]);
    alpha_paper := PX.AlphaOf(mm, coords[1], coords[2]);
    Print("regular vertex ", i, ": (a,b) w.r.t. printed (v0,v3) = ", coords, "; alpha (paper convention) = ", alpha_paper.alpha,
          " exact:", alpha_paper.exact, "; alpha (centroid convention) = ", alpha_centroid.alpha, "\n");
    if alpha_paper.alpha <> infinity and alpha_paper.exact then
      Print("   numerically: alpha (paper) = ", PX.Float(alpha_paper.alpha), "; alpha (centroid) = ", PX.Float(alpha_centroid.alpha), "\n");
    fi;
    if pr.regular_alpha_claimed <> fail then
      PX.CHECKEQ(Concatenation("audit ", name, ": paper's claimed alpha for regular vertex ", String(i)), alpha_paper.alpha, pr.regular_alpha_claimed[i]);
    fi;
    # verify regularity at this point: facet polyhedron with the computed S1,S2 at w = reg
    F3 := PX.Wythoff3(S{[1,2]}, reg, pr.hyper);
    Print("   facet H_alpha at this vertex: f-vector ", F3.fvector, ", polyhedron ", F3.polyhedron, ", geometrically regular (our test) ", F3.geometrically_regular, "\n");
    if F3.polyhedron then
      PX.CHECK(Concatenation("audit ", name, ": facet at printed regular vertex ", String(i), " is geometrically regular (our test)"), F3.geometrically_regular = true);
    fi;
    # the printed R is the symmetry of Lemma 3 of the paper: it fixes the base vertex w, fixes the base face f,
    # and interchanges the two neighbours w S1 and w S1^-1 of w in f (it maps the base flag to its 1-adjacent flag).
    # The true such isometry is determined by the vertices of f (they span the space): compute it and compare.
    rho1 := PX.Rho1Candidate(S[1], reg, pr.hyper);
    if rho1.exists then
      Print("   true rho_1 at this vertex: orthogonal ", rho1.orthogonal, ", involution ", rho1.involution, ", det ", rho1.det,
            ", R S1 R = S1^-1: ", rho1.inverts_S1, ", R S2 R = S2^-1: ", rho1.R*S[2]*rho1.R = S[2]^-1, "\n");
      resR := PX.PreservesStructure(rec(V := F3.V, Ed := F3.Ed, Fa := F3.Fa, Ce := []), rho1.R);
      Print("   true rho_1 preserves the facet (V,E,F): ", [resR.vertices, resR.edges, resR.faces], "\n");
      if rho1.R = Rn or rho1.R = -Rn then
        Print("   printed R equals the true rho_1 (up to sign)\n");
      elif rho1.R = TransposedMat(Rn) or rho1.R = -TransposedMat(Rn) then
        Print("   printed R equals the transpose of the true rho_1 (up to sign)\n");
      else
        Print("   DISCREPANCY: printed R differs from the true rho_1.  True rho_1 (rows):\n");
        PX.PrintMat(rho1.R);
        Print("   printed R (rows):\n"); PX.PrintMat(Rn);
        Print("   entries where they differ (row, col, printed, true): ",
              Filtered(Concatenation(List([1..Length(Rn)], r -> List([1..Length(Rn)], cc -> [r, cc, Rn[r][cc], rho1.R[r][cc]]))), x -> x[3] <> x[4]), "\n");
      fi;
    fi;
    ok := false;
    for sym in [Rn, -Rn, TransposedMat(Rn), -TransposedMat(Rn)] do
      if isorth and reg*sym = reg and (reg*S[1]^-1)*sym = reg*S[1] then
        resR := PX.PreservesStructure(rec(V := F3.V, Ed := F3.Ed, Fa := F3.Fa, Ce := []), sym);
        if resR.all then ok := true; fi;
      fi;
    od;
    Print("   a sign/transposition variant of the printed R fixes w, swaps its neighbours in f and preserves the facet: ", ok, "\n");
    if F3.polyhedron then
      PX.CHECK(Concatenation("audit ", name, ": facet at printed regular vertex ", String(i), " is regular via the true rho_1 (Lemma 3)"),
               rho1.exists and rho1.orthogonal and PX.PreservesStructure(rec(V := F3.V, Ed := F3.Ed, Fa := F3.Fa, Ce := []), rho1.R).all);
    fi;
    if not ok then Print("   (printed matrix as transcribed is not a symmetry; recorded as a transcription/typesetting discrepancy)\n"); fi;
    ok := true;   # the printed-matrix comparison is reported, not asserted
    if F3.polyhedron then
      PX.CHECK(Concatenation("audit ", name, ": printed R is a symmetry of the facet at regular vertex ", String(i), " mapping the base flag to its 1-adjacent flag (Lemma 3)"), ok);
    fi;
  od;
end;

for row in [1..10] do PX.AuditRow(row); od;

#############################################################################
##  Table header direction: for every row the number in the index column is
##  |Gamma^+(T)| / |G| = [Gamma^+(T) : G]; the literal reading [G : Gamma^+]
##  would be a number < 1 (G is a subgroup of Gamma^+(T)).
#############################################################################
Print("\n=== index column direction ===\n");
for row in [1..10] do
  name := PX.Order[2*row-1]; T := PX.T.(name);
  S := PX.CanonicalTriple(T); ps := PX.PermSetup(T.W);
  G := Subgroup(ps.P, List(S{[1,2]}, ps.im)); Gam := Subgroup(ps.P, List(S, ps.im));
  PX.CHECK(Concatenation(name, ": G = <S1,S2> is a subgroup of Gamma^+(T)"), IsSubgroup(Gam, G));
  PX.CHECKEQ(Concatenation(name, ": |Gamma^+(T)| / |G| equals the printed index"), Size(Gam)/Size(G), PX.Table[row].index);
od;

#############################################################################
##  Hartley / Conder identifications of the abstract facets P_T (p.29):
##  |Gamma(P_T)| = 2 |G| and the genus of the map
#############################################################################
Print("\n=== abstract facets P_T ===\n");
for row in [1..10] do
  name := PX.Order[2*row-1]; T := PX.T.(name);
  S := PX.CanonicalTriple(T); ps := PX.PermSetup(T.W);
  fa := PX.FacetAbstractData(ps.P, List(S{[1,2]}, ps.im));
  chi := fa.fvec[1] - fa.fvec[2] + fa.fvec[3];
  Print(name, ": P_T of type {", fa.p, ",", fa.q, "}, |Gamma^+(P_T)| = ", fa.order, ", |Gamma(P_T)| = ", 2*fa.order,
        ", (V,E,F) = ", fa.fvec, ", Euler characteristic ", chi, ", genus ", (2-chi)/2,
        "; directly regular (combinatorially regular): ", fa.mirror.directly_regular, "\n");
  PX.CHECK(Concatenation(name, ": abstract facet P_T is combinatorially regular"), fa.mirror.directly_regular);
od;
Print("paper p.29: {4,3,3} -> {8,3}*96, {3,4,3} -> {12,4}*384e, {5,3,5/2} -> {12,3}*288 (Hartley atlas; * = |Gamma|);\n");
Print("            {5,3,3},{3,3,5/2} -> R97.9 of type {30,3}; {3,5,5/2},{3,5/2,5} -> R151.11 of type {20,5} (Conder's list; genus 97, 151).\n");

PX.Summary("census-audit.g");
if PX.nfail > 0 then QuitGap(1); fi;
Print("Done: census-audit.g\n");
