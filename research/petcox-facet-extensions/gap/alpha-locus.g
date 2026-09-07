#############################################################################
##
##  alpha-locus.g  --  which alpha can be the base vertex of a rank-4
##  Wythoff construction whose facet generators are the PETCOX S1, S2?
##
##  Facts verified exactly for each of the 16 polytopes T:
##   (1) Fix(S2) = the 2-plane Pi = span(v0, v3): S2 = R2 R1 fixes exactly the
##       intersection of mirrors 1 and 2, which contains v0 and v3.  Hence
##       every Wythoff base vertex of ANY extension (S1,S2,X) lies on the
##       great circle Pi cap S^3, i.e. it is a PETCOX point (v,c)_alpha for
##       some projective alpha in R u {oo} (up to the antipodal map).
##   (2) Fix(S2) cap Fix(S3) = span(v0) for the canonical S3 = R3 R2, so the
##       canonical construction forces alpha = 0; for the canonical third
##       generator of T^*, S3^* = R0 R1, the locus is span(v3): alpha = 1.
##   (3) The pointwise stabiliser of Pi in W is <R1,R2>, whose rotations are
##       <S2>: no element outside <S2> fixes the whole circle.
##   (4) Nondegeneracy of H_alpha(T) at alpha = 0 and 1 (vertex, edge, face
##       collapse), compared with the "Colapses at alpha=(0,1)" column.
##   (5) The exceptional regular values of alpha (paper): the printed base
##       vertices for the regular cases are converted to exact alpha in the
##       paper's own convention, and geometric regularity is verified there.
##
#############################################################################

if not IsBound(PX) then Read("lib.g"); fi;
if not IsBound(PX.T) or Length(RecNames(PX.T)) = 0 then Read("polytopes.g"); PX.BuildAll(); PX.SetupRows(); fi;

PX.AlphaResults := rec();

for name in PX.Order do
  T := PX.T.(name);
  S := PX.CanonicalTriple(T);
  S3star := T.R[1]*T.R[2];       # canonical third generator of T^* (R0^* R1^* ... with reversed labels: R3^* R2^* = R0 R1)
  Print("\n=== ", name, " ===\n");
  ## (1) fixed space of S2
  F2 := PX.CommonFixedSpace([S[2]], T.dim, T.hyper);
  PX.CHECKEQ(Concatenation(name, ": dim Fix(S2)"), Length(F2), 2);
  PX.CHECK(Concatenation(name, ": Fix(S2) = span(v0,v3)"), RankMat(Concatenation(F2, [T.v0, T.v3])) = 2);
  ## (2) canonical locus
  F23 := PX.CommonFixedSpace([S[2], S[3]], T.dim, T.hyper);
  PX.CHECKEQ(Concatenation(name, ": dim Fix(S2) cap Fix(S3)"), Length(F23), 1);
  PX.CHECK(Concatenation(name, ": Fix(S2) cap Fix(S3) = span(v0)"), RankMat(Concatenation(F23, [T.v0])) = 1);
  L3 := PX.FixedLocusInPlane(T, S[3]);
  PX.CHECK(Concatenation(name, ": in-plane fixed locus of S3 is {b = 0}, i.e. alpha = 0"), Length(L3) = 1 and L3[1][2] = 0);
  F2s := PX.CommonFixedSpace([S[2], S3star], T.dim, T.hyper);
  PX.CHECK(Concatenation(name, ": Fix(S2) cap Fix(R0R1) = span(v3), i.e. alpha = 1 for the dual endpoint"),
           Length(F2s) = 1 and RankMat(Concatenation(F2s, [T.v3])) = 1);
  ## v0 and v3 are linearly independent (so alpha is a genuine parameter)
  PX.CHECK(Concatenation(name, ": v0, v3 independent"), RankMat([T.v0, T.v3]) = 2);
  ## (3) pointwise stabiliser of the plane
  Wm := T.W;
  stabPlane := Stabilizer(Stabilizer(Wm, T.v0, OnPoints), T.v3, OnPoints);
  D := Group(T.R{[2,3]});
  PX.CHECK(Concatenation(name, ": pointwise stabiliser of span(v0,v3) in W is <R1,R2>"), stabPlane = D);
  PX.CHECKEQ(Concatenation(name, ": its order 2q"), Size(stabPlane), 2*Order(S[2]));
  rotPlane := Filtered(AsList(stabPlane), g -> DeterminantMat(g) = 1);
  PX.CHECK(Concatenation(name, ": rotations fixing the plane pointwise = <S2>"), Set(rotPlane) = Set(AsList(Group(S[2]))));
  ## (4) nondegeneracy of the facet at alpha = 0 and alpha = 1
  res := rec(name := name);
  for pair in [ ["0", T.v0], ["1", T.v3] ] do
    F3 := PX.Wythoff3(S{[1,2]}, pair[2], T.hyper);
    Gm := Group(S{[1,2]});
    mult := Size(Stabilizer(Gm, pair[2], OnPoints))/Order(S[2]);
    Print("H_", pair[1], "(", name, "): facet f-vector ", F3.fvector, " (abstract ", [Size(Gm)/Order(S[2]), Size(Gm)/2, Size(Gm)/Order(S[1])], ")",
          "; vertex collapse multiplicity ", mult, "; stabilisers (v,e,f) match: ", F3.stab_equal,
          "; polyhedron: ", F3.polyhedron, "; geometrically regular: ", F3.geometrically_regular, "\n");
    res.(Concatenation("alpha", pair[1])) := rec(fvector := F3.fvector, mult := mult, polyhedron := F3.polyhedron, regular := F3.geometrically_regular);
  od;
  row := PX.RowOf.(name);
  side := 1; if PX.Order[2*row] = name then side := 2; fi;
  tab := PX.Table[row];
  # for the row's T (side 1): alpha=0 -> collapse[1], alpha=1 -> collapse[2]; for T^* (side 2) the roles swap
  if side = 1 then exp0 := tab.collapse[1]; exp1 := tab.collapse[2]; else exp0 := tab.collapse[2]; exp1 := tab.collapse[1]; fi;
  PX.CHECKEQ(Concatenation(name, ": collapse multiplicity at alpha=0 vs table"), res.alpha0.mult, exp0);
  PX.CHECKEQ(Concatenation(name, ": collapse multiplicity at alpha=1 vs table"), res.alpha1.mult, exp1);
  PX.CHECK(Concatenation(name, ": H_0 is a polyhedron iff no vertex collapse"), res.alpha0.polyhedron = (res.alpha0.mult = 1));
  PX.CHECK(Concatenation(name, ": H_1 is a polyhedron iff no vertex collapse"), res.alpha1.polyhedron = (res.alpha1.mult = 1));
  if res.alpha0.polyhedron then PX.CHECK(Concatenation(name, ": H_0 geometrically chiral"), res.alpha0.regular = false); fi;
  if res.alpha1.polyhedron then PX.CHECK(Concatenation(name, ": H_1 geometrically chiral"), res.alpha1.regular = false); fi;
  PX.AlphaResults.(name) := res;
