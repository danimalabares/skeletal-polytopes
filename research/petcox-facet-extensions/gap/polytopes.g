#############################################################################
##
##  polytopes.g  --  exact reflection generators of the 16 regular 4-polytopes
##
##  * {3,3,3}: 5x5 permutation matrices on the sum-zero hyperplane of R^5,
##    tetrahedron as in petcox.pdf p.22.
##  * {4,3,3}: the reflection matrices of the legacy script cube.g (identical
##    to the mirrors of the tetrahedron of petcox.pdf p.23).
##  * {3,4,3}: mirrors of the basic tetrahedron of petcox.pdf p.24.
##  * the twelve members of the [3,3,5] family: derived from the 600-cell
##    reflections of the legacy scripts geometric.g / chiral.g / dual.g by an
##    exhaustive search over string quadruples of the 60 mirrors of [3,3,5]
##    (keyed by the geometric Schlaefli marks read off the angles between
##    consecutive mirrors), so that no matrix has to be transcribed from the
##    paper.  The transcribed data of the paper are checked separately in
##    census-audit.g.
##  * duals: reversed reflections (H_alpha(T) = H_{1-alpha}(T^*)).
##
##  For every polytope the record stores v0 (base vertex) and v3 (centroid
##  of the base cell), both exact and unnormalised.
##
#############################################################################

if not IsBound(PX) then Read("lib.g"); fi;

PX.T := rec();
PX.Order := [];        # the 16 names in a fixed order (10 PETCOX rows, T then T^*)

PX.AddT := function(T) PX.T.(T.name) := T; Add(PX.Order, T.name); end;

#############################################################################
##  {3,3,3}  (5-dimensional coordinates, petcox.pdf p.22)
#############################################################################
PX.Simplex := function()
  local perm, R, ones, v0, T;
  perm := function(i,j) local M; M := IdentityMat(5); M[i][i] := 0; M[j][j] := 0; M[i][j] := 1; M[j][i] := 1; return M; end;
  R := [ perm(1,2), perm(2,3), perm(3,4), perm(4,5) ];
  ones := [1,1,1,1,1];
  v0 := [4,-1,-1,-1,-1];
  T := PX.MakePolytope("{3,3,3}", R, v0, ones);
  return T;
end;

#############################################################################
##  {4,3,3}  (cube.g matrices; petcox.pdf p.23 tetrahedron)
#############################################################################
PX.Hypercube := function()
  local R0, R1, R2, R3;
  R0 := [ [ -1, 0, 0, 0 ], [ 0, 1, 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ] ];
  R1 := [ [ 0, 1, 0, 0 ], [ 1, 0, 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ] ];
  R2 := [ [ 1, 0, 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 1, 0, 0 ], [ 0, 0, 0, 1 ] ];
  R3 := [ [ 1, 0, 0, 0 ], [ 0, 1, 0, 0 ], [ 0, 0, 0, 1 ], [ 0, 0, 1, 0 ] ];
  return PX.MakePolytope("{4,3,3}", [R0,R1,R2,R3], [1,1,1,1], fail);
end;

#############################################################################
##  {3,4,3}  (petcox.pdf p.24 tetrahedron)
#############################################################################
PX.Icositetrachoron := function()
  local vs, R;
  vs := [ [1,0,0,0], [3,1,1,1], [2,1,1,0], [1,1,0,0] ];
  R := PX.MirrorsFromTetrahedron(vs, fail);
  return PX.MakePolytope("{3,4,3}", R, [1,0,0,0], fail);
end;

