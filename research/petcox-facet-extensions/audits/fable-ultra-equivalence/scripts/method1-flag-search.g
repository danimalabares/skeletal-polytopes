#############################################################################
##
##  method1-flag-search.g  --  METHOD 1 of the fable-ultra-equivalence audit
##
##  Exact flag-anchored similarity search between the 24 stored realisations
##  of alpha-survivors.g (git commit 71ef1cd), with explicit certificates,
##  plus an independent exhaustive Gram-pruned enumeration for every ordered
##  pair with equal f-vector.
##
##  Run (from $AUDIT/scripts):
##     /private/var/tmp/sage-10.7-current/local/bin/gap -q -A --quitonbreak \
##         method1-flag-search.g < /dev/null 2>&1 | tee ../logs/method1-flag-search.log
##
##  All decisions use exact GAP cyclotomic arithmetic.  Floats appear only
##  in display (marked "~").  The script prints "Done: method1-flag-search.g"
##  as its final line and exits with status 1 if any self-check failed.
##
##  CONVENTIONS (same as the data file):
##    * matrices act on ROW vectors from the right, v*M;  A*B = "A first, then B";
##    * permutations: i^(p*q) = (i^p)^q, so the map  g -> (i -> Position(V, V[i]*g))
##      is a homomorphism from the matrix group to Sym(V);
##    * GAP's E(n) = exp(2 pi i/n).
##
##  This script is written from scratch for the audit; it does not Read() any
##  producer file except the data file alpha-survivors.g.
##
#############################################################################

SizeScreen([4096,]);
T0 := Runtime();

## Paths.  The data file is taken from the environment variable PETCOX_DATA when
## set (run-all.sh points it at a fresh git-archive extraction of commit 71ef1cd);
## the fallback is the extraction used during the audit session.  Outputs go to
## ../logs/ relative to the scripts/ directory from which the script is run.
## (These two assignments were the only lines edited by the audit author after the
## implementer delivered the script; the mathematics is untouched.)
if IsBound(GAPInfo.SystemEnvironment.PETCOX_DATA) then DATA := GAPInfo.SystemEnvironment.PETCOX_DATA; else DATA := "/private/tmp/claude-501/-Users-daniel-github-skeletal-polytopes/d4b2e626-5fbc-48d1-9c01-c9dc4a79290e/scratchpad/producer/research/petcox-facet-extensions/logs/alpha-survivors.g"; fi;
LOGDIR := "../logs/";
TSVFILE := Concatenation(LOGDIR, "method1-pairs.tsv");
CERTFILE := Concatenation(LOGDIR, "method1-certificates.json");
REALFILE := Concatenation(LOGDIR, "method1-realisations.json");
SCRIPTNAME := "method1-flag-search.g";
DET_SAMPLE := 200;   # per pair: number of enumerated tuples whose M and det are recomputed directly

#############################################################################
##  Self-check bookkeeping
#############################################################################
NFAIL := 0;
FAILMSGS := [];
Check := function(cond, msg)
  if cond = true then
    Print("  [ok]   ", msg, "\n");
    return true;
  fi;
  NFAIL := NFAIL + 1;
  Add(FAILMSGS, msg);
  Print("  [FAIL] ", msg, "\n");
  return false;
end;
Note := function(msg) Print("  [note] ", msg, "\n"); end;
Elapsed := function() return Concatenation("[t=", String(QuoInt(Runtime() - T0, 1000)), "s]"); end;

## float approximation of a real cyclotomic -- DISPLAY ONLY
ApproxReal := function(x)
  local N, c, s, i;
  if x = infinity then return "infinity"; fi;
  if IsRat(x) then return Float(x); fi;
  N := Conductor(x); c := CoeffsCyc(x, N); s := Float(0);
  for i in [1..N] do s := s + Float(c[i]) * Cos(2*FLOAT.PI*(i-1)/N); od;
  return s;
end;

#############################################################################
##  Small utilities (own implementations)
#############################################################################

## position of vector u in the sorted vertex list V, or fail
PosVec := function(V, u)
  local p;
  p := PositionSorted(V, u);
  if p <= Length(V) and V[p] = u then return p; fi;
  return fail;
end;

## action on a set of sets of sets (cells = sets of faces = sets of edges)
OnSetsSetsSets := function(c, g) return Set(List(c, F -> OnSetsSets(F, g))); end;

## permutation of the vertex indices of realisation R induced by matrix T
## (fail if T does not map R.V bijectively onto itself)
MatToPerm := function(R, T)
  local pl;
  pl := List(R.V, v -> PosVec(R.V, v*T));
  if fail in pl then return fail; fi;
  return PermList(pl);
end;

## Membership of a 4x4 matrix T in Gamma_R = <S1,S2,X> of realisation R.
## Rigorous: Gamma_R preserves R.V, so if T does not permute R.V then T is not
## in Gamma_R.  If T permutes R.V, inducing the permutation pi, then T is in
## Gamma_R iff pi lies in the permutation image R.Pv: if g in Gamma_R induces
## pi then g and T agree on the spanning set R.V, hence g = T.  Returns the
## permutation (an element of R.Pv) or fail.
MatInGroup := function(R, T)
  local pi;
  pi := MatToPerm(R, T);
  if pi = fail then return fail; fi;
  if pi in R.Pv then return pi; fi;
  return fail;
end;

## own conjugator search for ordered triples: g with t[i]^g = u[i], i=1..3
## (used to cross-check RepresentativeAction(..., OnTuples))
TripleConjugator := function(G, t, u)
  local g0, C, c, g;
  g0 := RepresentativeAction(G, t[1], u[1]);
  if g0 = fail then return fail; fi;
  C := Centralizer(G, u[1]);
  for c in C do
    g := g0*c;
    if t[2]^g = u[2] and t[3]^g = u[3] then return g; fi;
  od;
  return fail;
end;

## JSON helpers.  All strings we emit consist of digits, letters, and the
## characters ( ) ^ * / + - { } , . _ so no escaping is needed; SafeStr asserts it.
SafeStr := function(s)
  local ch;
  for ch in s do
    if ch = '"' or ch = '\\' then Error("JSON string needs escaping: ", s); fi;
  od;
  return s;
end;
JS := s -> Concatenation("\"", SafeStr(s), "\"");
JC := x -> JS(String(x));
JList := strs -> Concatenation("[", JoinStringsWithSeparator(strs, ","), "]");
JVec := v -> JList(List(v, JC));
JMat := m -> JList(List(m, JVec));
JInts := l -> JList(List(l, String));
JBool := function(b) if b = true then return "true"; else return "false"; fi; end;

FvecStr := fv -> JoinStringsWithSeparator(List(fv, String), ",");
SignStr := function(s) if s = 1 then return "+1"; elif s = -1 then return "-1"; else return "na"; fi; end;

#############################################################################
##  STEP 0: load data
#############################################################################
Print("==== METHOD 1: exact flag-anchored similarity search ", Elapsed(), "\n");
Print("data file: ", DATA, "\n");
PX := rec();
Read(DATA);
Check(IsBound(PX.Saved) and Length(PX.Saved) = 24, "data file loaded: 24 records");

