SizeScreen([4096,]);
## top-level variables assigned inside the row loop (declared here so that GAP
## emits no "Unbound global variable" syntax warnings)
recs := 0; S1 := 0; S2 := 0; eqs := 0; N := 0; eqs2 := 0; M0 := 0; mu := 0; r0 := 0; fin := 0; v0 := 0; rf := 0; v3 := 0;
rho := 0; A := 0; a11 := 0; a12 := 0; a21 := 0; a22 := 0; Mob := 0; AlphaOf := 0; disc := 0; x := 0; pol := 0; rts := 0;
r := 0; t2 := 0; al2 := 0; partner := 0; i := 0; j := 0; a := 0; b := 0; img := 0; k := 0; c := 0; Pa := 0; Pb := 0; M := 0;
im := 0; sb := 0; lam := 0; T := 0; l := 0; s := 0;
#############################################################################
##  author-check-antiautomorphism.g  --  the audit author's own independent
##  check (written before the delegated Methods 1-4 reported): for each row T
##  compute the unique-up-to-scalar matrix M0 inverting both PETCOX generators
##  (M0 S1 = S1^-1 M0, M0 S2 = S2^-1 M0), its determinant sign, its action on
##  the PETCOX circle, the fixed points (= PETCOX regular alpha), the induced
##  pairing of the 24 stored realisations, and a direct exact verification that
##  M0/c carries the whole realisation a (vertices, edges, 2-faces, cells)
##  onto realisation b.  Data path: environment variable PETCOX_DATA, else the
##  producer extraction used during the audit session.
##  Run:  gap -q -A --quitonbreak author-check-antiautomorphism.g < /dev/null
#############################################################################
if IsBound(GAPInfo.SystemEnvironment.PETCOX_DATA) then datafile := GAPInfo.SystemEnvironment.PETCOX_DATA; else datafile := "/private/tmp/claude-501/-Users-daniel-github-skeletal-polytopes/d4b2e626-5fbc-48d1-9c01-c9dc4a79290e/scratchpad/producer/research/petcox-facet-extensions/logs/alpha-survivors.g"; fi;
Print("data file: ", datafile, "\n");
PX := rec(); Read(datafile);
Print("records: ", Length(PX.Saved), "\n");

I4 := IdentityMat(4);
Vec := M -> Concatenation(M);  Mat := v -> List([0..3], i -> v{[4*i+1..4*i+4]});
basis := List([1..16], i -> Mat(IdentityMat(16)[i]));
Fl := function(x) local n, c, s, k; if x = infinity then return "oo"; fi; if IsRat(x) then return Float(x); fi;
  n := Conductor(x); c := CoeffsCyc(x, n); s := 0.0;
  for k in [1..n] do if c[k] <> 0 then s := s + Float(c[k])*Cos(2*3.14159265358979323846*(k-1)/n); fi; od; return s; end;
Build := function(r)
  local Gam, V, pos, e, f, c, Ed, Fa, Ce, p, gp, sp;
  Gam := Group(r.S1, r.S2, r.X);
  V := List(Orbit(Gam, r.w, OnPoints), x -> x);
  pos := x -> Position(V, x);
  p := Order(r.S1);
  sp := List([r.S1,r.S2,r.X], m -> Permutation(m, V, OnPoints));
  gp := Group(sp);
  e := Set([pos(r.w), pos(r.w*r.S1^-1)]);
  f := Set(List([0..p-1], k -> Set([pos(r.w*r.S1^k), pos(r.w*r.S1^(k+1))])));
  c := Set(Orbit(Group(sp{[1,2]}), f, OnSetsSets));
  Ed := Set(Orbit(gp, e, OnSets));
  Fa := Set(Orbit(gp, f, OnSetsSets));
  Ce := Set(Orbit(gp, c, function(x,g) return Set(List(x, y -> OnSetsSets(y,g))); end));
  return rec(V := V, Ed := Ed, Fa := Fa, Ce := Ce, fv := [Length(V), Length(Ed), Length(Fa), Length(Ce)]);
end;
Vecs := function(P) local vec; vec := e -> Set(List(e, i -> P.V[i]));
  return rec(V := Set(P.V), E := Set(List(P.Ed, vec)), F := Set(List(P.Fa, f -> Set(List(f, vec)))),
             C := Set(List(P.Ce, c -> Set(List(c, f -> Set(List(f, vec))))))); end;
ApplyM := function(st, M) return rec(V := Set(List(st.V, v -> v*M)), E := Set(List(st.E, e -> Set(List(e, v -> v*M)))),
  F := Set(List(st.F, f -> Set(List(f, e -> Set(List(e, v -> v*M)))))),
  C := Set(List(st.C, c -> Set(List(c, f -> Set(List(f, e -> Set(List(e, v -> v*M))))))))); end;
