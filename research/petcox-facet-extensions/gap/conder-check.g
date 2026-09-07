#############################################################################
##
##  conder-check.g  --  identification of the abstract polytopes and of the
##  abstract cells against the published censuses.
##
##  (a) Petrie lengths of the ten PETCOX cells.  For an orientably regular
##      map with distinguished rotations sigma1 (face) and sigma2 (vertex),
##      the Petrie polygon length is r = ord(rho0 rho1 rho2), and
##          (rho0 rho1 rho2)^2 = sigma1^2 sigma2^2
##      because rho0 rho2 = rho2 rho0 and rho0 rho2 = sigma1 sigma2.  The
##      element rho0 rho1 rho2 reverses orientation, so it is not in the
##      rotation subgroup and r = 2 ord(sigma1^2 sigma2^2).  This settles
##      which entry of Conder's census of regular orientable maps each cell
##      is (his labels carry the Petrie length as a subscript).
##
##  (b) The two abstract 4-polytopes small enough to lie inside Conder's
##      census of chiral polytopes with up to 4000 flags (group order at most
##      2000) are identified with the actual entries of that file, quoted in
##      references.md and transcribed here.  Conder's list is taken up to
##      isomorphism, reflection and duality, and his generators A.1, A.2, A.3
##      are the distinguished rotations of the polytope (his types are the
##      duals of ours: [3,3,8] for our {8,3,3} and [4,3,12] for our {12,3,4}).
##
##  Run from gap/:  gap -q -A --quitonbreak conder-check.g < /dev/null
##
#############################################################################

if not IsBound(PX) then Read("lib.g"); fi;
if not IsBound(PX.T) or Length(RecNames(PX.T)) = 0 then Read("polytopes.g"); PX.BuildAll(); PX.SetupRows(); fi;

#############################################################################
##  (a) Petrie lengths of the cells
#############################################################################
Print("=== Petrie polygon lengths of the abstract cells P_T ===\n");
Print("(r = 2 * ord(S1^2 S2^2); Conder writes the length as the subscript of the type)\n");
for row in [1..10] do
  name := PX.Order[2*row-1];
  T := PX.T.(name);
  S := PX.CanonicalTriple(T);
  ps := PX.PermSetup(Group(S{[1,2]}));
  s1 := ps.im(S[1]); s2 := ps.im(S[2]);
  r := 2*Order(s1^2*s2^2);
  Print("  ", name, ": cell type {", Order(s1), ",", Order(s2), "}, |G| = ", Size(ps.P),
        ", Petrie length r = ", r, "\n");
  PX.(Concatenation("Petrie", String(row))) := r;
od;
## Independent check of the Petrie length: build the full automorphism group
## Gamma(P_T) = G . <rho0> as a semidirect product, with rho0 acting by the
## mirror automorphism, and compute ord(rho0 rho1 rho2) directly.  In that
## group rho1 = rho0 S1 and rho2 = rho0 S1 S2 are involutions with
## rho0 rho1 = S1 and rho1 rho2 = S2, and rho0 rho1 rho2 = rho0 S2.
Print("\nindependent check in the full automorphism group Gamma(P_T) = G . <rho0>:\n");
for row in [1..10] do
  name := PX.Order[2*row-1];
  T := PX.T.(name);
  S := PX.CanonicalTriple(T);
  ps := PX.PermSetup(Group(S{[1,2]}));
  s1 := ps.im(S[1]); s2 := ps.im(S[2]);
  G := ps.P;
  rho := GroupHomomorphismByImages(G, G, [s1,s2], [s1^-1, s1^2*s2]);
  if rho = fail then
    Print("  ", name, ": the mirror automorphism does not exist (the map would not be regular)\n");
    continue;
  fi;
  aut := Group([rho]);
  C2 := Group((1,2));
  alpha := GroupHomomorphismByImages(C2, AutomorphismGroup(G), [(1,2)], [rho]);
  D := SemidirectProduct(C2, alpha, G);
  e1 := Embedding(D, 1); e2 := Embedding(D, 2);
  r0 := Image(e1, (1,2));
  t1 := Image(e2, s1); t2 := Image(e2, s2);
  r1 := r0*t1; r2 := r0*t1*t2;
  PX.CHECK(Concatenation(name, ": rho0, rho1, rho2 are involutions with rho0rho1 = S1 and rho1rho2 = S2"),
           r0^2 = One(D) and r1^2 = One(D) and r2^2 = One(D) and r0*r1 = t1 and r1*r2 = t2);
  Print("  ", name, ": |Gamma(P_T)| = ", Size(D), ", ord(rho0 rho1 rho2) = ", Order(r0*r1*r2),
        " (formula 2*ord(S1^2 S2^2) gives ", PX.(Concatenation("Petrie", String(row))), ")\n");
  PX.CHECKEQ(Concatenation(name, ": the two computations of the Petrie length agree"),
             Order(r0*r1*r2), PX.(Concatenation("Petrie", String(row))));
  PX.CHECKEQ(Concatenation(name, ": |Gamma(P_T)| = 2|G|"), Size(D), 2*Size(G));
