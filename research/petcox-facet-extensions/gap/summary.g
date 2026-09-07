#############################################################################
##
##  summary.g  --  the final table of every surviving realisation, with the
##  chirality group X(P) of one representative of each abstract isomorphism
##  class, computed with the repository's own chirality-group library
##  (computations/chirality-groups/common/chirality-group.g, read-only).
##
##  Reads the machine-generated survivor files written by parent-search.g and
##  alpha-complete.g, recomputes every invariant from the stored matrices, and
##  writes ../logs/summary-rows.tsv.
##
##  Run from gap/:  gap -q -A --quitonbreak summary.g < /dev/null
##
#############################################################################

if not IsBound(PX) then Read("lib.g"); fi;
if not IsBound(PX.T) or Length(RecNames(PX.T)) = 0 then Read("polytopes.g"); PX.BuildAll(); PX.SetupRows(); fi;

PX.Saved := [];
if IsExistingFile("../logs/parent-survivors.g") then Read("../logs/parent-survivors.g"); fi;
if IsExistingFile("../logs/alpha-survivors.g") then Read("../logs/alpha-survivors.g"); fi;

## the canonical survivors, in the same record shape
PX.All := [];
for name in PX.Order do
  T := PX.T.(name); S := PX.CanonicalTriple(T);
  ps := PX.PermSetup(T.W); s := List(S, ps.im);
  if PX.StringRelations(s).holds and PX.IntersectionData(ps.P, s).holds then
    Add(PX.All, rec(case := Concatenation("C-", name), T := name, alpha := 0, S := S, w := T.v0, source := "canonical"));
  fi;
od;
for r in PX.Saved do
  if r.skeletal then
    Add(PX.All, rec(case := r.case, T := r.T, alpha := r.alpha, S := [r.S1, r.S2, r.X], w := r.w,
                    source := r.parent));
  fi;
od;
Print("realisations to summarise: ", Length(PX.All), "\n");

PX.SummaryTSV := "../logs/summary-rows.tsv";
PrintTo(PX.SummaryTSV, JoinStringsWithSeparator([
  "case","source","T","alpha_exact","alpha_numeric","type","fvector","gamma_order","vf_group",
  "facet_fvector","facet_geometrically_regular","directly_regular","geometrically_chiral",
  "twist","invariant_key"], "\t"), "\n");

## invariants that do not depend on the choice of base flag orbit:
## the multiset over the two orientations of the orders of a few words
PX.OrientationInvariant := function(P, s)
  local mir, words, f;
  mir := PX.Mirror(s);
  words := function(x) return [ Order(x[1]*x[3]), Order(x[1]^-1*x[3]), Order(x[3]*x[2]*x[1]),
                                Order(x[1]*x[2]*x[3]^-1), Order(x[1]^2*x[3]), Order(x[1]*x[3]^2) ]; end;
  return Set([ words(s), words(mir) ]);
end;

PX.Rows := [];
for r in PX.All do
  T := PX.T.(r.T);
  ps := PX.PermSetup(Group(r.S));
  s := List(r.S, ps.im);
  G := ps.P;
  fv := PX.FVector(G, s);
  fa := PX.Wythoff3(r.S{[1,2]}, r.w, T.hyper);
  mt := PX.MirrorTest(G, s);
  tw := PX.TwistType(r.S[1], T.hyper);
  inv := PX.OrientationInvariant(G, s);

  row := rec(case := r.case, source := r.source, T := r.T, alpha := r.alpha,
             alpha_num := "-", type := List(r.S, Order), fvector := fv, gamma := Size(G),
             vf := Size(Subgroup(G, s{[2,3]})), facet_fv := fa.fvector,
             facet_reg := fa.geometrically_regular, dr := mt.directly_regular,
             twist := tw.pairs, inv := inv, S := r.S, w := r.w, G := G, s := s);
  if r.alpha <> infinity then row.alpha_num := PX.Float(r.alpha); fi;
  Add(PX.Rows, row);
  Print(row.case, " | ", row.T, " | alpha = ", row.alpha, " (", row.alpha_num, ") | type ", row.type,
        " | f = ", row.fvector, " | |Gamma| = ", row.gamma, " | vf group ", row.vf,
        " | facet ", row.facet_fv, ", geometrically regular: ", row.facet_reg,
        " | directly regular: ", row.dr, "\n");
  AppendTo(PX.SummaryTSV, JoinStringsWithSeparator(List([row.case, row.source, row.T, row.alpha, row.alpha_num,
    String(row.type), String(row.fvector), row.gamma, row.vf, String(row.facet_fv), row.facet_reg, row.dr,
    true, String(row.twist), String(row.inv)], String), "\t"), "\n");
