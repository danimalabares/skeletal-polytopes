#############################################################################
##
##  printed-data-audit.g  --  fresh-session Fable audit: direct checks of the
##  producer's claims about the data printed in petcox.pdf (author version,
##  SHA-256 462428270b44ef53deceec14835fafa9379824bb145b0cb2326d68c6a24347d5),
##  transcribed HERE from the rendered pages 24-26 and 28 (viewed as PNG),
##  independently of the producer's census-audit.g; and of the Conder-map
##  identification of the {30,3} cell (relators as transcribed by the producer
##  in references.md; the census file itself could not be fetched offline).
##
##  Run from audits/fable-ultra/scripts:  gap -q -A --quitonbreak printed-data-audit.g < /dev/null
##
#############################################################################
Read("../../../gap/lib.g");
Read("../../../gap/polytopes.g");
PX.BuildAll(); PX.SetupRows();
SizeScreen([ 4096, ]);
AU := rec(npass := 0, nfail := 0, failed := []);
AU.CHECK := function(name, val)
  if val = true then AU.npass := AU.npass + 1; Print("AU-PASS  ", name, "\n");
  else AU.nfail := AU.nfail + 1; Add(AU.failed, name); Print("AU-FAIL  ", name, "   (got ", val, ")\n"); fi;
end;
phi := (1+Sqrt(5))/2; ip := phi - 1; s2 := Sqrt(2); s6 := Sqrt(6);
Refl := function(u) return IdentityMat(Length(u)) - 2*TransposedMat([u])*[u]/(u*u); end;
Mirrors := function(vs) return List([1..4], i -> Refl(NullspaceMat(TransposedMat(vs{Difference([1..4],[i])}))[1])); end;
Marks := function(Rs) local us, c2, m;
  us := List(Rs, X -> First(IdentityMat(4) - X, r -> r <> 0*r));
  m := function(c2) if c2 = 1/4 then return 3; elif c2 = 1/2 then return 4; elif c2 = (phi/2)^2 then return 5; elif c2 = ((phi-1)/2)^2 then return 5/2; else return c2; fi; end;
  return List([1..3], i -> m((us[i]*us[i+1])^2/((us[i]*us[i])*(us[i+1]*us[i+1]))));
end;

## --- D1: p. 25, paragraph "{3,5,5/2}", printed basic tetrahedron (read from the rendered page) ---
v_p25 := [ [phi^2, 1, -ip^2, 0], [phi, ip, 0, 0], [2+phi, 1, 0, ip], [1, 0, 0, 0] ];
v_p24 := [ [phi^2, 1, -ip^2, 0], [phi, ip, 0, 0], [2+phi, 1, 0, ip], [1, 0, 0, 0] ];   # p. 24, paragraph "{5,3,3}"
Print("p.25 {3,5,5/2} tetrahedron equals p.24 {5,3,3} tetrahedron as printed: ", v_p25 = v_p24, "\n");
Rs := Mirrors(v_p25);
W := Group(Rs);
Print("mirrors of the p.25 tetrahedron generate a group of order ", Size(W), " with Schlaefli marks ", Marks(Rs), "\n");
AU.CHECK("D1: the tetrahedron printed for {3,5,5/2} on p.25 is the {5,3,3} tetrahedron (marks {5,3,3}), not a {3,5,5/2} one", Marks(Rs) = [5,3,3]);
S1_25 := (1/2)*[[phi,1,0,-ip],[1,-1,-1,1],[0,1,ip,phi],[ip,-1,phi,0]];     # printed S1 on p.25 (same as p.24)
S2_25 := (1/2)*[[2,0,0,0],[0,phi,-1,ip],[0,1,-ip,phi],[0,-ip,-phi,-1]];   # printed S2 on p.25 (row 3, col 2 has +1)
S2_24 := (1/2)*[[2,0,0,0],[0,phi,-1,ip],[0,-1,-ip,phi],[0,-ip,-phi,-1]];  # printed S2 on p.24 (row 3, col 2 has -1)
c1 := Rs[1]*Rs[2]*Rs[4]*Rs[3]; c2 := Rs[3]*Rs[2];
Print("printed p.24/25 S1 = R0R1R3R2 of the tetrahedron [row / transposed]: ", [S1_25 = c1, S1_25 = TransposedMat(c1)], "\n");
Print("printed p.24 S2 = R2R1 [row / transposed]: ", [S2_24 = c2, S2_24 = TransposedMat(c2)], "; printed p.25 S2 = R2R1 [row / transposed]: ", [S2_25 = c2, S2_25 = TransposedMat(c2)], "\n");
Print("p.25 S2 orthogonal: ", S2_25*TransposedMat(S2_25) = IdentityMat(4), "; order (if finite, up to 60): ", First([1..60], k -> S2_25^k = IdentityMat(4)), "\n");
AU.CHECK("D1: the printed p.25 S2 differs from the p.24 S2 in exactly one entry", Number(Concatenation(S2_25 - S2_24), x -> x <> 0) = 1);
## the true {3,5,5/2} data (producer's construction) for the table row
T := PX.T.("{3,5,5/2}"); S := PX.CanonicalTriple(T); ps := PX.PermSetup(T.W);
Print("true {3,5,5/2}: |<S1,S2>| = ", Size(Subgroup(ps.P, List(S{[1,2]}, ps.im))), ", type of S1 ", PX.TwistType(S[1], fail), ", q = ", Order(S[2]), "\n");

