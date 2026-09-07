#############################################################################
##
##  chirality-group.g  --  chirality group X(P) (Breda D'Azevedo-Jones-Schulte)
##  of the new abstract chiral 4-polytope of type {30,3,3} obtained from the
##  canonical extensions of {5,3,3} and {5/2,3,3}, using the library of the
##  repository's computations/chirality-groups (read-only), if present.
##
#############################################################################

if not IsBound(PX) then Read("lib.g"); fi;
if not IsBound(PX.T) or Length(RecNames(PX.T)) = 0 then Read("polytopes.g"); PX.BuildAll(); PX.SetupRows(); fi;

cgfile := "../../../computations/chirality-groups/common/chirality-group.g";
if not IsExistingFile(cgfile) then
  Print("chirality-group library not found at ", cgfile, "; skipping.\n");
  Print("Done: chirality-group.g (skipped)\n");
else
  Read(cgfile);
  for name in ["{5,3,3}", "{5/2,3,3}", "{4,3,3}", "{5/2,3,5}"] do
    T := PX.T.(name); S := PX.CanonicalTriple(T);
    ps := PX.PermSetup(T.W); s := List(S, ps.im);
    G := Subgroup(ps.P, s);
    res := CG.ComputeChiralityGroup(G, s, ["S1","S2","S3"]);
    CG.PrintReport(res, Concatenation("Chirality group of the canonical extension of ", name));
    PX.CHECK(Concatenation(name, ": the three methods agree"), res.agree_12 and res.agree_13 and res.agree_2bar);
    PX.CHECK(Concatenation(name, ": X(P) nontrivial (combinatorially chiral)"), not res.directly_regular);
    if name = "{4,3,3}" then PX.CHECKEQ("Roli's cube: |X(P)| (repository result: 2)", Size(res.X), 2); fi;
    if name = "{5/2,3,5}" then PX.CHECKEQ("{12/(1,5),3,5}: |X(P)| (repository result: 120)", Size(res.X), 120); fi;
    PX.(Concatenation("CGres", String(Position(["{5,3,3}", "{5/2,3,3}", "{4,3,3}", "{5/2,3,5}"], name)))) := res;
  od;
  PX.CHECKEQ("{5,3,3} and {5/2,3,3}: same |X(P)| (same abstract polytope)", Size(PX.CGres1.X), Size(PX.CGres2.X));
  PX.Summary("chirality-group.g");
  if PX.nfail > 0 then QuitGap(1); fi;
  Print("Done: chirality-group.g\n");
fi;
