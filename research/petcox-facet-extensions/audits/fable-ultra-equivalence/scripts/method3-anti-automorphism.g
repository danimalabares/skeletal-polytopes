#############################################################################
##
##  method3-anti-automorphism.g
##
##  METHOD 3 of the hostile equivalence audit of the PETCOX facet-extension
##  classification (git commit 71ef1cd, file logs/alpha-survivors.g): the
##  structural explanation of similarities between the 24 stored realisations
##  through the (unique up to scalar) isometry M0 that INVERTS both PETCOX
##  generators S1, S2 of a row.
##
##  Run with
##     gap -q -A --quitonbreak method3-anti-automorphism.g < /dev/null
##  (in the audit shell "gap" is an alias for "git apply"; use the full path
##  /private/var/tmp/sage-10.7-current/local/bin/gap).  The script prints
##  "Done: method3-anti-automorphism.g" as its last line and exits with a
##  non-zero status if any self-check fails.  It writes logs/method3-pairing.tsv.
##
##  All decisions are made in exact arithmetic (GAP cyclotomics); floating
##  point numbers appear for display only.  No producer code is loaded: the
##  orbit / incidence code below is written from scratch.
##
##  CONVENTIONS (from the task statement).  Matrices act on row vectors from
##  the right, v*M; the product A*B means "A first, then B".  For a record with
##  data (S1, S2, X, w):  Gamma = <S1,S2,X>,  G = <S1,S2>,
##      vertices  V = w*Gamma,
##      base edge e = {w, w*S1^-1},
##      base 2-face f = the p-cycle (w*S1^k)_{k=0..p-1}, p = Order(S1),
##                      stored as its set of p edges {w S1^k, w S1^(k+1)},
##      base cell  c = f*G  (a set of faces),
##  and the edge / 2-face / cell sets of the polytope are the Gamma-orbits of
##  e, f, c.  A realisation is the 4-tuple (V, E, F, C) of these SETS; a linear
##  map N is an equivalence of realisation a onto realisation b iff it carries
##  V_a onto V_b, E_a onto E_b, F_a onto F_b and C_a onto C_b.
##
##  THE THEOREM BEHIND METHOD 3 (see also the comments at step 6 below).
##  Let a, b be two stored realisations of the same row (same S1, S2, hence
##  same G = <S1,S2>), and let n be a similarity of E^4 with P_a n = P_b.
##  (i)  n maps cells to cells.  Composing with an element of Gamma_b we may
##       assume that the base cell c_a = H_{w_a} (the Wythoff polyhedron of G
##       at w_a) is mapped onto the base cell c_b = H_{w_b}.
##  (ii) The isometry group of a cell H_w is exactly G (verified in step 6 for
##       every stored w: the only candidate for an extra symmetry is the
##       reversing map R, which does not preserve the edge set).  Hence
##       n^-1 G n = G, i.e. n normalises G.
##  (iii) G acts freely on the 2|G| flags of H_{w_b} with two orbits, the orbit
##       of the base flag Phi_b and the orbit of its 2-adjacent flag Phi_b^2
##       (verified in step 6).  Composing n with an element of G we may assume
##       Phi_a n = Phi_b  or  Phi_a n = Phi_b^2.
##  (iv) In the first case n^-1 S1 n and S1 both map Phi_b to Phi_b^{10}, and
##       n^-1 S2 n and S2 both map Phi_b to Phi_b^{21}; freeness gives
##       n^-1 S1 n = S1, n^-1 S2 n = S2, so n lies in the commutant of G, which
##       is 1-dimensional (step 1): n = lambda*I.  Then w_b = lambda*w_a forces
##       t_a = t_b, i.e. a = b.
##  (v)  In the second case the distinguished generators of Phi_b^2 are
##       (S2^-1 S1^-1 S2, S2^-1) (verified in step 6), so n^-1 S1 n =
##       S2^-1 S1^-1 S2 and n^-1 S2 n = S2^-1, whence (S2 n)^-1 S1 (S2 n) =
##       S1^-1 and (S2 n)^-1 S2 (S2 n) = S2^-1: S2 n lies in the 1-dimensional
##       anti-space (step 2), S2 n = lambda*M0.  Since w_a S2 = w_a we get
##       w_a n = lambda * w_a M0 = w_b.
##  Hence: a and b are similar  <=>  w_a M0 is a nonzero multiple of w_b
##                              <=>  t_b = Moebius(t_a)   (steps 4, 5).
##  The converse direction is verified directly for every predicted pair by
##  transporting the complete realisation (V,E,F,C) with the map M0/s.
##
#############################################################################

SizeScreen([4096,]);   # no line wrapping in the transcript / TSV

## Paths: PETCOX_DATA from the environment when set (run-all.sh), else the session's extraction;
## the TSV goes to ../logs relative to scripts/.  (Audit author's edits after delivery: these path
## lines, and the rename of the variable Phi -> PhiW because Phi is a read-only GAP built-in.)
if IsBound(GAPInfo.SystemEnvironment.PETCOX_DATA) then DATA := GAPInfo.SystemEnvironment.PETCOX_DATA; else DATA := "/private/tmp/claude-501/-Users-daniel-github-skeletal-polytopes/d4b2e626-5fbc-48d1-9c01-c9dc4a79290e/scratchpad/producer/research/petcox-facet-extensions/logs/alpha-survivors.g"; fi;
TSV  := "../logs/method3-pairing.tsv";

Print("method3-anti-automorphism.g  --  GAP ", GAPInfo.Version, "\n");
Print("DATA = ", DATA, "\n");

PX := rec();
Read(DATA);
Print("records loaded: ", Length(PX.Saved), "\n");

#############################################################################
##  self-check bookkeeping
#############################################################################
NFAIL := 0;
Check := function(cond, msg)
  if cond = true then
    Print("  [ok]   ", msg, "\n");
  else
    Print("  [FAIL] ", msg, "\n");
    NFAIL := NFAIL + 1;
  fi;
end;

#############################################################################
##  exact helpers
#############################################################################
x := Indeterminate(Cyclotomics, "x");
Id4 := IdentityMat(4);

# float value of a real cyclotomic (display only; this GAP build has no Float method for irrational cyclotomics)
CycFloat := function(z)
  local n, co, re, im, k;
  if z = infinity then return infinity; fi;
  if IsRat(z) then return Float(z); fi;
  n := Conductor(z); co := CoeffsCyc(z, n); re := 0.0; im := 0.0;
  for k in [1..n] do
    if co[k] <> 0 then
      re := re + Float(co[k])*Cos(2*FLOAT.PI*(k-1)/n);
      im := im + Float(co[k])*Sin(2*FLOAT.PI*(k-1)/n);
    fi;
  od;
  if AbsoluteValue(im) > 1.0e-9 then Error("CycFloat: argument is not real"); fi;
  return re;
