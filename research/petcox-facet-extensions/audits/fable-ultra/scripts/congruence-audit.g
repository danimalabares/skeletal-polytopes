#############################################################################
##
##  congruence-audit.g  --  fresh-session Fable audit (audits/fable-ultra):
##  independent verification of the 24 claimed realisations and of the
##  claim "exactly 24 up to congruence and enantiomorphism, 6 abstract
##  classes with 4 realisations each".
##
##  Input: the producer's machine-generated survivor file
##  logs/alpha-survivors.g (24 records: matrices S1, S2, X and base vertex w
##  for every Level-3 survivor), read-only, plus the reflection groups of
##  gap/polytopes.g.  Every invariant below is recomputed from the matrices
##  with code written for this audit.
##
##  Congruence is decided by an actual isometry search: for two realisations
##  P_a, P_b an isometry g of E^4 (up to scale) with V_a g = V_b is
##  determined by the images of four linearly independent vertices of V_a;
##  since Gamma_b is transitive on V_b, the base vertex of P_a may be sent to
##  the base vertex of P_b, and the remaining three images are found by
##  matching Gram matrices.  Every solution g is then tested on the edge,
##  2-face and cell structure.  (compare.g only tested "identical, or the
##  image under one reflection R0 of W", which decides congruence only for
##  pairs living on the same W-invariant vertex set.)
##
##  Run from audits/fable-ultra/scripts:
##      gap -q -A --quitonbreak congruence-audit.g < /dev/null
##
#############################################################################

Read("../../../gap/lib.g");
Read("../../../gap/polytopes.g");
PX.BuildAll(); PX.SetupRows();
SizeScreen([ 4096, ]);

AU := rec(npass := 0, nfail := 0, failed := []);
AU.CHECK := function(name, val)
  if val = true then AU.npass := AU.npass + 1; Print("AU-PASS  ", name, "\n");
  else AU.nfail := AU.nfail + 1; Add(AU.failed, name); Print("AU-FAIL  ", name, "   (got ", val, ")\n"); fi;
end;
AU.CHECKEQ := function(name, a, b)
  if a = b then AU.npass := AU.npass + 1; Print("AU-PASS  ", name, " = ", b, "\n");
  else AU.nfail := AU.nfail + 1; Add(AU.failed, name); Print("AU-FAIL  ", name, "   (expected ", b, ", got ", a, ")\n"); fi;
end;
AU.PI := 3.14159265358979323846;
AU.Float := function(x) local n, c, s, k;
  if x = infinity then return infinity; fi;
  if IsRat(x) then return Float(x); fi;
  n := Conductor(x); c := CoeffsCyc(x, n); s := 0.0;
  for k in [1..n] do if c[k] <> 0 then s := s + Float(c[k])*Cos(2*AU.PI*(k-1)/n); fi; od;
  return s;
end;
AU.OnSSS := function(cell, g) return Set(List(cell, x -> OnSetsSets(x, g))); end;
AU.Orbit := function(gens, w, cap) local orb, i, g, im;
  orb := [ w ]; i := 1;
  while i <= Length(orb) do
    for g in gens do im := orb[i]*g;
      if not im in orb then if Length(orb) >= cap then return fail; fi; Add(orb, im); fi;
    od; i := i + 1;
  od;
  return orb;
end;

## load the 24 survivors
PX.Saved := [];
Read("../../../logs/alpha-survivors.g");
Cand := Filtered(PX.Saved, r -> r.skeletal);
Print("Level-3 survivors read from logs/alpha-survivors.g: ", Length(Cand), "\n");
AU.CHECKEQ("number of Level-3 survivors in the producer's survivor file", Length(Cand), 24);

## also the 5 canonical extensions (they must coincide with survivors at alpha = 0 or 1)
Canon := [];
for name in ["{4,3,3}", "{5,3,3}", "{5,3,5/2}", "{5/2,3,5}", "{5/2,3,3}"] do
  T := PX.T.(name);
  Add(Canon, rec(case := Concatenation("C-", name), T := name, S1 := T.R[1]*T.R[2]*T.R[4]*T.R[3], S2 := T.R[3]*T.R[2], X := T.R[4]*T.R[3], w := T.v0, alpha := 0));
od;