#############################################################################
##  The [3,3,5] family from the legacy 600-cell reflections
#############################################################################
PX.H4 := rec();
PX.H4.Setup := function()
  local phi, R0, R1, R2, R3, W, els, I4, refl, us, cosval, marks, found, m0, m1, m2, m3, key, p1, p2, p3, ok;
  phi := PX.phi;
  ## legacy geometric.g (verbatim):
  R0 := (1/2) * [ [phi, 1, 0, -1 + phi], [1, 1 - phi, 0, -phi], [0, 0, 2, 0], [-1 + phi, -phi, 0, 1] ];
  R1 := [ [1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, -1] ];
  R2 := (1/2) * [ [2, 0, 0, 0], [0, phi, -1, phi - 1], [0, -1, 1 - phi, phi], [0, phi - 1, phi, 1] ];
  R3 := [ [1, 0, 0, 0], [0, 1, 0, 0], [0, 0, -1, 0], [0, 0, 0, 1] ];
  PX.H4.R600 := [R0,R1,R2,R3];
  W := Group([R0,R1,R2,R3]);
  PX.H4.W := W;
  els := AsList(W);
  I4 := IdentityMat(4);
  refl := Filtered(els, PX.IsHyperplaneReflection);
  us := List(refl, PX.NormalOf);
  # canonical order: sort mirrors by their (sign-normalised) normal vectors
  us := List(us, function(u) local f; f := First(u, x -> x <> 0); return u/f; end);
  SortParallel(us, refl);
  PX.H4.refl := refl; PX.H4.normals := us;
  cosval := function(a,b) return (a*b)^2/((a*a)*(b*b)); end;
  found := rec();
  m0 := 1;
  for m1 in [1..Length(refl)] do if m1 <> m0 and cosval(us[m0],us[m1]) <> 0 then
   for m2 in [1..Length(refl)] do if not m2 in [m0,m1] and cosval(us[m0],us[m2]) = 0 and cosval(us[m1],us[m2]) <> 0 then
    for m3 in [1..Length(refl)] do if not m3 in [m0,m1,m2] and cosval(us[m0],us[m3]) = 0 and cosval(us[m1],us[m3]) = 0 and cosval(us[m2],us[m3]) <> 0 then
      p1 := PX.MarkFromCos2(cosval(us[m0],us[m1])); p2 := PX.MarkFromCos2(cosval(us[m1],us[m2])); p3 := PX.MarkFromCos2(cosval(us[m2],us[m3]));
      key := Concatenation("{", String(p1), ",", String(p2), ",", String(p3), "}");
      if not IsBound(found.(key)) then found.(key) := [m0,m1,m2,m3]; fi;
    fi; od;
   fi; od;
  fi; od;
  PX.H4.found := found;
  return found;
end;

## build the polytope with the given symbol from the search
PX.H4.Make := function(symbol)
  local q, R, v0, T;
  if not IsBound(PX.H4.found) then PX.H4.Setup(); fi;
  q := PX.H4.found.(symbol);
  R := List(q, i -> PX.H4.refl[i]);
  if Size(Group(R)) <> 14400 then Error("PX.H4.Make: quadruple does not generate [3,3,5]"); fi;
  v0 := PX.Orthogonal(List(R{[2,3,4]}, PX.NormalOf), fail);
  T := PX.MakePolytope(symbol, R, v0, fail);
  return T;
end;

#############################################################################
##  Assemble all sixteen (in the order of the PETCOX table, T then T^*)
#############################################################################
PX.BuildAll := function()
  local T;
  PX.T := rec(); PX.Order := [];
  T := PX.Simplex();          PX.AddT(T); PX.AddT(PX.Dual(T, "{3,3,3}*"));
  T := PX.Hypercube();        PX.AddT(T); PX.AddT(PX.Dual(T, "{3,3,4}"));
  T := PX.Icositetrachoron(); PX.AddT(T); PX.AddT(PX.Dual(T, "{3,4,3}*"));
  PX.H4.Setup();
  T := PX.H4.Make("{5,3,3}");     PX.AddT(T); PX.AddT(PX.Dual(T, "{3,3,5}"));
  T := PX.H4.Make("{3,5,5/2}");   PX.AddT(T); PX.AddT(PX.Dual(T, "{5/2,5,3}"));
  T := PX.H4.Make("{5,5/2,5}");   PX.AddT(T); PX.AddT(PX.Dual(T, "{5,5/2,5}*"));
  T := PX.H4.Make("{5,3,5/2}");   PX.AddT(T); PX.AddT(PX.Dual(T, "{5/2,3,5}"));
  T := PX.H4.Make("{3,3,5/2}");   PX.AddT(T); PX.AddT(PX.Dual(T, "{5/2,3,3}"));
  T := PX.H4.Make("{3,5/2,5}");   PX.AddT(T); PX.AddT(PX.Dual(T, "{5,5/2,3}"));
  T := PX.H4.Make("{5/2,5,5/2}"); PX.AddT(T); PX.AddT(PX.Dual(T, "{5/2,5,5/2}*"));
  return PX.T;
end;

## The PETCOX table row (T, T^*) each name belongs to, and its dual's name
PX.RowOf := rec();
PX.DualName := rec();
PX.SetupRows := function()
  local i;
  for i in [1..Length(PX.Order)/2] do
    PX.RowOf.(PX.Order[2*i-1]) := i; PX.RowOf.(PX.Order[2*i]) := i;
    PX.DualName.(PX.Order[2*i-1]) := PX.Order[2*i];
    PX.DualName.(PX.Order[2*i]) := PX.Order[2*i-1];
  od;
end;

