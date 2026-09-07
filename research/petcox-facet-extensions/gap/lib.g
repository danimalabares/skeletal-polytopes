#############################################################################
##
##  lib.g  --  exact GAP machinery for testing PETCOX polyhedra H_alpha(T)
##             as facets of chiral skeletal 4-polytopes in E^4.
##
##  Conventions.
##   * Matrices act on ROW vectors from the right (GAP convention): v*M.
##     A product A*B therefore means "A first, then B".
##   * A regular 4-polytope T is stored as a record with fields
##       name, R (4 hyperplane reflections R[1..4] = R_0..R_3), W (matrix
##       group), dim (ambient dimension, 4 or 5), v0 (base vertex, exact,
##       unnormalised), v3 (normalised-direction representative of the
##       centroid of the base cell, exact, unnormalised), hyper (for the
##       simplex: the all-ones vector spanning the orthogonal complement of
##       the 4-space; otherwise fail).
##   * The PETCOX facet generators (paper eq. (2),(3)) are
##       S1 = R0 R1 R3 R2,   S2 = R2 R1,
##     and the canonical third generator is S3 = R3 R2.
##   * Schulte-Weiss orientation: (S1 S2)^2 = (S2 S3)^2 = (S1 S2 S3)^2 = 1,
##     mirror substitution S1 -> S1^-1, S2 -> S1^2 S2, S3 -> S3.
##
##  Everything is exact: entries lie in cyclotomic fields (Sqrt(5) etc.).
##
#############################################################################

PX := rec();
SizeScreen([ 4096, ]);

PX.phi := (1+Sqrt(5))/2;

#############################################################################
##  Assertion framework (PASS/FAIL lines; verify.sh greps for FAIL)
#############################################################################
PX.npass := 0; PX.nfail := 0; PX.failed := [];
PX.CHECK := function(name, value)
  if value = true then
    PX.npass := PX.npass + 1; Print("PASS  ", name, "\n");
  else
    PX.nfail := PX.nfail + 1; Add(PX.failed, name);
    Print("FAIL  ", name, "   (got ", value, ")\n");
  fi;
end;
PX.CHECKEQ := function(name, actual, expected)
  if actual = expected then
    PX.npass := PX.npass + 1; Print("PASS  ", name, " = ", expected, "\n");
  else
    PX.nfail := PX.nfail + 1; Add(PX.failed, name);
    Print("FAIL  ", name, "   (expected ", expected, ", got ", actual, ")\n");
  fi;
end;
PX.Summary := function(title)
  Print("\n", title, ": ", PX.npass, " passed, ", PX.nfail, " failed.\n");
  if PX.nfail > 0 then Print("FAILED CHECKS: ", PX.failed, "\n"); fi;
end;

#############################################################################
##  Linear algebra helpers
#############################################################################
PX.Reflection := function(u)   # reflection in the hyperplane orthogonal to u
  return IdentityMat(Length(u)) - 2*TransposedMat([u])*[u]/(u*u);
end;

## a nonzero vector orthogonal to all rows of A (and to hyper if given)
PX.Orthogonal := function(A, hyper)
  local rows, N;
  rows := ShallowCopy(A);
  if hyper <> fail then Add(rows, hyper); fi;
  N := NullspaceMat(TransposedMat(rows));
  if Length(N) <> 1 then Error("PX.Orthogonal: expected a 1-dimensional solution space, got ", Length(N)); fi;
  return N[1];
end;

## the mirrors of the basic tetrahedron v0,v1,v2,v3: R_i is the reflection in
## the hyperplane through the origin and the v_j, j <> i.
PX.MirrorsFromTetrahedron := function(vs, hyper)
  return List([1..4], i -> PX.Reflection(PX.Orthogonal(vs{Difference([1..4],[i])}, hyper)));
end;

## normal vector of a reflection matrix
PX.NormalOf := function(X)
  local M;
  M := IdentityMat(Length(X)) - X;
  return First(M, r -> r <> 0*r);
end;

PX.IsHyperplaneReflection := function(X)
  local n;
  n := Length(X);
  return X^2 = IdentityMat(n) and X <> IdentityMat(n) and RankMat(X - IdentityMat(n)) = 1;
end;

## Square root of a real cyclotomic number, computed exactly, or fail.
## Strategy (no recursion): rationals via Sqrt; then the ansatz
## y = c + d sqrt5 for x in Q(sqrt5); then y = sqrt(m)(c + d sqrt5) for a
## small square-free m; finally a root of t^2 - x in a small cyclotomic field.
PX.SqrtCycCore := function(x)
  local s, p, q, disc, r, c, d, y;
  if IsRat(x) then
    if x < 0 then return fail; fi;
    y := Sqrt(x);
    if y^2 = x then return y; fi;
    return fail;
  fi;
  s := Sqrt(5);
  p := (x + GaloisCyc(x, 2))/2;
  q := (x - GaloisCyc(x, 2))/(2*s);
  if not (IsRat(p) and IsRat(q)) then return fail; fi;
  ## y = c + d sqrt5 with c^2 + 5 d^2 = p and 2 c d = q; c^2 is a root of
  ## z^2 - p z + 5 q^2/4 = 0
  disc := p^2 - 5*q^2;
  if disc < 0 then return fail; fi;
  for r in [ (p + Sqrt(disc))/2, (p - Sqrt(disc))/2 ] do
    if IsRat(r) and r >= 0 then
      c := Sqrt(r);
      if IsRat(c) or c^2 = r then
        if c <> 0 then d := q/(2*c); else d := Sqrt(p/5); fi;
        y := c + d*s;
        if y^2 = x then return y; fi;
      fi;
    fi;
  od;
  return fail;
end;

PX.SqrtCyc := function(x)
  local y, m, fld, rr, t, R, n0;
  y := PX.SqrtCycCore(x);
  if y <> fail then return y; fi;
  for m in [2,3,5,6,7,10,11,13,14,15,21,22,26,30] do
    y := PX.SqrtCycCore(x/m);
    if y <> fail then
      y := y*Sqrt(m);
      if y^2 = x then return y; fi;
    fi;
  od;
  ## last resort: a root of t^2 - x in a cyclotomic field containing x
  n0 := Conductor(x);
  t := Indeterminate(CF(n0), "sqrtvar");
  for m in [1, 2, 4, 8, 3, 6, 12, 5] do
    if Phi(Lcm(n0, 8*m)) > 32 then continue; fi;      # keep the search cheap
    fld := CF(Lcm(n0, 8*m));
    rr := RootsOfUPol(fld, t^2 - x);
    if Length(rr) > 0 then
      for y in rr do
        if y^2 = x and GaloisCyc(y, -1) = y then return y; fi;
      od;
    fi;
  od;
  return fail;
end;

## floating approximation of a real cyclotomic (for display only)
PX.Float := function(x)
  local c, i, n, s, r, e, k;
  if IsRat(x) then return Float(x); fi;
  n := Conductor(x);
  c := CoeffsCyc(x, n);
  s := 0.0;
  for k in [1..n] do
    if c[k] <> 0 then s := s + Float(c[k])*Cos(2*3.14159265358979323846*(k-1)/n); fi;
  od;
  return s;
end;

#############################################################################
##  Regular polytope records
#############################################################################

## Build the record from four reflections and a base vertex direction v0.
## v3 := the centroid of the base cell (average of the orbit of v0 under
## <R0,R1,R2>), exact and unnormalised.  name is a string.
PX.MakePolytope := function(name, R, v0, hyper)
  local T, cellgrp, cellverts, c;
  T := rec(name := name, R := R, dim := Length(v0), hyper := hyper);
  T.W := Group(R);
  T.v0 := v0;
  cellgrp := Group(R{[1,2,3]});
  cellverts := Orbit(cellgrp, v0, OnPoints);
  c := Sum(cellverts)/Length(cellverts);
  if c = 0*c then Error("PX.MakePolytope: cell centroid is the origin"); fi;
  T.v3 := c;
  T.cellsize := Length(cellverts);
  # sanity: v0 fixed by R1,R2,R3 and moved by R0; v3 fixed by R0,R1,R2
  if not ForAll([2,3,4], i -> v0*R[i] = v0) or v0*R[1] = v0 then
    Error("PX.MakePolytope: v0 is not the base vertex of the mirrors");
  fi;
  if not ForAll([1,2,3], i -> T.v3*R[i] = T.v3) then
    Error("PX.MakePolytope: centroid not fixed by R0,R1,R2");
  fi;
  return T;