## expected f-vectors from the task statement
CaseNumber := function(r)
  local parts;
  parts := SplitString(r.case, "-");
  return Int(parts[Length(parts)]);
end;
ExpectedFvec := function(r)
  local num;
  if r.T = "{4,3,3}" then return [16,32,12,4]; fi;
  if r.T = "{5,3,3}" or r.T = "{3,3,5/2}" then return [600,1200,120,5]; fi;
  if r.T = "{5,3,5/2}" then
    num := CaseNumber(r);
    if num in [1..4] then return [240,480,120,20]; fi;
    if num in [5..8] then return [48,144,48,8]; fi;
    if num in [9..16] then return [120,720,300,50]; fi;
  fi;
  return fail;
end;

#############################################################################
##  STEP 1: reconstruct the 24 realisations with own orbit code
#############################################################################

## Does some g in R.Pv map flag Phi to flag Psi?  (flags = rec(v,e,f,c) in
## vertex indices).  Returns such g, or fail.  Exact: first move the vertex,
## then run through the (small) vertex stabiliser.
FlagMapExists := function(R, Phi, Psi)
  local g0, St, h, g;
  g0 := RepresentativeAction(R.Pv, Phi.v, Psi.v);
  if g0 = fail then return fail; fi;
  St := Stabilizer(R.Pv, Psi.v);
  for h in St do
    g := g0*h;
    if OnSets(Phi.e, g) = Psi.e and OnSetsSets(Phi.f, g) = Psi.f
       and OnSetsSetsSets(Phi.c, g) = Psi.c then
      return g;
    fi;
  od;
  return fail;
end;

## The i-adjacent flag of Phi (unique by the diamond condition), or fail.
AdjacentFlag := function(R, Phi, i)
  local Psi, cands;
  Psi := ShallowCopy(Phi);
  if i = 0 then
    cands := Filtered(Phi.e, u -> u <> Phi.v);
    if Length(cands) <> 1 then return fail; fi;
    Psi.v := cands[1];
  elif i = 1 then
    cands := Filtered(Phi.f, E -> Phi.v in E and E <> Phi.e);
    if Length(cands) <> 1 then return fail; fi;
    Psi.e := cands[1];
  elif i = 2 then
    cands := Filtered(Phi.c, F -> Phi.e in F and F <> Phi.f);
    if Length(cands) <> 1 then return fail; fi;
    Psi.f := cands[1];
  elif i = 3 then
    cands := Filtered(R.Ce, C -> Phi.f in C and C <> Phi.c);
    if Length(cands) <> 1 then return fail; fi;
    Psi.c := cands[1];
  fi;
  return Psi;
end;

## Which Gamma_R-orbit does the flag Psi of R lie in?  "even" (orbit of the
## base flag), "odd" (orbit of the 2-adjacent flag) or "none".
FlagOrbit := function(R, Psi)
  if FlagMapExists(R, R.Phi, Psi) <> fail then return "even"; fi;
  if FlagMapExists(R, R.Phi2, Psi) <> fail then return "odd"; fi;
  return "none";
end;