built := rec();
for T in ["{4,3,3}", "{5,3,3}", "{5,3,5/2}", "{3,3,5/2}"] do
  Print("\n########## row ", T, " ##########\n");
  recs := Filtered(PX.Saved, r -> r.T = T);
  S1 := recs[1].S1; S2 := recs[1].S2;
  Print("all records share S1,S2: ", ForAll(recs, r -> r.S1 = S1 and r.S2 = S2), "; |G| = ", Size(Group(S1,S2)), "; -I in G: ", -I4 in Group(S1,S2), "\n");
  eqs := List(basis, B -> Concatenation(Vec(B*S1 - S1^-1*B), Vec(B*S2 - S2^-1*B)));
  N := NullspaceMat(eqs);
  eqs2 := List(basis, B -> Concatenation(Vec(B*S1 - S1*B), Vec(B*S2 - S2*B)));
  Print("dim anti-space = ", Length(N), ", dim commutant = ", Length(NullspaceMat(eqs2)), "\n");
  M0 := Sum([1..16], i -> N[1][i]*basis[i]);
  mu := (M0*TransposedMat(M0))[1][1];
  Print("M0 = ", M0, "\nM0 M0^T = mu I: ", M0*TransposedMat(M0) = mu*I4, "; mu = ", mu, "; det M0 = ", DeterminantMat(M0), " (= +mu^2: ", DeterminantMat(M0) = mu^2, ", = -mu^2: ", DeterminantMat(M0) = -mu^2, "); M0^2 = mu I: ", M0^2 = mu*I4, ", M0^2 = -mu I: ", M0^2 = -mu*I4, "\n");
  # v0, v3 and rho
  r0 := First(recs, r -> r.alpha = 0);
  fin := Filtered(recs, r -> r.ab[1] <> infinity);
  if r0 <> fail then v0 := r0.w; else v0 := (fin[1].w - fin[2].w)/(fin[1].ab[1] - fin[2].ab[1]); fi;
  rf := First(recs, r -> r.ab[1] <> infinity and r.ab[1] <> 0 and not r.alpha in [0,1]);
  v3 := rf.w - rf.ab[1]*v0;
  Print("v0 = ", v0, ", v3 = ", v3, "; consistency w = t v0 + v3 for all records: ", ForAll(recs, r -> (r.ab[1] = infinity and r.w = v0) or r.w = r.ab[1]*v0 + v3), "\n");
  rho := (1/rf.alpha - 1)/rf.ab[1];
  Print("rho = |v0|/|v3| = ", rho, "; rho^2 = |v0|^2/|v3|^2: ", rho^2 = (v0*v0)/(v3*v3), "; alpha = 1/(1+t rho) for all records: ",
        ForAll(recs, r -> (r.ab[1] = infinity and r.alpha = 0) or (1 + r.ab[1]*rho = 0 and r.alpha = infinity) or (1 + r.ab[1]*rho <> 0 and r.alpha = 1/(1 + r.ab[1]*rho))), "\n");
  # action on Pi in basis (v0, v3)
  A := List([v0, v3], v -> SolutionMat([v0, v3], v*M0));
  Print("M0 on Pi in basis (v0,v3): ", A, "; det on Pi = ", DeterminantMat(A), "; trace = ", Trace(A), "\n");
  # Moebius: (t,1) A = (t a11 + a21, t a12 + a22) -> t' = (t a11 + a21)/(t a12 + a22)
  a11 := A[1][1]; a12 := A[1][2]; a21 := A[2][1]; a22 := A[2][2];
  Mob := function(t) if t = infinity then if a12 = 0 then return infinity; else return a11/a12; fi; fi;
    if t*a12 + a22 = 0 then return infinity; fi; return (t*a11 + a21)/(t*a12 + a22); end;
  AlphaOf := function(t) if t = infinity then return 0; fi; if 1 + t*rho = 0 then return infinity; fi; return 1/(1 + t*rho); end;
  # fixed points: a12 t^2 + (a22 - a11) t - a21 = 0
  disc := (a22 - a11)^2 + 4*a12*a21;
  Print("fixed-point quadratic: ", a12, " t^2 + (", a22 - a11, ") t - (", a21, ") = 0; discriminant = ", disc, "\n");
  x := Indeterminate(CF(120), "x");
  pol := a12*x^2 + (a22 - a11)*x - a21;
  rts := RootsOfUPol(CF(120), pol);
  Print("fixed t (exact, in CF(120)): ", rts, "  -> fixed alpha: ", List(rts, AlphaOf), " ~ ", List(rts, t -> Fl(AlphaOf(t))), "\n");
  for r in recs do
    t2 := Mob(r.ab[1]); al2 := AlphaOf(t2);
    partner := Filtered(recs, s -> s.ab[1] = t2);
    Print("  ", r.case, ": t = ", r.ab[1], " (alpha ~ ", Fl(r.alpha), ") -> t' = ", t2, " (alpha' ~ ", Fl(al2), ") partner: ", List(partner, s -> s.case), "\n");
  od;
  # direct structure verification for predicted pairs (a < b)
  for i in [1..Length(recs)] do for j in [1..Length(recs)] do
    a := recs[i]; b := recs[j];
    if Mob(a.ab[1]) = b.ab[1] and i < j then
      img := a.w*M0; k := First([1..4], l -> b.w[l] <> 0); c := img[k]/b.w[k];
      Print("  PAIR ", a.case, " -> ", b.case, ": w_a M0 = c w_b with c = ", c, " exactly: ", img = c*b.w, "\n");
      if not IsBound(built.(a.case)) then built.(a.case) := Build(a); fi;
      if not IsBound(built.(b.case)) then built.(b.case) := Build(b); fi;
      Pa := built.(a.case); Pb := built.(b.case);
      M := M0*(1/c); im := ApplyM(Vecs(Pa), M); sb := Vecs(Pb);
      lam := (M*TransposedMat(M))[1][1];
      Print("     f-vectors ", Pa.fv, " ", Pb.fv, "; M = M0/c: M M^T = lambda I with lambda = ", lam, " (= |w_b|^2/|w_a|^2: ", lam = (b.w*b.w)/(a.w*a.w), "), det M = ", DeterminantMat(M), " (>0: ", DeterminantMat(M) = lam^2, ")\n");
      Print("     structure: V ", im.V = sb.V, " E ", im.E = sb.E, " F ", im.F = sb.F, " C ", im.C = sb.C, "; lambda = 1 (isometry as stored): ", lam = 1, "; lambda ~ ", Fl(lam), "\n");
    fi;
  od; od;
od;
Print("Done: author-check-antiautomorphism.g\n");
QUIT;
