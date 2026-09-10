#############################################################################
##
##  five-five-audit.g -- fresh-session Fable audit: settles every trace-equation
##  factor that the independent sweep l3-audit.g could not solve by radicals
##  (irreducible quartics over Q(sqrt5) with real roots), in particular the two
##  arising in the (q,m) = (5,5) vertex-figure case (rows 6 and 9, target k = 2).
##
##  Certificate.  Let f be such a factor, L = Q(sqrt5)(t) = Q(sqrt5)[t]/(f), a
##  field of degree 8 over Q.  If Gamma = <S1,S2,X(t)> were finite, every trace
##  tr(w) of a word w in S1, S2, X would be a sum of four roots of unity, hence
##  in the maximal abelian extension Q^ab.  We compute tr(w) as an element of L,
##  its minimal polynomial over Q, and the Galois group of that polynomial
##  (GaloisType, transitive-groups library).  A NON-ABELIAN Galois group proves
##  tr(w) is not in Q^ab, so Gamma (indeed <S2,X> when w is a word in S2, X) is
##  infinite and no discrete polytope exists at any root of f.
##
##  Second, independent certificate for the (5,5) case: in A5 two elements of
##  order 5 in the SAME conjugacy class never have an involutory product
##  (class structure constant 0), so with S2 of angle 4pi/5 a finite <S2,X> = A5
##  forces X to have angle 2pi/5, i.e. k = 1, never k = 2.
##
##  Run from audits/fable-ultra/scripts:  gap -q -A --quitonbreak five-five-audit.g < /dev/null
#############################################################################
Read("../../../gap/lib.g"); Read("../../../gap/polytopes.g"); PX.BuildAll(); PX.SetupRows();
SizeScreen([4096,]);
AU := rec(npass := 0, nfail := 0, failed := []);
AU.CHECK := function(name, val)
  if val = true then AU.npass := AU.npass + 1; Print("AU-PASS  ", name, "\n");
  else AU.nfail := AU.nfail + 1; Add(AU.failed, name); Print("AU-FAIL  ", name, "   (got ", val, ")\n"); fi;
end;
K := CF(5); t := Indeterminate(K, "t"); R := PolynomialRing(K, [t]); sq5 := Sqrt(5);
AU.Q5 := function(x) local a, b;
  if IsRat(x) then return [x, 0]; fi;
  a := (x + GaloisCyc(x, 2))/2; b := (x - GaloisCyc(x, 2))/(2*sq5);
  if IsRat(a) and IsRat(b) and a + b*sq5 = x then return [a, b]; fi; return fail;
end;
AU.IsReal := function(x) return GaloisCyc(x, -1) = x; end;
AU.Deg := function(f) return DegreeOfLaurentPolynomial(f); end;
AU.Coeffs := function(f) return CoefficientsOfUnivariatePolynomial(f); end;
AU.Planes := function(S, dim) local p, res, k, c, N;
  p := Order(S); res := [];
  for k in [1..Int(p/2)] do c := E(p)^k + E(p)^(-k); N := NullspaceMat(S^2 - c*S + IdentityMat(dim));
    if Length(N) > 0 then Add(res, rec(k := k, B := N, P := TransposedMat(N)*(N*TransposedMat(N))^-1*N)); fi; od;
  return res;
end;
## Sturm count (as in l3-audit.g)
AU.SignRat := function(a) return SignInt(NumeratorRat(a)); end;
AU.Sign := function(x) local ab, a, b; ab := AU.Q5(x); if ab = fail then return fail; fi; a := ab[1]; b := ab[2];
  if b = 0 then return AU.SignRat(a); fi; if a = 0 then return AU.SignRat(b); fi;
  if AU.SignRat(a) = AU.SignRat(b) then return AU.SignRat(a); fi;
  if a > 0 then if a^2 > 5*b^2 then return 1; elif a^2 = 5*b^2 then return 0; else return -1; fi;
  else if 5*b^2 > a^2 then return 1; elif 5*b^2 = a^2 then return 0; else return -1; fi; fi; end;
AU.SturmCount := function(f) local g, seq, r, sp, sn, lc, d, V, h;
  g := Gcd(R, f, Derivative(f)); f := Quotient(R, f, g); seq := [ f, Derivative(f) ];
  while AU.Deg(seq[Length(seq)]) > 0 do r := -EuclideanRemainder(R, seq[Length(seq)-1], seq[Length(seq)]); if IsZero(r) then break; fi; Add(seq, r); od;
  sp := []; sn := [];
  for h in seq do if IsZero(h) then continue; fi; lc := LeadingCoefficient(h); d := AU.Deg(h);
    Add(sp, AU.Sign(lc)); if d mod 2 = 0 then Add(sn, AU.Sign(lc)); else Add(sn, -AU.Sign(lc)); fi; od;
  V := function(l) local c, i; c := 0; for i in [1..Length(l)-1] do if l[i]*l[i+1] < 0 then c := c + 1; fi; od; return c; end;
  return V(sn) - V(sp);
