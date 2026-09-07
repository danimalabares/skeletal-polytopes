#############################################################################
##
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
##
#############################################################################

if not IsBound(PX) then Read("lib.g"); fi;
if not IsBound(PX.T) or Length(RecNames(PX.T)) = 0 then Read("polytopes.g"); PX.BuildAll(); PX.SetupRows(); fi;

PX.Saved := [];
if IsExistingFile("../logs/parent-survivors.g") then Read("../logs/parent-survivors.g"); fi;
n1 := Length(PX.Saved);
if IsExistingFile("../logs/alpha-survivors.g") then Read("../logs/alpha-survivors.g"); fi;
Print("candidates read: ", n1, " from the parent searches, ", Length(PX.Saved) - n1, " from the Level 3 analysis\n");

## canonical survivors
PX.Cands := [];
for name in PX.Order do
  T := PX.T.(name); S := PX.CanonicalTriple(T);
  ps := PX.PermSetup(T.W); s := List(S, ps.im);
  if PX.StringRelations(s).holds and PX.IntersectionData(ps.P, s).holds then
    Add(PX.Cands, rec(case := Concatenation("C-", name), T := name, parent := "canonical", alpha := 0, S := S, w := T.v0,
                      Wname := PX.RowOf.(name)));
  fi;
od;
for r in PX.Saved do
  if r.skeletal then
    Add(PX.Cands, rec(case := r.case, T := r.T, parent := r.parent, alpha := r.alpha, S := [r.S1, r.S2, r.X], w := r.w,
                      Wname := fail, saved_dr := r.directly_regular));
  fi;
od;
Print("total candidates (skeletal 4-polytopes): ", Length(PX.Cands), "\n");

## structures as sets of vectors (for identity / mirror tests inside a common coordinate system)
PX.StructureVectors := function(Wy)
  local V, vec, Ev, Fv, Cv;
  V := Wy.V;
  vec := e -> Set(List(e, i -> V[i]));
  Ev := Set(List(Wy.Ed, vec));
  Fv := Set(List(Wy.Fa, f -> Set(List(f, vec))));
  Cv := Set(List(Wy.Ce, c -> Set(List(c, f -> Set(List(f, vec))))));
  return rec(V := Set(V), E := Ev, F := Fv, C := Cv);
end;
PX.ApplyToStructure := function(st, g)
  return rec(V := Set(List(st.V, v -> v*g)),
             E := Set(List(st.E, e -> Set(List(e, v -> v*g)))),
             F := Set(List(st.F, f -> Set(List(f, e -> Set(List(e, v -> v*g)))))),
             C := Set(List(st.C, c -> Set(List(c, f -> Set(List(f, e -> Set(List(e, v -> v*g)))))))));
end;
PX.NormalisedGram := function(V)
  local i, j, l, n;
  l := [];
  for i in [1..Length(V)] do for j in [i+1..Length(V)] do
    Add(l, (V[i]*V[j])/((V[i]*V[i])));   # all vertices have the same norm (one orbit)
  od; od;
  return Collected(l);
end;

## compute data for each candidate
for c in PX.Cands do
  c.Gm := Group(c.S);
  c.ps := PX.PermSetup(c.Gm);
  c.s := List(c.S, c.ps.im);
  c.G := c.ps.P;
  c.Wy := PX.Wythoff4(c.S, c.w);
  c.st := PX.StructureVectors(c.Wy);
  c.gram := PX.NormalisedGram(c.Wy.V);
  c.fvector := c.Wy.fvector;
  c.orders := List(c.S, Order);
  c.twist := PX.TwistType(c.S[1], PX.T.(c.T).hyper);
  if IsBound(c.saved_dr) then c.mirror := c.saved_dr; else c.mirror := PX.MirrorTest(c.G, c.s).directly_regular; fi;
  c.dim := Length(c.w);
  Print(c.case, ": T = ", c.T, ", parent ", c.parent, ", alpha = ", c.alpha, ", type ", c.orders, ", twist ", c.twist.pairs,
        ", f-vector ", c.fvector, ", |Gamma| = ", Size(c.G), ", directly regular: ", c.mirror, "\n");
od;

Print("\n=== pairwise comparison ===\n");
PX.Classes := [];      # equivalence classes up to isomorphism/enantiomorphism (abstract) with geometric annotations
for i in [1..Length(PX.Cands)] do
  a := PX.Cands[i];
  a.abstract_class := fail; a.geom_relation := [];
  for j in [1..i-1] do
    b := PX.Cands[j];
    if a.dim <> b.dim then continue; fi;
    if a.orders <> b.orders or a.fvector <> b.fvector or Size(a.G) <> Size(b.G) then continue; fi;
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
    if cmp.isomorphic or cmp.dual or a.gram = b.gram then
      Print(a.case, " vs ", b.case, ": abstractly isomorphic (same orientation ", cmp.isomorphic_same_orientation, ", mirror ", cmp.isomorphic_mirror,
            "), dual ", cmp.dual, "; geometry: ", geom, "\n");
    fi;
    if cmp.isomorphic and a.abstract_class = fail then a.abstract_class := b.abstract_class; fi;
    Add(a.geom_relation, rec(other := b.case, iso := cmp.isomorphic, iso_same := cmp.isomorphic_same_orientation, iso_mirror := cmp.isomorphic_mirror, dual := cmp.dual, geom := geom));
  od;
  if a.abstract_class = fail then Add(PX.Classes, a.case); a.abstract_class := Length(PX.Classes); fi;
od;

Print("\n=== abstract isomorphism classes (up to enantiomorphism) ===\n");
for k in [1..Length(PX.Classes)] do
  mem := Filtered(PX.Cands, c -> c.abstract_class = k);
  Print("class ", k, ": ", List(mem, c -> c.case), "  type ", mem[1].orders, ", f-vector ", mem[1].fvector, ", |Gamma| = ", Size(mem[1].G),
        ", directly regular: ", mem[1].mirror, "\n");
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
  PX.CHECK(Concatenation("class ", String(k), ": all members have the same f-vector and type"),
           ForAll(mem, c -> c.fvector = mem[1].fvector and c.orders = mem[1].orders));
od;

## The expected picture: three abstract classes (Roli's cube {8,3,3}; the thesis polytope {12,3,5}; the new {30,3,3}),
## the thesis class and the new class each with two non-congruent realisations.
Print("\nnumber of abstract isomorphism classes (up to enantiomorphism) among all candidates: ", Length(PX.Classes), "\n");
for k in [1..Length(PX.Classes)] do
  mem := Filtered(PX.Cands, c -> c.abstract_class = k);
  Print("  class ", k, ": type ", mem[1].orders, ", f-vector ", mem[1].fvector, ", |Gamma| = ", Size(mem[1].G),
        ", directly regular ", mem[1].mirror, ", ", Length(mem), " candidate(s)\n");
od;
PX.CHECK("every candidate falls into one of the abstract classes",
         ForAll(PX.Cands, c -> c.abstract_class <> fail and c.abstract_class >= 1));

PX.Summary("compare.g");
if PX.nfail > 0 then QuitGap(1); fi;
Print("Done: compare.g\n");