#############################################################################
##  Full independent data for one realisation
#############################################################################
AU.Data := function(c)
  local S, w, d, V, pos, perms, P, s, e, f, cc, Ed, Fa, Ce, r, hom, Vn, n2, gram, i, j, prof, nb, vfg, p, R, M, Mp, Rmat, VR, stabs, mirror3, G3, F3V, hyper, dd;
  S := [c.S1, c.S2, c.X]; w := c.w; d := Length(w);
  hyper := PX.T.(c.T).hyper;
  r := rec(case := c.case, T := c.T, alpha := c.alpha, alpha_f := AU.Float(c.alpha), S := S, w := w, dim := d);
  V := AU.Orbit(S, w, 8000); r.V := V; r.nV := Length(V);
  pos := x -> Position(V, x);
  perms := List(S, g -> PermList(List(V, v -> pos(v*g))));
  P := Group(perms); s := perms; r.P := P; r.s := s;
  r.order := Size(P); r.orders := List(s, Order);
  r.relations := (Order(s[1]*s[2]) = 2 and Order(s[2]*s[3]) = 2 and Order(s[1]*s[2]*s[3]) = 2);
  r.ip := IsTrivial(Intersection(Subgroup(P,[s[1]]), Subgroup(P,[s[2]]))) and IsTrivial(Intersection(Subgroup(P,[s[2]]), Subgroup(P,[s[3]])))
          and Intersection(Subgroup(P, s{[1,2]}), Subgroup(P, s{[2,3]})) = Subgroup(P, [s[2]]);
  r.fvec_coset := [ Index(P, Subgroup(P, s{[2,3]})), Index(P, Subgroup(P, [s[3], s[1]*s[2]])), Index(P, Subgroup(P, [s[1], s[2]*s[3]])), Index(P, Subgroup(P, s{[1,2]})) ];
  hom := GroupHomomorphismByImages(P, P, s, [ s[1]^-1, s[1]^2*s[2], s[3] ]);
  r.directly_regular := (hom <> fail and IsBijective(hom));
  e := Set([ pos(w), pos(w*S[1]^-1) ]); f := Set(Orbit(Group(s[1]), e, OnSets)); cc := Set(Orbit(Group(s{[1,2]}), f, OnSetsSets));
  Ed := Orbit(P, e, OnSets); Fa := Orbit(P, f, OnSetsSets); Ce := Orbit(P, cc, AU.OnSSS);
  r.e := e; r.f := f; r.c := cc; r.Ed := Set(Ed); r.Fa := Set(Fa); r.Ce := Set(Ce);
  r.fvec_geom := [ Length(V), Length(Ed), Length(Fa), Length(Ce) ];
  r.stab := [ Stabilizer(P, pos(w), OnPoints) = Subgroup(P, s{[2,3]}), Stabilizer(P, e, OnSets) = Subgroup(P, [s[3], s[1]*s[2]]),
              Stabilizer(P, f, OnSetsSets) = Subgroup(P, [s[1], s[2]*s[3]]), Stabilizer(P, cc, AU.OnSSS) = Subgroup(P, s{[1,2]}) ];
  r.diamond := [ Number(f, x -> pos(w) in x), Number(cc, x -> e in x), Number(Ce, x -> f in x) ];
  r.span := RankMat(V); r.face_span := RankMat(List(f, x -> V[x[1]]));
  r.faithful := (r.fvec_geom = r.fvec_coset) and ForAll(r.stab, x -> x) and r.span = 4;
  ## facet: vertex count and geometric regularity (rho_0 candidate)
  F3V := AU.Orbit(S{[1,2]}, w, 8000); r.facet_nV := Length(F3V); r.facet_abstract_nV := Size(Subgroup(P, s{[1,2]}))/Order(s[2]);
  M := List([0..3], k -> w*S[1]^k); Mp := List([0..3], k -> w*S[1]^(-k-1));
  if hyper <> fail then Add(M, hyper); Add(Mp, hyper); fi;
  Rmat := M^-1*Mp;    # the unique linear map acting on the base 2-face as the flag-reversing reflection
  r.R0_orthogonal := (Rmat*TransposedMat(Rmat) = IdentityMat(d));
  VR := Set(List(F3V, x -> x*Rmat));
  r.facet_regular := (VR = Set(F3V)) and ForAll(Set(List(Orbit(Group(s{[1,2]}), e, OnSets), x -> Set(List(x, i -> V[i])))),
                        ed -> Set(List(ed, v -> v*Rmat)) in Set(List(Orbit(Group(s{[1,2]}), e, OnSets), x -> Set(List(x, i -> V[i])))));
  r.R0_in_Gamma := (Rmat = S[1]*S[2]*S[3]);
  r.polytope_regular_candidate_preserves_vertices := (Set(List(V, x -> x*Rmat)) = Set(V));
  ## congruence invariants (scale-free)
  n2 := w*w;
  r.edge_ip := (w*(w*S[1]^-1))/n2;
  r.face_profile := List([1..Int(Order(S[1])/2)], k -> (w*(w*S[1]^k))/n2);
  nb := List(Orbit(Group(s{[2,3]}), pos(w*S[1]^-1), OnPoints), i -> V[i]);
  r.vf_profile := Collected(List(Combinations([1..Length(nb)], 2), pr -> (nb[pr[1]]*nb[pr[2]])/n2));
  gram := [];
  for i in [1..Length(V)] do for j in [i+1..Length(V)] do Add(gram, (V[i]*V[j])/n2); od; od;
  r.gram := Collected(gram);
  r.twist := PX.TwistType(S[1], hyper).pairs;
  return r;