end;

## The dual polytope: reversed reflections; base vertex = centroid direction
## of the base cell of T; its own cell centroid is recomputed.
PX.Dual := function(T, name)
  return PX.MakePolytope(name, Reversed(T.R), T.v3, T.hyper);
end;

## Schlaefli symbol data of a polytope record: the orders of R_{i-1}R_i and
## the geometric marks p_i determined by cos^2(pi/p_i) = (u_{i-1}.u_i)^2/(|u|^2|u'|^2)
PX.MarkFromCos2 := function(c2)
  local phi;
  phi := PX.phi;
  if c2 = 1/4 then return 3; fi;
  if c2 = 1/2 then return 4; fi;
  if c2 = (phi/2)^2 then return 5; fi;
  if c2 = ((phi-1)/2)^2 then return 5/2; fi;
  return fail;
end;
PX.SchlaefliData := function(T)
  local us, i, marks, orders;
  us := List(T.R, PX.NormalOf);
  marks := List([1..3], i -> PX.MarkFromCos2((us[i]*us[i+1])^2/((us[i]*us[i])*(us[i+1]*us[i+1]))));
  orders := List([1..3], i -> Order(T.R[i]*T.R[i+1]));
  return rec(marks := marks, orders := orders,
             commuting := ForAll([[1,3],[1,4],[2,4]], p -> T.R[p[1]]*T.R[p[2]] = T.R[p[2]]*T.R[p[1]]),
             involutions := ForAll(T.R, PX.IsHyperplaneReflection));
end;
PX.FVectorOfT := function(T)
  local W, R;
  W := T.W; R := T.R;
  return [ Index(W, Subgroup(W, R{[2,3,4]})), Index(W, Subgroup(W, R{[1,3,4]})),
           Index(W, Subgroup(W, R{[1,2,4]})), Index(W, Subgroup(W, R{[1,2,3]})) ];
end;

## The PETCOX triple of T (canonical): S1 = R0 R1 R3 R2, S2 = R2 R1, S3 = R3 R2.
PX.CanonicalTriple := function(T)
  local R;
  R := T.R;
  return [ R[1]*R[2]*R[4]*R[3], R[3]*R[2], R[4]*R[3] ];
end;

#############################################################################
##  alpha and the PETCOX great circle
#############################################################################

## Express w = a*v0 + b*v3 (exact); returns [a,b] or fail if w is not in the plane.
PX.PlaneCoordinates := function(T, w)
  local sol;
  sol := SolutionMat([T.v0, T.v3], w);
  return sol;
end;

## PETCOX alpha of the direction a*v0 + b*v3 (v0, v3 unnormalised):
## with unit vectors, w = a|v0| v0^ + b|v3| v3^, so
##   alpha = b|v3| / (a|v0| + b|v3|)  (projective; alpha = infinity if the
## denominator vanishes).  Returns a record with exact alpha when the norm
## ratio rho = |v0|/|v3| is a cyclotomic, otherwise a float, plus flags.
PX.AlphaOf := function(T, a, b)
  local rho2, rho, r, den;
  rho2 := (T.v0*T.v0)/(T.v3*T.v3);
  rho := PX.SqrtCyc(rho2);
  r := rec(a := a, b := b, rho2 := rho2);
  if b = 0 then r.alpha := 0; r.exact := true; return r; fi;
  if a = 0 then r.alpha := 1; r.exact := true; return r; fi;
  # alpha = 1/(1 + (a/b) rho)
  if (a/b)^2 * rho2 = 1 then
    # alpha is 1/2 or infinity depending on the sign of (a/b)*rho
    if rho <> fail then
      if (a/b)*rho = 1 then r.alpha := 1/2; else r.alpha := infinity; fi;
      r.exact := true; return r;
    fi;
  fi;
  if rho <> fail then
    den := 1 + (a/b)*rho;
    if den = 0 then r.alpha := infinity; else r.alpha := 1/den; fi;
    r.exact := true;
  else
    den := 1 + PX.Float(a/b)*Sqrt(PX.Float(rho2));
    if den = 0.0 then r.alpha := infinity; else r.alpha := 1/den; fi;
    r.exact := false;
  fi;
  return r;
end;

## The PETCOX base vertex direction for a given alpha (needs unit vectors;
## returns an exact vector when the norms are cyclotomic, else fail)
PX.BaseVertexAtAlpha := function(T, alpha)
  local n0, n3;
  n0 := PX.SqrtCyc(T.v0*T.v0); n3 := PX.SqrtCyc(T.v3*T.v3);
  if n0 = fail or n3 = fail then return fail; fi;
  if alpha = infinity then return T.v3/n3 - T.v0/n0; fi;
  return (1-alpha)*T.v0/n0 + alpha*T.v3/n3;
end;

## Fixed locus of a matrix X inside the plane spanned by v0, v3:
## the solutions (a,b) of (a v0 + b v3) X = a v0 + b v3.
PX.FixedLocusInPlane := function(T, X)
  local I, N;
  I := IdentityMat(T.dim);
  N := NullspaceMat([ T.v0*(X - I), T.v3*(X - I) ]);
  return N;    # list of [a,b] rows; Length = dimension of the fixed locus in the plane
end;

## Fixed subspace of a list of matrices (pointwise), as a basis of row vectors;
## restricted to the 4-space if hyper <> fail.
PX.CommonFixedSpace := function(mats, dim, hyper)
  local I, M, N;
  I := IdentityMat(dim);
  M := Concatenation(List(mats, X -> TransposedMat(X - I)));   # rows: columns of (X-I)
  # v fixed by X  <=>  v (X-I) = 0  <=>  (X-I)^T v^T = 0
  N := NullspaceMat(TransposedMat(M));
  if hyper <> fail then
    # intersect with hyper^perp: solve within N for vectors orthogonal to hyper
    N := List(NullspaceMat(TransposedMat([List(N, n -> n*hyper)])), c -> c*N);
  fi;
  return N;
end;

#############################################################################
##  Twist type of an orthogonal matrix of finite order (4-space part)
##  returns rec(p, pairs) with pairs = list of [p1,p2], 0<=p1<=p2<=p/2, such
##  that the eigenvalues (on the 4-space) are E(p)^{+-p1}, E(p)^{+-p2}.
#############################################################################
PX.TwistType := function(S, hyper)
  local p, k, tr, cands, p1, p2, ok, res, sub, d;
  p := Order(S);
  d := Length(S);
  res := [];
  for p1 in [0..Int(p/2)] do for p2 in [p1..Int(p/2)] do
    ok := true;
    for k in [1..4] do
      tr := Trace(S^k);
      if hyper <> fail then tr := tr - 1; fi;   # remove the fixed all-ones direction
      if tr <> E(p)^(k*p1) + E(p)^(-k*p1) + E(p)^(k*p2) + E(p)^(-k*p2) then ok := false; break; fi;
    od;
    if ok then Add(res, [p1,p2]); fi;
  od; od;
  return rec(p := p, pairs := res);
end;

#############################################################################
##  Group-theoretic checks (done in a faithful permutation image)
#############################################################################

## rec with perm group image and generator images
PX.PermSetup := function(Wmat)
  local iso;
  iso := IsomorphismPermGroup(Wmat);
  return rec(iso := iso, P := Image(iso), im := (m -> Image(iso, m)));
end;

PX.StringRelations := function(S)
  local S1, S2, S3;
  S1 := S[1]; S2 := S[2]; S3 := S[3];
  return rec(orders := List(S, Order),
             r12 := Order(S1*S2), r23 := Order(S2*S3), r123 := Order(S1*S2*S3), r321 := Order(S3*S2*S1),
             holds := (Order(S1*S2) = 2 and Order(S2*S3) = 2 and Order(S1*S2*S3) = 2));
