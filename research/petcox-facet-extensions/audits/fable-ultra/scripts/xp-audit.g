#############################################################################
##  xp-audit.g -- fresh-session Fable audit: chirality groups X(P) of one
##  representative per abstract class, by the mix construction only
##  (Mix = <(S1,S1^-1),(S2,S1^2 S2),(S3,S3)> <= Gamma x Gamma; X(P) = first
##  coordinates of the kernel of the projection onto the second factor;
##  |Mix| = |Gamma| |X(P)|), independent of the repository's library.
##  Run from audits/fable-ultra/scripts:  gap -q -A --quitonbreak xp-audit.g < /dev/null
#############################################################################
Read("../../../gap/lib.g"); Read("../../../gap/polytopes.g"); PX.BuildAll(); PX.SetupRows();
SizeScreen([4096,]);
AU := rec(npass := 0, nfail := 0);
AU.CHECK := function(name, val) if val = true then AU.npass := AU.npass + 1; Print("AU-PASS  ", name, "\n"); else AU.nfail := AU.nfail + 1; Print("AU-FAIL  ", name, "\n"); fi; end;
AU.Orbit := function(gens, w) local orb, i, g, im; orb := [w]; i := 1;
  while i <= Length(orb) do for g in gens do im := orb[i]*g; if not im in orb then Add(orb, im); fi; od; i := i + 1; od; return orb; end;
PX.Saved := []; Read("../../../logs/alpha-survivors.g");
## one representative per producer class: class 1 alpha=0 {4,3,3}; class 2 alpha=0 {5,3,3}; class 3 alpha=0 {5,3,5/2}; class 4 L3-{5,3,5/2}-1; class 5 L3-{5,3,5/2}-5; class 6 L3-{5,3,5/2}-10
reps := [ ["class 1 (Roli)", "L3-{4,3,3}-6", 2], ["class 2 ({30,3,3})", "L3-{5,3,3}-8", 120], ["class 3 (thesis)", "L3-{5,3,5/2}-16", 120],
          ["class 4 ({12,3,3})", "L3-{5,3,5/2}-1", 1], ["class 5 ({12,3,4})", "L3-{5,3,5/2}-5", 8], ["class 6 ({12,3,5}')", "L3-{5,3,5/2}-10", 120] ];
for rp in reps do
  c := First(PX.Saved, r -> r.case = rp[2]); S := [c.S1, c.S2, c.X]; V := AU.Orbit(S, c.w); pos := x -> Position(V, x);
  s := List(S, g -> PermList(List(V, v -> pos(v*g)))); P := Group(s);
  D := DirectProduct(P, P); e1 := Embedding(D,1); e2 := Embedding(D,2); p1 := Projection(D,1);
  bar := [s[1]^-1, s[1]^2*s[2], s[3]];
  Mix := Subgroup(D, List([1..3], i -> Image(e1, s[i])*Image(e2, bar[i])));
  Xp := Image(p1, Intersection(Mix, Image(e1, P)));
  Print(rp[1], " ", rp[2], ": |Gamma| = ", Size(P), ", |Mix| = ", Size(Mix), ", |X(P)| = ", Size(Xp), " = ", StructureDescription(Xp), ", [Gamma:X] = ", Size(P)/Size(Xp),
        ", Gamma/X = ", StructureDescription(P/Xp), ", |Mix| = |Gamma||X|: ", Size(Mix) = Size(P)*Size(Xp), "\n");
  AU.CHECK(Concatenation(rp[1], ": |X(P)| = ", String(rp[3]), " as claimed"), Size(Xp) = rp[3]);
od;
Print("\nxp-audit.g: ", AU.npass, " passed, ", AU.nfail, " failed.\nDone: xp-audit.g\n");
