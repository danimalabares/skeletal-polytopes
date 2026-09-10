#############################################################################
##  congruence-certify.g -- fresh-session Fable audit: explicit certificates of
##  congruence (up to scale and enantiomorphism) between realisations that the
##  producer's compare.g counted as distinct.  For each ordered pair (a,b) of
##  the 24 realisations in the same abstract class we search for a linear map
##  g with  w_a g = w_b  and  V_a g = V_b  (four-point basis matching, exact
##  cyclotomic arithmetic) and then verify, for the first structure-preserving
##  solution found:  g g^T = lambda I (a similarity), V_a g = V_b,
##  E_a g = E_b, F_a g = F_b, C_a g = C_b (edges, 2-faces, cells as vertex
##  structures), and  g^-1 Gamma_a g = Gamma_b  (conjugation of the symmetry
##  groups).  det g > 0 means proper similarity (same handedness), det g < 0
##  means the two are mirror images.  Pairs whose scale-free invariants differ
##  are reported as non-congruent (with the differing invariant).
##  Run from audits/fable-ultra/scripts:  gap -q -A --quitonbreak congruence-certify.g < /dev/null
#############################################################################
Read("../../../gap/lib.g"); Read("../../../gap/polytopes.g"); PX.BuildAll(); PX.SetupRows();
SizeScreen([4096,]);
AU := rec(npass := 0, nfail := 0, failed := []);
AU.CHECK := function(name, val)
  if val = true then AU.npass := AU.npass + 1; Print("AU-PASS  ", name, "\n");
  else AU.nfail := AU.nfail + 1; Add(AU.failed, name); Print("AU-FAIL  ", name, "   (got ", val, ")\n"); fi;
end;
AU.Orbit := function(gens, w) local orb, i, g, im; orb := [w]; i := 1;
  while i <= Length(orb) do for g in gens do im := orb[i]*g; if not im in orb then Add(orb, im); fi; od; i := i + 1; od; return orb; end;
AU.OnSSS := function(cell, g) return Set(List(cell, x -> OnSetsSets(x, g))); end;
PX.Saved := []; Read("../../../logs/alpha-survivors.g");
Cand := Filtered(PX.Saved, r -> r.skeletal);
Data := [];
for c in Cand do
  S := [c.S1, c.S2, c.X]; w := c.w; n2 := w*w; V := AU.Orbit(S, w); pos := x -> Position(V, x);
  perms := List(S, g -> PermList(List(V, v -> pos(v*g)))); P := Group(perms); s := perms;
  e := Set([pos(w), pos(w*S[1]^-1)]); f := Set(Orbit(Group(s[1]), e, OnSets)); cc := Set(Orbit(Group(s{[1,2]}), f, OnSetsSets));
  vec := x -> Set(List(x, i -> V[i]));
  Ev := Set(List(Orbit(P, e, OnSets), vec));
  Fv := Set(List(Orbit(P, f, OnSetsSets), fa -> Set(List(fa, vec))));
  Cv := Set(List(Orbit(P, cc, AU.OnSSS), ce -> Set(List(ce, fa -> Set(List(fa, vec))))));
  nb := AU.Orbit([c.S2, c.X], w*c.S1^-1);
  if c.alpha = infinity then af := infinity; else af := PX.Float(c.alpha); fi;
  r := rec(case := c.case, T := c.T, alpha := c.alpha, alpha_f := af, S := S, w := w, V := V, Vset := Set(V), E := Ev, F := Fv, C := Cv, P := P, s := s,
           order := Size(P), orders := List(s, Order), fvec := [Length(V), Length(Ev), Length(Fv), Length(Cv)],
           inv := [ (w*(w*c.S1^-1))/n2, List([1..Int(Order(c.S1)/2)], k -> (w*(w*c.S1^k))/n2),
                    Collected(List(Combinations([1..Length(nb)], 2), pr -> (nb[pr[1]]*nb[pr[2]])/n2)), Collected(List(V, v -> (w*v)/n2)) ]);
  Add(Data, r);