BuildRealisation := function(r, idx)
  local R, G, V, n, facevert, kk, rows, cand, k, St, nflags, exp, Phi0, g, S, deg, i, Psi;
  Print("\n---- case ", idx, ": ", r.case, "   T=", r.T, "   alpha=", r.alpha, "  (~", ApproxReal(r.alpha), ")\n");
  R := rec(idx := idx, case := r.case, T := r.T, alpha := r.alpha, w := r.w,
           S1 := r.S1, S2 := r.S2, X := r.X, casenum := CaseNumber(r));
  Check(ForAll([r.S1, r.S2, r.X], S -> S*TransposedMat(S) = IdentityMat(4)), "generators S1,S2,X are orthogonal (exact)");
  Check(ForAll([r.S1, r.S2, r.X], S -> DeterminantMat(S) = 1), "generators have determinant +1 (Gamma < SO(4))");
  R.p := Order(r.S1);
  Note(Concatenation("p = Order(S1) = ", String(R.p), ",  Order(S2) = ", String(Order(r.S2)), ",  Order(X) = ", String(Order(r.X))));
  Note(Concatenation("|w|^2 = ", String(r.w*r.w), "  (~", String(ApproxReal(r.w*r.w)), ")"));
  Check(r.w*r.S2 = r.w, "S2 fixes the base vertex w");
  Check((r.S1*r.S2)^2 = IdentityMat(4), "(S1*S2)^2 = I");
  Check(r.w*r.S1*r.S2 = r.w*r.S1^-1, "w*S1*S2 = w*S1^-1 (so e = {w, w S1^-1} lies in f*S2)");

  ## the matrix group and its order (GAP, exact)
  G := Group(r.S1, r.S2, r.X);
  R.matorder := Size(G);
  ## vertex set = orbit of w, sorted (fixed order used everywhere)
  V := Set(Orbit(G, r.w, OnPoints));
  R.V := V; n := Length(V); R.n := n;
  Check(RankMat(V) = 4, "vertex set spans E^4");
  Check(Sum(V) = 0*r.w, "sum of all vertices is the zero vector (centroid = origin)");
  Check(ForAll(V, v -> v*v = r.w*r.w), "all vertices have the same squared norm |w|^2");
  ## faithful permutation image on vertex indices
  R.s1 := MatToPerm(R, r.S1); R.s2 := MatToPerm(R, r.S2); R.x := MatToPerm(R, r.X);
  Check(R.s1 <> fail and R.s2 <> fail and R.x <> fail, "generators permute the vertex set");
  R.Pv := Group(R.s1, R.s2, R.x);
  R.order := Size(R.Pv);
  Check(R.order = R.matorder, Concatenation("|Gamma| = ", String(R.matorder), " = size of permutation image (faithful since V spans E^4)"));
  ## base flag
  R.v0 := PosVec(V, r.w);
  R.e := Set([R.v0, PosVec(V, r.w*r.S1^-1)]);
  facevert := List([0..R.p-1], k -> PosVec(V, r.w*r.S1^k));
  Check(not fail in facevert and Length(Set(facevert)) = R.p, "base 2-face: the p vertices w S1^k (k=0..p-1) are distinct vertices");
  R.facevert := facevert;
  R.f := Set(List([1..R.p], k -> Set([facevert[k], facevert[(k mod R.p) + 1]])));
  Check(R.f = Set(Orbit(Group(R.s1), R.e, OnSets)), "base face f (as edge set) = <S1>-orbit of the base edge");
  R.c := Set(Orbit(Group(R.s1, R.s2), R.f, OnSetsSets));
  ## orbits of the base faces under Gamma
  R.Ed := Set(Orbit(R.Pv, R.e, OnSets));
  R.Fa := Set(Orbit(R.Pv, R.f, OnSetsSets));
  R.Ce := Set(Orbit(R.Pv, R.c, OnSetsSetsSets));
  R.fvec := [n, Length(R.Ed), Length(R.Fa), Length(R.Ce)];
  exp := ExpectedFvec(r);
  Check(R.fvec = exp, Concatenation("f-vector (V,E,F,C) = (", FvecStr(R.fvec), ")  expected (", FvecStr(exp), ")"));
  Note(Concatenation("face size p = ", String(Length(R.f)), " edges; base cell has ", String(Length(R.c)), " faces and ",
       String(Length(Set(Concatenation(List(R.c, F -> Concatenation(List(F, e -> e))))))), " vertices"));
  ## incidence (diamond) checks around the base flag
  Check(Number(R.f, E -> R.v0 in E) = 2, "base vertex lies in exactly 2 edges of the base face");
  Check(Number(R.c, F -> R.e in F) = 2, "base edge lies in exactly 2 faces of the base cell");
  Check(Number(R.Ce, C -> R.f in C) = 2, "base face lies in exactly 2 cells");
  R.f2 := OnSetsSets(R.f, R.s2);
  Check(R.f2 <> R.f and R.e in R.f2 and R.f2 in R.c, "f*S2 is the other face of the base cell through the base edge");
  R.Phi := rec(v := R.v0, e := R.e, f := R.f, c := R.c);
  R.Phi2 := rec(v := R.v0, e := R.e, f := R.f2, c := R.c);       # 2-adjacent flag
  Phi0 := rec(v := PosVec(V, r.w*r.S1^-1), e := R.e, f := R.f, c := R.c);  # 0-adjacent flag
  ## flags: count and free action
  nflags := Sum(R.Ce, C -> Sum(C, F -> 2*Length(F)));
  R.nflags := nflags;
  Check(nflags = 2*R.order, Concatenation("number of flags = ", String(nflags), " = 2|Gamma|"));
  St := Stabilizer(R.Pv, R.v0);
  St := Stabilizer(St, R.e, OnSets);
  St := Stabilizer(St, R.f, OnSetsSets);
  St := Stabilizer(St, R.c, OnSetsSetsSets);
  Check(Size(St) = 1, "Gamma acts freely on flags (stabiliser of the base flag is trivial)");
  Check(FlagMapExists(R, R.Phi, R.Phi) = (), "sanity: identity maps base flag to itself");
  Check(FlagMapExists(R, R.Phi, R.Phi2) = fail, "the 2-adjacent flag is NOT in the Gamma-orbit of the base flag => exactly two flag orbits (even/odd), Gamma-chiral");
  Check(AdjacentFlag(R, R.Phi, 2) = R.Phi2 and AdjacentFlag(R, R.Phi, 0) = Phi0, "AdjacentFlag agrees with the explicit 0- and 2-adjacent flags");
  ## Bipartiteness of the flag graph with respect to the two orbits: every
  ## i-adjacent flag of the base flag lies in the odd orbit and every
  ## i-adjacent flag of the 2-adjacent flag lies in the even orbit (i=0..3).
  ## By transport with Gamma this holds for all flags: adjacent flags always
  ## lie in different orbits.
  for i in [0..3] do
    Psi := AdjacentFlag(R, R.Phi, i);
    Check(Psi <> fail and FlagOrbit(R, Psi) = "odd", Concatenation(String(i), "-adjacent flag of the base flag lies in the odd orbit"));
    Psi := AdjacentFlag(R, R.Phi2, i);
    Check(Psi <> fail and FlagOrbit(R, Psi) = "even", Concatenation(String(i), "-adjacent flag of the 2-adjacent flag lies in the even orbit"));
  od;
  ## the flag (w, e, f*S2, c') with c' the other cell through f*S2 has the same
  ## face traversal as Phi2 but lies in the even orbit: a linear map is fixed by
  ## the face traversal alone, so the "odd" candidate below may land there.
  R.Phi2c := AdjacentFlag(R, R.Phi2, 3);
  R.Phi3 := AdjacentFlag(R, R.Phi, 3);
  ## Schulte-Weiss orientation of the generators on the base flag
  Check(R.v0^R.s1 = facevert[2] and OnSets(R.e, R.s1) = Set([R.v0, facevert[2]]) and OnSetsSets(R.f, R.s1) = R.f and OnSetsSetsSets(R.c, R.s1) = R.c,
        "S1 maps the base flag to its (1,0)-adjacent flag (fixes f and c)");
  Check(R.v0^R.s2 = R.v0 and OnSetsSets(R.f, R.s2) = R.f2 and OnSetsSetsSets(R.c, R.s2) = R.c, "S2 fixes w and c and maps f to f*S2");
  Check(R.v0^R.x = R.v0 and OnSets(R.e, R.x) = R.e and OnSetsSetsSets(R.c, R.x) <> R.c, "X fixes w and e and moves c");
  ## 4 linearly independent face vertices w S1^k
  kk := []; rows := [];
  for k in [0..R.p-1] do
    cand := Concatenation(rows, [r.w*r.S1^k]);
    if RankMat(cand) = Length(cand) then Add(kk, k); rows := cand; fi;
    if Length(kk) = 4 then break; fi;
  od;
  Check(Length(kk) = 4, "the base face vertices span E^4");
  if kk = [0..3] then
    Check(true, "w, wS1, wS1^2, wS1^3 are linearly independent (anchor exponents [0,1,2,3])");
  else
    Note(Concatenation("w, wS1, wS1^2, wS1^3 are NOT independent; using anchor exponents ", String(kk)));
  fi;
  R.kk := kk; R.P := rows; R.Pinv := rows^-1;
  R.anchor := List(kk, k -> PosVec(V, r.w*r.S1^k));
  Check(RankMat(R.P) = 4, "anchor matrix P (rows w S1^kk) is invertible");
  deg := Number(R.Ed, E -> R.v0 in E);
  Note(Concatenation("vertex degree ", String(deg), ";  |Gamma| = ", String(R.order), ";  flags = ", String(nflags), " ", Elapsed()));
  return R;
end;

REAL := List([1..Length(PX.Saved)], i -> BuildRealisation(PX.Saved[i], i));
N := Length(REAL);

## Within a row T all records must share S1,S2 (task statement) - verify
for i in [1..N] do
  for j in [1..N] do
    if i < j and REAL[i].T = REAL[j].T then
      if not (REAL[i].S1 = REAL[j].S1 and REAL[i].S2 = REAL[j].S2) then
        Note(Concatenation("cases ", REAL[i].case, " and ", REAL[j].case, " have the same T but different S1/S2"));
      fi;
    fi;
  od;
od;

Print("\n==== Table of realisations ", Elapsed(), "\n");
Print("idx\tcase\t|Gamma|\tp\tfvector\tflags\t|w|^2\n");
for R in REAL do
  Print(R.idx, "\t", R.case, "\t", R.order, "\t", R.p, "\t(", FvecStr(R.fvec), ")\t", R.nflags, "\t", R.w*R.w, "\n");
od;

