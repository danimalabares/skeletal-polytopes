#############################################################################
##  atlas-id-audit.g -- fresh-session Fable audit: identify the full automorphism
##  groups Gamma(P_T) = G.<rho0> of the three small PETCOX cells with the
##  SmallGroups library, and compute the two atlas invariants
##  'Order of s0 s1 s2' (Petrie) and 'Order of s0 s1 s2 s1', to test the
##  identifications {8,3}*96 = SmallGroup(96,193), {12,3}*288 = SmallGroup(288,847),
##  {12,4}*384e = SmallGroup(384,18044) (the atlas lists five {12,4}*384x entries).
##  Run from audits/fable-ultra/scripts: gap -q -A --quitonbreak atlas-id-audit.g < /dev/null
#############################################################################
Read("../../../gap/lib.g"); Read("../../../gap/polytopes.g"); PX.BuildAll(); PX.SetupRows();
SizeScreen([4096,]);
for pair in [ ["{4,3,3}", [96,193], 12, 8], ["{5,3,5/2}", [288,847], 24, 12], ["{3,4,3}", [384,18044], 24, 8] ] do
  T := PX.T.(pair[1]); S := PX.CanonicalTriple(T);
  ps := PX.PermSetup(Group(S{[1,2]})); s1 := ps.im(S[1]); s2 := ps.im(S[2]); G := ps.P;
  rho := GroupHomomorphismByImages(G, G, [s1,s2], [s1^-1, s1^2*s2]);
  C2 := Group((1,2)); al := GroupHomomorphismByImages(C2, AutomorphismGroup(G), [(1,2)], [rho]);
  D := SemidirectProduct(C2, al, G); e1 := Embedding(D,1); e2 := Embedding(D,2);
  r0 := Image(e1,(1,2)); t1 := Image(e2,s1); t2 := Image(e2,s2); r1 := r0*t1; r2 := r0*t1*t2;
  Print(pair[1], " cell: |Gamma(P_T)| = ", Size(D), ", IdGroup = ", IdGroup(D), " (atlas: ", pair[2], "), ord(s0s1s2) = ", Order(r0*r1*r2),
        " (atlas ", pair[3], "), ord(s0s1s2s1) = ", Order(r0*r1*r2*r1), " (atlas ", pair[4], "), type {", Order(r0*r1), ",", Order(r1*r2), "}",
        ", (V,E,F) = ", [Index(D, Subgroup(D,[r1,r2])), Index(D, Subgroup(D,[r0,r2])), Index(D, Subgroup(D,[r0,r1]))], "\n");
  if IdGroup(D) = pair[2] and Order(r0*r1*r2) = pair[3] and Order(r0*r1*r2*r1) = pair[4] then Print("AU-PASS  ", pair[1], " cell matches the atlas entry\n");
  else Print("AU-FAIL  ", pair[1], " cell does not match the atlas entry\n"); fi;
od;
Print("Done: atlas-id-audit.g\n");