end;

# exact positive square root of a positive real cyclotomic c, or fail.
#  (a) c rational: GAP's Sqrt (exact cyclotomic).
#  (b) c in a real quadratic field with two Galois conjugates c, c' and rational-square norm:
#      with p = (c+c')/2, r = sqrt(c c') rational, sqrt(c) = sqrt((p+r)/2) +- sqrt((p-r)/2), both radicands rational.
#  (c) otherwise a bounded search over cyclotomic fields CF(N), N <= 120, with RootsOfUPol.
#  Every returned value is verified by squaring.
CycSqrt := function(c)
  local n, k, N, rts, r, cj, p, nrm, s1, s2, cand;
  if CycFloat(c) <= 0.0 then Error("CycSqrt: argument not positive"); fi;
  if IsRat(c) then r := Sqrt(c); if r^2 = c then return r; else return fail; fi; fi;
  n := Conductor(c);
  cj := Set(List(PrimeResidues(n), k -> GaloisCyc(c, k)));
  if Length(cj) = 2 then
    p := (cj[1]+cj[2])/2; nrm := cj[1]*cj[2];
    if IsRat(p) and IsRat(nrm) and nrm > 0 and Sqrt(nrm)^2 = nrm then
      r := Sqrt(nrm); s1 := Sqrt((p+r)/2); s2 := Sqrt((p-r)/2);
      for cand in [s1+s2, s1-s2] do
        if cand^2 = c then
          if CycFloat(cand) > 0.0 then return cand; else return -cand; fi;
        fi;
      od;
    fi;
  fi;
  for k in [1,3,4,5,8,12,15,20,24,40,60,120] do
    N := Lcm(n,k);
    if N <= 120 then
      rts := RootsOfUPol(CF(N), x^2-c);
      if rts <> [] then
        r := First(rts, y -> CycFloat(y) > 0.0);
        if r^2 <> c then Error("CycSqrt: bad root"); fi;
        return r;
      fi;
    fi;
  od;
  return fail;
end;

FStr := function(z)     # short float string for display
  if z = infinity then return "infinity"; fi;
  return String(CycFloat(z));
end;
XStr := function(z)     # exact string
  if z = infinity then return "infinity"; fi;
  return String(z);
end;

Vec := M -> Concatenation(M);          # 4x4 matrix -> row vector of length 16 (row major)
UnVec := v -> List([1..4], i -> v{[4*i-3..4*i]});
ElemMats := function()
  local L, i, j, E;
  L := [];
  for i in [1..4] do for j in [1..4] do E := NullMat(4,4); E[i][j] := 1; Add(L, E); od; od;
  return L;
end;
Es := ElemMats();

# variables assigned inside the loops below and referenced inside function bodies; pre-declared so that GAP
# emits no parse-time "Unbound global variable" warnings (they are re-assigned before use)
S1 := 0; S2 := 0; p := 0; G := 0; M0 := 0; M0inv := 0; mu := 0; rho := 0; Pi := 0; a := 0; b := 0; c := 0; d := 0;
Pm := 0; Qm := 0; Rm := 0; Sm := 0; tp := 0; afix := 0; tfix := 0; Hw := 0; Hfix := 0; recs := 0; idx := 0; rr := 0;
v0 := 0; v3 := 0; sd := 0; disc := 0; normalised := false; Moeb := 0; AlphaOf := 0; TOf := 0; MoebAlpha := 0;
nfe := 0; ii := 0; wb := 0; T := 0; r := 0; REAL := []; FINV := []; CLASSES := []; PAIRS := []; ROWSUMMARY := []; PETCOX := rec();

# dimension and basis of {M : M*A_i = B_i*M for all i} as 4x4 matrices
LinearSolutionSpace := function(pairs)
  local A, ns;
  A := List(Es, E -> Concatenation(List(pairs, pr -> Vec(E*pr[1] - pr[2]*E))));
  ns := NullspaceMat(A);
  return List(ns, UnVec);
end;

#############################################################################
##  own orbit / incidence code (index based)
#############################################################################
VertexOrbit := function(gens, w)        # sorted list of the orbit of the row vector w
  local orb, queue, i, g, v;
  orb := [w]; queue := [w]; i := 0;
  while i < Length(queue) do
    i := i + 1;
    for g in gens do
      v := queue[i]*g;
      if not v in orb then AddSet(orb, v); Add(queue, v); fi;
    od;
  od;
  return orb;
end;
PermOnList := function(V, g)            # permutation of [1..|V|] induced by v -> v*g, or fail
  local L;
  L := List(V, v -> Position(V, v*g));
  if fail in L then return fail; fi;
  return PermList(L);
end;
CellAct := function(c, g) return Set(List(c, f -> OnSetsSets(f, g))); end;
FlagAct := function(fl, g) return [fl[1]^g, OnSets(fl[2], g), OnSetsSets(fl[3], g)]; end;

# Wythoff polyhedron H_u of G = <S1,S2> at base vertex u  (indices refer to H.V)
Polyhedron := function(S1, S2, u)
  local H, p;
  H := rec();
  H.V := VertexOrbit([S1,S2], u);
  H.p1 := PermOnList(H.V, S1); H.p2 := PermOnList(H.V, S2);
  H.Gp := Group(H.p1, H.p2);
  p := Order(S1); H.p := p;
  H.v := Position(H.V, u);
  H.e := Set([Position(H.V, u), Position(H.V, u*S1^-1)]);
  H.f := Set(List([0..p-1], k -> Set([Position(H.V, u*S1^k), Position(H.V, u*S1^(k+1))])));
  H.E := Set(Orbit(H.Gp, H.e, OnSets));
  H.F := Set(Orbit(H.Gp, H.f, OnSetsSets));
  return H;
end;

# complete realisation (V,E,F,C) of a record
Realisation := function(S1, S2, X, w)
  local R, p, Gc;
  R := rec();
  R.V := VertexOrbit([S1,S2,X], w);
  R.p1 := PermOnList(R.V, S1); R.p2 := PermOnList(R.V, S2); R.pX := PermOnList(R.V, X);
  R.Gp := Group(R.p1, R.p2, R.pX); Gc := Group(R.p1, R.p2);
  p := Order(S1); R.p := p;
  R.e := Set([Position(R.V, w), Position(R.V, w*S1^-1)]);
  R.f := Set(List([0..p-1], k -> Set([Position(R.V, w*S1^k), Position(R.V, w*S1^(k+1))])));
  R.c := Set(Orbit(Gc, R.f, OnSetsSets));
  R.E := Set(Orbit(R.Gp, R.e, OnSets));
  R.F := Set(Orbit(R.Gp, R.f, OnSetsSets));
  R.C := Set(Orbit(R.Gp, R.c, CellAct));
  R.fvec := [Length(R.V), Length(R.E), Length(R.F), Length(R.C)];
  return R;