end;

## Rank-4 intersection condition (Schulte-Weiss Lemma 11 / BJS eq. (5)),
## with the defect |<S1,S2> cap <S2,S3> : <S2>| reported.  Groups are
## subgroups of the same permutation group P.
PX.IntersectionData := function(P, s)
  local A, B, C2, I, r;
  A := Subgroup(P, s{[1,2]}); B := Subgroup(P, s{[2,3]}); C2 := Subgroup(P, [s[2]]);
  I := Intersection(A, B);
  r := rec();
  r.i12_trivial := IsTrivial(Intersection(Subgroup(P,[s[1]]), C2));
  r.i23_trivial := IsTrivial(Intersection(C2, Subgroup(P,[s[3]])));
  r.I := I;
  r.I_equals_S2 := (I = C2);
  r.I_contains_S2 := IsSubgroup(I, C2);
  r.defect := Size(I)/Size(C2);
  r.holds := r.i12_trivial and r.i23_trivial and r.I_equals_S2;
  return r;
end;

## Coset f-vector of P(Gamma; S1,S2,S3)
PX.FVector := function(P, s)
  local G;
  G := Subgroup(P, s);
  return [ Index(G, Subgroup(G, s{[2,3]})), Index(G, Subgroup(G, [s[3], s[1]*s[2]])),
           Index(G, Subgroup(G, [s[1], s[2]*s[3]])), Index(G, Subgroup(G, s{[1,2]})) ];
end;

## Face groups Gamma^0..Gamma^3 in P
PX.FaceGroups := function(P, s)
  return [ Subgroup(P, s{[2,3]}), Subgroup(P, [s[3], s[1]*s[2]]),
           Subgroup(P, [s[1], s[2]*s[3]]), Subgroup(P, s{[1,2]}) ];
end;

PX.Mirror := function(s) return [ s[1]^-1, s[1]^2*s[2], s[3] ]; end;
PX.Mirror3 := function(s) return [ s[1]^-1, s[1]^2*s[2] ]; end;

## Schulte-Weiss Theorem 1(c) test, with full rigour:
## the assignment extends to a homomorphism (GAP checks well-definedness),
## which is then checked to be bijective and involutory.  If it fails, an
## explicit obstruction is produced: a relator of a certified presentation on
## the generators whose mirror image is nontrivial, plus the order witness
## ord(S1^-1 S3) vs ord(S1 S3).
PX.MirrorTest := function(P, s)
  local G, hom, r, mir, pres, fp, F, fg, rels, w, img, i, iso, Ffp, oldgens;
  G := Subgroup(P, s);
  mir := PX.Mirror(s);
  r := rec();
  r.ord_S1invS3 := Order(s[1]^-1*s[3]);
  r.ord_S1S3 := Order(s[1]*s[3]);
  hom := GroupHomomorphismByImages(G, G, s, mir);
  r.hom := hom;
  r.extends := (hom <> fail);
  if hom <> fail then
    r.bijective := IsBijective(hom);
    r.involutory := ForAll(s, g -> Image(hom, Image(hom, g)) = g);
    r.directly_regular := r.bijective and r.involutory;
  else
    r.bijective := false; r.involutory := false; r.directly_regular := false;
    # certified presentation on exactly these generators
    Reset(GlobalMersenneTwister); Reset(GlobalRandomSource);
    iso := IsomorphismFpGroupByGenerators(G, s);
    Ffp := Range(iso);
    if List(s, x -> Image(iso, x)) <> GeneratorsOfGroup(Ffp) then Error("generator correspondence"); fi;
    oldgens := GeneratorsOfGroup(FreeGroupOfFpGroup(Ffp));
    F := FreeGroup("S1","S2","S3"); fg := GeneratorsOfGroup(F);
    rels := List(RelatorsOfFpGroup(Ffp), w -> MappedWord(w, oldgens, fg));
    r.presentation_certified := ForAll(rels, w -> IsOne(MappedWord(w, fg, s))) and Size(F/rels) = Size(G);
    r.obstruction := fail;
    for w in rels do
      img := MappedWord(w, fg, PX.Mirror(fg));
      if not IsOne(MappedWord(img, fg, s)) then
        r.obstruction := rec(relator := w, mirrored := img, order_of_value := Order(MappedWord(img, fg, s)));
        break;
      fi;
    od;
  fi;
  return r;
end;

## rank-3 version for the facet polyhedron P(G; S1, S2): directly regular iff
## S1 -> S1^-1, S2 -> S1^2 S2 extends to an involutory automorphism.
PX.MirrorTest3 := function(P, s2)
  local G, hom, r;
  G := Subgroup(P, s2);
  hom := GroupHomomorphismByImages(G, G, s2, PX.Mirror3(s2));
  r := rec(extends := hom <> fail);
  if hom <> fail then
    r.bijective := IsBijective(hom);
    r.involutory := ForAll(s2, g -> Image(hom, Image(hom, g)) = g);
    r.directly_regular := r.bijective and r.involutory;
  else
    r.directly_regular := false;
  fi;
  return r;
end;

## rank-3 intersection condition and coset counts for the facet
PX.FacetAbstractData := function(P, s2)
  local G, r;
  G := Subgroup(P, s2);
  r := rec(order := Size(G), p := Order(s2[1]), q := Order(s2[2]), ord_S1S2 := Order(s2[1]*s2[2]));
  r.ip := IsTrivial(Intersection(Subgroup(G,[s2[1]]), Subgroup(G,[s2[2]])));
  r.fvec := [ Index(G, Subgroup(G,[s2[2]])), Index(G, Subgroup(G,[s2[1]*s2[2]])), Index(G, Subgroup(G,[s2[1]])) ];
  r.mirror := PX.MirrorTest3(P, s2);
  return r;
end;

#############################################################################
##  Wythoff realisation (geometric structure)
#############################################################################
PX.OnSetsSetsSets := function(cell, g)
  return Set(List(cell, f -> OnSetsSets(f, g)));
end;

## Geometric structure of the Wythoff polytope of the matrix group generated
## by S = [S1,S2,S3] with base vertex w.  Returns a record with vertex list
## (exact vectors), and edges/faces/cells as index structures, plus the
## permutation action of Gamma on the vertices.
PX.Wythoff4 := function(S, w)
  local Gm, V, pos, act, Pv, sperm, S1p, S2p, S3p, e, f, c, Vc, Ed, Fa, Ce, r, i;
  Gm := Group(S);
  V := Orbit(Gm, w, OnPoints);
  V := List(V, x -> x);           # plain list
  pos := x -> Position(V, x);
  act := ActionHomomorphism(Gm, V, OnPoints);
  Pv := Image(act);
  sperm := List(S, m -> Image(act, m));
  S1p := sperm[1]; S2p := sperm[2]; S3p := sperm[3];
  # base flag in indices: v = 1 (w is V[1]? not necessarily) -> use pos(w)
  e := Set([pos(w), pos(w*S[1]^-1)]);
  f := Set(Orbit(Group(S1p), e, OnSets));
  c := Set(Orbit(Group(S1p, S2p), f, OnSetsSets));
  Ed := Orbit(Pv, e, OnSets);
  Fa := Orbit(Pv, f, OnSetsSets);
  Ce := Orbit(Pv, c, PX.OnSetsSetsSets);
  r := rec(V := V, Gm := Gm, act := act, Pv := Pv, sperm := sperm,
           v := pos(w), e := e, f := f, c := c,
           Ed := Ed, Fa := Fa, Ce := Ce,
           fvector := [Length(V), Length(Ed), Length(Fa), Length(Ce)],
           face_size := Length(f), cell_faces := Length(c),
           faithful_action := (Size(Pv) = Size(Gm)));
  return r;
end;