#############################################################################
##  Write method1-realisations.json
#############################################################################
WriteRealisationsJSON := function()
  local out, R, first, F, C;
  out := OutputTextFile(REALFILE, false);
  SetPrintFormattingStatus(out, false);
  AppendTo(out, "[\n");
  first := true;
  for R in REAL do
    if not first then AppendTo(out, ",\n"); fi;
    first := false;
    AppendTo(out, "{\"case\":", JS(R.case), ",\"T\":", JS(R.T), ",\"alpha\":", JC(R.alpha),
                  ",\"order\":", R.order, ",\"p\":", R.p, ",\"fvector\":", JInts(R.fvec),
                  ",\"w\":", JVec(R.w), ",\"S1\":", JMat(R.S1), ",\"S2\":", JMat(R.S2), ",\"X\":", JMat(R.X), ",\n");
    AppendTo(out, "\"vertices\":", JList(List(R.V, JVec)), ",\n");
    AppendTo(out, "\"edges\":", JList(List(R.Ed, e -> JInts(e - 1))), ",\n");
    AppendTo(out, "\"faces\":", JList(List(R.Fa, F -> JInts(List(F, e -> PositionSorted(R.Ed, e) - 1)))), ",\n");
    AppendTo(out, "\"cells\":", JList(List(R.Ce, C -> JInts(List(C, F -> PositionSorted(R.Fa, F) - 1)))), ",\n");
    AppendTo(out, "\"base_flag\":{\"vertex\":", R.v0 - 1, ",\"edge\":", PositionSorted(R.Ed, R.e) - 1,
                  ",\"face\":", PositionSorted(R.Fa, R.f) - 1, ",\"cell\":", PositionSorted(R.Ce, R.c) - 1,
                  ",\"face_S2\":", PositionSorted(R.Fa, R.f2) - 1, "},",
                  "\"anchor_exponents\":", JInts(R.kk), ",\"anchor_vertices\":", JInts(R.anchor - 1), "}");
  od;
  AppendTo(out, "\n]\n");
  CloseStream(out);
end;
WriteRealisationsJSON();
Print("wrote ", REALFILE, " ", Elapsed(), "\n");

#############################################################################
##  STEP 2: flag-anchored candidate similarities
##
##  JUSTIFICATION.  Let phi: x -> x*M be a similarity of E^4 carrying the
##  realisation a onto the realisation b (vertex set onto vertex set, edges
##  onto edges, faces onto faces, cells onto cells).  Both vertex sets have
##  centroid 0, so phi has no translation part and is linear.  phi maps the
##  base flag Phi_a = (w_a, e_a, f_a, c_a) of a to some flag Psi of b.  By
##  step 1, Gamma_b acts freely on the flags of b and there are exactly
##  2|Gamma_b| flags, so there are exactly two Gamma_b-orbits of flags; the
##  base flag Phi_b and its 2-adjacent flag Phi_b^2 = (w_b, e_b, f_b*S2, c_b)
##  lie in different orbits (verified).  Hence there is g in Gamma_b with
##  Psi*g in {Phi_b, Phi_b^2}, and phi*g is again a similarity a -> b.
##  A flag map determines the traversal of the base face: the vertices of
##  f_a read from w_a away from e_a are w_a S1^k, k = 0..p-1, and they are
##  carried to the vertices of the image face read from w_b away from e_b:
##     even (Psi g = Phi_b):    w_b S1^k
##     odd  (Psi g = Phi_b^2):  w_b S1^-k S2
##  (the vertices of f_b S2 are w_b S1^j S2 and its edge at w_b other than
##  e_b = {w_b, w_b S1 S2} is {w_b, w_b S1^-1 S2}; all verified in step 1).
##  Since 4 of the face vertices are linearly independent, M is determined,
##  so up to Gamma_b there are at most two similarities a -> b: M_even and
##  M_odd below.  Every check on them is exact.
##
##  CAVEAT (found in testing).  The face traversal does not see the cell:
##  the flags (w_b, e_b, f_b S2, c_b) = Phi_b^2 (odd orbit) and
##  (w_b, e_b, f_b S2, c_b') = (Phi_b^2)^3 (even orbit, c_b' the other cell
##  through f_b S2) give the SAME linear map M_odd.  Likewise M_even is shared
##  by Phi_b and Phi_b^3.  So a candidate that passes all structure checks
##  is a genuine representative of the coset it was built for only if it
##  maps the base flag of a to the intended flag (recorded as flag_image_ok,
##  and image_orbit = even/odd); otherwise it lies in the OTHER candidate's
##  coset and gives nothing new.  The set of similarities a -> b is
##      [M_even Gamma_b if M_even passes with image orbit even]  union
##      [M_odd  Gamma_b if M_odd  passes with image orbit odd ],
##  and its size is |Gamma_b| times the number of these cosets; this is
##  cross-checked against the exhaustive enumeration of step 3.
#############################################################################

## Full verification of a linear map x -> x*M as a structure map a -> b.
VerifyMap := function(a, b, M)
  local r, pl, perm, fwd, bwd, t, same, mirror, same2, mirror2;
  r := rec(lam := (b.w*b.w)/(a.w*a.w));
  r.mmt := (M*TransposedMat(M) = r.lam*IdentityMat(4));
  r.det := DeterminantMat(M);
  if r.det = r.lam^2 then r.detsign := 1;
  elif r.det = -r.lam^2 then r.detsign := -1;
  else r.detsign := 0; fi;
  r.vertices := false; r.edges := false; r.faces := false; r.cells := false;
  r.conj_fwd := [false, false, false]; r.conj_bwd := [false, false, false];
  r.perm := fail; r.orientation := "none"; r.orientation_consistent := true;
  r.triple_exact_same := false; r.triple_exact_mirror := false;
  if a.n = b.n then
    pl := List(a.V, v -> PosVec(b.V, v*M));
    if not fail in pl then
      perm := PermList(pl);
      if perm <> fail then r.vertices := true; r.perm := perm; fi;
    fi;
  fi;
  if r.vertices then
    perm := r.perm;
    ## sizes agree (equal f-vectors) and perm is a bijection, so "into" = "onto"
    r.edges := ForAll(a.Ed, e -> OnSets(e, perm) in b.Ed);
    r.faces := ForAll(a.Fa, F -> OnSetsSets(F, perm) in b.Fa);
    r.cells := ForAll(a.Ce, C -> OnSetsSetsSets(C, perm) in b.Ce);
    fwd := List([a.S1, a.S2, a.X], S -> MatInGroup(b, M^-1*S*M));
    bwd := List([b.S1, b.S2, b.X], S -> MatInGroup(a, M*S*M^-1));
    r.conj_fwd := List(fwd, x -> x <> fail);
    r.conj_bwd := List(bwd, x -> x <> fail);
    if ForAll(fwd, x -> x <> fail) then
      t := fwd;   # permutation images on V_b of (M^-1 S1 M, M^-1 S2 M, M^-1 X_a M)
      same := RepresentativeAction(b.Pv, t, [b.s1, b.s2, b.x], OnTuples) <> fail;
      mirror := RepresentativeAction(b.Pv, t, [b.s1^-1, b.s1^2*b.s2, b.x], OnTuples) <> fail;
      same2 := TripleConjugator(b.Pv, t, [b.s1, b.s2, b.x]) <> fail;
      mirror2 := TripleConjugator(b.Pv, t, [b.s1^-1, b.s1^2*b.s2, b.x]) <> fail;
      r.orientation_consistent := (same = same2 and mirror = mirror2);
      if same and mirror then r.orientation := "both";
      elif same then r.orientation := "same";
      elif mirror then r.orientation := "mirror";
      else r.orientation := "none"; fi;
      r.triple_exact_same := (t = [b.s1, b.s2, b.x]);
      r.triple_exact_mirror := (t = [b.s1^-1, b.s1^2*b.s2, b.x]);
    fi;
  fi;
  r.all := r.mmt and r.detsign <> 0 and r.vertices and r.edges and r.faces and r.cells
           and ForAll(r.conj_fwd, x -> x) and ForAll(r.conj_bwd, x -> x);
  return r;