end;

#############################################################################
##  Similarity search: all g (linear, orthogonal up to scale) with V_a g = V_b
##  and g(w_a) = w_b; then test the structure.  Returns list of records.
#############################################################################
AU.Basis4 := function(V, w, hyper)
  local B, v, need;
  B := [ w ]; need := 4; if hyper <> fail then Add(B, hyper); need := 5; fi;
  for v in V do
    if RankMat(Concatenation(B, [v])) > Length(B) then Add(B, v); fi;
    if Length(B) = need then break; fi;
  od;
  return B;
end;
AU.Similarities := function(a, b)
  local hyper, Ba, na, nb, la, lb, gramA, cands, sols, rec4, i, extend, g, imgV, Vb, structOK, res, k;
  hyper := PX.T.(a.T).hyper;
  Ba := AU.Basis4(a.V, a.w, hyper);       # [w_a, (hyper), v2, v3, v4]
  na := a.w*a.w; nb := b.w*b.w;
  ## normalised Gram matrix of the basis of a (all vertices have norm^2 = na)
  gramA := List(Ba, x -> List(Ba, y -> (x*y)/na));
  Vb := b.V;
  sols := [];
  ## images: w_a -> w_b, hyper -> hyper; find images of the remaining basis vectors among V_b
  extend := function(imgs)
    local idx, cand, ok, i, j, Bb, g;
    idx := Length(imgs) + 1;
    if idx > Length(Ba) then
      Bb := imgs;
      g := Ba^-1 * Bb;               # linear map with Ba[i] g = Bb[i]
      Add(sols, g); return;
    fi;
    if hyper <> fail and idx = 2 then extend(Concatenation(imgs, [hyper])); return; fi;
    for cand in Vb do
      ok := true;
      for j in [1..Length(imgs)] do
        if (imgs[j]*cand)/nb <> gramA[j][idx] then ok := false; break; fi;
      od;
      if ok then extend(Concatenation(imgs, [cand])); fi;
    od;
  end;
  extend([ b.w ]);
  res := [];
  for g in sols do
    imgV := Set(List(a.V, v -> v*g));
    if imgV <> Set(Vb) then continue; fi;
    ## structure: edges, faces, cells as vector sets
    structOK := rec(g := g, det := DeterminantMat(g));
    structOK.edges := ( Set(List(a.Ed, ed -> Set(List(ed, i -> a.V[i]*g)))) = Set(List(b.Ed, ed -> Set(List(ed, i -> b.V[i])))) );
    structOK.faces := ( Set(List(a.Fa, fa -> Set(List(fa, ed -> Set(List(ed, i -> a.V[i]*g)))))) = Set(List(b.Fa, fa -> Set(List(fa, ed -> Set(List(ed, i -> b.V[i])))))) );
    structOK.cells := ( Set(List(a.Ce, ce -> Set(List(ce, fa -> Set(List(fa, ed -> Set(List(ed, i -> a.V[i]*g)))))))) = Set(List(b.Ce, ce -> Set(List(ce, fa -> Set(List(fa, ed -> Set(List(ed, i -> b.V[i])))))))) );
    structOK.all := structOK.edges and structOK.faces and structOK.cells;
    Add(res, structOK);
  od;
  return rec(vertex_similarities := Length(res), structure_preserving := Filtered(res, x -> x.all));
