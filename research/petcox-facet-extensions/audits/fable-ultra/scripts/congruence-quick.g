#############################################################################
##  congruence-quick.g -- fresh-session Fable audit: lighter companion of
##  congruence-audit.g.  Decides congruence-up-to-enantiomorphism of the 24
##  realisations using O(n) scale-free invariants (edge inner product, 2-face
##  profile, vertex-figure profile, and the multiset of inner products of the
##  base vertex with all vertices -- a congruence invariant because Gamma is
##  vertex-transitive) and an explicit similarity search (four-point basis
##  matching, base vertex to base vertex) whenever the invariants coincide.
##  Abstract classes by generator-preserving isomorphism (both orientations).
##  Run from audits/fable-ultra/scripts:  gap -q -A --quitonbreak congruence-quick.g < /dev/null
#############################################################################
Read("../../../gap/lib.g"); Read("../../../gap/polytopes.g"); PX.BuildAll(); PX.SetupRows();
SizeScreen([4096,]);
AU := rec(npass := 0, nfail := 0, failed := []);
AU.CHECK := function(name, val)
  if val = true then AU.npass := AU.npass + 1; Print("AU-PASS  ", name, "\n");
  else AU.nfail := AU.nfail + 1; Add(AU.failed, name); Print("AU-FAIL  ", name, "   (got ", val, ")\n"); fi;
end;
AU.CHECKEQ := function(name, a, b)
  if a = b then AU.npass := AU.npass + 1; Print("AU-PASS  ", name, " = ", b, "\n");
  else AU.nfail := AU.nfail + 1; Add(AU.failed, name); Print("AU-FAIL  ", name, "   (expected ", b, ", got ", a, ")\n"); fi;
end;
AU.Orbit := function(gens, w, cap) local orb, i, g, im;
  orb := [ w ]; i := 1;
  while i <= Length(orb) do for g in gens do im := orb[i]*g; if not im in orb then if Length(orb) >= cap then return fail; fi; Add(orb, im); fi; od; i := i + 1; od;
  return orb;
end;
PX.Saved := []; Read("../../../logs/alpha-survivors.g");
Cand := Filtered(PX.Saved, r -> r.skeletal);
Print("survivors: ", Length(Cand), "\n");
Data := [];
for c in Cand do
  S := [c.S1, c.S2, c.X]; w := c.w; n2 := w*w;
  V := AU.Orbit(S, w, 8000);
  pos := x -> Position(V, x);
  perms := List(S, g -> PermList(List(V, v -> pos(v*g)))); P := Group(perms); s := perms;
  hom := GroupHomomorphismByImages(P, P, s, [s[1]^-1, s[1]^2*s[2], s[3]]);
  nb := AU.Orbit([c.S2, c.X], w*c.S1^-1, 500);
  if c.alpha = infinity then af := infinity; else af := PX.Float(c.alpha); fi;
  r := rec(case := c.case, T := c.T, alpha := c.alpha, alpha_f := af, S := S, w := w, V := V, P := P, s := s,
           order := Size(P), orders := List(s, Order), dr := (hom <> fail and IsBijective(hom)),
           fvec := [ Index(P, Subgroup(P, s{[2,3]})), Index(P, Subgroup(P, [s[3], s[1]*s[2]])), Index(P, Subgroup(P, [s[1], s[2]*s[3]])), Index(P, Subgroup(P, s{[1,2]})) ],
           edge_ip := (w*(w*c.S1^-1))/n2,
           face_profile := List([1..Int(Order(c.S1)/2)], k -> (w*(w*c.S1^k))/n2),
           vf_profile := Collected(List(Combinations([1..Length(nb)], 2), pr -> (nb[pr[1]]*nb[pr[2]])/n2)),
           dist := Collected(List(V, v -> (w*v)/n2)));
  r.inv := [r.edge_ip, r.face_profile, r.vf_profile, r.dist];
  Add(Data, r);
  Print(r.case, " | alpha~", r.alpha_f, " | type ", r.orders, " |Gamma| ", r.order, " f ", r.fvec, " dr ", r.dr, " | edge ip ", r.edge_ip, " ~ ", PX.Float(r.edge_ip), " | #dist ", Length(r.dist), "\n");