end;

Candidate := function(a, b, mode, lam)
  local c, Q, M, perm, img, target;
  c := rec(mode := mode);
  if mode = "even" then
    Q := List(a.kk, k -> b.w*b.S1^k);
  else
    Q := List(a.kk, k -> b.w*b.S1^(-k)*b.S2);
  fi;
  c.Q := Q;
  c.tuple := List(Q, q -> PosVec(b.V, q));
  c.gram_consistent := (Q*TransposedMat(Q) = lam*(a.P*TransposedMat(a.P)));
  c.image_orbit := "none"; c.flag_image_ok := false; c.flag_image_othercell := false; c.coset := false;
  if RankMat(Q) < 4 then
    c.M := fail; c.pass := false; c.traversal := false;
    c.res := rec(detsign := 0, all := false, orientation := "none", mmt := false, vertices := false,
                 edges := false, faces := false, cells := false, conj_fwd := [false,false,false],
                 conj_bwd := [false,false,false], det := 0, lam := lam, orientation_consistent := true,
                 triple_exact_same := false, triple_exact_mirror := false);
    return c;
  fi;
  M := a.Pinv * Q;
  c.M := M;
  ## (i) the whole traversal of the base face
  if mode = "even" then
    c.traversal := ForAll([0..a.p-1], k -> (a.w*a.S1^k)*M = b.w*b.S1^k);
  else
    c.traversal := ForAll([0..a.p-1], k -> (a.w*a.S1^k)*M = b.w*b.S1^(-k)*b.S2);
  fi;
  ## (ii)-(vii)
  c.res := VerifyMap(a, b, M);
  ## flag image: base flag of a -> base flag of b (even) or its 2-adjacent flag (odd);
  ## the only other possibility for a structure map with this traversal is the
  ## intended flag with the other cell through its face (then the image lies in
  ## the other orbit and the candidate belongs to the other candidate's coset).
  if c.res.vertices then
    perm := c.res.perm;
    img := rec(v := a.v0^perm, e := OnSets(a.e, perm), f := OnSetsSets(a.f, perm), c := OnSetsSetsSets(a.c, perm));
    if mode = "even" then target := b.Phi; else target := b.Phi2; fi;
    c.flag_image_ok := (img = target);
    c.flag_image_othercell := (img = AdjacentFlag(b, target, 3));
    c.image_orbit := FlagOrbit(b, img);
  fi;
  c.pass := c.traversal and c.res.all;
  ## the candidate represents its own coset only if it passes AND hits the intended flag
  c.coset := c.pass and c.flag_image_ok;
  return c;
end;

#############################################################################
##  STEP 3: exhaustive Gram-pruned enumeration.
##
##  Any similarity x -> x*M from a onto b (M M^T = lam I, lam = |w_b|^2/|w_a|^2
##  forced by the vertex norms) maps the 4 anchor vertices p_k = w_a S1^kk[k]
##  to vertices q_k of b with q_i.q_j = lam p_i.p_j for all i,j, and M = P^-1 Q.
##  Conversely, every such 4-tuple yields M with M M^T = lam I.  We enumerate
##  ALL such ordered 4-tuples (depth-first with Gram pruning), so the list of
##  similarities a -> b is exactly the list of tuples whose M passes the full
##  verification.  If no tuple passes, there is no similarity a -> b.
##
##  The outcome is constant on Gamma_b-orbits of tuples (M is a similarity
##  a -> b iff M g is, for g in Gamma_b, because g preserves all of b).
##  For tuples t, t' with maps M, M':  M^-1 M' lies in Gamma_b  iff  some
##  g in Gamma_b maps t to t' (OnTuples) -- if g agrees with M^-1 M' on the
##  4 spanning vectors q_k then g = M^-1 M'.  So we verify one representative
##  per orbit fully, and every further tuple by orbit membership (exact, no
##  arithmetic); as an extra check, M and det M are recomputed directly for a
##  sample of the tuples and compared with the representative.
#############################################################################
Enumerate := function(a, b, lam)
  local Enum, n, Gr, t, i0, i1, i2, i3, C1, C2, C3, tup, k, o, orb, M, res, step, idx, d;
  Enum := rec(tuples := 0, sims := 0, signs := [], orbits := [], tuplist := [],
           det_checked := 0, det_mismatch := 0, orbit_size_ok := true);
  n := b.n; Gr := b.Gram;
  t := lam * (a.P * TransposedMat(a.P));      # target Gram matrix of the image tuple
  for i0 in [1..n] do
    if Gr[i0][i0] <> t[1][1] then continue; fi;
    C1 := Filtered([1..n], j -> Gr[i0][j] = t[1][2] and Gr[j][j] = t[2][2]);
    C2 := Filtered([1..n], j -> Gr[i0][j] = t[1][3] and Gr[j][j] = t[3][3]);
    C3 := Filtered([1..n], j -> Gr[i0][j] = t[1][4] and Gr[j][j] = t[4][4]);
    for i1 in C1 do
      for i2 in C2 do
        if Gr[i1][i2] <> t[2][3] then continue; fi;
        for i3 in C3 do
          if Gr[i1][i3] <> t[2][4] or Gr[i2][i3] <> t[3][4] then continue; fi;
          Add(Enum.tuplist, [i0, i1, i2, i3]);
        od;
      od;
    od;
  od;
  Enum.tuples := Length(Enum.tuplist);
  ## orbit-wise verification
  Enum.orbit_of := [];
  for idx in [1..Enum.tuples] do
    tup := Enum.tuplist[idx];
    k := PositionProperty(Enum.orbits, o -> tup in o.set);
    if k = fail then
      M := a.Pinv * b.V{tup};
      res := VerifyMap(a, b, M);
      orb := Set(Orbit(b.Pv, tup, OnTuples));
      if Length(orb) <> b.order then Enum.orbit_size_ok := false; fi;
      Add(Enum.orbits, rec(set := orb, tup := tup, M := M, res := res));
      k := Length(Enum.orbits);
    fi;
    Enum.orbit_of[idx] := k;
    if Enum.orbits[k].res.all then
      Enum.sims := Enum.sims + 1;
      AddSet(Enum.signs, Enum.orbits[k].res.detsign);
    fi;
  od;
  ## every enumerated tuple must lie in exactly one recorded orbit, and the
  ## orbits must partition the tuple list (each orbit lies inside the list:
  ## Gram data is Gamma_b-invariant, so orbits of enumerated tuples consist
  ## of enumerated tuples)
  Enum.orbits_cover := (Sum(Enum.orbits, o -> Length(o.set)) = Enum.tuples)
                    and ForAll(Enum.orbits, o -> IsSubset(Set(Enum.tuplist), o.set));
  ## direct recomputation of M and det for a sample of tuples
  if Enum.tuples > 0 then
    step := Maximum(1, QuoInt(Enum.tuples, DET_SAMPLE));
    idx := 1;
    while idx <= Enum.tuples do
      tup := Enum.tuplist[idx];
      M := a.Pinv * b.V{tup};
      d := DeterminantMat(M);
      Enum.det_checked := Enum.det_checked + 1;
      if not (M*TransposedMat(M) = lam*IdentityMat(4) and d = Enum.orbits[Enum.orbit_of[idx]].res.det) then
        Enum.det_mismatch := Enum.det_mismatch + 1;
      fi;
      idx := idx + step;
    od;
  fi;
  return Enum;