end;

#############################################################################
##  Abstract isomorphism (generator-preserving, either orientation) and duality
#############################################################################
AU.GenIso := function(Pa, sa, Pb, sb) local h;
  if Size(Pa) <> Size(Pb) then return false; fi;
  h := GroupHomomorphismByImages(Pa, Pb, sa, sb);
  return h <> fail and IsBijective(h);
end;
AU.Iso := function(a, b)
  return rec(same := AU.GenIso(a.P, a.s, b.P, b.s),
             mirror := AU.GenIso(a.P, a.s, b.P, [ b.s[1]^-1, b.s[1]^2*b.s[2], b.s[3] ]),
             dual := AU.GenIso(a.P, a.s, b.P, [ b.s[3]^-1, b.s[2]^-1, b.s[1]^-1 ]),
             dualmirror := AU.GenIso(a.P, a.s, b.P, [ b.s[3], b.s[3]^-2*b.s[2]^-1, b.s[1]^-1 ]));
end;

#############################################################################
##  Chirality group by the mix (own implementation)
#############################################################################
AU.ChiralityGroup := function(P, s)
  local D, e1, e2, bar, mix, Mix, K, X, p1;
  D := DirectProduct(P, P); e1 := Embedding(D, 1); e2 := Embedding(D, 2); p1 := Projection(D, 1);
  bar := [ s[1]^-1, s[1]^2*s[2], s[3] ];
  mix := List([1..3], i -> Image(e1, s[i])*Image(e2, bar[i]));
  Mix := Subgroup(D, mix);
  K := Intersection(Mix, Image(e1, P));
  X := Image(p1, K);
  return rec(X := X, size := Size(X), structure := StructureDescription(X), mixsize := Size(Mix), index := Size(P)/Size(X),
             consistent := (Size(Mix) = Size(P)*Size(X)), quotient := StructureDescription(P/X));
end;

#############################################################################
##  Run
#############################################################################
Print("\n=== per-realisation data ===\n");
Data := [];
for c in Cand do
  r := AU.Data(c); Add(Data, r);
  Print(r.case, " | T = ", r.T, " | alpha ~ ", r.alpha_f, " | type ", r.orders, " | |Gamma| = ", r.order, " | f_coset ", r.fvec_coset, " f_geom ", r.fvec_geom,
        " | rel ", r.relations, " IP ", r.ip, " | stab ", r.stab, " diamond ", r.diamond, " | span ", r.span, " 2-face span ", r.face_span,
        " | facet nV ", r.facet_nV, "/", r.facet_abstract_nV, " facet regular ", r.facet_regular, " | R0 in Gamma (=S1S2S3) ", r.R0_in_Gamma,
        " | dr ", r.directly_regular, " | edge ip ", r.edge_ip, " ~ ", AU.Float(r.edge_ip), " | twist ", r.twist, "\n");
  AU.CHECK(Concatenation(r.case, ": relations, IP, faithful, diamond, connected data, ord(X)>=3"), r.relations and r.ip and r.faithful and r.diamond = [2,2,2] and r.orders[3] >= 3);
  AU.CHECK(Concatenation(r.case, ": facet has no vertex collapse and is geometrically chiral"), r.facet_nV = r.facet_abstract_nV and r.facet_regular = false);
  AU.CHECK(Concatenation(r.case, ": 2-face vertices span E^4 (Prop. D1 hypothesis) and the flag-reversing isometry of the 2-face is S1 S2 S3 in Gamma"), r.face_span = 4 and r.R0_in_Gamma);
  AU.CHECK(Concatenation(r.case, ": the flag-reversing isometry of the base 2-face does not preserve the vertex set or moves the base cell (so P is not regular)"),
           (not r.polytope_regular_candidate_preserves_vertices) or (AU.OnSSS(r.c, r.s[1]*r.s[2]*r.s[3]) <> r.c));