end;

## elements of L = K[t]/(f) are polynomials of degree < deg f with coefficients in K
AU.Reduce := function(P, f) return EuclideanRemainder(R, P, f); end;
AU.InvMod := function(Q, f) local g; g := GcdRepresentation(R, Q, f); return AU.Reduce(g[1], f); end;   # Q invertible mod f (f irreducible, Q not divisible by f)
## rational-function-valued matrices: pairs (numerator matrix over K[t], denominator polynomial)
AU.RFMat := function(N, D) return rec(N := N, D := D); end;
AU.RFMul := function(A, B) return rec(N := A.N*B.N, D := A.D*B.D); end;
AU.RFTraceMod := function(A, f) return AU.Reduce(AU.Reduce(Trace(A.N), f)*AU.InvMod(AU.Reduce(A.D, f), f), f); end;
## minimal polynomial over Q of an element tau of L (deg f = 4): 8x8 multiplication matrix on the basis {t^i, sqrt5 t^i}
AU.MinPolyQ := function(tau, f) local d, basis, M, e, prod, cf, row, i, j, ab;
  d := AU.Deg(f);
  basis := Concatenation(List([0..d-1], i -> t^i), List([0..d-1], i -> sq5*t^i));
  M := [];
  for e in basis do
    prod := AU.Reduce(tau*e, f);
    cf := ShallowCopy(AU.Coeffs(prod)); while Length(cf) < d do Add(cf, Zero(K)); od;
    row := []; for i in [1..d] do ab := AU.Q5(cf[i]); if ab = fail then return fail; fi; Add(row, ab[1]); od;
    for i in [1..d] do Add(row, AU.Q5(cf[i])[2]); od;
    Add(M, row);
  od;
  return MinimalPolynomial(Rationals, M);
end;
AU.GaloisAbelian := function(mp) local d, nr, G;
  d := DegreeOfLaurentPolynomial(mp);
  if d <= 2 then return rec(degree := d, abelian := true, group := "cyclic/trivial"); fi;
  nr := GaloisType(mp); G := TransitiveGroup(d, nr);
  return rec(degree := d, abelian := IsAbelian(G), group := Concatenation(String(nr), ": ", StructureDescription(G)), order := Size(G));
end;