## Stabiliser checks: geometric stabilisers of the base faces equal the
## abstract face groups (as subgroups of the permutation image Pv).
PX.StabiliserChecks := function(Wy)
  local Pv, s, Gi, st, r;
  Pv := Wy.Pv; s := Wy.sperm;
  Gi := PX.FaceGroups(Pv, s);
  st := [ Stabilizer(Pv, Wy.v, OnPoints), Stabilizer(Pv, Wy.e, OnSets),
          Stabilizer(Pv, Wy.f, OnSetsSets), Stabilizer(Pv, Wy.c, PX.OnSetsSetsSets) ];
  r := rec(equal := List([1..4], i -> st[i] = Gi[i]),
           stab_orders := List(st, Size), facegroup_orders := List(Gi, Size));
  r.all := ForAll(r.equal, x -> x);
  return r;
end;

## Diamond / incidence / orientation checks on the geometric base flag
## (Schulte-Weiss orientation: F_i . S_i is the other i-face of the diamond).
PX.FlagChecks := function(Wy)
  local s, r, e1, f2, c3, V, v;
  s := Wy.sperm; v := Wy.v;
  r := rec();
  r.v_fixed_S2 := (v^s[2] = v); r.v_fixed_S3 := (v^s[3] = v); r.v_moved_S1 := (v^s[1] <> v);
  r.edges_of_f_at_v := Number(Wy.f, x -> v in x);
  r.faces_of_c_at_e := Number(Wy.c, x -> Wy.e in x);
  r.cells_at_f := Number(Wy.Ce, x -> Wy.f in x);
  e1 := OnSets(Wy.e, s[1]);
  r.orient1 := (e1 <> Wy.e and v in e1 and e1 in Wy.f);
  f2 := OnSetsSets(Wy.f, s[2]);
  r.orient2 := (f2 <> Wy.f and Wy.e in f2 and f2 in Wy.c);
  c3 := PX.OnSetsSetsSets(Wy.c, s[3]);
  r.orient3 := (c3 <> Wy.c and Wy.f in c3 and c3 in Wy.Ce);
  r.diamond := (r.edges_of_f_at_v = 2 and r.faces_of_c_at_e = 2 and r.cells_at_f = 2);
  r.all := r.v_fixed_S2 and r.v_fixed_S3 and r.v_moved_S1 and r.diamond and r.orient1 and r.orient2 and r.orient3;
  return r;
end;

## connectivity of the 1-skeleton (graph on vertex indices)
PX.GraphConnected := function(n, Ed)
  local adj, seen, stack, x, y, e;
  adj := List([1..n], i -> []);
  for e in Ed do Add(adj[e[1]], e[2]); Add(adj[e[2]], e[1]); od;
  seen := BlistList([1..n], [1]); stack := [1];
  while Length(stack) > 0 do
    x := Remove(stack);
    for y in adj[x] do if not seen[y] then seen[y] := true; Add(stack, y); fi; od;
  od;
  return SizeBlist(seen) = n;
end;

## rank of the vertex set (affine hull through the origin = linear span since
## the origin is the centre)
PX.SpanDimension := function(V) return RankMat(V); end;

## Vertex-figure at the base vertex: neighbours, their induced polyhedron
## (faces = p2-gons u<S2> and images), counts vs abstract vertex figure.
PX.VertexFigure := function(Wy, S)
  local s, v, Vf, nb, u, ffaces, fedges, H, r, Hm, vnb;
  s := Wy.sperm; v := Wy.v;
  H := Group(s{[2,3]});                              # Gamma^0 acting on vertex indices
  u := Wy.v^(s[1]^-1);                               # neighbour along the base edge (index)
  nb := Orbit(H, u, OnPoints);                       # neighbours of v
  # vertex-figure edge for the base 2-face f: {v S1^-1, v S1}
  fedges := Orbit(H, Set([Wy.v^(s[1]^-1), Wy.v^s[1]]), OnSets);
  ffaces := Orbit(H, Set(Orbit(Group(s[2]), Set([Wy.v^(s[1]^-1), Wy.v^s[1]]), OnSets)), OnSetsSets);
  r := rec(n_neighbours := Length(nb), n_vf_edges := Length(fedges), n_vf_faces := Length(ffaces),
           abstract := [ Index(H, Subgroup(H,[s[3]])), Index(H, Subgroup(H,[s[2]*s[3]])), Index(H, Subgroup(H,[s[2]])) ],
           vf_face_size := Order(s[2]), vf_vertex_degree := Order(s[3]));
  r.counts_match := (r.n_neighbours = r.abstract[1] and r.n_vf_edges = r.abstract[2] and r.n_vf_faces = r.abstract[3]);
  r.vf_graph_connected := PX.GraphConnected(Length(nb), List(fedges, e -> List(e, x -> Position(nb, x))));
  r.vf_edge_in_two_faces := ForAll(fedges, e -> Number(ffaces, F -> e in F) = 2);
  # neighbours equidistant from v (all on a sphere around v)
  vnb := List(nb, i -> (Wy.V[i] - Wy.V[v])*(Wy.V[i] - Wy.V[v]));
  r.equidistant := Length(Set(vnb)) = 1;
  return r;
end;

#############################################################################
##  The unique candidate rho_0 (half-turn) and the regularity test
##  For the base 2-face f = w<S1>, if the vertices of f span the 4-space,
##  there is exactly one linear isometry R with  w S1^k R = w S1^{-k-1} for
##  all k, i.e. R acts on f as the reflection fixing the base edge e = {w, w S1^-1}
##  set-wise and swapping its ends.  Any symmetry mapping the base flag to
##  its 0-adjacent flag must equal R.  Hence the polytope is regular iff R
##  preserves it.
#############################################################################
PX.HalfTurnCandidate := function(S1, w, hyper)
  local M, Mp, rows, R, k, r, d;
  d := Length(w);
  M := List([0..3], k -> w*S1^k);
  Mp := List([0..3], k -> w*S1^(-k-1));
  if hyper <> fail then Add(M, hyper); Add(Mp, hyper); fi;
  if RankMat(M) < d then return rec(exists := false, reason := "vertices of the base 2-face do not span the space"); fi;
  R := M^-1 * Mp;
  r := rec(exists := true, R := R);
  r.orthogonal := (R*TransposedMat(R) = IdentityMat(d));
  r.involution := (R^2 = IdentityMat(d));
  r.inverts_S1 := (R*S1*R = S1^-1);
  r.det := DeterminantMat(R);
  r.maps_w_to_wS1inv := (w*R = w*S1^-1);
  return r;
end;

## The unique isometry acting on the base 2-face as the reflection FIXING the
## base vertex w and swapping its two neighbours (rho_1-type; PETCOX Lemma 3):
## w S1^k -> w S1^-k.  Exists uniquely when the vertices of f span the space.
PX.Rho1Candidate := function(S1, w, hyper)
  local M, Mp, R, d, r;
  d := Length(w);
  M := List([0..3], k -> w*S1^k);
  Mp := List([0..3], k -> w*S1^(-k));
  if hyper <> fail then Add(M, hyper); Add(Mp, hyper); fi;
  if RankMat(M) < d then return rec(exists := false); fi;
  R := M^-1 * Mp;
  r := rec(exists := true, R := R);
  r.orthogonal := (R*TransposedMat(R) = IdentityMat(d));
  r.involution := (R^2 = IdentityMat(d));
  r.inverts_S1 := (R*S1*R = S1^-1);
  r.det := DeterminantMat(R);
  return r;
end;

## Does the isometry R preserve the geometric structure (V, E, F, C)?
PX.PreservesStructure := function(Wy, R)
  local V, VR, perm, imgs, r, Edset, Faset, Ceset;
  V := Wy.V;
  VR := List(V, x -> x*R);
  r := rec();
  r.vertices := (Set(VR) = Set(V));
  if not r.vertices then r.edges := false; r.faces := false; r.cells := false; r.all := false; return r; fi;
  perm := PermList(List(VR, x -> Position(V, x)));
  Edset := Set(Wy.Ed); Faset := Set(Wy.Fa); Ceset := Set(Wy.Ce);
  r.edges := ForAll(Wy.Ed, e -> OnSets(e, perm) in Edset);
  r.faces := ForAll(Wy.Fa, f -> OnSetsSets(f, perm) in Faset);
  r.cells := ForAll(Wy.Ce, c -> PX.OnSetsSetsSets(c, perm) in Ceset);
  r.all := r.vertices and r.edges and r.faces and r.cells;
  return r;