od;
## canonical extensions coincide with survivors
Print("\n=== canonical extensions vs Level-3 survivors ===\n");
for c in Canon do
  r := AU.Data(c);
  m := Filtered(Data, x -> x.T = c.T and Set(x.V) = Set(r.V) and x.Ed = r.Ed and x.Fa = r.Fa and x.Ce = r.Ce);
  if Length(m) = 0 then
    ## the canonical extension of T^* appears on the circle of T at alpha = 1 (possibly scaled)
    m := Filtered(Data, x -> Length(AU.Similarities(r, x).structure_preserving) > 0);
  fi;
  Print(c.case, ": identical/similar to survivor(s) ", List(m, x -> x.case), "\n");
  AU.CHECK(Concatenation(c.case, ": the canonical extension is one of the 24 Level-3 survivors (up to similarity)"), Length(m) >= 1);
od;

Print("\n=== abstract isomorphism classes (generator-preserving isomorphism, either orientation) ===\n");
cls := [];
for i in [1..Length(Data)] do
  a := Data[i]; a.cls := fail;
  for j in [1..i-1] do
    b := Data[j];
    if a.order = b.order and a.orders = b.orders and a.fvec_coset = b.fvec_coset then
      iso := AU.Iso(a, b);
      if iso.same or iso.mirror then a.cls := b.cls; break; fi;
    fi;
  od;
  if a.cls = fail then Add(cls, a.case); a.cls := Length(cls); fi;
od;
for k in [1..Length(cls)] do
  mem := Filtered(Data, x -> x.cls = k);
  Print("class ", k, ": ", List(mem, x -> Concatenation(x.case, " (alpha~", String(x.alpha_f), ")")), " type ", mem[1].orders, " f ", mem[1].fvec_coset, " |Gamma| ", mem[1].order, " dr ", mem[1].directly_regular, "\n");
  AU.CHECKEQ(Concatenation("class ", String(k), ": number of realisations"), Length(mem), 4);
od;
AU.CHECKEQ("number of abstract isomorphism classes (up to enantiomorphism)", Length(cls), 6);
## class 3 vs class 6 (both {12,3,5}, f = (120,720,300,50))
c3 := Filtered(Data, x -> x.orders = [12,3,5] and x.alpha = 0);   # thesis {12/(1,5),3,5/2} at alpha = 0
c6 := Filtered(Data, x -> x.orders = [12,3,5] and x.alpha = 2);   # class-6 member at alpha = 2
if Length(c3) = 1 and Length(c6) = 1 then
  iso := AU.Iso(c3[1], c6[1]);
  Print("class 3 (alpha=0) vs class 6 (alpha=2): same ", iso.same, " mirror ", iso.mirror, " dual ", iso.dual, " dualmirror ", iso.dualmirror,
        "; groups abstractly isomorphic: ", IsomorphismGroups(c3[1].P, c6[1].P) <> fail, "\n");
  AU.CHECK("classes 3 and 6 are not isomorphic as (oriented or mirrored) polytopes, nor dual", not (iso.same or iso.mirror or iso.dual or iso.dualmirror));
  ## an extra independent invariant: multiset of orders of S1 S3 and S1^-1 S3 over both orientations
  inv := function(x) return Set([ [Order(x.s[1]*x.s[3]), Order(x.s[1]^-1*x.s[3])], [Order(x.s[1]^-1*x.s[3]), Order(x.s[1]*x.s[3])] ]); end;
  Print("   orientation-free invariant {ord(S1S3), ord(S1^-1S3)}: class 3 ", inv(c3[1]), ", class 6 ", inv(c6[1]), "\n");
  AU.CHECK("classes 3 and 6 are separated by the orientation-free order invariant", inv(c3[1]) <> inv(c6[1]));
fi;