od;
## abstract classes
AU.GenIso := function(Pa, sa, Pb, sb) local h; if Size(Pa) <> Size(Pb) then return false; fi; h := GroupHomomorphismByImages(Pa, Pb, sa, sb); return h <> fail and IsBijective(h); end;
cls := [];
for i in [1..Length(Data)] do
  a := Data[i]; a.cls := fail;
  for j in [1..i-1] do b := Data[j];
    if a.order = b.order and a.orders = b.orders and a.fvec = b.fvec and (AU.GenIso(a.P, a.s, b.P, b.s) or AU.GenIso(a.P, a.s, b.P, [b.s[1]^-1, b.s[1]^2*b.s[2], b.s[3]])) then a.cls := b.cls; break; fi;
  od;
  if a.cls = fail then Add(cls, a.case); a.cls := Length(cls); fi;
od;
Print("\n=== abstract classes ===\n");
for k in [1..Length(cls)] do mem := Filtered(Data, x -> x.cls = k);
  Print("class ", k, ": ", List(mem, x -> Concatenation(x.case, "(", String(x.alpha_f), ")")), " type ", mem[1].orders, " f ", mem[1].fvec, " |Gamma| ", mem[1].order, " dr ", mem[1].dr, "\n");
  AU.CHECKEQ(Concatenation("class ", String(k), " size"), Length(mem), 4); od;
AU.CHECKEQ("number of abstract classes", Length(cls), 6);
c3 := First(Data, x -> x.orders = [12,3,5] and x.alpha = 0); c6 := First(Data, x -> x.orders = [12,3,5] and x.alpha = 2);
AU.CHECK("class of alpha=0 (thesis) and class of alpha=2 differ (classes 3 and 6 non-isomorphic)", c3.cls <> c6.cls);
Print("groups of classes 3 and 6 abstractly isomorphic: ", IsomorphismGroups(c3.P, c6.P) <> fail, "\n");
## similarity search
AU.Basis := function(V, w, hyper) local B, v, need; B := [w]; need := 4; if hyper <> fail then Add(B, hyper); need := 5; fi;
  for v in V do if RankMat(Concatenation(B, [v])) > Length(B) then Add(B, v); fi; if Length(B) = need then break; fi; od; return B; end;
AU.Similarities := function(a, b) local hyper, Ba, na, nb, gramA, sols, extend, res, g, imgV, Va, Vb, Ea, Eb, ok;
  hyper := PX.T.(a.T).hyper; Ba := AU.Basis(a.V, a.w, hyper); na := a.w*a.w; nb := b.w*b.w;
  gramA := List(Ba, x -> List(Ba, y -> (x*y)/na)); sols := [];
  extend := function(imgs) local idx, cand, ok, j;
    idx := Length(imgs) + 1;
    if idx > Length(Ba) then Add(sols, Ba^-1*imgs); return; fi;
    if hyper <> fail and idx = 2 then extend(Concatenation(imgs, [hyper])); return; fi;
    for cand in b.V do ok := true;
      for j in [1..Length(imgs)] do if (imgs[j]*cand)/nb <> gramA[j][idx] then ok := false; break; fi; od;
      if ok then extend(Concatenation(imgs, [cand])); fi; od;
  end;
  extend([b.w]);
  Va := Set(a.V); Vb := Set(b.V); res := [];
  Ea := Set(List(Orbit(Group(a.S), Set([a.w, a.w*a.S[1]^-1]), OnSets)));   # edges as vertex pairs
  Eb := Set(List(Orbit(Group(b.S), Set([b.w, b.w*b.S[1]^-1]), OnSets)));
  for g in sols do
    if Set(List(a.V, v -> v*g)) <> Vb then continue; fi;
    ok := rec(g := g, det := DeterminantMat(g), edges := (Set(List(Ea, e -> Set(List(e, v -> v*g)))) = Eb));
    if ok.edges then
      ## 2-faces as sets of vertex sets (edges) and cells as sets of faces
      Fa := Set(List(Orbit(Group(a.S), Set(List(Orbit(Group(a.S[1]), Set([a.w, a.w*a.S[1]^-1]), OnSets))), OnSetsSets)));
      Fb := Set(List(Orbit(Group(b.S), Set(List(Orbit(Group(b.S[1]), Set([b.w, b.w*b.S[1]^-1]), OnSets))), OnSetsSets)));
      ok.faces := (Set(List(Fa, f -> Set(List(f, e -> Set(List(e, v -> v*g)))))) = Fb);
    else ok.faces := false; fi;
    Add(res, ok);
  od;
  return rec(vertex_similarities := Length(sols), vertex_set_similarities := Length(res), edge_preserving := Filtered(res, x -> x.edges), face_preserving := Filtered(res, x -> x.faces));