end;

#############################################################################
##  Facet polyhedron (rank 3 Wythoff) of <S1,S2> at w, with chirality test
#############################################################################
PX.Wythoff3 := function(S2gens, w, hyper)
  local Gm, V, pos, act, Pv, sp, e, f, Ed, Fa, r, R, i;
  Gm := Group(S2gens);
  V := List(Orbit(Gm, w, OnPoints), x -> x);
  pos := x -> Position(V, x);
  act := ActionHomomorphism(Gm, V, OnPoints);
  Pv := Image(act);
  sp := List(S2gens, m -> Image(act, m));
  e := Set([pos(w), pos(w*S2gens[1]^-1)]);
  f := Set(Orbit(Group(sp[1]), e, OnSets));
  Ed := Orbit(Pv, e, OnSets);
  Fa := Orbit(Pv, f, OnSetsSets);
  r := rec(V := V, Pv := Pv, sp := sp, v := pos(w), e := e, f := f, Ed := Ed, Fa := Fa,
           fvector := [Length(V), Length(Ed), Length(Fa)], face_size := Length(f),
           faithful_action := (Size(Pv) = Size(Gm)));
  r.stab_equal := [ Stabilizer(Pv, r.v, OnPoints) = Subgroup(Pv, [sp[2]]),
                    Stabilizer(Pv, e, OnSets) = Subgroup(Pv, [sp[1]*sp[2]]),
                    Stabilizer(Pv, f, OnSetsSets) = Subgroup(Pv, [sp[1]]) ];
  r.edge_in_two_faces := ForAll(Ed, x -> Number(Fa, F -> x in F) = 2);
  r.graph_connected := PX.GraphConnected(Length(V), Ed);
  r.span := RankMat(V);
  # vertex-figure at v: neighbours and the cycle condition
  r.neighbours := Orbit(Group(sp[2]), pos(w*S2gens[1]^-1), OnPoints);
  r.vf_is_cycle := (Length(r.neighbours) = Order(S2gens[2]) and Length(r.neighbours) >= 3);
  r.polyhedron := r.faithful_action and ForAll(r.stab_equal, x -> x) and r.edge_in_two_faces and r.graph_connected and r.vf_is_cycle;
  # geometric regularity test via the unique half-turn candidate
  R := PX.HalfTurnCandidate(S2gens[1], w, hyper);
  r.halfturn := R;
  if R.exists then
    r.R_preserves_vertices := (Set(List(V, x -> x*R.R)) = Set(V));
    if r.R_preserves_vertices then
      r.R_preserves := PX.PreservesStructure(rec(V := V, Ed := Ed, Fa := Fa, Ce := []), R.R);
      r.geometrically_regular := r.R_preserves.all;
    else
      r.geometrically_regular := false;
    fi;
  else
    r.geometrically_regular := fail;
  fi;
  return r;
end;

#############################################################################
##  Abstract comparison of two rank-4 triples (isomorphism of the
##  polytopes P(G;s) and P(G';s'): generator-preserving isomorphism, possibly
##  after the mirror substitution (change of base-flag orbit); and duality.
#############################################################################
PX.GenIso := function(G1, s1, G2, s2)
  local hom;
  if Size(G1) <> Size(G2) then return false; fi;
  hom := GroupHomomorphismByImages(G1, G2, s1, s2);
  return hom <> fail and IsBijective(hom);
end;
PX.CompareTriples := function(G1, s1, G2, s2)
  local r;
  r := rec();
  r.isomorphic_same_orientation := PX.GenIso(G1, s1, G2, s2);
  r.isomorphic_mirror := PX.GenIso(G1, s1, G2, PX.Mirror(s2));
  r.isomorphic := r.isomorphic_same_orientation or r.isomorphic_mirror;
  r.dual_same := PX.GenIso(G1, s1, G2, [s2[3]^-1, s2[2]^-1, s2[1]^-1]);
  r.dual_mirror := PX.GenIso(G1, s1, G2, PX.Mirror([s2[3]^-1, s2[2]^-1, s2[1]^-1]));
  r.dual := r.dual_same or r.dual_mirror;
  return r;
end;

#############################################################################
##  Printing helpers
#############################################################################
PX.PrintMat := function(M)
  local row;
  for row in M do Print("    ", row, "\n"); od;
end;
PX.Str := function(x) return String(x); end;
## u = lambda v ?  returns lambda, or fail
PX.Parallel := function(u, v)
  local i, lam;
  i := First([1..Length(v)], k -> v[k] <> 0);
  lam := u[i]/v[i];
  if u = lam*v then return lam; fi;
  return fail;
end;
PX.TSVRow := function(fields)
  Print(JoinStringsWithSeparator(List(fields, String), "\t"), "\n");
end;