end;

# does the linear map N carry structure P onto structure Q (both index based)?  returns rec(V,E,F[,C]) of booleans
MapsOnto := function(P, Q, N)
  local phi, res, img;
  phi := List(P.V, v -> Position(Q.V, v*N));
  res := rec();
  res.V := (not fail in phi) and Length(Set(phi)) = Length(Q.V) and Length(P.V) = Length(Q.V);
  if not res.V then
    res.E := false; res.F := false; if IsBound(P.C) then res.C := false; fi;
    return res;
  fi;
  img := e -> Set(phi{e});
  res.E := Set(List(P.E, img)) = Q.E;
  res.F := Set(List(P.F, f -> Set(List(f, img)))) = Q.F;
  if IsBound(P.C) then
    res.C := Set(List(P.C, c -> Set(List(c, f -> Set(List(f, img)))))) = Q.C;
  fi;
  return res;
end;
AllTrue := res -> ForAll(RecNames(res), nm -> res.(nm) = true);
ResStr := function(res)
  local s, nm;
  s := "";
  for nm in ["V","E","F","C"] do
    if IsBound(res.(nm)) then Append(s, Concatenation(nm, "=", String(res.(nm)), " ")); fi;
  od;
  return s;
end;

# flag adjacency inside a polyhedron H (flags are [vertex index, edge, face])
Adj0 := function(H, fl) return [Difference(fl[2], [fl[1]])[1], fl[2], fl[3]]; end;
Adj1 := function(H, fl) return [fl[1], First(fl[3], e -> fl[1] in e and e <> fl[2]), fl[3]]; end;
Adj2 := function(H, fl) return [fl[1], fl[2], First(H.F, f -> fl[2] in f and f <> fl[3])]; end;

#############################################################################
##  expected data
#############################################################################
ROWS := ["{4,3,3}", "{5,3,3}", "{5,3,5/2}", "{3,3,5/2}"];
PETCOX := rec();          # geometrically regular alpha values, PETCOX Section 4 / producer census (5 significant digits)
PETCOX.("{4,3,3}")   := [0.26795, 3.73205];
PETCOX.("{5,3,3}")   := [0.15327, 19.1653];
PETCOX.("{5,3,5/2}") := [0.075375, 2.26627];
PETCOX.("{3,3,5/2}") := [0.26580, 1.90082];
PETCOXexact := rec();
PETCOXexact.("{4,3,3}") := [2-ER(3), 2+ER(3)];

CaseNumber := function(cs)   # "L3-{5,3,5/2}-12" -> 12
  local parts;
  parts := SplitString(cs, "-");
  return Int(parts[Length(parts)]);
end;
ExpectedFvec := function(T, k)
  if T = "{4,3,3}" then return [16,32,12,4]; fi;
  if T = "{5,3,3}" or T = "{3,3,5/2}" then return [600,1200,120,5]; fi;
  if T = "{5,3,5/2}" then
    if k >= 9 then return [120,720,300,50]; fi;
    if k <= 4 then return [240,480,120,20]; fi;
    return [48,144,48,8];
  fi;
  return fail;
end;
RelClose := function(fl, target)   # |fl - target| <= 2e-4 * |target|
  return AbsoluteValue(fl - target) <= 2.0e-4 * AbsoluteValue(target);
end;

#############################################################################
##  Step 0: realisations and f-vectors of all 24 records
#############################################################################
Print("\n==================== STEP 0: realisations and f-vectors ====================\n");
REAL := [];
for i in [1..Length(PX.Saved)] do
  r := PX.Saved[i];
  Check(r.ab[2] = 1, Concatenation(r.case, ": ab[2] = 1 (t = ab[1])"));
  Check(r.S1*TransposedMat(r.S1) = Id4 and r.S2*TransposedMat(r.S2) = Id4 and r.X*TransposedMat(r.X) = Id4,
        Concatenation(r.case, ": S1, S2, X orthogonal"));
  REAL[i] := Realisation(r.S1, r.S2, r.X, r.w);
  Print("  ", r.case, "  |Gamma|=", Size(Group(r.S1,r.S2,r.X)), " |G|=", Size(Group(r.S1,r.S2)),
        "  f-vector ", REAL[i].fvec, "  |w|^2=", r.w*r.w, "\n");
  Check(REAL[i].fvec = ExpectedFvec(r.T, CaseNumber(r.case)), Concatenation(r.case, ": f-vector = expected ", String(ExpectedFvec(r.T, CaseNumber(r.case)))));
  Check(Size(REAL[i].Gp) = Size(Group(r.S1,r.S2,r.X)), Concatenation(r.case, ": Gamma acts faithfully on V"));
  Check(Length(Set(Concatenation(REAL[i].f))) = REAL[i].p, Concatenation(r.case, ": base 2-face has p=", String(REAL[i].p), " distinct vertices"));
  nfe := Number(REAL[i].F, f -> REAL[i].e in f);
  Check(nfe >= 2 and ForAll(REAL[i].E, e -> Number(REAL[i].F, f -> e in f) = nfe),
        Concatenation(r.case, ": every edge lies in the same number (", String(nfe), ") of 2-faces, at least 2"));
  Check(ForAll(REAL[i].F, f -> Number(REAL[i].C, c -> f in c) = 2), Concatenation(r.case, ": every 2-face lies in exactly 2 cells"));
od;

# similarity invariant of the base 2-face: normalised squared diagonals |w - w S1^k|^2 / |w|^2, k = 1..p/2
FaceInvariant := function(r)
  local p;
  p := Order(r.S1);
  return List([1..Int(p/2)], k -> ((r.w - r.w*r.S1^k)*(r.w - r.w*r.S1^k))/(r.w*r.w));
end;
FINV := List(PX.Saved, FaceInvariant);