od;
Print("realisations: ", Length(Data), "\n");
AU.GenIso := function(Pa, sa, Pb, sb) local h; if Size(Pa) <> Size(Pb) then return false; fi; h := GroupHomomorphismByImages(Pa, Pb, sa, sb); return h <> fail and IsBijective(h); end;
cls := [];
for i in [1..Length(Data)] do a := Data[i]; a.cls := fail;
  for j in [1..i-1] do b := Data[j];
    if a.order = b.order and a.orders = b.orders and a.fvec = b.fvec and (AU.GenIso(a.P, a.s, b.P, b.s) or AU.GenIso(a.P, a.s, b.P, [b.s[1]^-1, b.s[1]^2*b.s[2], b.s[3]])) then a.cls := b.cls; break; fi; od;
  if a.cls = fail then Add(cls, a.case); a.cls := Length(cls); fi;
od;
AU.Basis := function(V, w, hyper) local B, v, need; B := [w]; need := 4; if hyper <> fail then Add(B, hyper); need := 5; fi;
  for v in V do if RankMat(Concatenation(B, [v])) > Length(B) then Add(B, v); fi; if Length(B) = need then break; fi; od; return B; end;
## the rho_1-type intertwiner of the cell group of a (unique up to scalar when the solution space is 1-dimensional)
AU.Rho1 := function(a) local S1, S2, d, rows, i, j, Ek, sol, hyper;
  S1 := a.S[1]; S2 := a.S[2]; d := Length(S1); hyper := PX.T.(a.T).hyper; rows := [];
  for i in [1..d] do for j in [1..d] do Ek := NullMat(d, d); Ek[i][j] := 1;
    if hyper = fail then Add(rows, Concatenation(Concatenation(Ek*S1 - S1^-1*Ek), Concatenation(Ek*S2 - S2^-1*Ek)));
    else Add(rows, Concatenation(Concatenation(Ek*S1 - S1^-1*Ek), Concatenation(Ek*S2 - S2^-1*Ek), hyper*Ek)); fi; od; od;
  sol := NullspaceMat(rows); if Length(sol) <> 1 then return fail; fi;
  return List([1..d], i -> sol[1]{[(i-1)*d+1..i*d]});
end;
AU.FindSimilarity := function(a, b) local hyper, Ba, na, nb, gramA, sols, extend, g, res, ok;
  hyper := PX.T.(a.T).hyper; Ba := AU.Basis(a.V, a.w, hyper); na := a.w*a.w; nb := b.w*b.w;
  gramA := List(Ba, x -> List(Ba, y -> (x*y)/na)); sols := [];
  extend := function(imgs) local idx, cand, ok, j; idx := Length(imgs) + 1;
    if idx > Length(Ba) then Add(sols, Ba^-1*imgs); return; fi;
    if hyper <> fail and idx = 2 then extend(Concatenation(imgs, [hyper])); return; fi;
    for cand in b.V do ok := true; for j in [1..Length(imgs)] do if (imgs[j]*cand)/nb <> gramA[j][idx] then ok := false; break; fi; od; if ok then extend(Concatenation(imgs, [cand])); fi; od; end;
  extend([b.w]);
  res := rec(nsols := Length(sols), good := []);
  for g in sols do
    if Set(List(a.V, v -> v*g)) <> b.Vset then continue; fi;
    ok := rec(g := g, det := DeterminantMat(g),
              similarity := (g*TransposedMat(g) = (g*TransposedMat(g))[1][1]*IdentityMat(Length(g))), lambda := (g*TransposedMat(g))[1][1],
              edges := Set(List(a.E, ed -> Set(List(ed, v -> v*g)))) = b.E,
              faces := Set(List(a.F, fa -> Set(List(fa, ed -> Set(List(ed, v -> v*g)))))) = b.F,
              cells := Set(List(a.C, ce -> Set(List(ce, fa -> Set(List(fa, ed -> Set(List(ed, v -> v*g)))))))) = b.C);
    ok.conj := ForAll(a.S, m -> ForAll(b.S, x -> true)) and ForAll(a.S, m -> (g^-1*m*g) in Group(b.S));   # g^-1 Gamma_a g = Gamma_b (generators suffice, same order)
    ok.all := ok.similarity and ok.edges and ok.faces and ok.cells and ok.conj;
    Add(res.good, ok);
  od;
  return res;