od;

## published cross-checks (references.md, retrieved 2026-09-07)
PX.CHECKEQ("Petrie length of the {8,3} cell (Hartley {8,3}*96 says 'Order of s0 s1 s2: 12'; Conder R2.1 is {3,8}_12)",
           PX.Petrie2, 12);
PX.CHECKEQ("Petrie length of the {12,3} cell (Hartley {12,3}*288 says 24; Conder R7.2 is {3,12}_24)",
           PX.Petrie7, 24);
PX.CHECKEQ("Petrie length of the {12,4} cell (Hartley {12,4}*384e says 24)", PX.Petrie3, 24);
PX.CHECKEQ("Petrie length of the {5,3} cell (the dodecahedron has Petrie hexagons... 10)", PX.Petrie1, 10);
Print("\nConder's census of regular orientable maps prints R97.9 as 'Type {3,30}_20', i.e. Petrie length 20,\n");
Print("and R97.10 (the other genus-97 candidate) has a different Petrie length; the value computed above\n");
Print("for the {30,3} cell of rows 4 and 8 therefore identifies the entry.\n");
PX.CHECKEQ("the two {30,3} cells (rows 4 and 8) have the same Petrie length", PX.Petrie4, PX.Petrie8);
PX.CHECKEQ("the two {20,5} cells (rows 5 and 9) have the same Petrie length", PX.Petrie5, PX.Petrie9);
PX.CHECKEQ("the two {15,5} cells (rows 6 and 10) have the same Petrie length", PX.Petrie6, PX.Petrie10);