#############################################################################
##  Steps 1-6 per row
#############################################################################
PrintTo(TSV, "kind\tT\tdim_commutant\tdim_anti_space\tdet_sign_M0\tM0_squared\taction_on_Pi\tmu_raw\tsqrt_mu\tMoebius_t\tMoebius_alpha\tfixed_alpha_exact\tfixed_alpha_float\tPETCOX_values\tagreement\n");
AppendTo(TSV, "kind\tT\tcase\tt\talpha\timage_t\timage_alpha\tpaired_case\tscalar_s\tlambda\tdet_sign_similarity\tstructure_map_verified\tM0invXM0_in_Gamma_paired\n");

PAIRS := [];        # [caseA, caseB]
CLASSES := [];      # predicted similarity classes (lists of case names)
ROWSUMMARY := [];

for T in ROWS do
  Print("\n\n############################################################################\n");
  Print("##  ROW ", T, "\n############################################################################\n");
  idx := Filtered([1..Length(PX.Saved)], i -> PX.Saved[i].T = T);
  recs := PX.Saved{idx};
  Print("records: ", List(recs, r -> r.case), "\n");
  S1 := recs[1].S1; S2 := recs[1].S2;
  Check(ForAll(recs, r -> r.S1 = S1 and r.S2 = S2), "all records of the row share S1, S2");
  p := Order(S1);
  G := Group(S1, S2);
  Print("Order(S1)=", p, " Order(S2)=", Order(S2), " Order(S1*S2)=", Order(S1*S2), " |G|=", Size(G), "\n");
  Print("S1 = ", S1, "\nS2 = ", S2, "\n");
  Check(Length(Set(List(recs, r -> r.ab[1]))) = Length(recs), "the t-values of the records of the row are pairwise distinct");

  ## ---------------- Step 1: commutant ----------------
  Print("\n--- Step 1: commutant of G ---\n");
  COM := LinearSolutionSpace([[S1,S1],[S2,S2]]);
  dimCom := Length(COM);
  Print("dim {M : M S1 = S1 M, M S2 = S2 M} = ", dimCom, "   basis: ", COM, "\n");
  Check(dimCom = 1, "commutant is 1-dimensional (only scalars centralise G; the only isometries are +-I)");

  ## ---------------- Step 2: anti-automorphism realiser ----------------
  Print("\n--- Step 2: anti-space {M : M S1 = S1^-1 M, M S2 = S2^-1 M} ---\n");
  ANTI := LinearSolutionSpace([[S1,S1^-1],[S2,S2^-1]]);
  dimAnti := Length(ANTI);
  Print("dim anti-space = ", dimAnti, "\n");
  Check(dimAnti = 1, "anti-space is 1-dimensional");
  M0raw := ANTI[1];
  Print("M0 (raw basis vector, semi-echelon normalised) = ", M0raw, "\n");
  MM := M0raw*TransposedMat(M0raw);
  mu := MM[1][1];
  Check(MM = mu*Id4, Concatenation("M0 M0^T = mu I with mu = ", XStr(mu), " ~ ", FStr(mu)));
  Check(CycFloat(mu) > 0.0, "mu > 0");
  Print("M0^2 / mu = ", M0raw^2/mu, "\n");
  Check(M0raw^2 = mu*Id4 or M0raw^2 = -mu*Id4, "M0^2 = +-mu I");
  Print("M0 symmetric: ", M0raw = TransposedMat(M0raw), "   skew: ", M0raw = -TransposedMat(M0raw), "\n");
  Print("det M0 / mu^2 = ", DeterminantMat(M0raw)/mu^2, "\n");
  Check(DeterminantMat(M0raw) = mu^2 or DeterminantMat(M0raw) = -mu^2, "det M0 = +-mu^2");
  sq := CycSqrt(mu);
  if sq <> fail then
    Print("exact sqrt(mu) = ", sq, " ~ ", FStr(sq), "  (conductor ", Conductor(sq), ")\n");
    Check(sq^2 = mu and CycFloat(sq) > 0.0, "sqrt(mu)^2 = mu, sqrt(mu) > 0");
    M0 := M0raw/sq;
    normalised := true;
  else
    Print("no cyclotomic square root of mu found; working with M0 up to positive scalar, M0 M0^T = mu I\n");
    M0 := M0raw; normalised := false;
  fi;
  Print("M0 (normalised) = ", M0, "\n");
  if normalised then
    Check(M0*TransposedMat(M0) = Id4, "M0 M0^T = I exactly (M0 is an isometry)");
    Check(M0^2 = Id4 or M0^2 = -Id4, "M0^2 = +-I");
    if M0^2 = Id4 then M0sq := "+I"; else M0sq := "-I"; fi;
    Print("M0^2 = ", M0sq, "\n");
    detM0 := DeterminantMat(M0);
    Check(detM0 = 1 or detM0 = -1, "det M0 = +-1 exactly");
  else
    detM0 := DeterminantMat(M0raw)/mu^2;
    if M0raw^2 = mu*Id4 then M0sq := "+mu I"; else M0sq := "-mu I"; fi;
  fi;
  if detM0 = 1 then detSign := "+1 (proper)"; else detSign := "-1 (improper)"; fi;
  Print("det M0 = ", detM0, "  -> ", detSign, "\n");
  M0inv := M0^-1;
  Print("M0^-1 S1 M0 = ", M0inv*S1*M0, "\nS1^-1        = ", S1^-1, "\n");
  Print("M0^-1 S2 M0 = ", M0inv*S2*M0, "\nS2^-1        = ", S2^-1, "\n");
  Check(M0inv*S1*M0 = S1^-1 and M0inv*S2*M0 = S2^-1, "M0^-1 S1 M0 = S1^-1 and M0^-1 S2 M0 = S2^-1 (M0 normalises G, inverting both generators)");
  Print("M0 normalises Gamma of each record?  (M0^-1 X M0 in Gamma = <S1,S2,X>)\n");
  normGamma := [];
  for r in recs do
    Gam := Group(S1, S2, r.X);
    b := (M0inv*r.X*M0) in Gam;
    normGamma[Position(recs, r)] := b;
    Print("   ", r.case, ": ", b, "\n");
  od;

  ## ---------------- Step 3: the PETCOX circle ----------------
  Print("\n--- Step 3: the PETCOX circle Pi = Fix(S2) ---\n");
  Pi := NullspaceMat(S2 - Id4);
  Print("basis of Pi: ", Pi, "\n");
  Check(Length(Pi) = 2, "dim Pi = 2");
  Check(ForAll(recs, r -> SolutionMat(Pi, r.w) <> fail), "every stored w of the row lies in Pi");
  Check(ForAll(recs, r -> r.w*S2 = r.w), "every stored w is fixed by S2");
  infrecs := Filtered(recs, r -> r.ab[1] = infinity);
  finrecs := Filtered(recs, r -> r.ab[1] <> infinity);
  if Length(infrecs) > 0 then
    Check(Length(infrecs) = 1 and infrecs[1].alpha = 0, "exactly one record with t = infinity, and it has alpha = 0");
    v0 := infrecs[1].w;
    Print("v0 := w of ", infrecs[1].case, " = ", v0, "\n");
    v3s := List(finrecs, r -> r.w - r.ab[1]*v0);
    for r in finrecs do Print("   ", r.case, ": t = ", r.ab[1], "  w - t v0 = ", r.w - r.ab[1]*v0, "\n"); od;
    Check(Length(Set(v3s)) = 1, "w - t v0 is the same vector v3 for all finite-t records of the row");
    v3 := v3s[1];
  else
    Print("no record with t = infinity in this row; recovering v0, v3 from two finite records\n");
    Check(Length(finrecs) >= 2, "at least two finite-t records");
    r1 := finrecs[1]; r2 := finrecs[2];
    v0 := (r1.w - r2.w)/(r1.ab[1] - r2.ab[1]);
    v3 := r1.w - r1.ab[1]*v0;
    Print("v0 = (w_", r1.case, " - w_", r2.case, ")/(t1 - t2) = ", v0, "\nv3 = ", v3, "\n");
    Check(ForAll(finrecs, r -> r.w = r.ab[1]*v0 + v3), "w = t v0 + v3 for all records of the row");
  fi;
  Print("v0 = ", v0, "  |v0|^2 = ", v0*v0, " ~ ", FStr(v0*v0), "\n");
  Print("v3 = ", v3, "  |v3|^2 = ", v3*v3, " ~ ", FStr(v3*v3), "\n");
  Print("v0.v3 = ", v0*v3, " ~ ", FStr(v0*v3), "\n");
  Check(RankMat([v0,v3]) = 2 and SolutionMat(Pi, v0) <> fail and SolutionMat(Pi, v3) <> fail, "v0, v3 form a basis of Pi");
  # rho from alpha = 1/(1 + t rho)
  rr := First(recs, r -> r.ab[1] <> infinity and r.ab[1] <> 0 and not r.alpha in [0, 1, infinity]);
  Check(rr <> fail, "a record with finite t <> 0 and alpha not in {0,1,infinity} exists");
  rho := (1/rr.alpha - 1)/rr.ab[1];
  Print("rho recovered from ", rr.case, ": rho = ", rho, " ~ ", FStr(rho), "\n");
  Check(CycFloat(rho) > 0.0, "rho > 0");
  Check(rho^2 = (v0*v0)/(v3*v3), "rho^2 = (v0.v0)/(v3.v3) exactly");
  AlphaOf := function(t)
    if t = infinity then return 0; fi;
    if 1 + t*rho = 0 then return infinity; fi;
    return 1/(1 + t*rho);
  end;
  TOf := function(alpha)
    if alpha = 0 then return infinity; fi;
    if alpha = infinity then return -1/rho; fi;
    return (1/alpha - 1)/rho;
  end;
  Check(ForAll(recs, r -> AlphaOf(r.ab[1]) = r.alpha), "alpha = 1/(1 + t rho) reproduces the stored alpha of every record exactly");

  ## ---------------- Step 4: action of M0 on the circle ----------------
  Print("\n--- Step 4: action of M0 on Pi ---\n");
  Check(ForAll(Pi, v -> SolutionMat(Pi, v*M0) <> fail), "Pi is M0-invariant");
  A := [SolutionMat([v0,v3], v0*M0), SolutionMat([v0,v3], v3*M0)];
  Check(A <> fail and A[1] <> fail and A[2] <> fail, "M0 restricted to Pi expressed in the basis (v0, v3)");
  a := A[1][1]; b := A[1][2]; c := A[2][1]; d := A[2][2];
  Print("M0|Pi in basis (v0,v3) (rows = images):  v0 M0 = ", a, " v0 + ", b, " v3 ;  v3 M0 = ", c, " v0 + ", d, " v3\n");
  Print("A = ", A, "\ntrace(A) = ", a+d, "   det(A) = ", DeterminantMat(A), " ~ ", FStr(DeterminantMat(A)), "\n");
  if normalised then
    if a + d = 0 and DeterminantMat(A) = -1 then piAction := "reflection";
    elif DeterminantMat(A) = 1 then piAction := "rotation"; else piAction := "other"; fi;
  else
    if a + d = 0 and DeterminantMat(A) = -mu then piAction := "reflection";
    elif DeterminantMat(A) = mu then piAction := "rotation"; else piAction := "other"; fi;
  fi;
  Print("M0|Pi is a ", piAction, "\n");
  Check(piAction = "reflection", "M0 acts on Pi as a reflection (trace 0, determinant -1)");
  # Moebius map t -> t' :  w = t v0 + v3  ->  w M0 = (a t + c) v0 + (b t + d) v3  ~  t' v0 + v3,  t' = (a t + c)/(b t + d)
  Moeb := function(t)
    if t = infinity then if b = 0 then return infinity; else return a/b; fi; fi;
    if b*t + d = 0 then return infinity; fi;
    return (a*t + c)/(b*t + d);
  end;
  MoebStr := Concatenation("t' = (", XStr(a), ")*t + (", XStr(c), ")  /  (", XStr(b), ")*t + (", XStr(d), ")");
  Print("Moebius map on the projective parameter t:  ", MoebStr, "\n");
  Print("   floats: t' = (", FStr(a), " t + ", FStr(c), ") / (", FStr(b), " t + ", FStr(d), ")\n");
  # in terms of alpha:  t = (1-alpha)/(alpha rho)  =>  alpha' = (P alpha + Q)/(R alpha + S)
  Pm := d*rho - b; Qm := b; Rm := d*rho - b + rho^2*c - rho*a; Sm := b + rho*a;
  MoebAlphaStr := Concatenation("alpha' = (", XStr(Pm), ")*alpha + (", XStr(Qm), ")  /  (", XStr(Rm), ")*alpha + (", XStr(Sm), ")");
  Print("Moebius map on alpha:  ", MoebAlphaStr, "\n");
  Print("   floats: alpha' = (", FStr(Pm), " alpha + ", FStr(Qm), ") / (", FStr(Rm), " alpha + ", FStr(Sm), ")\n");
  MoebAlpha := function(al)
    if al = infinity then if Rm = 0 then return infinity; else return Pm/Rm; fi; fi;
    if Rm*al + Sm = 0 then return infinity; fi;
    return (Pm*al + Qm)/(Rm*al + Sm);
  end;
  Check(ForAll(recs, r -> MoebAlpha(r.alpha) = AlphaOf(Moeb(r.ab[1]))), "alpha-Moebius map agrees with alpha(Moebius(t)) on all records");
  Check(ForAll(recs, r -> Moeb(Moeb(r.ab[1])) = r.ab[1]), "the Moebius map is an involution on the stored t-values");
  # fixed points: b t^2 + (d - a) t - c = 0
  disc := (d-a)^2 + 4*b*c;
  Print("fixed points: ", XStr(b), " t^2 + (", XStr(d-a), ") t + (", XStr(-c), ") = 0,   discriminant = ", disc, " ~ ", FStr(disc), "\n");
  Check(b <> 0, "quadratic (b <> 0): infinity is not a fixed point");
  Check(CycFloat(disc) > 0.0, "discriminant > 0: two real fixed points (M0|Pi is a reflection with two eigen-lines)");
  sd := CycSqrt(disc);
  Check(sd <> fail, "exact cyclotomic square root of the discriminant found");
  Print("sqrt(disc) = ", sd, " ~ ", FStr(sd), "\n");
  tfix := [(-(d-a) + sd)/(2*b), (-(d-a) - sd)/(2*b)];
  Check(ForAll(tfix, t -> b*t^2 + (d-a)*t - c = 0), "both fixed t satisfy the quadratic exactly");
  Check(ForAll(tfix, t -> Moeb(t) = t), "both fixed t are fixed by the Moebius map exactly");
  afix := List(tfix, AlphaOf);
  SortParallel(List(afix, CycFloat), afix); afix := Set(afix);   # sorted by float
  tfix := List(afix, TOf);
  agree := [];
  for k in [1,2] do
    Print("fixed point ", k, ":  t* = ", tfix[k], " ~ ", FStr(tfix[k]), "    alpha* = ", afix[k], " ~ ", FStr(afix[k]), "\n");
    ag := ForAny(PETCOX.(T), v -> RelClose(CycFloat(afix[k]), v));
    Add(agree, ag);
    Print("   agrees with a PETCOX regular value ", PETCOX.(T), " to 5 significant digits: ", ag, "\n");
  od;
  Check(ForAll(agree, x -> x), Concatenation("both fixed alphas coincide (5 sig. digits) with the geometrically regular values of PETCOX for ", T));
  if IsBound(PETCOXexact.(T)) then
    Check(Set(afix) = Set(PETCOXexact.(T)), Concatenation("fixed alphas equal exactly ", String(PETCOXexact.(T))));
  fi;
  # structural verification at the fixed points
  Print("structural check at the fixed points: H_u = Wythoff polyhedron of G at u = t* v0 + v3\n");
  Hfix := [];
  for k in [1,2] do
    u := tfix[k]*v0 + v3;
    Hfix[k] := Polyhedron(S1, S2, u);
    Print("  fixed point ", k, ": |V(H)|=", Length(Hfix[k].V), " |E(H)|=", Length(Hfix[k].E), " |F(H)|=", Length(Hfix[k].F), "\n");
    Check(u*M0 = u or u*M0 = -u, Concatenation("  u is an eigenvector of M0 with eigenvalue +-1 (u M0 = ", String(SolutionMat([u], u*M0)), " u)"));
    resP := MapsOnto(Hfix[k], Hfix[k], M0); resM := MapsOnto(Hfix[k], Hfix[k], -M0);
    Print("  +M0 preserves H_u: ", ResStr(resP), "   -M0 preserves H_u: ", ResStr(resM), "\n");
    Check(AllTrue(resP) or AllTrue(resM), "  H_u at the fixed point is mapped onto itself by +M0 or -M0 (geometrically regular there)");
    # R at the fixed point equals +-M0
    B := List([0..3], j -> u*S1^j); Cm := List([0..3], j -> u*S1^-j);
    Check(RankMat(B) = 4, "  u S1^k, k=0..3 are linearly independent");
    Ru := B^-1*Cm;
    Check(Ru = M0 or Ru = -M0, "  the reversing map R_u (u S1^k -> u S1^-k) equals +-M0");
    Check(AllTrue(MapsOnto(Hfix[k], Hfix[k], Ru)), "  R_u preserves H_u (vertices, edges, faces)");
  od;
  Print("the same isometries +-M0 applied to the cells H_w of the stored records (expected: NOT preserved):\n");
  for r in recs do
    Hw := Polyhedron(S1, S2, r.w);
    resP := MapsOnto(Hw, Hw, M0); resM := MapsOnto(Hw, Hw, -M0);
    Print("  ", r.case, ": +M0: ", ResStr(resP), "  -M0: ", ResStr(resM), "\n");
    Check(not AllTrue(resP) and not AllTrue(resM), Concatenation("  ", r.case, ": neither +M0 nor -M0 preserves the cell H_w"));
  od;

  ## ---------------- Step 5: predicted pairing and direct verification ----------------
  Print("\n--- Step 5: predicted pairing via the Moebius map, and direct verification ---\n");
  rowlines := [];
  seen := [];
  for i in [1..Length(recs)] do
    r := recs[i];
    t := r.ab[1]; tp := Moeb(t); ap := AlphaOf(tp);
    j := PositionProperty(recs, s -> s.ab[1] = tp);
    Print("  ", r.case, ": t = ", XStr(t), " ~ ", FStr(t), "  alpha = ", XStr(r.alpha), " ~ ", FStr(r.alpha),
          "\n       image t' = ", XStr(tp), " ~ ", FStr(tp), "  alpha' = ", XStr(ap), " ~ ", FStr(ap), "\n");
    line := rec(case := r.case, t := t, alpha := r.alpha, tp := tp, ap := ap, paired := "none", s := "-", lambda := "-", detsign := "-", verified := "NA", inGam := "-");
    if j = fail then
      Print("       -> no record of the row has t = t'  (predicted: similarity class is a singleton)\n");
      if not r.case in seen then Add(CLASSES, [r.case]); Add(seen, r.case); fi;
    else
      rb := recs[j];
      Print("       -> paired with ", rb.case, " (t_b = t' exactly; alpha_b = alpha': ", rb.alpha = ap, ")\n");
      Check(rb.alpha = ap, "       alpha of the partner equals the image alpha");
      Check(j <> i, "       partner is a different record (stored records are not at fixed points)");
      line.paired := rb.case;
      if not r.case in seen then Add(PAIRS, [r.case, rb.case]); Add(CLASSES, [r.case, rb.case]); Add(seen, r.case); Add(seen, rb.case); fi;
      # scalar s with w_a M0 = s w_b
      wa := r.w; wb := rb.w;
      jj := PositionProperty(wb, z -> z <> 0);
      s := (wa*M0)[jj]/wb[jj];
      Check(wa*M0 = s*wb, Concatenation("       w_a M0 = s w_b exactly with s = ", XStr(s), " ~ ", FStr(s)));
      line.s := XStr(s);
      N := M0*(1/s);
      lambda := 1/s^2;
      line.lambda := XStr(lambda);
      Check(N*TransposedMat(N) = lambda*Id4, Concatenation("       N = M0/s is a similarity with N N^T = lambda I, lambda = ", XStr(lambda), " ~ ", FStr(lambda)));
      Check(lambda = (wb*wb)/(wa*wa), "       lambda = |w_b|^2/|w_a|^2 exactly");
      dN := DeterminantMat(N);
      Check(dN = lambda^2 or dN = -lambda^2, "       det N = +-lambda^2 exactly");
      if dN = lambda^2 then line.detsign := "+ (proper)"; else line.detsign := "- (improper)"; fi;
      Print("       det N = ", dN, " = ", line.detsign, " lambda^2\n");
      Check(wa*N = wb, "       w_a N = w_b");
      res := MapsOnto(REAL[idx[i]], REAL[idx[j]], N);
      Print("       N carries realisation ", r.case, " onto ", rb.case, ":  ", ResStr(res), "\n");
      Check(AllTrue(res), Concatenation("       N maps V,E,F,C of ", r.case, " onto V,E,F,C of ", rb.case));
      line.verified := String(AllTrue(res));
      Y := M0inv*r.X*M0;
      Gb := Group(S1, S2, rb.X);
      inG := Y in Gb;
      Print("       M0^-1 X_a M0 in Gamma_b = <S1,S2,X_b>: ", inG, "   (M0^-1 X_a M0 = ", Y, ")\n");
      line.inGam := String(inG);
      Check(inG, "       M0^-1 X_a M0 lies in Gamma_b (M0 conjugates Gamma_a onto Gamma_b)");
      Check(Y*TransposedMat(Y) = Id4 and Group(S1,S2,Y) = Gb, "       <S1,S2,M0^-1 X_a M0> = Gamma_b as matrix groups");
    fi;
    Add(rowlines, line);
  od;

  ## ---------------- Step 6: the ingredient "Sym(H_w) = G", flags, generators of Fl0^2 ----------------
  Print("\n--- Step 6: symmetry group of the cells; flag structure ---\n");
  ##  For a stored w let H_w be the cell.  An isometry n with H_w n = H_w maps the base flag Fl0 = (w, e, f) to a flag;
  ##  since G acts freely with two orbits on the 2|G| flags (checked below) we may compose with g in G so that
  ##  Fl0 n g = Fl0  or  Fl0 n g = Fl0^1 = (w, {w, w S1}, f).  In the first case n g fixes two adjacent vertices of the
  ##  polygon f and maps f to itself, hence fixes every vertex w S1^k of f; these span E^4, so n g = I and n in G.
  ##  In the second case n g fixes w, maps w S1^-1 to w S1 and f to itself, hence reverses the polygon:
  ##  (w S1^k) n g = w S1^-k for all k, so n g = R, the unique linear map determined by k = 0..3.  Therefore
  ##  Sym(H_w) = G  iff  R is not an isometry of H_w.  We check exactly: R orthogonal?  R preserves V, E, F of H_w?
  for r in recs do
    Hw := Polyhedron(S1, S2, r.w);
    B := List([0..3], j -> r.w*S1^j); Cm := List([0..3], j -> r.w*S1^-j);
    Check(RankMat(B) = 4, Concatenation(r.case, ": w S1^k, k=0..3 span E^4 (skew polygon)"));
    R := B^-1*Cm;
    orth := R*TransposedMat(R) = Id4;
    Print("  ", r.case, ": R = ", R, "\n       R orthogonal: ", orth, "  R^2 = I: ", R^2 = Id4, "  det R = ", DeterminantMat(R),
          "  (w S1^k) R = w S1^-k for all k<p: ", ForAll([0..p-1], k -> r.w*S1^k*R = r.w*S1^-k), "\n");
    Check(orth, Concatenation(r.case, ": R is orthogonal (a genuine isometry candidate)"));
    res := MapsOnto(Hw, Hw, R);
    Print("       R preserves H_w: ", ResStr(res), "\n");
    Check(res.E = false, Concatenation(r.case, ": R does NOT preserve the edge set of H_w  =>  Sym(H_w) = G, the cell is geometrically chiral"));
    Check(Length(Hw.V) = Size(G)/3 and Length(Hw.E) = Size(G)/2 and Length(Hw.F) = Size(G)/p,
          Concatenation(r.case, ": H_w has |G|/3 vertices, |G|/2 edges, |G|/p faces: ", String([Length(Hw.V), Length(Hw.E), Length(Hw.F)])));
  od;
  # flag structure for one stored w per row
  r := recs[1];
  Hw := Polyhedron(S1, S2, r.w);
  Print("  flag structure of H_w for ", r.case, ":\n");
  Check(ForAll(Hw.E, e -> Number(Hw.F, f -> e in f) = 2), "    every edge of H_w lies in exactly 2 faces (H_w is a polyhedron)");
  nflags := Sum(List(Hw.F, f -> 2*Length(f)));
  Print("    number of flags = ", nflags, "  2|G| = ", 2*Size(G), "\n");
  Check(nflags = 2*Size(G), "    H_w has exactly 2|G| flags");
  Check(Size(Hw.Gp) = Size(G), "    G acts faithfully on V(H_w)");
  Fl0 := [Hw.v, Hw.e, Hw.f];
  orbPhi := Orbit(Hw.Gp, Fl0, FlagAct);
  Check(Length(orbPhi) = Size(G), "    G acts freely on the flags: |Fl0 G| = |G|");
  Fl2 := Adj2(Hw, Fl0);
  Check(not Fl2 in orbPhi, "    the 2-adjacent flag Fl0^2 is not in the G-orbit of Fl0 (two flag orbits)");
  Check(Length(Set(Orbit(Hw.Gp, Fl2, FlagAct))) = Size(G), "    |Fl0^2 G| = |G|, so Fl0 G and Fl0^2 G exhaust the 2|G| flags");
  # distinguished generators: S1: Fl0 -> Fl0^{10}, S2: Fl0 -> Fl0^{21}; for Fl0^2: (S2^-1 S1^-1 S2, S2^-1)
  Check(FlagAct(Fl0, Hw.p1) = Adj0(Hw, Adj1(Hw, Fl0)), "    S1 maps Fl0 to (Fl0^1)^0");
  Check(FlagAct(Fl0, Hw.p2) = Adj1(Hw, Adj2(Hw, Fl0)), "    S2 maps Fl0 to (Fl0^2)^1");
  Check(Fl2[3] = OnSetsSets(Hw.f, Hw.p2), "    the second face at the base edge is f S2");
  q1 := Hw.p2^-1*Hw.p1^-1*Hw.p2; q2 := Hw.p2^-1;
  Check(FlagAct(Fl2, q1) = Adj0(Hw, Adj1(Hw, Fl2)), "    S2^-1 S1^-1 S2 maps Fl0^2 to ((Fl0^2)^1)^0  (distinguished sigma_1 of Fl0^2)");
  Check(FlagAct(Fl2, q2) = Adj1(Hw, Adj2(Hw, Fl2)), "    S2^-1 maps Fl0^2 to ((Fl0^2)^2)^1  (distinguished sigma_2 of Fl0^2)");
  Check(Adj2(Hw, Fl2) = Fl0, "    (Fl0^2)^2 = Fl0");

  ## ---------------- TSV output ----------------
  fixedExact := Concatenation(XStr(afix[1]), " ; ", XStr(afix[2]));
  fixedFloat := Concatenation(FStr(afix[1]), " ; ", FStr(afix[2]));
  agreeStr := Concatenation(String(agree[1]), " ; ", String(agree[2]));
  AppendTo(TSV, "row\t", T, "\t", dimCom, "\t", dimAnti, "\t", detSign, "\t", M0sq, "\t", piAction, "\t", XStr(mu), "\t", XStr(sq), "\t",
           MoebStr, "\t", MoebAlphaStr, "\t", fixedExact, "\t", fixedFloat, "\t", String(PETCOX.(T)), "\t", agreeStr, "\n");
  for line in rowlines do
    AppendTo(TSV, "record\t", T, "\t", line.case, "\t", XStr(line.t), "\t", XStr(line.alpha), "\t", XStr(line.tp), "\t", XStr(line.ap), "\t",
             line.paired, "\t", line.s, "\t", line.lambda, "\t", line.detsign, "\t", line.verified, "\t", line.inGam, "\n");
  od;
  Add(ROWSUMMARY, rec(T := T, dimCom := dimCom, dimAnti := dimAnti, detSign := detSign, M0sq := M0sq, piAction := piAction,
                      afix := afix, agree := agree, lines := rowlines));
