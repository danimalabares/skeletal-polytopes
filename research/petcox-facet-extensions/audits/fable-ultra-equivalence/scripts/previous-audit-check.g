#############################################################################
##  previous-audit-check.g  --  exact re-verification of the twelve certificate
##  matrices printed by the previous audit (audits/fable-ultra/logs/audit-runs/
##  congruence-certify.log, transcribed into ../logs/previous-audit-certificates.g),
##  and the test the previous audit did not make: whether each of its matrices g
##  lies in the coset (M0/c) Gamma_b of the anti-automorphism realiser M0 of the
##  row (the "rho_1-type half-turn"), which is the mechanism behind the pairing.
##  The previous audit tested only whether g itself is a scalar multiple of that
##  half-turn (false, as expected: g is determined only up to Gamma_b).
##  Data path: PETCOX_DATA (run-all.sh) or the session's extraction.
##  Run from scripts/:  gap -q -A --quitonbreak previous-audit-check.g < /dev/null
#############################################################################
SizeScreen([4096,]);
if IsBound(GAPInfo.SystemEnvironment.PETCOX_DATA) then DATA := GAPInfo.SystemEnvironment.PETCOX_DATA; else DATA := "/private/tmp/claude-501/-Users-daniel-github-skeletal-polytopes/d4b2e626-5fbc-48d1-9c01-c9dc4a79290e/scratchpad/producer/research/petcox-facet-extensions/logs/alpha-survivors.g"; fi;
PX := rec(); Read(DATA);
Read("../logs/previous-audit-certificates.g");
Print("records: ", Length(PX.Saved), "; previous-audit certificates: ", Length(PREV), "\n");
NFAIL := 0; Chk := function(c, m) if c = true then Print("PASS  ", m, "\n"); else NFAIL := NFAIL + 1; Print("FAIL  ", m, "\n"); fi; end;
I4 := IdentityMat(4);
Vec := M -> Concatenation(M);  Mat := v -> List([0..3], i -> v{[4*i+1..4*i+4]});
basis := List([1..16], i -> Mat(IdentityMat(16)[i]));
Rec := c -> First(PX.Saved, r -> r.case = c);
Build := function(r)
  local Gam, V, pos, e, f, c, Ed, Fa, Ce, p, sp, gp;
  Gam := Group(r.S1, r.S2, r.X);
  V := List(Orbit(Gam, r.w, OnPoints), x -> x);  pos := x -> Position(V, x);  p := Order(r.S1);
  sp := List([r.S1,r.S2,r.X], m -> Permutation(m, V, OnPoints));  gp := Group(sp);
  e := Set([pos(r.w), pos(r.w*r.S1^-1)]);
  f := Set(List([0..p-1], k -> Set([pos(r.w*r.S1^k), pos(r.w*r.S1^(k+1))])));
  c := Set(Orbit(Group(sp{[1,2]}), f, OnSetsSets));
  Ed := Set(Orbit(gp, e, OnSets));  Fa := Set(Orbit(gp, f, OnSetsSets));
  Ce := Set(Orbit(gp, c, function(x,g) return Set(List(x, y -> OnSetsSets(y,g))); end));
  return rec(V := V, Ed := Ed, Fa := Fa, Ce := Ce, gp := gp, sp := sp, fv := [Length(V), Length(Ed), Length(Fa), Length(Ce)]);
end;
Vecs := function(P) local vec; vec := e -> Set(List(e, i -> P.V[i]));
  return rec(V := Set(P.V), E := Set(List(P.Ed, vec)), F := Set(List(P.Fa, f -> Set(List(f, vec)))),
             C := Set(List(P.Ce, c -> Set(List(c, f -> Set(List(f, vec))))))); end;
ApplyM := function(st, M) return rec(V := Set(List(st.V, v -> v*M)), E := Set(List(st.E, e -> Set(List(e, v -> v*M)))),
  F := Set(List(st.F, f -> Set(List(f, e -> Set(List(e, v -> v*M)))))),
  C := Set(List(st.C, c -> Set(List(c, f -> Set(List(f, e -> Set(List(e, v -> v*M))))))))); end;