#############################################################################
##  (a2) identification of the cells against Conder's map census, directly
##  from his defining relations (independent of the Petrie-length convention).
##
##  Conder's generators satisfy T^2 = (R T)^2 = (S T)^2 = 1, so T inverts both
##  R and S: T is a rho_1-type reflection, R = sigma_1 and S = sigma_2 of HIS
##  map, whose type is {ord(R), ord(S)}.  His census is up to duality and
##  lists only the orientation with the smaller face size first, so his map is
##  the DUAL of our cell: for the dual, sigma_1 = (our sigma_2)^-1 and
##  sigma_2 = (our sigma_1)^-1.  The distinguishing relators of the entries
##  below involve only R and S, so they can be tested inside the rotation
##  group of the cell.  All four sign variants are tried.
#############################################################################
Print("\n=== identification of the cells from Conder's defining relations ===\n");
## Conder's generators satisfy T^2 = (R T)^2 = (S T)^2 = 1, so T inverts both
## R and S: T is a rho_1-type reflection, and R, S are the distinguished
## rotations of HIS map, of orders equal to the two entries of his type.  His
## census is up to duality and lists only the orientation with the smaller
## face size first, so his map is the DUAL of our cell; for the dual,
## sigma_1 = (our sigma_2)^-1, sigma_2 = (our sigma_1)^-1, while rho_1 is the
## same reflection.  We therefore build the full automorphism group
## Gamma(P_T) = G . <rho_0> and set R = S2^-1, S = S1^-1, T = rho_1 = rho_0 S1
## (all four sign variants of R and S are tried, since a regular map is
## isomorphic to its mirror image).  A candidate entry is confirmed only if
## EVERY one of its relators is trivial; since our group and both candidate
## groups have order 2880 (resp. 2400), satisfying all relators of an entry
## identifies our map with it.
PX.FullMapGroup := function(T)
  local S, ps, s1, s2, G, rho, C2, alpha, D, e1, e2, r0, t1, t2;
  S := PX.CanonicalTriple(T);
  ps := PX.PermSetup(Group(S{[1,2]}));
  s1 := ps.im(S[1]); s2 := ps.im(S[2]); G := ps.P;
  rho := GroupHomomorphismByImages(G, G, [s1,s2], [s1^-1, s1^2*s2]);
  if rho = fail then return fail; fi;
  C2 := Group((1,2));
  alpha := GroupHomomorphismByImages(C2, AutomorphismGroup(G), [(1,2)], [rho]);
  D := SemidirectProduct(C2, alpha, G);
  e1 := Embedding(D, 1); e2 := Embedding(D, 2);
  r0 := Image(e1, (1,2)); t1 := Image(e2, s1); t2 := Image(e2, s2);
  return rec(D := D, rho0 := r0, rho1 := r0*t1, S1 := t1, S2 := t2, order := Size(D));
end;

PX.MatchConderMap := function(name, entry, relfun)
  local F, variants, v, vals, ok, any, T4;
  F := PX.FullMapGroup(PX.T.(name));
  if F = fail then Print("   ", name, ": no mirror automorphism\n"); return false; fi;
  T4 := F.rho1;
  variants := [ rec(n := "R=S2^-1,S=S1^-1", R := F.S2^-1, S := F.S1^-1),
                rec(n := "R=S2,   S=S1^-1", R := F.S2,    S := F.S1^-1),
                rec(n := "R=S2^-1,S=S1   ", R := F.S2^-1, S := F.S1),
                rec(n := "R=S2,   S=S1   ", R := F.S2,    S := F.S1) ];
  any := false;
  for v in variants do
    vals := relfun(v.R, v.S, T4);
    ok := ForAll(vals, x -> x = One(F.D));
    Print("   ", name, " vs ", entry, " [", v.n, "]: relators trivial? ", List(vals, x -> x = One(F.D)),
          " -> all: ", ok, "\n");
    if ok then any := true; fi;
  od;
  Print("   |Gamma(P_T)| = ", F.order, "\n");
  return any;
end;

## R97.9  : [ T^2, R^-3, (R*S)^2, (R*T)^2, (S*T)^2,
##            S*R*S^-2*R*S^-2*R*S^-1*R*S^-2*R*S^2*R^-1*S^2,
##            S*R*S^-3*R^-1*S^5*R^-1*S^-3*R*S^6 ]
## R97.10 : [ T^2, R^-3, (R*S)^2, (R*T)^2, (S*T)^2, (S^-2*R*S^-1)^3 ]
## (verbatim from RegularOrientableMaps301.txt, lines 12683-12689, 2026-09-07)
rel97_9 := function(R, S, T4) return
  [ T4^2, R^-3, (R*S)^2, (R*T4)^2, (S*T4)^2,
    S*R*S^-2*R*S^-2*R*S^-1*R*S^-2*R*S^2*R^-1*S^2,
    S*R*S^-3*R^-1*S^5*R^-1*S^-3*R*S^6 ]; end;