## --- D2: p. 26, paragraph "{5,3,5/2}", printed matrix R = +-(1/(2 sqrt6)) (...) ---
R_p26 := (1/(2*s6))*[[3*phi, ip^2, ip^2, -ip^2],[ip^2, -3-phi, 1, 2*ip],[ip^2, 1, -2*ip, 3+phi],[-ip^2, 2*ip, phi-3, 1]];
Print("p.26 printed R: row norms^2 (should all be 1): ", List(R_p26, r -> r*r), " ~ ", List(R_p26, r -> PX.Float(r*r)), "\n");
Print("p.26 printed R orthogonal: ", R_p26*TransposedMat(R_p26) = IdentityMat(4), "; R^2 = I: ", R_p26^2 = IdentityMat(4), "\n");
AU.CHECK("D2: the matrix R printed on p.26 for {5,3,5/2} is not orthogonal as printed", R_p26*TransposedMat(R_p26) <> IdentityMat(4));
## the printed tetrahedron and regular vertices for {5,3,5/2} are fine:
v_p26 := [ [1,0,0,0], [2+phi,1,0,ip], [2*phi,phi,-1,-ip], [1,1,1,-1] ];
Rs26 := Mirrors(v_p26);
Print("p.26 {5,3,5/2} tetrahedron: marks ", Marks(Rs26), ", |W| = ", Size(Group(Rs26)), "\n");
AU.CHECK("p.26 tetrahedron for {5,3,5/2} has marks {5,3,5/2}", Marks(Rs26) = [5,3,5/2]);
S1_26 := Rs26[1]*Rs26[2]*Rs26[4]*Rs26[3]; S2_26 := Rs26[3]*Rs26[2];
Vf := 0; Rtrue := 0;
for reg in [ [3+3*phi+2*s6*phi, ip, ip, -ip], [3+3*phi-2*s6*phi, ip, ip, -ip] ] do
  ## unique isometry acting on the base face as the rho_1-type reflection w S1^k -> w S1^-k
  M := List([0..3], k -> reg*S1_26^k); Mp := List([0..3], k -> reg*S1_26^(-k));
  Rtrue := M^-1*Mp;
  Vf := Orbit(Group([S1_26, S2_26]), reg, OnPoints);
  Print("regular vertex ", reg, ": in span(v0,v3): ", SolutionMat([v_p26[1], v_p26[4]], reg) <> fail, "; true rho_1 orthogonal ", Rtrue*TransposedMat(Rtrue) = IdentityMat(4),
        ", involution ", Rtrue^2 = IdentityMat(4), ", preserves the facet vertex set ", Set(List(Vf, x -> x*Rtrue)) = Set(Vf),
        ", equals printed R up to sign/transpose: ", Rtrue in [R_p26, -R_p26, TransposedMat(R_p26), -TransposedMat(R_p26)], "\n");
  AU.CHECK("p.26: the facet at the printed regular vertex is regular (true rho_1 preserves its vertex set)", Set(List(Vf, x -> x*Rtrue)) = Set(Vf) and Rtrue*TransposedMat(Rtrue) = IdentityMat(4));
od;

## --- H1: p. 28 table column "[G : Gamma^+]" ---
for row in [1..10] do
  name := PX.Order[2*row-1]; T := PX.T.(name); S := PX.CanonicalTriple(T); ps := PX.PermSetup(T.W);
  G := Subgroup(ps.P, List(S{[1,2]}, ps.im)); Gp := Subgroup(ps.P, List([1..3], i -> ps.im(T.R[i]*T.R[i+1])));
  Print(name, ": |G| = ", Size(G), " (table ", PX.Table[row].G, "), [Gamma^+(T) : G] = ", Size(Gp)/Size(G), " (table column ", PX.Table[row].index, "), G <= Gamma^+: ", IsSubgroup(Gp, G), "\n");
  AU.CHECK(Concatenation("H1 ", name, ": table index column equals [Gamma^+(T):G] (so the header [G:Gamma^+] is reversed)"), Size(Gp)/Size(G) = PX.Table[row].index and IsSubgroup(Gp, G));
od;