od;

#############################################################################
##  Abstract isomorphism classes, keyed by the orientation invariant, and the
##  chirality group of one representative of each
#############################################################################
Print("\n=== abstract classes by the orientation-independent word invariant ===\n");
keys := [];
for row in PX.Rows do
  k := [row.type, row.fvector, row.gamma, row.inv];
  if not k in keys then Add(keys, k); fi;
od;
for i in [1..Length(keys)] do
  mem := Filtered(PX.Rows, row -> [row.type, row.fvector, row.gamma, row.inv] = keys[i]);
  Print("class ", i, ": type ", keys[i][1], ", f-vector ", keys[i][2], ", |Gamma| = ", keys[i][3],
        ", ", Length(mem), " realisation(s): ", List(mem, x -> x.case), "\n");
  Print("   word-order invariant (both orientations) = ", keys[i][4], "\n");
od;
PX.CHECK("the word-order invariant separates the classes found by compare.g (6 classes)", Length(keys) = 6);

cgfile := "../../../computations/chirality-groups/common/chirality-group.g";
if IsExistingFile(cgfile) then
  Read(cgfile);
  Print("\n=== chirality groups X(P), one representative per class ===\n");
  for i in [1..Length(keys)] do
    mem := Filtered(PX.Rows, row -> [row.type, row.fvector, row.gamma, row.inv] = keys[i]);
    row := mem[1];
    res := CG.ComputeChiralityGroup(row.G, row.s, ["S1","S2","S3"]);
    Print("class ", i, " (", row.case, ", type ", row.type, ", f = ", row.fvector, "): |X(P)| = ", Size(res.X),
          ", X(P) = ", StructureDescription(res.X), ", [Gamma : X] = ", res.index,
          ", Gamma/X = ", res.quotient_desc.structure,
          ", quotient generator orders ", res.quotient_gens_orders,
          ", quotient coset f-vector ", res.quotient_fvector,
          ", quotient has the intersection property: ", res.quotient_ip,
          ", |Gamma o Gamma-bar| = ", Size(res.m2.Mix), "\n");
    PX.CHECK(Concatenation("class ", String(i), ": the three methods for X(P) agree"),
             res.agree_12 and res.agree_13 and res.agree_2bar);
    PX.CHECK(Concatenation("class ", String(i), ": X(P) trivial exactly when the polytope is directly regular"),
             IsTrivial(res.X) = row.dr);
    PX.(Concatenation("Xclass", String(i))) := rec(size := Size(res.X), structure := StructureDescription(res.X),
                                                   index := res.index, quotient := res.quotient_desc.structure);
  od;
  ## the two classes of type {12,3,5} with the same f-vector must differ
  a := PX.Xclass3; b := PX.Xclass6;
  Print("\nthe two classes of type {12,3,5} with f-vector (120,720,300,50): |X| = ", a.size, " and ", b.size, "\n");
else
  Print("chirality-group library not found at ", cgfile, "; chirality groups skipped\n");
fi;

PX.Summary("summary.g");
if PX.nfail > 0 then QuitGap(1); fi;
Print("Done: summary.g\n");