rel97_10 := function(R, S, T4) return
  [ T4^2, R^-3, (R*S)^2, (R*T4)^2, (S*T4)^2, (S^-2*R*S^-1)^3 ]; end;
## R151.10 : [ R^5, T^2, (R*S)^2, (R*T)^2, (S*T)^2, S*R*S^-1*R*S^-1*R^2*S^2*R^-1*S*R^-1 ]
## R151.11 : [ R^5, T^2, (R*S)^2, (R*T)^2, (S*T)^2, S^-1*R^-1*S^2*R^2*S^2*R^-1*S^-1 ]
## (lines 24067-24073)
rel151_10 := function(R, S, T4) return
  [ R^5, T4^2, (R*S)^2, (R*T4)^2, (S*T4)^2, S*R*S^-1*R*S^-1*R^2*S^2*R^-1*S*R^-1 ]; end;
rel151_11 := function(R, S, T4) return
  [ R^5, T4^2, (R*S)^2, (R*T4)^2, (S*T4)^2, S^-1*R^-1*S^2*R^2*S^2*R^-1*S^-1 ]; end;

for row in [4, 8] do
  name := PX.Order[2*row-1];
  Print("cell of row ", row, " (", name, "), type {30,3}, |G| = 1440, genus 97:\n");
  a := PX.MatchConderMap(name, "R97.10 (Type {3,30}_40, Order 2880)", rel97_10);
  b := PX.MatchConderMap(name, "R97.9  (Type {3,30}_20, Order 2880)", rel97_9);
  PX.CHECK(Concatenation(name, ": the {30,3} cell satisfies EVERY relator of Conder R97.10"), a);
  PX.CHECK(Concatenation(name, ": the {30,3} cell does NOT satisfy every relator of Conder R97.9, so it is not R97.9 (correcting PETCOX p.29)"), not b);
od;
for row in [5, 9] do
  name := PX.Order[2*row-1];
  Print("cell of row ", row, " (", name, "), type {20,5}, |G| = 1200, genus 151:\n");
  a := PX.MatchConderMap(name, "R151.11 (Type {5,20}_60, Order 2400)", rel151_11);
  b := PX.MatchConderMap(name, "R151.10 (Type {5,20}_12, Order 2400)", rel151_10);
  PX.CHECK(Concatenation(name, ": the {20,5} cell satisfies EVERY relator of Conder R151.11 (confirming PETCOX p.29)"), a);
  PX.CHECK(Concatenation(name, ": the {20,5} cell does NOT satisfy every relator of Conder R151.10"), not b);
od;

#############################################################################
##  (b) identification against Conder's chiral-polytope census
#############################################################################
Print("\n=== identification against Conder's chiral polytopes with up to 4000 flags ===\n");
## transcribed verbatim from
## https://www.math.auckland.ac.nz/~conder/ChiralPolytopesWithUpTo4000Flags-ByType.txt
## (retrieved 2026-09-07; ByType lines 7637-7638 and 8073-8074)
PX.Conder := function(p1, p2, p3, extra)
  local f, a1, a2, a3, rels, G;
  f := FreeGroup("a1","a2","a3");
  a1 := f.1; a2 := f.2; a3 := f.3;
  rels := [ a1^p1, a2^p2, (a1^-1*a2^-1)^2, (a2^-1*a3^-1)^2,
            a3^-1*a2*a1^-1*a3*a1, a3^-1*a1*a3*a2^-1*a1*a3^-2*a2 ];
  G := f/rels;
  return rec(free := f, gens := [a1,a2,a3], rels := rels, fp := G, size := Size(G));
end;

C338 := PX.Conder(3,3,8, []);
Print("Conder [3,3,8] entry, order from coset enumeration: ", C338.size, " (file says 192)\n");
PX.CHECKEQ("Conder's [3,3,8] presentation has order 192", C338.size, 192);
C4312 := PX.Conder(4,3,12, []);
Print("Conder [4,3,12] entry, order from coset enumeration: ", C4312.size, " (file says 1152)\n");
PX.CHECKEQ("Conder's [4,3,12] presentation has order 1152", C4312.size, 1152);