od;

#############################################################################
##  cross-check with a cheap similarity invariant (shape of the base 2-face)
#############################################################################
Print("\n\n==================== similarity invariant of the base 2-face (all 24 records) ====================\n");
Print("inv(r) = ( |w - w S1^k|^2 / |w|^2 )_{k=1..p/2}; equal invariants are necessary for similarity.\n");
for i in [1..Length(PX.Saved)] do
  same := Filtered([1..Length(PX.Saved)], j -> j <> i and FINV[j] = FINV[i] and Order(PX.Saved[j].S1) = Order(PX.Saved[i].S1));
  Print("  ", PX.Saved[i].case, ": invariant ~ ", List(FINV[i], CycFloat), "   other records with the same invariant: ", List(same, j -> PX.Saved[j].case), "\n");
od;
# consistency with the predicted classes: within a predicted pair the invariants agree; a singleton shares its invariant with nobody
for cl in CLASSES do
  ii := List(cl, cs -> PositionProperty(PX.Saved, r -> r.case = cs));
  if Length(cl) = 2 then
    Check(FINV[ii[1]] = FINV[ii[2]], Concatenation("pair ", cl[1], " ~ ", cl[2], ": equal face invariants"));
  else
    Check(ForAll([1..Length(PX.Saved)], j -> j = ii[1] or FINV[j] <> FINV[ii[1]] or Order(PX.Saved[j].S1) <> Order(PX.Saved[ii[1]].S1)),
          Concatenation("singleton ", cl[1], ": no other record (in any row) has the same face invariant"));
  fi;