end;
Print("\n=== congruence up to enantiomorphism within each abstract class ===\n");
ncong := 0;
for k in [1..Length(cls)] do
  mem := Filtered(Data, x -> x.cls = k); reps := [];
  for a in mem do placed := false;
    for rp in reps do
      Print("  ", a.case, " vs ", rp.case, ": invariants (edge ip, face profile, vf profile, distance distribution) equal: ", List([1..4], i -> a.inv[i] = rp.inv[i]));
      if a.inv = rp.inv then
        sim := AU.Similarities(a, rp);
        Print("; similarities w_a->w_b: ", sim.vertex_similarities, ", mapping V_a onto V_b: ", sim.vertex_set_similarities, ", edge-preserving: ", Length(sim.edge_preserving), ", face-preserving: ", Length(sim.face_preserving), " dets ", List(sim.face_preserving, x -> x.det));
        if Length(sim.face_preserving) > 0 then placed := true; Print("  => CONGRUENT or mirror-congruent"); else Print("  => NOT congruent (exhaustive isometry search)"); fi;
      else Print("  => not congruent (invariant differs)"); fi;
      Print("\n"); if placed then break; fi;
    od;
    if not placed then Add(reps, a); fi;
  od;
  Print("class ", k, ": ", Length(reps), " congruence classes up to enantiomorphism\n"); ncong := ncong + Length(reps);
  AU.CHECKEQ(Concatenation("class ", String(k), ": congruence classes up to enantiomorphism"), Length(reps), 4);
od;
AU.CHECKEQ("total realisations up to congruence and enantiomorphism", ncong, 24);
## self-checks of the search: a realisation vs itself, and Roli's cube vs its own mirror image (must be found)
a := First(Data, x -> x.orders = [8,3,3] and x.alpha = 0);
sim := AU.Similarities(a, a); Print("self-check ", a.case, " vs itself: face-preserving similarities ", Length(sim.face_preserving), " (expected >= |Stab(w)| = ", Size(Subgroup(a.P, a.s{[2,3]})), ")\n");
AU.CHECK("self-check: search finds the vertex stabiliser", Length(sim.face_preserving) >= Size(Subgroup(a.P, a.s{[2,3]})));
R0 := PX.T.("{4,3,3}").R[1]; m := rec(case := "mirror(Roli)", T := a.T, S := List(a.S, g -> R0*g*R0), w := a.w*R0, V := List(a.V, v -> v*R0));
sim := AU.Similarities(a, m); Print("self-check Roli vs its mirror image: face-preserving similarities ", Length(sim.face_preserving), ", dets ", Collected(List(sim.face_preserving, x -> x.det)), "\n");
AU.CHECK("self-check: search finds the mirror congruence (det -1)", ForAny(sim.face_preserving, x -> x.det = -1));
Print("\ncongruence-quick.g: ", AU.npass, " passed, ", AU.nfail, " failed.\n"); if AU.nfail > 0 then Print("FAILED: ", AU.failed, "\n"); fi;
Print("Done: congruence-quick.g\n");