od;

#############################################################################
##  (5) Exceptional regular values of alpha: the paper's printed base vertices
##  for the regular cases.  They are given for the row's T in the paper's own
##  coordinates; we transport them to our coordinates by finding the unique
##  element of O(4) (in fact of W or its normaliser) mapping the paper's
##  tetrahedron to ours -- simpler and fully rigorous: we rebuild the paper's
##  polytope from its printed tetrahedron (census-audit.g does this) and
##  solve for alpha there.  Here we only record, for each of our T, the alpha
##  values at which the facet H_alpha(T) becomes geometrically regular, by an
##  exact search: regularity at alpha needs a half-turn R normalising G with
##  R S1 R = S1^-1, R S2 R = S2^-1 and w_alpha R = w_alpha S1^-1; the set of
##  such R is finite (computed in the normaliser of G inside W and, when
##  -I is not in W, checked separately), and each R determines alpha.
#############################################################################
Print("\n=== exceptional (geometrically regular) alpha: half-turns in W inverting S1 and S2 ===\n");
for name in PX.Order do
  T := PX.T.(name);
  S := PX.CanonicalTriple(T);
  cands := Filtered(AsList(T.W), g -> g*S[1]*g^-1 = S[1]^-1 and g*S[2]*g^-1 = S[2]^-1);
  found := [];
  for g in cands do
    # need w R = w S1^-1 for some w on the circle: w (R S1) = w, i.e. w in Fix(g*S1) cap plane
    L := PX.FixedLocusInPlane(T, g*S[1]);
    if Length(L) = 1 then
      a := PX.AlphaOf(T, L[1][1], L[1][2]);
      Add(found, rec(alpha := a.alpha, exact := a.exact, ab := L[1], order := Order(g), det := DeterminantMat(g)));
    elif Length(L) = 2 then
      Add(found, rec(alpha := "all", exact := true, ab := fail, order := Order(g), det := DeterminantMat(g)));
    fi;
  od;
  Print(name, ": elements of W inverting S1 and S2 by conjugation: ", Length(cands), "; those fixing a point of the circle -> alpha in ",
        List(found, f -> f.alpha), " (orders ", List(found, f -> f.order), ", dets ", List(found, f -> f.det), ")\n");
  PX.AlphaResults.(name).regular_alphas_in_W := found;
od;

PX.Summary("alpha-locus.g");
if PX.nfail > 0 then QuitGap(1); fi;
Print("Done: alpha-locus.g\n");