#############################################################################
##  Full verification of one candidate triple S = [S1,S2,S3] (matrices) with
##  base vertex w for the polytope record T.  Returns a record and prints a
##  report.  Group theory is done in the faithful permutation image of the
##  matrix group Gamma = <S> acting on the vertex set (faithful when the
##  vertex set spans the space, which is checked).
#############################################################################
PX.FullVerify := function(T, S, w, label)
  local r, Wy, P, s, ip, fg, st, fl, vf, ht, fac, mt, F3, Gm, Pfull, sfull, isoW, spanOK;
  r := rec(label := label);
  Print("\n========== ", label, " ==========\n");
  ## group data in a faithful permutation image of Gamma = <S1,S2,S3> (X may lie
  ## outside W(T) in the parent searches; all subgroups are compared exactly)
  isoW := PX.PermSetup(Group(S));
  sfull := List(S, isoW.im);
  Pfull := isoW.P;
  r.orders := List(sfull, Order);
  r.strings := PX.StringRelations(sfull);
  Print("orders (S1,S2,S3) = ", r.orders, "; (S1S2)^2=(S2S3)^2=(S1S2S3)^2=1: ", r.strings.holds,
        "; ord(S3S2S1) = ", r.strings.r321, "\n");
  r.gamma_order := Size(Subgroup(Pfull, sfull));
  r.G_order := Size(Subgroup(Pfull, sfull{[1,2]}));
  r.vf_order := Size(Subgroup(Pfull, sfull{[2,3]}));
  r.W_order := Size(T.W);
  Print("|Gamma| = ", r.gamma_order, "  |<S1,S2>| = ", r.G_order, "  |<S2,S3>| = ", r.vf_order, "  |W(T)| = ", r.W_order,
        "  Gamma inside W(T): ", ForAll(S, x -> x in T.W), "\n");
  ip := PX.IntersectionData(Pfull, sfull);
  r.ip := ip;
  Print("intersection condition: <S1>cap<S2> trivial: ", ip.i12_trivial, "; <S2>cap<S3> trivial: ", ip.i23_trivial,
        "; <S1,S2>cap<S2,S3> = <S2>: ", ip.I_equals_S2, " (defect ", ip.defect, ")\n");
  r.twist := PX.TwistType(S[1], T.hyper);
  Print("twist type of S1: p = ", r.twist.p, ", (p1,p2) in ", r.twist.pairs, "\n");
  if not (r.strings.holds and ip.holds) then
    Print("-> abstract polytope P(Gamma) does NOT exist (relations or intersection condition fail)\n");
    r.abstract_polytope := false;
    return r;
  fi;
  r.abstract_polytope := true;
  r.fvector_abstract := PX.FVector(Pfull, sfull);
  Print("abstract f-vector (coset indices) = ", r.fvector_abstract, "\n");
  ## mirror test (SW Theorem 1(c))
  mt := PX.MirrorTest(Pfull, sfull);
  r.mirror := mt;
  Print("mirror assignment extends to a homomorphism: ", mt.extends);
  if mt.extends then
    Print("; bijective: ", mt.bijective, "; involutory: ", mt.involutory, "\n");
  else
    Print("; obstruction: ord(S1^-1 S3) = ", mt.ord_S1invS3, " vs ord(S1 S3) = ", mt.ord_S1S3);
    if mt.obstruction <> fail then
      Print("; relator ", mt.obstruction.relator, " mirrors to ", mt.obstruction.mirrored, " of order ", mt.obstruction.order_of_value);
    fi;
    Print("; presentation certified: ", mt.presentation_certified, "\n");
  fi;
  Print("abstract polytope is directly regular: ", mt.directly_regular, "  => combinatorially chiral: ", not mt.directly_regular, "\n");
  ## geometry
  r.w := w;
  r.w_fixed := [ w*S[1] = w, w*S[2] = w, w*S[3] = w ];
  Print("base vertex fixed by (S1,S2,S3): ", r.w_fixed, "\n");
  Wy := PX.Wythoff4(S, w);
  r.Wy := Wy;
  r.fvector_geometric := Wy.fvector;
  Print("geometric f-vector (orbit sizes) = ", Wy.fvector, "; 2-face size ", Wy.face_size, ", 2-faces per cell ", Wy.cell_faces, "\n");
  r.span := PX.SpanDimension(Wy.V);
  spanOK := (r.span = 4);
  Print("dimension of the linear span of the vertex set = ", r.span, "\n");
  r.action_faithful := Wy.faithful_action;
  Print("action of Gamma on vertices faithful: ", Wy.faithful_action, "\n");
  st := PX.StabiliserChecks(Wy);
  r.stab := st;
  Print("geometric stabilisers = abstract face groups (v,e,f,c): ", st.equal, "  orders ", st.stab_orders, " vs ", st.facegroup_orders, "\n");
  fl := PX.FlagChecks(Wy);
  r.flags := fl;
  Print("diamond at base flag (edges of f at v, 2-faces of c at e, cells at f) = ", [fl.edges_of_f_at_v, fl.faces_of_c_at_e, fl.cells_at_f],
        "; SW orientation F_i.S_i = F'_i for i=1,2,3: ", [fl.orient1, fl.orient2, fl.orient3], "\n");
  r.connected := PX.GraphConnected(Length(Wy.V), Wy.Ed);
  Print("1-skeleton connected: ", r.connected, "\n");
  vf := PX.VertexFigure(Wy, S);
  r.vf := vf;
  Print("vertex-figure: neighbours ", vf.n_neighbours, ", vf-edges ", vf.n_vf_edges, ", vf-faces ", vf.n_vf_faces,
        " vs abstract ", vf.abstract, "; type {", vf.vf_face_size, ",", vf.vf_vertex_degree, "}; connected: ", vf.vf_graph_connected,
        "; each vf-edge in two vf-faces: ", vf.vf_edge_in_two_faces, "; neighbours equidistant: ", vf.equidistant, "\n");
  ## facet polyhedron
  F3 := PX.Wythoff3(S{[1,2]}, w, T.hyper);
  r.facet := F3;
  Print("facet polyhedron: f-vector ", F3.fvector, ", face size ", F3.face_size, ", polyhedron: ", F3.polyhedron,
        ", span ", F3.span, ", geometrically regular: ", F3.geometrically_regular, "\n");
  fac := PX.FacetAbstractData(Pfull, sfull{[1,2]});
  r.facet_abstract := fac;
  Print("facet abstract: |G| = ", fac.order, ", type {", fac.p, ",", fac.q, "}, coset f-vector ", fac.fvec,
        ", rank-3 IP: ", fac.ip, ", combinatorially regular (directly regular): ", fac.mirror.directly_regular, "\n");
  ## geometric regularity / chirality.
  ## THEOREM (theory.md, Prop. C).  Let P be a faithful realisation whose
  ## base 2-face f has a vertex set spanning the whole space.  Any symmetry g
  ## of P mapping the base flag to an odd flag can be composed with an element
  ## of Gamma to a symmetry g' with g'(Phi) = Phi^3; g' fixes the vertex, edge
  ## and 2-face of Phi, hence (acting freely on the flags of the polygon f)
  ## fixes every vertex of f, hence is the identity -- a contradiction.  So
  ## G(P) = Gamma, P has two flag orbits with adjacent flags in different
  ## orbits: P is geometrically chiral.  Witnesses computed below: the unique
  ## isometry acting on f as the flag-reversing reflection is S1 S2 S3 (in
  ## Gamma), and it moves the base cell to c^{S3}.
  r.face_span := RankMat(List(Wy.f, e -> Wy.V[e[1]]));
  Print("dimension of the span of the vertices of the base 2-face = ", r.face_span, "\n");
  ht := PX.HalfTurnCandidate(S[1], w, T.hyper);
  r.halfturn := ht;
  if ht.exists then
    Print("unique isometry R acting on f as the flag-reversing reflection: orthogonal ", ht.orthogonal, ", involution ", ht.involution,
          ", R S1 R = S1^-1: ", ht.inverts_S1, ", det ", ht.det, ", w R = w S1^-1: ", ht.maps_w_to_wS1inv, "\n");
    r.R_is_S1S2S3 := (ht.R = S[1]*S[2]*S[3]);
    r.R_in_Gamma := (ht.R in Wy.Gm);
    r.R_moves_c := (PX.OnSetsSetsSets(Wy.c, Image(Wy.act, ht.R)) <> Wy.c);
    r.R_maps_c_to_cS3 := (PX.OnSetsSetsSets(Wy.c, Image(Wy.act, ht.R)) = PX.OnSetsSetsSets(Wy.c, Wy.sperm[3]));
    Print("R = S1 S2 S3: ", r.R_is_S1S2S3, "; R in Gamma: ", r.R_in_Gamma, "; R moves the base cell: ", r.R_moves_c,
          "; R(c) = c^{S3}: ", r.R_maps_c_to_cS3, "\n");
  else
    Print("no isometry is determined by the base 2-face: ", ht.reason, "\n");
    r.R_is_S1S2S3 := fail; r.R_in_Gamma := fail; r.R_moves_c := fail; r.R_maps_c_to_cS3 := fail;
  fi;
  if r.face_span = 4 then
    r.geometrically_regular := false;     # by the theorem, given faithfulness (checked below)
    r.chirality_proof := "2-face vertices span E^4 (Prop. C); witness R = S1S2S3 moves the base cell";
  else
    r.geometrically_regular := fail;
    r.chirality_proof := "inconclusive: 2-face vertices do not span E^4";
  fi;
  r.faithful := st.all and Wy.faithful_action and spanOK and (Wy.fvector = r.fvector_abstract);
  r.skeletal_polytope := r.faithful and fl.all and r.connected and vf.counts_match and vf.vf_graph_connected and vf.vf_edge_in_two_faces
                          and F3.polyhedron;
  r.geometrically_chiral := r.skeletal_polytope and (r.geometrically_regular = false) and r.R_moves_c = true;
  Print("=> faithful realisation: ", r.faithful, "; skeletal 4-polytope: ", r.skeletal_polytope,
        "; geometrically chiral (", r.chirality_proof, "): ", r.geometrically_chiral,
        "; combinatorially chiral: ", not mt.directly_regular, "\n");
  return r;
end;

#############################################################################
##
##  Complete (Level 3) analysis of the third generator.
##
##  THEOREM (theory.md, Prop. E1-E3).  Let S1, S2 be the PETCOX generators of
##  H_alpha(T) and let w be a base vertex.  Put A := S2 X.  Then
##    (i)  (S2X)^2 = (S1S2X)^2 = 1  <=>  A^2 = 1 and A S1 A = S1^-1;
##    (ii) X fixes w  <=>  X fixes the base edge {w, w S1^-1} pointwise
##         <=>  A fixes w;
##   (iii) every A with A S1 A = S1^-1 preserves the two invariant planes
##         E1, E2 of the twist S1 (their rotation angles satisfy
##         theta_2 <> +- theta_1 for all ten families) and acts on each as a
##         line reflection; hence A is the half-turn about the 2-plane
##         span(l1,l2), l_i a line of E_i, and det A = 1 = det X;
##    (iv) A fixes w = w_1 + w_2 (w_i in E_i, both nonzero) iff
##         l_i = span(w_i); so A, and therefore X = S2^-1 A, is UNIQUE.
##  Consequently the third generator is a function of the base vertex, i.e.
##  of the PETCOX parameter alpha, and X = X_alpha is computed below.
##
#############################################################################