## membership of a matrix in Gamma_b via the faithful permutation action on V_b
InGamma := function(Pb, M) local pl; pl := List(Pb.V, v -> Position(Pb.V, v*M)); if fail in pl then return false; fi; return PermList(pl) in Pb.gp; end;
built := rec(); M0s := rec();
npairs := 0; nmech := 0;
for pr in PREV do
  a := Rec(pr.case_a); b := Rec(pr.case_b);
  Print("\n== previous-audit certificate ", pr.case_a, " -> ", pr.case_b, "  (printed lambda = ", pr.lambda, ", handedness ", pr.handedness, ")\n");
  Chk(a <> fail and b <> fail and a.T = b.T, "both cases exist and lie in the same row");
  g := pr.g;
  lam := (b.w*b.w)/(a.w*a.w);
  Chk(g*TransposedMat(g) = lam*I4, Concatenation("g g^T = lambda I with lambda = |w_b|^2/|w_a|^2 = ", String(lam)));
  Chk(lam = pr.lambda, "printed lambda equals |w_b|^2/|w_a|^2");
  Chk(lam <> 1, "lambda <> 1: the stored coordinate sets are NOT congruent, only similar");
  Chk(DeterminantMat(g) = lam^2, "det g = +lambda^2 (proper similarity)");
  Chk(DeterminantMat(g) = pr.det, "printed det agrees");
  Chk(a.w*g = b.w, "w_a g = w_b");
  if not IsBound(built.(a.case)) then built.(a.case) := Build(a); fi;
  if not IsBound(built.(b.case)) then built.(b.case) := Build(b); fi;
  Pa := built.(a.case); Pb := built.(b.case);
  im := ApplyM(Vecs(Pa), g); sb := Vecs(Pb);
  Chk(im.V = sb.V and im.E = sb.E and im.F = sb.F and im.C = sb.C, "g carries vertices, edges, 2-faces and cells of a onto those of b");
  Chk(ForAll([a.S1, a.S2, a.X], S -> InGamma(Pb, g^-1*S*g)), "g^-1 {S1,S2,X_a} g in Gamma_b");
  ## the anti-automorphism realiser of the row
  if not IsBound(M0s.(a.T)) then
    eqs := List(basis, B -> Concatenation(Vec(B*a.S1 - a.S1^-1*B), Vec(B*a.S2 - a.S2^-1*B)));
    N := NullspaceMat(eqs);
    Chk(Length(N) = 1, Concatenation("row ", a.T, ": the space of matrices inverting S1 and S2 is one-dimensional"));
    M0s.(a.T) := Sum([1..16], i -> N[1][i]*basis[i]);
  fi;
  M0 := M0s.(a.T);
  k := First([1..4], i -> b.w[i] <> 0); c := (a.w*M0)[k]/b.w[k];
  Chk(a.w*M0 = c*b.w, Concatenation("w_a M0 = c w_b with c = ", String(c)));
  H := M0*(1/c);
  Chk(H*TransposedMat(H) = lam*I4 and DeterminantMat(H) = lam^2, "M0/c is a proper similarity with the same lambda");
  gam := H^-1*g;
  mech := InGamma(Pb, gam);
  Chk(mech, "MECHANISM: g = (M0/c) * gamma with gamma in Gamma_b, i.e. the previous audit's certificate lies in the coset of the rho_1-type half-turn M0 (the previous audit tested only g = scalar * M0, which is false)");
  Print("      g is a scalar multiple of M0: ", ForAny([1..4], i -> ForAny([1..4], j -> M0[i][j] <> 0 and g = (g[i][j]/M0[i][j])*M0)), "\n");
  npairs := npairs + 1; if mech then nmech := nmech + 1; fi;
od;
Print("\nprevious-audit certificates re-verified: ", npairs, "; lying in the coset (M0/c) Gamma_b: ", nmech, "\n");
Chk(npairs = 12 and nmech = 12, "all twelve previous-audit certificates are exact proper similarities with lambda <> 1 and all lie in the half-turn coset");
Print("\nFailures: ", NFAIL, "\n");
Print("Done: previous-audit-check.g\n");
if NFAIL > 0 then QUIT_GAP(1); fi;
QUIT_GAP(0);