## --- Conder identification of the {30,3} cell (relators as transcribed in references.md, which this audit could not re-fetch) ---
F := FreeGroup("R","S","T"); fr := GeneratorsOfGroup(F); Rf := fr[1]; Sf := fr[2]; Tf := fr[3];
rel97_9 := [ Tf^2, Rf^-3, (Rf*Sf)^2, (Rf*Tf)^2, (Sf*Tf)^2, Sf*Rf*Sf^-2*Rf*Sf^-2*Rf*Sf^-1*Rf*Sf^-2*Rf*Sf^2*Rf^-1*Sf^2, Sf*Rf*Sf^-3*Rf^-1*Sf^5*Rf^-1*Sf^-3*Rf*Sf^6 ];
rel97_10 := [ Tf^2, Rf^-3, (Rf*Sf)^2, (Rf*Tf)^2, (Sf*Tf)^2, (Sf^-2*Rf*Sf^-1)^3 ];
Print("coset enumeration of the transcribed presentations: |R97.9| = ", Size(F/rel97_9), ", |R97.10| = ", Size(F/rel97_10), " (census says 2880 for both)\n");
AU.CHECK("transcribed R97.9 and R97.10 presentations both define groups of order 2880", Size(F/rel97_9) = 2880 and Size(F/rel97_10) = 2880);
## Petrie lengths in the two fp groups: ord(R S T)?  In Conder's convention R,S rotations, T a reflection with (RT)^2=(ST)^2=1:
## rho1 := T; rho0 := T*R^-1 ... we avoid conventions and compute ord of every element of the form (reflection)(reflection)(reflection)
## using a permutation representation: Petrie length = ord(rho0 rho1 rho2) with rho1 = T, rho0 = R T (so rho0 rho1 = R), rho2 = T S (so rho1 rho2 = S)
for pair in [ ["R97.9", rel97_9], ["R97.10", rel97_10] ] do
  Gfp := F/pair[2]; iso := IsomorphismPermGroup(Gfp); gg := List(GeneratorsOfGroup(Gfp), x -> Image(iso, x));
  r0 := gg[1]*gg[3]; r1 := gg[3]; r2 := gg[3]*gg[2];
  Print(pair[1], ": rho_i involutions ", [r0^2, r1^2, r2^2] = [(),(),()], ", (rho0 rho2)^2 = 1: ", (r0*r2)^2 = (), ", ord(rho0 rho1) = ", Order(r0*r1), ", ord(rho1 rho2) = ", Order(r1*r2),
        ", Petrie length ord(rho0 rho1 rho2) = ", Order(r0*r1*r2), "\n");
od;
## our {30,3} cell: full automorphism group as permutation group on flags is expensive; use the producer-independent formula-free route:
## build the regular map group as G . <rho0> via the mirror automorphism (semidirect product) and compute ord(rho0 rho1 rho2) directly.
T := PX.T.("{5,3,3}"); S := PX.CanonicalTriple(T); ps := PX.PermSetup(Group(S{[1,2]})); s1 := ps.im(S[1]); s2 := ps.im(S[2]); G := ps.P;
rho := GroupHomomorphismByImages(G, G, [s1,s2], [s1^-1, s1^2*s2]);
AU.CHECK("{30,3} cell: rank-3 mirror automorphism exists (cell combinatorially regular)", rho <> fail);
Cc := Group((1,2)); al := GroupHomomorphismByImages(Cc, AutomorphismGroup(G), [(1,2)], [rho]); D := SemidirectProduct(Cc, al, G);
e1 := Embedding(D,1); e2 := Embedding(D,2); q0 := Image(e1,(1,2)); t1 := Image(e2,s1); t2 := Image(e2,s2); q1 := q0*t1; q2 := q0*t1*t2;
Print("{30,3} cell: |Gamma(P_T)| = ", Size(D), ", ord(rho0 rho1 rho2) = ", Order(q0*q1*q2), ", check rho0 rho1 = S1: ", q0*q1 = t1, ", rho1 rho2 = S2: ", q1*q2 = t2, "\n");
AU.CHECK("{30,3} cell has Petrie length 40", Order(q0*q1*q2) = 40);
## relator test in our group: Conder's map is the dual of the cell, R = S2^-1 (order 3), S = S1^-1 (order 30), T = rho_1 = rho0 S1
for pair in [ ["R97.10", rel97_10], ["R97.9", rel97_9] ] do
  ok := List([ [t2^-1, t1^-1], [t2, t1^-1], [t2^-1, t1], [t2, t1] ], v -> ForAll(pair[2], w -> IsOne(MappedWord(w, fr, [v[1], v[2], q1]))));
  Print("{30,3} cell satisfies all relators of ", pair[1], " for (R,S) = (S2^-1,S1^-1),(S2,S1^-1),(S2^-1,S1),(S2,S1): ", ok, "\n");
  if pair[1] = "R97.10" then AU.CHECK("{30,3} cell satisfies every transcribed relator of R97.10 (some orientation)", true in ok);
  else AU.CHECK("{30,3} cell fails the transcribed relators of R97.9 (every orientation)", not true in ok); fi;
od;

Print("\nprinted-data-audit.g: ", AU.npass, " passed, ", AU.nfail, " failed.\n");
if AU.nfail > 0 then Print("FAILED: ", AU.failed, "\n"); fi;
Print("Done: printed-data-audit.g\n");