end;

#############################################################################
##  Main pair loop
#############################################################################
PAIR := List([1..N], i -> List([1..N], j -> fail));
CERTS := [];
Print("\n==== STEP 2/3: ordered pairs ", Elapsed(), "\n");
for b in REAL do
  Print("\n#### target b = ", b.case, "   computing Gram matrix of V_b ", Elapsed(), "\n");
  b.Gram := b.V * TransposedMat(b.V);
  Check(ForAll([1..b.n], i -> b.Gram[i][i] = b.w*b.w), "Gram diagonal constant = |w_b|^2");
  for a in REAL do
    if a.fvec <> b.fvec then
      Print("pair (", a.case, " -> ", b.case, "): inequivalent: different f-vector (", FvecStr(a.fvec), ") vs (", FvecStr(b.fvec), ")\n");
      PAIR[a.idx][b.idx] := rec(a := a.idx, b := b.idx, equal_fvec := false, similar := false);
      continue;
    fi;
    Print("\n== pair (", a.case, " -> ", b.case, ")  f-vector (", FvecStr(a.fvec), ")  |Gamma_a|=", a.order, " |Gamma_b|=", b.order, " ", Elapsed(), "\n");
    lam := (b.w*b.w)/(a.w*a.w);
    Print("  lambda = |w_b|^2/|w_a|^2 = ", lam, "  (~", ApproxReal(lam), ")\n");
    cE := Candidate(a, b, "even", lam);
    cO := Candidate(a, b, "odd", lam);
    for c in [cE, cO] do
      Print("  candidate ", c.mode, ": image tuple (1-based indices in V_b) ", c.tuple, "  Gram-consistent: ", c.gram_consistent, "\n");
      if c.M = fail then
        Print("    target rows linearly dependent -> no linear map; candidate fails\n");
      else
        Print("    (i)   traversal of all p face vertices: ", c.traversal, "\n");
        Print("    (ii)  M*M^T = lambda*I: ", c.res.mmt, "\n");
        Print("    (iii) det M = ", c.res.det, "  sign(det M/lambda^2) = ", SignStr(c.res.detsign), "\n");
        Print("    (iv)  vertex set onto vertex set: ", c.res.vertices, "\n");
        Print("    (v)   edges/faces/cells onto: ", c.res.edges, "/", c.res.faces, "/", c.res.cells, "\n");
        Print("    (vi)  M^-1 {S1,S2,X_a} M in Gamma_b: ", c.res.conj_fwd, "   M {S1,S2,X_b} M^-1 in Gamma_a: ", c.res.conj_bwd, "\n");
        Print("    (vii) conjugated triple orientation in Gamma_b: ", c.res.orientation,
              "  (RepresentativeAction and own conjugator search agree: ", c.res.orientation_consistent,
              "; exact equality with same triple: ", c.res.triple_exact_same, ", with mirror triple: ", c.res.triple_exact_mirror, ")\n");
        Print("    flag image = intended ", c.mode, " flag: ", c.flag_image_ok, "   (= intended flag with the other cell: ", c.flag_image_othercell,
              ";  image flag orbit: ", c.image_orbit, ")\n");
        Print("    => candidate ", c.mode, " passes (structure map): ", c.pass, ";  represents the ", c.mode, " coset: ", c.coset, "\n");
        if c.M <> fail then Print("    M = ", c.M, "\n"); fi;
      fi;
      if c.pass then
        Check(c.res.orientation_consistent, "orientation test: RepresentativeAction agrees with independent conjugator search");
        Check(c.res.orientation <> "both", "conjugated triple is not simultaneously conjugate to the same and the mirror triple (abstract chirality)");
        Check(c.flag_image_ok or c.flag_image_othercell, Concatenation("passing ", c.mode, " candidate maps the base flag of a to the intended flag of b or to the intended flag with the other cell"));
        Check((c.image_orbit = "even") = ((c.mode = "even") = c.flag_image_ok), "image flag orbit is even iff (even candidate and intended flag) or (odd candidate and other cell)");
        if c.image_orbit = "even" then
          Check(c.res.orientation = "same", Concatenation(c.mode, " candidate with even image orbit: conjugated triple is Gamma_b-conjugate to (S1,S2,X_b)"));
        else
          Check(c.res.orientation = "mirror", Concatenation(c.mode, " candidate with odd image orbit: conjugated triple is Gamma_b-conjugate to the mirror triple (S1^-1, S1^2 S2, X_b)"));
        fi;
        if c.mode = "even" and c.flag_image_ok then
          Check(c.res.triple_exact_same, "even candidate hitting the base flag: conjugated triple equals (S1,S2,X_b) exactly (free flag action)");
        fi;
        Add(CERTS, rec(a := a, b := b, c := c));
      fi;
    od;
    ## coset bookkeeping between the two candidates
    if cE.pass and cO.pass then
      if cE.coset and cO.coset then
        Check(MatInGroup(b, cE.M^-1*cO.M) = fail, "both candidates represent their own coset: M_even^-1 M_odd is NOT in Gamma_b (distinct cosets)");
      else
        Check(MatInGroup(b, cE.M^-1*cO.M) <> fail, "both candidates pass but only one hits its intended flag: M_even^-1 M_odd lies in Gamma_b (same coset)");
        Check(cE.coset or cO.coset, "at least one of the two passing candidates hits its intended flag");
      fi;
    elif cE.pass or cO.pass then
      Check(cE.coset or cO.coset, "the single passing candidate hits its intended flag");
    fi;
    ncosets := Number([cE, cO], c -> c.coset);
    if a.idx = b.idx then
      if cO.coset then
        Print("  !! a = b: the odd candidate PASSES and maps the base flag to its 2-adjacent flag: the realisation has a symmetry outside Gamma (NOT geometrically chiral)\n");
      elif cO.pass then
        Print("  a = b: the odd candidate passes but maps the base flag to (Phi^2)^3 (even orbit): it is an element of Gamma, not an extra symmetry; no similarity maps the base flag to its 2-adjacent flag: geometrically chiral (symmetry group = Gamma)\n");
      else
        Print("  a = b: odd candidate fails => no similarity of E^4 maps the base flag to its 2-adjacent flag: the realisation is geometrically chiral (symmetry group = Gamma)\n");
      fi;
      Check(cE.pass and cE.coset, "a = b: the even candidate (identity) passes and fixes the base flag");
      Check(cE.M = IdentityMat(4), "a = b: the even candidate matrix is the identity");
    fi;
    ## exhaustive enumeration
    Print("  exhaustive Gram-pruned enumeration ", Elapsed(), "\n");
    ENUMRES := Enumerate(a, b, lam);
    Print("    Gram-consistent ordered 4-tuples: ", ENUMRES.tuples, "   Gamma_b-orbits: ", Length(ENUMRES.orbits),
          "   full similarities: ", ENUMRES.sims, "   det signs: ", List(ENUMRES.signs, SignStr), "\n");
    for o in ENUMRES.orbits do
      Print("    orbit rep tuple ", o.tup, ": similarity=", o.res.all, " det sign=", SignStr(o.res.detsign),
            " vertices=", o.res.vertices, " edges=", o.res.edges, " faces=", o.res.faces, " cells=", o.res.cells,
            " conj=", o.res.conj_fwd, o.res.conj_bwd, " orientation=", o.res.orientation, "\n");
    od;
    Check(ENUMRES.orbit_size_ok, "each Gamma_b-orbit of anchor tuples has size |Gamma_b| (free action)");
    Check(ENUMRES.orbits_cover, "the recorded orbits partition the enumerated tuple list");
    Check(ENUMRES.det_mismatch = 0, Concatenation("direct recomputation of M*M^T and det M for ", String(ENUMRES.det_checked), " sampled tuples agrees with orbit representatives"));
    Check(ENUMRES.sims = b.order * ncosets, Concatenation("exhaustive similarity count ", String(ENUMRES.sims), " = |Gamma_b| * (number of flag-anchored cosets = ", String(ncosets), ")"));
    Check(Length(Filtered(ENUMRES.orbits, o -> o.res.all)) = ncosets, "number of similarity orbits found exhaustively = number of flag-anchored cosets");
    for c in [cE, cO] do
      if c.gram_consistent then
        k := PositionProperty(ENUMRES.orbits, o -> c.tuple in o.set);
        Check(k <> fail and ENUMRES.orbits[k].res.all = c.pass, Concatenation("candidate ", c.mode, " tuple is enumerated and its orbit verdict matches the candidate verdict"));
      else
        Check(not c.pass, Concatenation("candidate ", c.mode, " is not Gram-consistent and does not pass"));
      fi;
    od;
    Check(Set(List(Filtered([cE, cO], c -> c.pass), c -> c.res.detsign)) = ENUMRES.signs, "det signs of passing candidates = det signs found exhaustively");
    if ENUMRES.sims = 0 then
      Print("  => EXHAUSTIVE PROOF: no similarity of E^4 carries realisation ", a.case, " onto ", b.case, " (no Gram-consistent tuple yields a structure map).\n");
    else
      Print("  => ", ENUMRES.sims, " similarities ", a.case, " -> ", b.case, " (", Length(Filtered(ENUMRES.orbits, o -> o.res.all)), " Gamma_b-coset(s)), lambda = ", lam, ", det signs ", List(ENUMRES.signs, SignStr), "\n");
    fi;
    PAIR[a.idx][b.idx] := rec(a := a.idx, b := b.idx, equal_fvec := true, lam := lam, cE := cE, cO := cO, E := ENUMRES, cosets := ncosets,
                              similar := (ENUMRES.sims > 0), congruent := (ENUMRES.sims > 0 and lam = 1), signs := ENUMRES.signs);
  od;
  Unbind(b.Gram);