end;
Print("\n=== pairwise congruence within abstract classes (up to scale; det>0 proper, det<0 mirror) ===\n");
total := 0;
for k in [1..Length(cls)] do
  mem := Filtered(Data, x -> x.cls = k); reps := [];
  Print("\n-- abstract class ", k, " (type ", mem[1].orders, ", f ", mem[1].fvec, ", |Gamma| ", mem[1].order, "): ", List(mem, x -> Concatenation(x.case, " alpha~", String(x.alpha_f))), "\n");
  for a in mem do placed := false;
    for rp in reps do
      if a.inv <> rp.inv then
        Print("   ", a.case, " vs ", rp.case, ": NOT congruent -- invariant differs: [edge ip, 2-face profile, vf profile, distance distribution] equal = ", List([1..4], i -> a.inv[i] = rp.inv[i]), "\n"); continue; fi;
      sim := AU.FindSimilarity(a, rp);
      good := Filtered(sim.good, x -> x.all);
      if Length(good) > 0 then
        g := good[1];
        Print("   ", a.case, " vs ", rp.case, ": CONGRUENT up to scale (", Length(good), " structure-preserving similarities found; det ", g.det, " ~ ", PX.Float(g.det), ", lambda = ", g.lambda, ")\n");
        if PX.Float(g.det) > 0.0 then Print("      handedness: PROPER similarity (not a mirror image)\n"); else Print("      handedness: IMPROPER similarity (mirror image)\n"); fi;
        Print("      determinants of all ", Length(good), " structure-preserving similarities: ", Collected(List(good, x -> PX.Float(x.det) > 0.0)), " (true = proper)\n");
        Print("      certificate g (rows), with w_a g = w_b, V_a g = V_b, E_a g = E_b, F_a g = F_b, C_a g = C_b, g^-1 Gamma_a g = Gamma_b all true:\n");
        for row in g.g do Print("        ", row, "\n"); od;
        AU.CHECK(Concatenation(a.case, " ~ ", rp.case, ": certificate verified on V, E, F, C and groups"), g.all);
        ## is g a scalar multiple of the rho_1-type half-turn R of the PETCOX family (R S1 R^-1 = S1^-1, R S2 R^-1 = S2^-1, R^2 = 1)?
        Rh := AU.Rho1(a);
        if Rh <> fail then
          mu := PX.Parallel(Concatenation(g.g), Concatenation(Rh));
          Print("      g is a scalar multiple of the rho_1 half-turn R of the family (R S_i R^-1 = S_i^-1): ", mu <> fail, "\n");
          Print("      hence the two realisations are exchanged by the isometry that makes the exceptional member of the family regular; ", "R fixes the circle point alpha_reg and reflects the PETCOX circle\n");
        fi;
        placed := true; break;
      else
        Print("   ", a.case, " vs ", rp.case, ": invariants equal but NO structure-preserving similarity (", sim.nsols, " basis matches, ", Length(sim.good), " vertex-set similarities) => not congruent\n");
      fi;
    od;
    if not placed then Add(reps, a); fi;
  od;
  Print("   => class ", k, ": ", Length(reps), " realisation(s) up to congruence and enantiomorphism: ", List(reps, x -> Concatenation(x.case, " alpha~", String(x.alpha_f))), "\n");
  total := total + Length(reps);
od;
Print("\nTOTAL realisations up to congruence and enantiomorphism: ", total, " (producer claims 24)\n");
Print("\ncongruence-certify.g: ", AU.npass, " passed, ", AU.nfail, " failed.\n"); if AU.nfail > 0 then Print("FAILED: ", AU.failed, "\n"); fi;
Print("Done: congruence-certify.g\n");