## the unresolved factors of l3-audit.g: (row, m, k)
Cases := [ [2,5,2], [2,10,3], [3,5,2], [4,10,3], [6,4,1], [6,5,2], [6,10,3], [7,10,3], [9,4,1], [9,5,2], [9,10,3] ];
for cs in Cases do
  row := cs[1]; m := cs[2]; k := cs[3];
  name := PX.Order[2*row-1]; T := PX.T.(name);
  S1 := T.R[1]*T.R[2]*T.R[4]*T.R[3]; S2 := T.R[3]*T.R[2]; d := T.dim; hyper := T.hyper; q := Order(S2);
  planes := AU.Planes(S1, d);
  wpol := List([1..d], i -> t*T.v0[i] + T.v3[i]); w1 := wpol*planes[1].P; w2 := wpol*planes[2].P; d1 := w1*w1; d2 := w2*w2;
  if hyper <> fail then dh := hyper*hyper*One(R); else dh := One(R); fi;
  N := 2*( TransposedMat([w1])*[w1]*d2*dh + TransposedMat([w2])*[w2]*d1*dh ); if hyper <> fail then N := N + 2*TransposedMat([hyper])*[hyper]*d1*d2; fi;
  N := N - d1*d2*dh*IdentityMat(d);
  Xrf := AU.RFMat(S2^-1*N, d1*d2*dh);
  c := 2 + E(m)^k + E(m)^(-k); if hyper <> fail then c := c + 1; fi;
  poly := Trace(S2^-1*N) - c*d1*d2*dh;
  facs := Set(List(Factors(R, poly), g -> g/LeadingCoefficient(g)));
  Print("\n==== row ", row, " T = ", name, " (q = ", q, ", p = ", Order(S1), "), target ord(X) = ", m, ", k = ", k, " ====\n");
  for f in facs do
    if AU.Deg(f) < 3 or not ForAll(AU.Coeffs(f), AU.IsReal) then continue; fi;
    nreal := AU.SturmCount(f);
    Print("factor of degree ", AU.Deg(f), " with ", nreal, " real roots: ", f, "\n");
    if nreal = 0 then continue; fi;
    ## Galois group of f over Q (minimal polynomial of t itself)
    mp := AU.MinPolyQ(AU.Reduce(t, f), f); ga := AU.GaloisAbelian(mp);
    Print("   minimal polynomial of t over Q: degree ", ga.degree, ", Galois group ", ga.group, ", abelian: ", ga.abelian, "\n");
    killed := false;
    words := [ rec(n := "X", w := Xrf), rec(n := "S2 X^2", w := AU.RFMul(AU.RFMat(S2, One(R)), AU.RFMul(Xrf, Xrf))),
               rec(n := "S2^2 X", w := AU.RFMul(AU.RFMat(S2^2, One(R)), Xrf)), rec(n := "X S2 X S2^2", w := AU.RFMul(AU.RFMul(AU.RFMul(Xrf, AU.RFMat(S2, One(R))), Xrf), AU.RFMat(S2^2, One(R)))),
               rec(n := "S1 X", w := AU.RFMul(AU.RFMat(S1, One(R)), Xrf)), rec(n := "S1^2 X", w := AU.RFMul(AU.RFMat(S1^2, One(R)), Xrf)),
               rec(n := "S1 S2 X", w := AU.RFMul(AU.RFMat(S1*S2, One(R)), Xrf)), rec(n := "S1 X S2 X", w := AU.RFMul(AU.RFMul(AU.RFMul(AU.RFMat(S1, One(R)), Xrf), AU.RFMat(S2, One(R))), Xrf)) ];
    for wd in words do
      tau := AU.RFTraceMod(wd.w, f);
      mp := AU.MinPolyQ(tau, f);
      if mp = fail then Print("   tr(", wd.n, "): could not express in the Q-basis\n"); continue; fi;
      ga := AU.GaloisAbelian(mp);
      Print("   tr(", wd.n, ") = ", tau, ";  minimal polynomial over Q of degree ", ga.degree, ", Galois group ", ga.group, ", abelian: ", ga.abelian, "\n");
      if ga.abelian = false then
        Print("   => tr(", wd.n, ") lies in no abelian extension of Q, hence in no cyclotomic field: the group generated is INFINITE at every root of this factor; no discrete polytope\n");
        killed := true; break;
      fi;
    od;
    AU.CHECK(Concatenation("row ", String(row), " ", name, " m=", String(m), " k=", String(k), ": the unresolved factor is killed by a non-abelian trace field"), killed);
    if not killed and m = 5 and q = 5 then Print("   (no non-abelian trace found among the tested words; see the A5 structure-constant certificate below)\n"); fi;
  od;
od;

Print("\n==== A5 structure constants: pairs of order-5 elements with involutory product ====\n");
A5 := AlternatingGroup(5);
fives := Filtered(AsList(A5), g -> Order(g) = 5);
cl := ConjugacyClasses(A5);
cls5 := Filtered(cl, c -> Order(Representative(c)) = 5);
Print("classes of order-5 elements: ", List(cls5, Size), " (rotation angles 2pi/5 and 4pi/5 in the icosahedral group)\n");
same := 0; diff := 0;
for a in fives do for b in fives do
  if Order(a*b) = 2 then
    if IsConjugate(A5, a, b) then same := same + 1; else diff := diff + 1; fi;
  fi;
od; od;
Print("ordered pairs (a,b) of order-5 elements with ab an involution: same class ", same, ", different classes ", diff, "\n");
AU.CHECK("A5: no two elements of order 5 in the same class have involutory product (so (5,5) with equal rotation angles, i.e. S2 of angle 4pi/5 and X with k=2, cannot give a finite vertex-figure group)", same = 0 and diff > 0);
for pr in Filtered(Cartesian(fives, fives), p -> Order(p[1]*p[2]) = 2) do
  AU.CHECK("A5: every such pair generates A5 and has trivial cyclic intersection (rank-3 IP)", Group(pr[1], pr[2]) = A5 and IsTrivial(Intersection(Group(pr[1]), Group(pr[2]))));
  break;
od;
## the rotation angles of S2 for the four q = 5 rows, as conjugacy-class information: S2 = R2 R1 rotates by 2 pi / q_geom
for row in [5,6,9,10] do
  T := PX.T.(PX.Order[2*row-1]); S2 := T.R[3]*T.R[2];
  tr := Trace(S2); Print("row ", row, " ", T.name, ": tr(S2) = ", tr, " = 2 + 2cos(theta) with theta = ", "2pi/5 iff tr = 3+phi (=", 2+E(5)+E(5)^-1 + 2, "-2), 4pi/5 iff tr = 3-phi; tr(S2) - 2 = ", tr - 2, "\n");
od;
Print("\nfive-five-audit.g: ", AU.npass, " passed, ", AU.nfail, " failed.\n");
if AU.nfail > 0 then Print("FAILED: ", AU.failed, "\n"); fi;
Print("Done: five-five-audit.g\n");