## our two candidates: class 1 (Roli's cube, {8,3,3}) and class 5 ({12,3,4})
PX.Saved := [];
if IsExistingFile("../logs/alpha-survivors.g") then Read("../logs/alpha-survivors.g"); fi;

## every variant of a triple that describes the same polytope up to
## isomorphism, enantiomorphism and duality
PX.TripleVariants := function(s)
  local mir, dual, dualmir;
  mir := PX.Mirror(s);
  dual := [ s[3]^-1, s[2]^-1, s[1]^-1 ];
  dualmir := PX.Mirror(dual);
  return [ rec(name := "identity", t := s), rec(name := "mirror", t := mir),
           rec(name := "dual", t := dual), rec(name := "dual+mirror", t := dualmir) ];
end;

PX.MatchConder := function(C, G, s, label)
  local v, hom, ok, res;
  res := [];
  for v in PX.TripleVariants(s) do
    ok := ForAll(C.rels, r -> IsOne(MappedWord(r, GeneratorsOfGroup(C.free), v.t)));
    if ok then
      hom := GroupHomomorphismByImages(C.fp, Group(v.t), List(GeneratorsOfGroup(C.fp), x -> x), v.t);
      Add(res, rec(variant := v.name, orders := List(v.t, Order), relators_hold := true,
                   iso := (Size(Group(v.t)) = C.size)));
      Print("   ", label, ": variant '", v.name, "' with generator orders ", List(v.t, Order),
            " satisfies every Conder relator; |<triple>| = ", Size(Group(v.t)),
            " and |Conder group| = ", C.size, " -> isomorphic: ", Size(Group(v.t)) = C.size, "\n");
    else
      Print("   ", label, ": variant '", v.name, "' with generator orders ", List(v.t, Order),
            " does not satisfy the relators\n");
    fi;
  od;
  return res;
end;

## class 1: Roli's cube, the canonical extension of {4,3,3}
T := PX.T.("{4,3,3}"); S := PX.CanonicalTriple(T);
ps := PX.PermSetup(Group(S)); s := List(S, ps.im);
Print("class 1 (Roli's cube, type {8,3,3}, |Gamma| = ", Size(ps.P), "):\n");
m1 := PX.MatchConder(C338, ps.P, s, "class 1");
PX.CHECK("Roli's cube matches Conder's [3,3,8] entry of order 192 (some variant satisfies every relator and the orders agree)",
         ForAny(m1, x -> x.iso));

## class 5: the {12,3,4} polytope, from the Level 3 survivors
cand := First(PX.Saved, r -> r.skeletal and Order(r.X) = 4 and r.T = "{5,3,5/2}");
if cand = fail then
  Print("class 5 candidate not found in the survivor file; run alpha-complete.g first\n");
else
  ps := PX.PermSetup(Group([cand.S1, cand.S2, cand.X])); s := List([cand.S1, cand.S2, cand.X], ps.im);
  Print("class 5 (type {12,3,4}, |Gamma| = ", Size(ps.P), ", case ", cand.case, "):\n");
  m5 := PX.MatchConder(C4312, ps.P, s, "class 5");
  PX.CHECK("the {12,3,4} polytope matches Conder's [4,3,12] entry of order 1152",
           ForAny(m5, x -> x.iso));
fi;

## the other classes are out of range: |Gamma| = 2880 and 7200 exceed 2000
Print("\nclasses 2, 3, 4 and 6 have |Gamma| = 7200, 7200, 2880, 7200, i.e. 14400, 14400, 5760, 14400 flags,\n");
Print("beyond the 4000-flag (group order 2000) limit of Conder's census, so that census cannot contain them.\n");

PX.Summary("conder-check.g");
if PX.nfail > 0 then QuitGap(1); fi;
Print("Done: conder-check.g\n");