od;
Check(Length(Set(FINV)) >= Length(CLASSES), "the face invariant separates at least as many classes as predicted");

#############################################################################
##  final summary
#############################################################################
Print("\n\n==================== SUMMARY ====================\n");
for rs in ROWSUMMARY do
  Print("Row ", rs.T, ": dim commutant = ", rs.dimCom, ", dim anti-space = ", rs.dimAnti, ", det M0 = ", rs.detSign, ", M0^2 = ", rs.M0sq,
        ", M0|Pi = ", rs.piAction, ", fixed alphas ~ ", List(rs.afix, CycFloat), " (PETCOX ", PETCOX.(rs.T), ", agree ", rs.agree, ")\n");
  for line in rs.lines do
    Print("    ", line.case, "  alpha ~ ", FStr(line.alpha), "  ->  alpha' ~ ", FStr(line.ap), "   partner: ", line.paired,
          "   s = ", line.s, "   structure map verified: ", line.verified, "\n");
  od;
od;
Print("\nPredicted similarity classes of the 24 stored realisations (", Length(CLASSES), " classes):\n");
for cl in CLASSES do Print("   ", cl, "\n"); od;
Print("pairs: ", PAIRS, "\n");
Print("number of pairs: ", Length(PAIRS), ", singletons: ", Number(CLASSES, cl -> Length(cl) = 1), "\n");
Check(Sum(List(CLASSES, Length)) = 24, "the classes partition all 24 records");
allLines := Concatenation(List(ROWSUMMARY, rs -> rs.lines));
pairedLines := Filtered(allLines, line -> line.paired <> "none");
Print("det signs of the pair similarities N = M0/s (det N = +-lambda^2): ", Set(List(pairedLines, line -> line.detsign)), "\n");
Print("det signs of M0 per row: ", List(ROWSUMMARY, rs -> rs.detSign), "\n");
if ForAll(pairedLines, line -> line.detsign = "+ (proper)") then
  Print("=> every predicted pair is related by a PROPER similarity (after normalisation an isometry of det +1).\n");
elif ForAll(pairedLines, line -> line.detsign = "- (improper)") then
  Print("=> every predicted pair is related by an IMPROPER similarity (after normalisation an isometry of det -1).\n");
else
  Print("=> mixed det signs among the pairs (see the per-record lines).\n");
fi;
Print("TSV written to ", TSV, "\n");
Print("\nself-check failures: ", NFAIL, "\n");
Print("Done: method3-anti-automorphism.g\n");
if NFAIL > 0 then QUIT_GAP(1); fi;