## The invariant planes of a finite-order rotation S (as orthogonal
## projections), together with the corresponding rotation angles 2*pi*k/p.
## In the 5-dimensional case (simplex) the fixed line spanned by <hyper> is
## returned separately.
PX.Eigenplanes := function(S, hyper)
  local d, p, res, k, c, M, N, B, P;
  d := Length(S);
  p := Order(S);
  res := [];
  for k in [1..Int(p/2)] do
    c := E(p)^k + E(p)^(-k);
    M := S^2 - c*S + IdentityMat(d);
    N := NullspaceMat(M);
    if Length(N) > 0 then
      if Length(N) <> 2 then
        Error("PX.Eigenplanes: invariant space of dimension ", Length(N), " for k = ", k);
      fi;
      B := N;
      P := TransposedMat(B) * (B*TransposedMat(B))^-1 * B;   # orthogonal projection, row convention
      Add(res, rec(k := k, cos2 := c, basis := B, P := P));
    fi;
  od;
  return res;
end;

## The half-turn A determined by a base vertex w (Prop. E1(iv)), or fail if w
## lies in one of the invariant planes (degenerate: planar 2-face).
PX.HalfTurnAtVertex := function(planes, w, hyper)
  local d, terms, pl, wi, A;
  d := Length(w);
  terms := [];
  for pl in planes do
    wi := w*pl.P;
    if wi = 0*wi then return fail; fi;
    Add(terms, TransposedMat([wi])*[wi]/(wi*wi));
  od;
  if hyper <> fail then
    Add(terms, TransposedMat([hyper])*[hyper]/(hyper*hyper));
  fi;
  A := 2*Sum(terms) - IdentityMat(d);
  return A;
end;

## The unique candidate third generator at the base vertex w.  Returns a
## record with X, A and the verification of every condition of Prop. E1.
PX.UniqueThirdGenerator := function(T, S1, S2, w)
  local d, I, planes, A, X, r;
  d := Length(w);
  I := IdentityMat(d);
  planes := PX.Eigenplanes(S1, T.hyper);
  A := PX.HalfTurnAtVertex(planes, w, T.hyper);
  if A = fail then return rec(exists := false, reason := "base vertex lies in an invariant plane of S1 (planar 2-face)"); fi;
  X := S2^-1 * A;
  r := rec(exists := true, A := A, X := X, nplanes := Length(planes),
           A_orthogonal := (A*TransposedMat(A) = I),
           A_involution := (A^2 = I),
           A_inverts_S1 := (A*S1*A = S1^-1),
           A_fixes_w := (w*A = w),
           det_X := DeterminantMat(X),
           rel_S2X := ((S2*X)^2 = I),
           rel_S1S2X := ((S1*S2*X)^2 = I),
           X_fixes_w := (w*X = w),
           X_fixes_edge := (w*S1^-1*X = w*S1^-1),
           order := Order(X));
  r.all := r.A_orthogonal and r.A_involution and r.A_inverts_S1 and r.A_fixes_w
           and r.rel_S2X and r.rel_S1S2X and r.X_fixes_w and r.X_fixes_edge;
  return r;
end;

## The vertex-figure group <S2,X> as a subgroup of the SO(3) fixing w
## (Prop. E2): it must be A4, S4 or A5, so ord(X) is in {3,4,5}.
PX.VertexFigureGroupType := function(S2, X, w)
  local H, n, r, iso, P;
  H := Group([S2, X]);
  r := rec(fixes_w := (w*S2 = w and w*X = w), orders := [Order(S2), Order(X)],
           ord_S2X := Order(S2*X));
  P := Image(IsomorphismPermGroup(H));
  r.size := Size(P);
  r.structure := StructureDescription(P);
  r.is_A4 := (IsomorphismGroups(P, AlternatingGroup(4)) <> fail);
  r.is_S4 := (IsomorphismGroups(P, SymmetricGroup(4)) <> fail);
  r.is_A5 := (IsomorphismGroups(P, AlternatingGroup(5)) <> fail);
  r.polyhedral := r.is_A4 or r.is_S4 or r.is_A5;
  return r;
end;

## Sign of an element of Q(sqrt 5) (exact; GAP does not order cyclotomics).
## Returns -1, 0, 1, or fail if x is not in Q(sqrt 5).
PX.SignQ5 := function(x)
  local s, p, q;
  if IsRat(x) then return SignInt(NumeratorRat(x)); fi;
  s := Sqrt(5);
  p := (x + GaloisCyc(x, 2))/2;
  q := (x - GaloisCyc(x, 2))/(2*s);
  if not (IsRat(p) and IsRat(q)) then return fail; fi;
  ## sign(p + q sqrt5)
  if q = 0 then return SignInt(NumeratorRat(p)); fi;
  if p = 0 then return SignInt(NumeratorRat(q)); fi;
  if p > 0 and q > 0 then return 1; fi;
  if p < 0 and q < 0 then return -1; fi;
  ## opposite signs: compare p^2 with 5 q^2
  if p > 0 then    # q < 0: p + q sqrt5 > 0  <=>  p^2 > 5 q^2
    if p^2 > 5*q^2 then return 1; elif p^2 = 5*q^2 then return 0; else return -1; fi;
  else             # p < 0, q > 0: positive iff 5q^2 > p^2
    if 5*q^2 > p^2 then return 1; elif 5*q^2 = p^2 then return 0; else return -1; fi;
  fi;
end;

## Exact number of distinct real roots of a univariate polynomial with
## coefficients in Q(sqrt 5), by Sturm's theorem.  All signs are decided
## exactly with PX.SignQ5, so the count is a proof, not an estimate.
PX.CountRealRoots := function(poly, ind)
  local R, seq, a, b, r, signs_pos, signs_neg, f, sg, d, lc, i, V;
  R := PolynomialRing(CF(5), [ind]);
  seq := [ poly, Derivative(poly) ];
  while DegreeOfLaurentPolynomial(seq[Length(seq)]) > 0 do
    r := -EuclideanRemainder(R, seq[Length(seq)-1], seq[Length(seq)]);
    if IsZero(r) then break; fi;
    Add(seq, r);
  od;
  if IsZero(seq[Length(seq)]) then return fail; fi;   # not square-free: caller must handle
  signs_pos := []; signs_neg := [];
  for f in seq do
    d := DegreeOfLaurentPolynomial(f);
    lc := LeadingCoefficient(f);
    sg := PX.SignQ5(lc);
    if sg = fail then return fail; fi;
    Add(signs_pos, sg);
    if d mod 2 = 0 then Add(signs_neg, sg); else Add(signs_neg, -sg); fi;
  od;
  V := function(l) local c, i; c := 0;
    for i in [1..Length(l)-1] do if l[i]*l[i+1] < 0 then c := c + 1; fi; od;
    return c; end;
  return V(signs_neg) - V(signs_pos);
end;