## Expected Schlaefli marks of each name (geometric), for verification
PX.ExpectedMarks := rec(
  ("{3,3,3}") := [3,3,3], ("{3,3,3}*") := [3,3,3],
  ("{4,3,3}") := [4,3,3], ("{3,3,4}") := [3,3,4],
  ("{3,4,3}") := [3,4,3], ("{3,4,3}*") := [3,4,3],
  ("{5,3,3}") := [5,3,3], ("{3,3,5}") := [3,3,5],
  ("{3,5,5/2}") := [3,5,5/2], ("{5/2,5,3}") := [5/2,5,3],
  ("{5,5/2,5}") := [5,5/2,5], ("{5,5/2,5}*") := [5,5/2,5],
  ("{5,3,5/2}") := [5,3,5/2], ("{5/2,3,5}") := [5/2,3,5],
  ("{3,3,5/2}") := [3,3,5/2], ("{5/2,3,3}") := [5/2,3,3],
  ("{3,5/2,5}") := [3,5/2,5], ("{5,5/2,3}") := [5,5/2,3],
  ("{5/2,5,5/2}") := [5/2,5,5/2], ("{5/2,5,5/2}*") := [5/2,5,5/2] );

## Expected f-vectors (Coxeter, Regular Polytopes, Table; Schlaefli-Hess data)
PX.ExpectedFVector := rec(
  ("{3,3,3}") := [5,10,10,5], ("{3,3,3}*") := [5,10,10,5],
  ("{4,3,3}") := [16,32,24,8], ("{3,3,4}") := [8,24,32,16],
  ("{3,4,3}") := [24,96,96,24], ("{3,4,3}*") := [24,96,96,24],
  ("{5,3,3}") := [600,1200,720,120], ("{3,3,5}") := [120,720,1200,600],
  ("{3,5,5/2}") := [120,720,1200,120], ("{5/2,5,3}") := [120,1200,720,120],
  ("{5,5/2,5}") := [120,720,720,120], ("{5,5/2,5}*") := [120,720,720,120],
  ("{5,3,5/2}") := [120,720,720,120], ("{5/2,3,5}") := [120,720,720,120],
  ("{3,3,5/2}") := [120,720,1200,600], ("{5/2,3,3}") := [600,1200,720,120],
  ("{3,5/2,5}") := [120,720,1200,120], ("{5,5/2,3}") := [120,1200,720,120],
  ("{5/2,5,5/2}") := [120,720,720,120], ("{5/2,5,5/2}*") := [120,720,720,120] );

## Expected group orders
PX.ExpectedGroupOrder := function(name)
  if name in ["{3,3,3}","{3,3,3}*"] then return 120; fi;
  if name in ["{4,3,3}","{3,3,4}"] then return 384; fi;
  if name in ["{3,4,3}","{3,4,3}*"] then return 1152; fi;
  return 14400;
end;

## PETCOX summary table (p.28), indexed by row
PX.Table := [
  rec(T := "{3,3,3}",     type := "{5/(1,2),3}",    G := 60,   index := 1,  collapse := [4,4]),
  rec(T := "{4,3,3}",     type := "{8/(1,3),3}",    G := 48,   index := 4,  collapse := [1,2]),
  rec(T := "{3,4,3}",     type := "{12/(1,5),4}",   G := 192,  index := 3,  collapse := [2,2]),
  rec(T := "{5,3,3}",     type := "{30/(1,11),3}",  G := 1440, index := 5,  collapse := [1,4]),
  rec(T := "{3,5,5/2}",   type := "{20/(1,9),5}",   G := 1200, index := 6,  collapse := [2,2]),
  rec(T := "{5,5/2,5}",   type := "{15/(1,4),5/2}", G := 7200, index := 1,  collapse := [12,12]),
  rec(T := "{5,3,5/2}",   type := "{12/(1,5),3}",   G := 144,  index := 50, collapse := [1,1]),
  rec(T := "{3,3,5/2}",   type := "{30/(7,13),3}",  G := 1440, index := 5,  collapse := [4,1]),
  rec(T := "{3,5/2,5}",   type := "{20/(3,7),5/2}", G := 1200, index := 6,  collapse := [2,2]),
  rec(T := "{5/2,5,5/2}", type := "{15/(2,7),5}",   G := 7200, index := 1,  collapse := [12,12]) ];
## the twist data (p; p1,p2) and q of the type column
PX.TableTwist := [ [5,1,2,3], [8,1,3,3], [12,1,5,4], [30,1,11,3], [20,1,9,5], [15,1,4,5], [12,1,5,3], [30,7,13,3], [20,3,7,5], [15,2,7,5] ];
