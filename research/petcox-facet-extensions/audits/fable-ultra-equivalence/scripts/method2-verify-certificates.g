# method2-verify-certificates.g
# ---------------------------------------------------------------------------
# Independent GAP re-verification of the similarity certificates produced by
# method2-canonical.sage (../logs/method2-certificates.g).  Uses ONLY the stored
# data ($DATA) and the certificate matrices; all orbit / incidence code is
# written here (no producer library).  Exact cyclotomic arithmetic throughout.
#
# Run (transcript):
#   cd $AUDIT/scripts && /private/var/tmp/sage-10.7-current/local/bin/gap -q -A --quitonbreak \
#       method2-verify-certificates.g < /dev/null 2>&1 | tee ../logs/method2-verify-certificates.log
#
# Conventions: row vectors, v*M ("A*B = A first, then B"); v^M = v*M in GAP.
# For each certificate (a, b, M, lambda, det_sign) we rebuild both realisations
#   V = Orbit of w under Gamma = <S1,S2,X>;  E = orbit of {w, w*S1^-1};
#   F = orbit of the p-cycle {w*S1^k, w*S1^(k+1)} (p = Order(S1)), as a set of edges;
#   C = orbit of the <S1,S2>-orbit of the base face (a set of faces)
# and check exactly:  M*M^T = lambda*I,  lambda = (w_b.w_b)/(w_a.w_a),
#   Det(M) = det_sign*lambda^2,  V_a*M = V_b,  E_a*M = E_b,  F_a*M = F_b,  C_a*M = C_b.
# ---------------------------------------------------------------------------
## Paths: PETCOX_DATA from the environment when set (run-all.sh), else the session's
## extraction; certificates from ../logs relative to scripts/.  (Only these two lines
## were edited by the audit author after delivery.)
if IsBound(GAPInfo.SystemEnvironment.PETCOX_DATA) then DATA := GAPInfo.SystemEnvironment.PETCOX_DATA; else DATA := "/private/tmp/claude-501/-Users-daniel-github-skeletal-polytopes/d4b2e626-5fbc-48d1-9c01-c9dc4a79290e/scratchpad/producer/research/petcox-facet-extensions/logs/alpha-survivors.g"; fi;
CERTS := "../logs/method2-certificates.g";

PX := rec();
Read(DATA);
Read(CERTS);
Print("=== method2-verify-certificates.g ===\n");
Print("records in DATA: ", Length(PX.Saved), " ; certificates: ", Length(M2CERTS), "\n");

nfail := 0;
Check := function(cond, msg)
  if cond then Print("  [ok]   ", msg, "\n");
  else Print("  [FAIL] ", msg, "\n"); nfail := nfail + 1; fi;
  return cond;
end;

OnSetsSetsSets := function(c, g) return Set(List(c, f -> OnSetsSets(f, g))); end;

ExpectedF := function(T, num)
  if T = "{4,3,3}" then return [16, 32, 12, 4]; fi;
  if T = "{5,3,3}" or T = "{3,3,5/2}" then return [600, 1200, 120, 5]; fi;
  if T = "{5,3,5/2}" then
    if num <= 4 then return [240, 480, 120, 20];
    elif num <= 8 then return [48, 144, 48, 8];
    else return [120, 720, 300, 50]; fi;
  fi;
  return fail;
end;

CaseNum := function(case)
  local parts;
  parts := SplitString(case, "-");
  return Int(parts[Length(parts)]);
end;

cache := rec();
Build := function(r)
  local G, H, V, e0, E, p, f0, F, c0, C, key, res;
  key := ReplacedString(ReplacedString(ReplacedString(r.case, "{", "_"), "}", "_"), "/", "_");
  key := ReplacedString(ReplacedString(key, ",", "_"), "-", "_");
  if IsBound(cache.(key)) then return cache.(key); fi;
  G := Group(r.S1, r.S2, r.X);
  H := Group(r.S1, r.S2);
  V := Set(Orbit(G, r.w, OnRight));
  e0 := Set([r.w, r.w * r.S1^-1]);
  E := Set(Orbit(G, e0, OnSets));
  p := Order(r.S1);
  f0 := Set(List([0..p-1], k -> Set([r.w * r.S1^k, r.w * r.S1^(k+1)])));
  F := Set(Orbit(G, f0, OnSetsSets));
  c0 := Set(Orbit(H, f0, OnSetsSets));
  C := Set(Orbit(G, c0, OnSetsSetsSets));
  res := rec(V := V, E := E, F := F, C := C, fvec := [Length(V), Length(E), Length(F), Length(C)],
             order := Size(G), p := p, ww := r.w * r.w);
  Print("  built ", r.case, ": f-vector ", res.fvec, ", |Gamma| = ", res.order, ", p = ", p, ", w.w = ", res.ww, "\n");
  Check(res.fvec = ExpectedF(r.T, CaseNum(r.case)), Concatenation("f-vector of ", r.case, " as expected"));
  Check(Length(f0) = p, "base face has p distinct edges");
  Check(IsSubset(E, f0), "base face edges lie in the edge orbit");
  cache.(key) := res;
  return res;
end;

ra := fail; rb := fail; A := fail; B := fail; M := fail; lam := fail;   # pre-declare loop globals (avoids parse-time warnings)
for c in M2CERTS do
  Print("\n--- certificate ", c.case_a, " -> ", c.case_b, "\n");
  ra := First(PX.Saved, r -> r.case = c.case_a);
  rb := First(PX.Saved, r -> r.case = c.case_b);
  A := Build(ra);
  B := Build(rb);
  M := c.M;
  lam := c.lambda;
  Print("  M = ", M, "\n  lambda = ", lam, "  det_sign = ", c.det_sign, "\n");
  Check(ForAll(M, row -> ForAll(row, x -> IsCyclotomic(x) and x = GaloisCyc(x, -1))), "M has real cyclotomic entries");
  Check(M * TransposedMat(M) = lam * IdentityMat(4), "M*M^T = lambda*I (exact)");
  Check(lam = B.ww / A.ww, "lambda = (w_b.w_b)/(w_a.w_a) (exact)");
  Check(DeterminantMat(M) = c.det_sign * lam^2, Concatenation("Det(M) = ", String(c.det_sign), "*lambda^2 (exact)"));
  Check(Set(List(A.V, v -> v * M)) = B.V, "V_a * M = V_b (vertex sets, exact)");
  Check(Set(List(A.E, e -> OnSets(e, M))) = B.E, "E_a * M = E_b (edge sets, exact)");
  Check(Set(List(A.F, f -> OnSetsSets(f, M))) = B.F, "F_a * M = F_b (2-face sets, exact)");
  Check(Set(List(A.C, x -> OnSetsSetsSets(x, M))) = B.C, "C_a * M = C_b (cell sets, exact)");
  if c.raw_congruent then Check(lam = 1, "raw-congruent pair has lambda = 1");
  else Check(lam <> 1, "non-congruent pair has lambda <> 1"); fi;
  if c.proper_similar then Check(c.det_sign = 1, "proper-similar pair: certificate is proper (det > 0)"); fi;
od;

Print("\ncertificates verified: ", Length(M2CERTS), " ; failures: ", nfail, "\n");
Print("Done: method2-verify-certificates.g\n");
if nfail > 0 then QUIT_GAP(1); else QUIT_GAP(0); fi;