## Real roots of a univariate polynomial with coefficients in Q(sqrt 5),
## computed exactly: factor over Q(sqrt 5) = CF(5)^+; linear factors give
## roots directly; quadratic factors are solved by radicals, the sign of the
## discriminant being decided exactly in Q(sqrt 5) and its square root taken
## in a cyclotomic field when possible.  Factors that cannot be resolved this
## way are returned in .unresolved together with a numerical count of their
## real roots (for reporting only; no decision below depends on it).
PX.RealRootsExact := function(poly, ind)
  local R, facs, roots, unresolved, f, cf, deg, b, c, D, sg, sq, r1, r2, coeffs, fl, i, a, vals, nreal, x;
  R := PolynomialRing(CF(5), [ind]);
  facs := Factors(R, poly);
  roots := []; unresolved := [];
  for f in facs do
    deg := DegreeOfLaurentPolynomial(f);
    coeffs := CoefficientsOfUnivariatePolynomial(f);
    if deg = 0 or deg = DEGREE_ZERO_LAURPOL then continue; fi;
    if deg = 1 then
      x := -coeffs[1]/coeffs[2];
      if not x in roots then Add(roots, x); fi;
      continue;
    fi;
    if deg = 2 then
      b := coeffs[2]/coeffs[3]; c := coeffs[1]/coeffs[3];
      D := b^2 - 4*c;
      sg := PX.SignQ5(D);
      if sg = fail then
        Add(unresolved, rec(factor := f, degree := 2, reason := "discriminant not in Q(sqrt5)", discriminant := D));
        continue;
      fi;
      if sg < 0 then
        Add(unresolved, rec(factor := f, degree := 2, reason := "no real roots (discriminant < 0)", discriminant := D, real_roots := 0));
        continue;
      fi;
      sq := PX.SqrtCyc(D);
      if sq = fail then
        Add(unresolved, rec(factor := f, degree := 2, reason := "two real roots, square root of the discriminant is not cyclotomic",
                            discriminant := D, real_roots := 2));
        continue;
      fi;
      for x in [(-b+sq)/2, (-b-sq)/2] do
        if not x in roots then Add(roots, x); fi;
      od;
      continue;
    fi;
    ## degree >= 3: count the real roots exactly (Sturm)
    nreal := PX.CountRealRoots(f, ind);
    if nreal = 0 then
      Add(unresolved, rec(factor := f, degree := deg, reason := "no real roots (exact Sturm count)", real_roots := 0));
    else
      Add(unresolved, rec(factor := f, degree := deg,
                          reason := "irreducible of degree >= 3 with real roots: NOT RESOLVED", real_roots := nreal));
    fi;
  od;
  return rec(factors := facs, roots := roots, unresolved := unresolved);
end;

## A safe finiteness test and permutation representation for a candidate
## rotation group: compute the orbit of the base vertex with a cap.  If the
## orbit is finite and spans the ambient space, the action on it is faithful
## (an isometry fixing a spanning set is the identity), so the group is finite
## and isomorphic to the permutation group induced on the orbit.
PX.SafeGamma := function(gens, w, cap, spandim)
  local orb, pos, i, g, im, new, perms, p, r, spans;
  orb := [w]; pos := rec(); i := 1;
  while i <= Length(orb) do
    for g in gens do
      im := orb[i]*g;
      if not im in orb then
        if Length(orb) >= cap then return rec(finite := fail, orbit_size := Length(orb), capped := true); fi;
        Add(orb, im);
      fi;
    od;
    i := i + 1;
  od;
  spans := (RankMat(orb) = spandim);
  if not spans then return rec(finite := fail, orbit_size := Length(orb), capped := false, spans := false); fi;
  perms := List(gens, g -> PermList(List(orb, v -> Position(orb, v*g))));
  if ForAny(perms, x -> x = fail) then return rec(finite := fail, orbit_size := Length(orb), spans := true, perm_fail := true); fi;
  p := Group(perms);
  r := rec(finite := true, orbit := orb, orbit_size := Length(orb), spans := true,
           perms := perms, P := p, order := Size(p));
  return r;
end;

## Effective (ambient) dimension of the polytope record: 4 always, but the
## simplex is carried in 5 coordinates on the sum-zero hyperplane.
PX.EffDim := function(T)
  if T.hyper = fail then return T.dim; fi;
  return T.dim - 1;
end;

#############################################################################
##
##  Prop. E4 (quaternionic projection bound) and the Kronecker-Weber trace
##  obstruction, used to settle the base vertices whose parameter t is not
##  cyclotomic.
##
##  E4.  Write SO(4) = (S^3 x S^3)/{+-1}, an element (a,b) acting by
##  x -> a x b^-1.  The stabiliser of a point w of S^3 is the diagonal
##  {(a,a)}/{+-1} = SO(3).  By Prop. E2 the vertex-figure group <S2,X> is
##  A4, S4 or A5, so it lifts to a diagonal copy of 2T, 2O or 2I.  Hence both
##  projections of the preimage of a FINITE Gamma contain 2T, 2O or 2I; since
##  2T, 2O, 2I are maximal among the finite subgroups of S^3 except for the
##  inclusions 2T < 2O and 2T < 2I, a finite Gamma is conjugate into
##  (2X x 2Y)/{+-1} with X, Y in {T,O,I}; the largest such group is
##  +-[I x I] = [3,3,5]^+ of order 7200, and in the octahedral case
##  (vertex figure S4) both projections are 2O, so Gamma is conjugate into
##  +-[O x O] of order 1152.  Consequently:
##    * any vertex orbit of more than 7200 points proves Gamma infinite;
##    * ord(S1) must be an element order of the relevant group.
##
##  Kronecker-Weber trace obstruction.  Every element of a finite subgroup of
##  GL(4,C) has trace equal to a sum of four roots of unity, hence lying in a
##  cyclotomic field.  If K = Q(sqrt 5) and the base-vertex parameter t is a
##  root of an irreducible quadratic over K whose discriminant D has
##  K(sqrt D) NOT abelian over Q (equivalently, by Kronecker-Weber, sqrt D
##  lies in no cyclotomic field; equivalently the norm D sigma(D) is not a
##  square in K), then any trace of the form c0 + c1 t with c1 <> 0 lies in
##  no cyclotomic field, so Gamma is infinite and there is no polytope.
##
#############################################################################

## Is Q(sqrt5, sqrt D)/Q abelian?  (D in Q(sqrt5), not a square in K.)
PX.IsAbelianQuadExtOfQ5 := function(D)
  local n, r;
  n := D*GaloisCyc(D, 2);
  if not IsRat(n) then return fail; fi;
  if n = 0 then return true; fi;
  if n < 0 then return false; fi;              # a real square must be positive
  r := PX.SqrtCycCore(n);
  if r <> fail and IsRat(r) then return true; fi;      # n is a rational square
  r := PX.SqrtCycCore(n/5);
  if r <> fail and IsRat(r) then return true; fi;      # n = 5 * (rational square)
  return false;
end;

## Reduce the rational function P/Q modulo the irreducible polynomial f
## (degree 2) over CF(5): returns the coefficient list [c0, c1] of the value
## at a root of f, or fail.
PX.RationalModFactor := function(P, Q, f, ind)
  local R, Pr, Qr, gr, inv, res, cf;
  R := PolynomialRing(CF(5), [ind]);
  Pr := EuclideanRemainder(R, P, f);
  Qr := EuclideanRemainder(R, Q, f);
  if IsZero(Qr) then return fail; fi;
  gr := GcdRepresentation(R, Qr, f);            # gr[1]*Qr + gr[2]*f = gcd = 1
  inv := gr[1];
  res := EuclideanRemainder(R, Pr*inv, f);
  cf := ShallowCopy(CoefficientsOfUnivariatePolynomial(res));
  while Length(cf) < 2 do Add(cf, Zero(CF(5))); od;
  return cf{[1,2]};
end;

## Scale a matrix X0 that intertwines the generators so that it becomes an
## orthogonal matrix, or return fail.  In the 5-coordinate simplex model the
## solution kills the fixed all-ones direction, so X0 X0^T is a multiple of
## the projection onto the 4-space; the scaled matrix is completed by the
## projection onto the fixed direction.
PX.OrthogonaliseIntertwiner := function(X0, hyper)
  local d, Ph, P4, c, lam, sq;
  d := Length(X0);
  if hyper = fail then
    c := X0*TransposedMat(X0);
    if c <> c[1][1]*IdentityMat(d) or c[1][1] = 0 then return fail; fi;
    sq := PX.SqrtCyc(c[1][1]);
    if sq = fail then return fail; fi;
    return X0/sq;
  fi;
  Ph := TransposedMat([hyper])*[hyper]/(hyper*hyper);
  P4 := IdentityMat(d) - Ph;
  c := X0*TransposedMat(X0);
  ## c should be lam * P4
  lam := First(Concatenation(c), x -> x <> 0);
  if lam = fail then return fail; fi;
  lam := c*P4;                          # c restricted; find the scalar from a diagonal entry of P4
  lam := First([1..d], i -> P4[i][i] <> 0);
  if lam = fail then return fail; fi;
  lam := c[lam][lam]/P4[lam][lam];
  if c <> lam*P4 or lam = 0 then return fail; fi;
  sq := PX.SqrtCyc(lam);
  if sq = fail then return fail; fi;
  return X0/sq + Ph;
end;