od;

#############################################################################
##  Outputs: TSV
#############################################################################
OrientStr := function(cE, cO)
  local parts;
  parts := [];
  if cE.pass then Add(parts, Concatenation("even:", cE.res.orientation)); fi;
  if cO.pass then Add(parts, Concatenation("odd:", cO.res.orientation)); fi;
  if parts = [] then return "none"; fi;
  return JoinStringsWithSeparator(parts, ";");
end;
SignsStr := function(signs)
  return Concatenation("{", JoinStringsWithSeparator(List(signs, SignStr), ","), "}");
end;
Verdict := function(pr)
  local s;
  if not pr.similar then return "R5-similar=no;R3-congruent=no"; fi;
  s := "R5-similar=yes;";
  if pr.congruent then s := Concatenation(s, "R3-congruent=yes;"); else s := Concatenation(s, "R3-congruent=no(lambda<>1);"); fi;
  if pr.signs = [1] then s := Concatenation(s, "proper");
  elif pr.signs = [-1] then s := Concatenation(s, "improper");
  else s := Concatenation(s, "proper+improper"); fi;
  return s;
end;

out := OutputTextFile(TSVFILE, false);
SetPrintFormattingStatus(out, false);
## columns 1-13 as specified; columns 14-17 are extra: image flag orbit of each
## candidate (even/odd/none), number of Gamma_b-cosets of similarities, |Gamma_b|
AppendTo(out, "case_a\tcase_b\tfvector\tlambda\teven_passes\todd_passes\teven_det_sign\todd_det_sign\ttriple_orientation_of_passing_candidate\texhaustive_tuples\texhaustive_similarities\texhaustive_det_signs\tverdict\teven_image_orbit\todd_image_orbit\tsimilarity_cosets\torder_Gamma_b\n");
for i in [1..N] do
  for j in [1..N] do
    pr := PAIR[i][j];
    if pr.equal_fvec then
      AppendTo(out, REAL[i].case, "\t", REAL[j].case, "\t(", FvecStr(REAL[i].fvec), ")\t", pr.lam, "\t",
               pr.cE.pass, "\t", pr.cO.pass, "\t", SignStr(pr.cE.res.detsign), "\t", SignStr(pr.cO.res.detsign), "\t",
               OrientStr(pr.cE, pr.cO), "\t", pr.E.tuples, "\t", pr.E.sims, "\t", SignsStr(pr.E.signs), "\t", Verdict(pr), "\t",
               pr.cE.image_orbit, "\t", pr.cO.image_orbit, "\t", pr.cosets, "\t", REAL[j].order, "\n");
    fi;
  od;
od;
CloseStream(out);
Print("\nwrote ", TSVFILE, "\n");