Print("\n=== congruence up to enantiomorphism within each abstract class (isometry search) ===\n");
ncong := 0;
for k in [1..Length(cls)] do
  mem := Filtered(Data, x -> x.cls = k);
  reps := [];
  for a in mem do
    placed := false;
    for rp in reps do
      inv_equal := (a.gram = rp.gram and a.edge_ip = rp.edge_ip and a.face_profile = rp.face_profile and a.vf_profile = rp.vf_profile);
      Print("  ", a.case, " vs ", rp.case, ": Gram equal ", a.gram = rp.gram, ", edge ip equal ", a.edge_ip = rp.edge_ip, ", face profile equal ", a.face_profile = rp.face_profile, ", vf profile equal ", a.vf_profile = rp.vf_profile);
      if inv_equal then
        sim := AU.Similarities(a, rp);
        Print("; similarities of vertex sets (w_a -> w_b): ", sim.vertex_similarities, ", structure-preserving: ", Length(sim.structure_preserving),
              " with determinants ", List(sim.structure_preserving, x -> x.det));
        if Length(sim.structure_preserving) > 0 then placed := true; Print("  => CONGRUENT (or mirror-congruent)"); fi;
      else
        Print("; distinguished by a congruence invariant => not congruent, not mirror images");
      fi;
      Print("\n");
      if placed then break; fi;
    od;
    if not placed then Add(reps, a); fi;
  od;
  Print("class ", k, ": ", Length(reps), " congruence classes up to enantiomorphism: ", List(reps, x -> x.case), "\n");
  ncong := ncong + Length(reps);
  AU.CHECKEQ(Concatenation("class ", String(k), ": congruence classes up to enantiomorphism"), Length(reps), 4);
od;
AU.CHECKEQ("total number of realisations up to congruence and enantiomorphism", ncong, 24);
## sanity: the isometry search does find the proper self-similarities (Gamma_b stabiliser of w_b)
a := Data[1]; sim := AU.Similarities(a, a);
Print("self-check: similarities of ", a.case, " with itself fixing w: ", sim.vertex_similarities, ", structure-preserving: ", Length(sim.structure_preserving),
      " (expected |Stab_Gamma(w)| = ", Size(Subgroup(a.P, a.s{[2,3]})), " proper ones, plus improper ones iff the vertex set has extra symmetry)\n");
AU.CHECK("self-check: the search finds at least the vertex stabiliser", Length(sim.structure_preserving) >= Size(Subgroup(a.P, a.s{[2,3]})));

Print("\n=== chirality groups X(P) via the mix, one representative per class ===\n");
for k in [1..Length(cls)] do
  a := First(Data, x -> x.cls = k);
  cg := AU.ChiralityGroup(a.P, a.s);
  Print("class ", k, " (", a.case, "): |X(P)| = ", cg.size, " ", cg.structure, ", [Gamma:X] = ", cg.index, ", Gamma/X = ", cg.quotient, ", |Mix| = ", cg.mixsize, " consistent ", cg.consistent, "\n");
  AU.CHECK(Concatenation("class ", String(k), ": |Mix| = |Gamma| |X|"), cg.consistent);
  AU.CHECK(Concatenation("class ", String(k), ": X(P) trivial iff directly regular"), (cg.size = 1) = a.directly_regular);
  a.cg := cg;
od;
expectedX := [ 2, 120, 120, 1, 8, 120 ];
Print("expected |X(P)| by class (RESULT.md): ", expectedX, "; found: ", List([1..Length(cls)], k -> First(Data, x -> x.cls = k).cg.size), "\n");

Print("\n=== group orders, types, f-vectors versus RESULT.md ===\n");
expected := [ rec(type := [8,3,3], f := [16,32,12,4], g := 192), rec(type := [30,3,3], f := [600,1200,120,5], g := 7200),
              rec(type := [12,3,5], f := [120,720,300,50], g := 7200), rec(type := [12,3,3], f := [240,480,120,20], g := 2880),
              rec(type := [12,3,4], f := [48,144,48,8], g := 1152), rec(type := [12,3,5], f := [120,720,300,50], g := 7200) ];
found := List([1..Length(cls)], k -> First(Data, x -> x.cls = k));
for k in [1..Length(cls)] do
  m := First(expected, ex -> ex.type = found[k].orders and ex.f = found[k].fvec_coset and ex.g = found[k].order);
  AU.CHECK(Concatenation("class ", String(k), ": (type, f-vector, |Gamma|) is one of the six claimed"), m <> fail);
od;

Print("\ncongruence-audit.g: ", AU.npass, " passed, ", AU.nfail, " failed.\n");
if AU.nfail > 0 then Print("FAILED: ", AU.failed, "\n"); fi;
Print("Done: congruence-audit.g\n");