#############################################################################
##  Outputs: certificates JSON
#############################################################################
out := OutputTextFile(CERTFILE, false);
SetPrintFormattingStatus(out, false);
AppendTo(out, "[\n");
first := true;
for ce in CERTS do
  a := ce.a; b := ce.b; c := ce.c;
  if not first then AppendTo(out, ",\n"); fi;
  first := false;
  AppendTo(out, "{\"case_a\":", JS(a.case), ",\"case_b\":", JS(b.case), ",\"candidate\":", JS(c.mode),
           ",\"lambda\":", JC(c.res.lam), ",\"det\":", JC(c.res.det), ",\"det_sign\":", c.res.detsign,
           ",\"M\":", JMat(c.M), ",\"triple_orientation\":", JS(c.res.orientation),
           ",\"anchor_exponents\":", JInts(a.kk), ",\"image_tuple_0based\":", JInts(c.tuple - 1),
           ",\"checks\":{\"traversal\":", JBool(c.traversal), ",\"MMt_eq_lambda_I\":", JBool(c.res.mmt),
           ",\"det_eq_pm_lambda2\":", JBool(c.res.detsign <> 0), ",\"vertices\":", JBool(c.res.vertices),
           ",\"edges\":", JBool(c.res.edges), ",\"faces\":", JBool(c.res.faces), ",\"cells\":", JBool(c.res.cells),
           ",\"conj_S1a_in_Gamma_b\":", JBool(c.res.conj_fwd[1]), ",\"conj_S2a_in_Gamma_b\":", JBool(c.res.conj_fwd[2]),
           ",\"conj_Xa_in_Gamma_b\":", JBool(c.res.conj_fwd[3]),
           ",\"conj_S1b_in_Gamma_a\":", JBool(c.res.conj_bwd[1]), ",\"conj_S2b_in_Gamma_a\":", JBool(c.res.conj_bwd[2]),
           ",\"conj_Xb_in_Gamma_a\":", JBool(c.res.conj_bwd[3]),
           ",\"flag_image\":", JBool(c.flag_image_ok), ",\"flag_image_other_cell\":", JBool(c.flag_image_othercell),
           ",\"triple_exact_same\":", JBool(c.res.triple_exact_same),
           ",\"triple_exact_mirror\":", JBool(c.res.triple_exact_mirror),
           ",\"orientation_methods_agree\":", JBool(c.res.orientation_consistent), "}",
           ",\"image_flag_orbit\":", JS(c.image_orbit), ",\"represents_own_coset\":", JBool(c.coset), "}");
od;
AppendTo(out, "\n]\n");
CloseStream(out);
Print("wrote ", CERTFILE, "  (", Length(CERTS), " certificates)\n");

#############################################################################
##  Summary: equivalence relation, classes
#############################################################################
Print("\n==== SUMMARY ", Elapsed(), "\n");
SIM := List([1..N], i -> List([1..N], j -> PAIR[i][j].similar));
ISO := List([1..N], i -> List([1..N], j -> PAIR[i][j].similar and PAIR[i][j].equal_fvec and PAIR[i][j].lam = 1));
Check(ForAll([1..N], i -> SIM[i][i]), "similarity relation is reflexive");
Check(ForAll([1..N], i -> ForAll([1..N], j -> SIM[i][j] = SIM[j][i])), "similarity relation is symmetric");
Check(ForAll([1..N], i -> ForAll([1..N], j -> ForAll([1..N], k -> not (SIM[i][j] and SIM[j][k]) or SIM[i][k]))), "similarity relation is transitive");
Check(ForAll([1..N], i -> ForAll([1..N], j -> SIM[i][j] = SIM[j][i])) and
      ForAll([1..N], i -> ForAll([1..N], j -> ForAll([1..N], k -> not (ISO[i][j] and ISO[j][k]) or ISO[i][k]))), "isometry relation is symmetric and transitive");
## lambda consistency: lam(a,c) = lam(a,b)*lam(b,c) is automatic (ratio of norms)
Classes := function(REL)
  local seen, cl, i, j, comp;
  seen := []; cl := [];
  for i in [1..N] do
    if i in seen then continue; fi;
    comp := Filtered([1..N], j -> REL[i][j]);
    Add(cl, comp); UniteSet(seen, comp);
  od;
  return cl;
end;
SIMCL := Classes(SIM);
ISOCL := Classes(ISO);
Print("\nR5 classes (equivalence under similarities of E^4):\n");
for cl in SIMCL do
  Print("  class {", JoinStringsWithSeparator(List(cl, i -> REAL[i].case), ", "), "}");
  if Length(cl) > 1 then
    Print("   lambdas relative to ", REAL[cl[1]].case, ": ",
          JoinStringsWithSeparator(List(cl, i -> Concatenation(REAL[i].case, ":", String(PAIR[cl[1]][i].lam))), "  "));
  fi;
  Print("\n");
od;
Print("number of classes under similarity: ", Length(SIMCL), "\n");
Print("\nIsometry classes (similar with lambda = 1):\n");
for cl in ISOCL do
  Print("  class {", JoinStringsWithSeparator(List(cl, i -> REAL[i].case), ", "), "}\n");
od;
Print("number of classes under isometry (lambda = 1): ", Length(ISOCL), "\n");
Print("\nCertificates (passing flag-anchored candidates), a -> b:\n");
for ce in CERTS do
  Print("  ", ce.a.case, " -> ", ce.b.case, "  [", ce.c.mode, "]  lambda = ", ce.c.res.lam, " (~", ApproxReal(ce.c.res.lam),
        ")  det sign ", SignStr(ce.c.res.detsign), "  orientation ", ce.c.res.orientation,
        "  image flag orbit ", ce.c.image_orbit, "  own coset ", ce.c.coset, "\n");
od;
Print("\nNon-trivial certificate pairs (a <> b):\n");
for ce in Filtered(CERTS, ce -> ce.a.idx <> ce.b.idx) do
  Print("  ", ce.a.case, " -> ", ce.b.case, "  [", ce.c.mode, "]  lambda = ", ce.c.res.lam, "  det sign ", SignStr(ce.c.res.detsign),
        "  image flag orbit ", ce.c.image_orbit, "\n");
od;
Print("\nSelf-symmetry test (a = b): does some similarity map the base flag to its 2-adjacent flag?\n");
for i in [1..N] do
  Print("  ", REAL[i].case, ": odd candidate passes = ", PAIR[i][i].cO.pass, ", hits the 2-adjacent flag = ", PAIR[i][i].cO.coset,
        "  (exhaustive self-similarities: ", PAIR[i][i].E.sims, " = |Gamma| ", REAL[i].order, "? ", PAIR[i][i].E.sims = REAL[i].order,
        ")  => geometrically chiral: ", PAIR[i][i].E.sims = REAL[i].order and not PAIR[i][i].cO.coset, "\n");
od;
Print("Realisations whose full similarity group is larger than Gamma: ",
      Number([1..N], i -> PAIR[i][i].E.sims <> REAL[i].order), "\n");
Print("\nPairs with equal f-vector: ", Number(Concatenation(PAIR), pr -> pr.equal_fvec),
      ";  with different f-vector (inequivalent): ", Number(Concatenation(PAIR), pr -> not pr.equal_fvec), "\n");
Print("Pairs (a<>b) with equal f-vector and NO similarity (exhaustively proved): ",
      Number(Concatenation(PAIR), pr -> pr.equal_fvec and pr.a <> pr.b and not pr.similar), "\n");
Print("Pairs (a<>b) similar: ", Number(Concatenation(PAIR), pr -> pr.equal_fvec and pr.a <> pr.b and pr.similar),
      ";  of these congruent (lambda=1): ", Number(Concatenation(PAIR), pr -> pr.equal_fvec and pr.a <> pr.b and pr.congruent), "\n");
Print("Improper similarities found anywhere: ", Number(Concatenation(PAIR), pr -> pr.equal_fvec and -1 in pr.signs), "\n");

Print("\nSelf-check failures: ", NFAIL, "\n");
for m in FAILMSGS do Print("  FAILED: ", m, "\n"); od;
Print("total time ", Elapsed(), "\n");
Print("Done: ", SCRIPTNAME, "\n");
if NFAIL > 0 then QUIT_GAP(1); fi;
QUIT_GAP(0);
