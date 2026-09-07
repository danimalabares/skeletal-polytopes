#############################################################################
##
##  common/chirality-group.g
##
##  GAP library for computing the chirality group X(P) of a chiral or
##  directly regular 4-polytope P whose rotation group
##      Gamma^+(P) = < S1, S2, S3 >
##  is given as a finite permutation group with its distinguished
##  generators.
##
##  CONVENTIONS (Schulte & Weiss 1991, Sect. 2-3; Breda D'Azevedo, Jones &
##  Schulte 2011, Sect. 2 and 4; Cunningham 2012, Sect. 2.3 and 4):
##
##    * sigma_i = rho_{i-1} rho_i.  The distinguished generators satisfy
##          (s1 s2)^2 = (s2 s3)^2 = (s1 s2 s3)^2 = 1,
##      which is the presentation of W^+ = [oo,oo,oo]^+ (BJS eq. (11)).
##    * The enantiomorphic (mirror) substitution is conjugation by rho_0 = r_0:
##          s1 -> s1^-1,   s2 -> s1^2 s2,   s3 -> s3            (BJS p.6, p.12).
##    * Gamma^+(P) = W^+/M.  With M^{r0} := r0 M r0 the chirality group is
##          X(P) = M M^{r0} / M  ~=  M^{r0} / (M cap M^{r0})    (BJS Lemma 4.1),
##      a normal subgroup of Gamma^+(P) = W^+/M.
##
##  Three computations of X(P) are provided:
##
##    Method 1 (CG.ChiralityGroupByRelators):  BJS Sect. 4, p.12.
##      Take a complete presentation < s1,s2,s3 | R > of Gamma on the
##      distinguished generators, apply the mirror substitution to every
##      relator (as a word in the free group), evaluate the mirrored words
##      in Gamma, and take the normal closure.
##
##    Method 2 (CG.ChiralityGroupByMix):  mix with the enantiomorphic group.
##      Inside Gamma x Gamma take
##          Mix = < (S1, S1^-1), (S2, S1^2 S2), (S3, S3) > ~= W^+/(M cap M^{r0}).
##      The kernel of the projection onto the second (mirror) factor consists
##      of the pairs (x,1); the set of their first coordinates is
##          phi(M^{r0}) = M M^{r0}/M = X(P)  as a subgroup of Gamma^+(P).
##      (See TECHNICAL_NOTES.md for the derivation, and note that here the kernel of
##      the *first* projection, read in the second coordinate, is the same
##      subgroup of Gamma, because the mirror copy lives inside Gamma itself.)
##
##    Method 3 (CG.MirrorInvariantNormalSubgroups):  lattice characterisation.
##      X(P) is the smallest normal subgroup N of Gamma such that Gamma/N
##      admits the (involutory) mirror automorphism.  This follows from
##      X(P) = M^W/M with M^W = M M^{r0} the smallest r0-invariant normal
##      subgroup of W^+ containing M.
##
##  Only core GAP is used (plus the packages GAP itself always loads).
##
#############################################################################

CG := rec();

## Wide output lines so that the transcript is not wrapped mid-number.
SizeScreen([ 200, ]);

#############################################################################
##  Basic words and relations
#############################################################################

## Mirror (enantiomorphic) images of a triple, valid in any group.
CG.MirrorImages := function(gens)
  return [ gens[1]^-1, gens[1]^2*gens[2], gens[3] ];
end;

## The W^+ = [oo,oo,oo]^+ relators as words in a free group on 3 generators.
CG.WPlusRelators := function(f)
  return [ (f[1]*f[2])^2, (f[2]*f[3])^2, (f[1]*f[2]*f[3])^2 ];
end;

## Orders of the generators and of the standard products, plus the two
## convention-sensitive products s1 s2 s3 and s3 s2 s1.
CG.StringRelationData := function(gens)
  local S1, S2, S3;
  S1 := gens[1]; S2 := gens[2]; S3 := gens[3];
  return rec(
    orders      := List(gens, Order),
    ord_S1S2    := Order(S1*S2),
    ord_S2S3    := Order(S2*S3),
    ord_S1S2S3  := Order(S1*S2*S3),
    ord_S3S2S1  := Order(S3*S2*S1),
    ord_S1S3    := Order(S1*S3),
    ord_S1invS3 := Order(S1^-1*S3),
    holds := ( Order(S1*S2) = 2 and Order(S2*S3) = 2 and Order(S1*S2*S3) = 2 )
  );
end;

## Rank-4 intersection condition, BJS eq. (5); equivalent to the full
## intersection property (14) of Schulte-Weiss in rank 4 by their Lemma 11
## (p. 511).
CG.IntersectionProperty := function(G, gens)
  local S1, S2, S3;
  S1 := gens[1]; S2 := gens[2]; S3 := gens[3];
  return IsTrivial(Intersection(Subgroup(G,[S1]), Subgroup(G,[S2])))
     and IsTrivial(Intersection(Subgroup(G,[S2]), Subgroup(G,[S3])))
     and Intersection(Subgroup(G,[S1,S2]), Subgroup(G,[S2,S3])) = Subgroup(G,[S2]);
end;

## Numbers of i-faces of the abstract polytope P(Gamma) (Schulte-Weiss 1991,
## Prop. 6 / thesis eq. for Gamma^i):  faces of rank i <-> cosets of Gamma^i.
CG.FVector := function(G, gens)
  local S1, S2, S3;
  S1 := gens[1]; S2 := gens[2]; S3 := gens[3];
  return [ Index(G, Subgroup(G,[S2,S3])),        # vertices
           Index(G, Subgroup(G,[S3,S1*S2])),     # edges
           Index(G, Subgroup(G,[S1,S2*S3])),     # 2-faces
           Index(G, Subgroup(G,[S1,S2])) ];      # facets (cells)
end;

#############################################################################
##  Geometric base flag (Wythoff's construction) and orientation of the S_i
#############################################################################

## matS = [S1,S2,S3] as matrices acting on row vectors (GAP right action),
## v = base vertex.  Builds the base flag of the thesis,
##     e = {v, v S1^-1},  f = e<S1>,  c = f<S1,S2>,
## the geometric f-vector (orbit sizes), the face stabilisers, and checks the
## Schulte-Weiss orientation convention in GAP's right-action form
##     F_i . S_i = F'_i   (F'_i = the other i-face between F_{i-1} and F_{i+1}),
## for i = 1,2,3, together with the diamond condition at each step.
CG.GeometricFlagData := function(matS, v)
  local OnSetsSetsSets, S1, S2, S3, Q, e, f, c, Vp, Ep, Fp, Cp, r, e1, f2, c3;
  OnSetsSetsSets := function(cell, g)
    return Set(List(cell, i -> OnSetsSets(i, g)));
  end;
  S1 := matS[1]; S2 := matS[2]; S3 := matS[3];
  Q  := Group(matS);
  e  := Set([v, v*S1^-1]);
  f  := Set(Orbit(Group(S1), e, OnSets));
  c  := Set(Orbit(Group(S1, S2), f, OnSetsSets));
  Vp := Orbit(Q, v, OnPoints);
  Ep := Orbit(Q, e, OnSets);
  Fp := Orbit(Q, f, OnSetsSets);
  Cp := Orbit(Q, c, OnSetsSetsSets);
  r := rec( fvector := [Length(Vp), Length(Ep), Length(Fp), Length(Cp)],
            face_sizes := [Length(f), Length(c)] );   # edges per 2-face, 2-faces per cell
  r.v_fixed_by_S2S3_not_S1 := ( v*S2 = v and v*S3 = v and v*S1 <> v );
  # i = 1: e.S1 is an edge of f at v, different from e; exactly two edges of f at v
  e1 := OnSets(e, S1);
  r.orient1 := ( e1 <> e and v in e1 and e1 in f and Number(f, x -> v in x) = 2 );
  # i = 2: f.S2 is a 2-face of c containing e, different from f; exactly two such
  f2 := OnSetsSets(f, S2);
  r.orient2 := ( f2 <> f and e in f2 and f2 in c and Number(c, x -> e in x) = 2 );
  # i = 3: c.S3 is a cell containing f, different from c; exactly two such
  c3 := OnSetsSetsSets(c, S3);
  r.orient3 := ( c3 <> c and f in c3 and c3 in Cp and Number(Cp, x -> f in x) = 2 );
  # the triple (-S1, S2, S3) would satisfy the same relations but violates
  # the orientation of S1 (its e.(-S1) is not an edge at v)
  r.minusS1_fails := not ( v in OnSets(e, -S1) );
  # face stabilisers (Schulte-Weiss Prop. 6 / thesis face groups)
  r.stabilisers_ok :=
        Stabilizer(Q, v, OnPoints)          = Group(S2, S3)
    and Stabilizer(Q, e, OnSets)            = Group(S3, S1*S2)
    and Stabilizer(Q, f, OnSetsSets)        = Group(S1, S2*S3)
    and Stabilizer(Q, c, OnSetsSetsSets)    = Group(S1, S2);
  r.all_ok := r.v_fixed_by_S2S3_not_S1 and r.orient1 and r.orient2 and r.orient3
              and r.minusS1_fails and r.stabilisers_ok;
  return r;
end;

#############################################################################
##  Mirror automorphism test (Schulte-Weiss 1991, Thm. 1; BJS p.5-6)
#############################################################################

## Returns the involutory automorphism of G mapping gens to their mirror
## images, or fail if the assignment does not extend to a homomorphism.
## G must be generated by gens.
CG.MirrorAutomorphism := function(G, gens)
  local rho;
  if not Subgroup(G, gens) = G then
    Error("CG.MirrorAutomorphism: gens must generate G");
  fi;
  rho := GroupHomomorphismByImages(G, G, gens, CG.MirrorImages(gens));
  if rho = fail then
    return fail;
  fi;
  # The mirror images generate G, so rho is surjective, hence bijective
  # (G finite); and the substitution is involutory on words.
  if not IsBijective(rho) then
    Error("CG.MirrorAutomorphism: homomorphism exists but is not bijective");
  fi;
  if not ForAll(gens, g -> Image(rho, Image(rho, g)) = g) then
    Error("CG.MirrorAutomorphism: automorphism exists but is not involutory");
  fi;
  return rho;
end;

#############################################################################
##  A certified presentation on the distinguished generators
#############################################################################

## Returns a record with
##   free      : free group F on 3 generators (names given by <names>)
##   fgens     : its generators, corresponding to gens[1], gens[2], gens[3]
##   relators  : list of words in F: the W^+ relators followed by a complete
##               set of defining relators of G on gens
##   fp        : the fp group F/relators
##   iso       : the isomorphism G -> fp group returned by GAP
##   certified : true iff (a) every relator evaluates to 1 in G and
##               (b) Size(fp) = Size(G) by coset enumeration.
## (a) and (b) together prove that s_i -> gens[i] induces an isomorphism
## F/<<relators>> -> G, i.e. that the relators form a complete presentation
## of G on exactly the distinguished generators.  No Tietze generator other
## than the three distinguished ones ever occurs.
CG.PresentationOnGenerators := function(G, gens, names)
  local iso, Ffp, Ffree, oldgens, F, fgens, transport, rels, allrels, fp,
        evalOK, sizeOK;
  # The relator set GAP returns depends on the state of its random sources;
  # reset them so that the presentation does not depend on what was computed
  # before.  (X(P) is independent of the presentation in any case.)
  Reset(GlobalMersenneTwister);
  Reset(GlobalRandomSource);
  iso := IsomorphismFpGroupByGenerators(G, gens);
  Ffp := Range(iso);
  # Generator correspondence: the i-th fp generator is the image of gens[i].
  if List(gens, x -> Image(iso, x)) <> GeneratorsOfGroup(Ffp) then
    Error("CG.PresentationOnGenerators: generator correspondence failed");
  fi;
  if List(GeneratorsOfGroup(Ffp), x -> PreImagesRepresentative(iso, x)) <> gens then
    Error("CG.PresentationOnGenerators: inverse generator correspondence failed");
  fi;
  Ffree := FreeGroupOfFpGroup(Ffp);
  oldgens := GeneratorsOfGroup(Ffree);
  # Transport the relators to a free group with readable generator names.
  F := FreeGroup(names);
  fgens := GeneratorsOfGroup(F);
  transport := w -> MappedWord(w, oldgens, fgens);
  rels := List(RelatorsOfFpGroup(Ffp), transport);
  allrels := Concatenation(CG.WPlusRelators(fgens), rels);
  fp := F / allrels;
  evalOK := ForAll(allrels, r -> IsOne(MappedWord(r, fgens, gens)));
  sizeOK := ( Size(fp) = Size(G) );        # coset enumeration
  return rec( free := F, fgens := fgens, relators := allrels, fp := fp,
              iso := iso, nrelators := Length(allrels),
              evalOK := evalOK, sizeOK := sizeOK,
              certified := evalOK and sizeOK );
end;

#############################################################################
##  Method 1: normal closure of the mirrored relators (BJS Sect. 4, p.12)
#############################################################################

## pres is the record returned by CG.PresentationOnGenerators.
CG.ChiralityGroupByRelators := function(G, gens, pres)
  local fgens, mirrored, images, X, minimal, N, i;
  fgens := pres.fgens;
  mirrored := List(pres.relators, r -> MappedWord(r, fgens, CG.MirrorImages(fgens)));
  images   := List(mirrored, w -> MappedWord(w, fgens, gens));
  X := NormalClosure(G, Subgroup(G, images));
  # A greedy sublist of mirrored relators whose images already normally
  # generate X (for reporting; the full list is what the theory prescribes).
  minimal := [];
  N := TrivialSubgroup(G);
  for i in [1..Length(images)] do
    if not images[i] in N then
      Add(minimal, i);
      N := NormalClosure(G, ClosureGroup(N, images[i]));
    fi;
  od;
  if N <> X then Error("CG.ChiralityGroupByRelators: greedy closure mismatch"); fi;
  return rec( mirrored := mirrored, images := images, X := X,
              minimal_indices := minimal );
end;

#############################################################################
##  Method 2: mix with the enantiomorphic group
#############################################################################

CG.ChiralityGroupByMix := function(G, gens)
  local D, e1, e2, p1, p2, bar, mixgens, Mix, K2, K1, X, Xbar, hom2, ker2, Xhom;
  D  := DirectProduct(G, G);
  e1 := Embedding(D, 1);  e2 := Embedding(D, 2);
  p1 := Projection(D, 1); p2 := Projection(D, 2);
  bar := CG.MirrorImages(gens);
  mixgens := List([1..3], i -> Image(e1, gens[i]) * Image(e2, bar[i]));
  Mix := Subgroup(D, mixgens);
  # Kernel of the projection onto the mirror factor: pairs (x, 1).
  K2 := Intersection(Mix, Image(e1, G));
  X  := Image(p1, K2);                     # subgroup of G  (= X(P))
  # Kernel of the projection onto the first factor: pairs (1, y).
  K1 := Intersection(Mix, Image(e2, G));
  Xbar := Image(p2, K1);                   # subgroup of G  (= X(P-bar) read in Gamma)
  # Cross-check of the kernel via an explicit homomorphism Mix -> Gamma-bar.
  hom2 := GroupHomomorphismByImages(Mix, G, mixgens, bar);
  if hom2 = fail then Error("CG.ChiralityGroupByMix: projection hom failed"); fi;
  ker2 := Kernel(hom2);
  Xhom := Image(p1, ker2);
  return rec( D := D, Mix := Mix, mixgens := mixgens, K1 := K1, K2 := K2,
              X := X, Xbar := Xbar, Xhom := Xhom,
              proj1_surjective := ( Image(p1, Mix) = G ),
              proj2_surjective := ( Image(p2, Mix) = G ) );
end;

#############################################################################
##  Method 3: smallest normal subgroup with a mirror-invariant quotient
#############################################################################

CG.MirrorInvariantNormalSubgroups := function(G, gens)
  local Ns, inv, N, nat, Q, qgens;
  Ns  := NormalSubgroups(G);
  inv := [];
  for N in Ns do
    nat   := NaturalHomomorphismByNormalSubgroup(G, N);
    Q     := Image(nat);
    qgens := List(gens, x -> Image(nat, x));
    if GroupHomomorphismByImages(Q, Q, qgens, CG.MirrorImages(qgens)) <> fail then
      Add(inv, N);
    fi;
  od;
  return rec( all := Ns, invariant := inv, smallest := Intersection(inv) );
end;

#############################################################################
##  Identification helpers
#############################################################################

CG.Describe := function(H)
  local r;
  r := rec( size := Size(H), structure := StructureDescription(H) );
  if Size(H) <= 2000 and Size(H) <> 1024 then
    r.idgroup := IdGroup(H);
  else
    r.idgroup := fail;
  fi;
  return r;
end;

## Words in the distinguished generators.
CG.WordEpimorphism := function(G, names)
  return EpimorphismFromFreeGroup(G : names := names);
end;

CG.Word := function(epi, g)
  return PreImagesRepresentative(epi, g);
end;

## Standard comparison groups as permutation groups.
CG.StandardGroup := function(name)
  if name = "A5"        then return AlternatingGroup(5); fi;
  if name = "S4"        then return SymmetricGroup(4); fi;
  if name = "S5"        then return SymmetricGroup(5); fi;
  if name = "A5xA5"     then return DirectProduct(AlternatingGroup(5), AlternatingGroup(5)); fi;
  if name = "SL(2,5)"   then return Image(IsomorphismPermGroup(SL(2,5))); fi;
  if name = "SL(2,3)"   then return Image(IsomorphismPermGroup(SL(2,3))); fi;
  if name = "GL(2,3)"   then return Image(IsomorphismPermGroup(GL(2,3))); fi;
  if name = "Q8"        then return Image(IsomorphismPermGroup(QuaternionGroup(8))); fi;
  if name = "C2"        then return CyclicGroup(IsPermGroup, 2); fi;
  if name = "C2^3"      then return Image(IsomorphismPermGroup(ElementaryAbelianGroup(8))); fi;
  if name = "C2xC4"     then return Image(IsomorphismPermGroup(AbelianGroup([2,4]))); fi;
  if name = "C4"        then return CyclicGroup(IsPermGroup, 4); fi;
  if name = "C8"        then return CyclicGroup(IsPermGroup, 8); fi;
  if name = "1"         then return TrivialGroup(IsPermGroup); fi;
  Error("CG.StandardGroup: unknown name ", name);
end;

## true iff H is isomorphic to the named standard group (explicit isomorphism).
CG.IsIsomorphicToStandard := function(H, name)
  return IsomorphismGroups(H, CG.StandardGroup(name)) <> fail;
end;

#############################################################################
##  Environment report
#############################################################################

CG.PrintEnvironment := function()
  local n;
  Print("GAP version: ", GAPInfo.Version, "\n");
  Print("Loaded packages:\n");
  for n in Set(RecNames(GAPInfo.PackagesLoaded)) do
    Print("  ", n, " ", GAPInfo.PackagesLoaded.(n)[2], "\n");
  od;
end;

#############################################################################
##  Full pipeline for one polytope
#############################################################################

## G     : the finite group Gamma = <gens>
## gens  : [S1,S2,S3]
## names : generator names for words, e.g. ["S1","S2","S3"]
## Returns a record with everything the report and the verification need.
CG.ComputeChiralityGroup := function(G, gens, names)
  local res, pres, m1, m2, m3, X, quo, nat, epi, k1, k2;
  if GeneratorsOfGroup(G) <> gens then
    Error("CG.ComputeChiralityGroup: G must be given with GeneratorsOfGroup(G) = gens ",
          "(words and homomorphisms rely on this correspondence)");
  fi;
  res := rec();
  res.G := G; res.gens := gens; res.names := names;
  res.order := Size(G);
  res.G_desc := CG.Describe(G);
  res.strings := CG.StringRelationData(gens);
  res.intersection_property := CG.IntersectionProperty(G, gens);
  res.fvector := CG.FVector(G, gens);
  res.mirror_automorphism := CG.MirrorAutomorphism(G, gens);
  # Method 1
  pres := CG.PresentationOnGenerators(G, gens, names);
  res.pres := pres;
  m1 := CG.ChiralityGroupByRelators(G, gens, pres);
  res.m1 := m1;
  # Method 2
  m2 := CG.ChiralityGroupByMix(G, gens);
  res.m2 := m2;
  # Method 3
  m3 := CG.MirrorInvariantNormalSubgroups(G, gens);
  res.m3 := m3;
  # Agreement
  res.agree_12   := ( m1.X = m2.X );
  res.agree_2bar := ( m2.X = m2.Xbar );
  res.agree_2hom := ( m2.X = m2.Xhom );
  res.agree_13   := ( m1.X = m3.smallest );
  res.mix_order_ok := ( Size(m2.Mix) = Size(G) * Size(m1.X) );
  # Every N with mirror-invariant quotient contains X (theorem); the set of
  # such N is closed under intersection (theorem).  The converse "N contains X
  # implies mirror-invariant quotient" is FALSE in general and is not claimed.
  res.invariant_all_contain_X := ForAll(m3.invariant, N -> IsSubgroup(N, m1.X));
  res.invariant_closed_under_intersection :=
     ForAll(m3.invariant, N1 -> ForAll(m3.invariant, N2 -> Intersection(N1, N2) in m3.invariant));
  res.contains_X_but_not_invariant :=
     Filtered(m3.all, N -> IsSubgroup(N, m1.X) and not N in m3.invariant);
  X := m1.X;
  res.X := X;
  res.X_normal := IsNormal(G, X);
  res.index := Index(G, X);
  res.X_desc := CG.Describe(X);
  nat := NaturalHomomorphismByNormalSubgroup(G, X);
  quo := Image(nat);
  res.quotient := quo;
  res.quotient_desc := CG.Describe(quo);
  res.quotient_gens := List(gens, g -> Image(nat, g));
  res.quotient_mirror := CG.MirrorAutomorphism(quo, res.quotient_gens);
  res.quotient_gens_orders := List(res.quotient_gens, Order);
  res.quotient_strings_hold := CG.StringRelationData(res.quotient_gens).holds;
  res.quotient_ip := CG.IntersectionProperty(quo, res.quotient_gens);
  res.quotient_fvector := CG.FVector(quo, res.quotient_gens);
  # The mix Gamma ◊ Gamma-bar = W^+/(M cap M^{r0}) is the rotation group of the
  # smallest directly regular cover P_W (BJS Sect. 4; Cunningham Sect. 4).
  res.mix_gens_orders := List(m2.mixgens, Order);
  res.mix_strings_hold := CG.StringRelationData(m2.mixgens).holds;
  res.mix_mirror := CG.MirrorAutomorphism(m2.Mix, m2.mixgens);
  res.mix_ip := CG.IntersectionProperty(m2.Mix, m2.mixgens);
  res.mix_fvector := CG.FVector(m2.Mix, m2.mixgens);
  res.totally_chiral := ( X = G );
  res.directly_regular := IsTrivial(X);
  # Defect elements from ord(S1^-1 S3) versus ord(S1 S3)
  k1 := res.strings.ord_S1invS3;   # relator (s1^-1 s3)^k1 holds; mirror is (s1 s3)^k1
  k2 := res.strings.ord_S1S3;      # relator (s1 s3)^k2 holds;    mirror is (s1^-1 s3)^k2
  res.defect_A := (gens[1]*gens[3])^k1;
  res.defect_B := (gens[1]^-1*gens[3])^k2;
  res.defect_A_closure := NormalClosure(G, Subgroup(G, [res.defect_A]));
  res.defect_B_closure := NormalClosure(G, Subgroup(G, [res.defect_B]));
  res.defect_A_generates_X := ( res.defect_A_closure = X );
  res.defect_B_generates_X := ( res.defect_B_closure = X );
  # Words
  epi := CG.WordEpimorphism(G, names);
  res.epi := epi;
  return res;
end;

#############################################################################
##  Report printer
#############################################################################

CG.PrintReport := function(res, title)
  local s, i, w, F, fg, imgs, showrel, nshow;
  Print("\n==========================================================\n");
  Print(title, "\n");
  Print("==========================================================\n");
  s := res.strings;
  Print("|Gamma| = ", res.order, "\n");
  Print("IdGroup(Gamma) = ", res.G_desc.idgroup,
        "   StructureDescription(Gamma) = ", res.G_desc.structure,
        "   (StructureDescription strings are GAP output, not isomorphism invariants)\n");
  Print("orders of (S1,S2,S3) = ", s.orders, "   (Schlaefli type {",
        s.orders[1], ",", s.orders[2], ",", s.orders[3], "})\n");
  Print("ord(S1 S2) = ", s.ord_S1S2, ", ord(S2 S3) = ", s.ord_S2S3,
        ", ord(S1 S2 S3) = ", s.ord_S1S2S3, ", ord(S3 S2 S1) = ", s.ord_S3S2S1, "\n");
  Print("standard relations (s1s2)^2=(s2s3)^2=(s1s2s3)^2=1 hold: ", s.holds, "\n");
  Print("intersection property (rank 4) holds: ", res.intersection_property, "\n");
  Print("abstract f-vector (vertices, edges, 2-faces, cells) = ", res.fvector, "\n");
  Print("mirror assignment S1->S1^-1, S2->S1^2 S2, S3->S3 extends to an automorphism of Gamma: ",
        res.mirror_automorphism <> fail, "\n");
  Print("ord(S1^-1 S3) = ", s.ord_S1invS3, "   versus   ord(S1 S3) = ", s.ord_S1S3, "\n");
  Print("\n--- Method 1: mirrored relators ---\n");
  Print("presentation on (S1,S2,S3): ", res.pres.nrelators, " relators (3 of W^+ first); ",
        "relators hold in Gamma: ", res.pres.evalOK,
        "; |<S1,S2,S3 | R>| = |Gamma| by coset enumeration: ", res.pres.sizeOK, "\n");
  Print("relators R (as words in S1,S2,S3):\n");
  for i in [1..Length(res.pres.relators)] do
    Print("  r", i, " = ", res.pres.relators[i], "\n");
  od;
  Print("mirrored relators R^{r0} and their values in Gamma (order of the value):\n");
  for i in [1..Length(res.m1.mirrored)] do
    Print("  r", i, "-bar = ", res.m1.mirrored[i], "   -> order ", Order(res.m1.images[i]), "\n");
  od;
  Print("|X_1| = |normal closure of the mirrored relators| = ", Size(res.m1.X), "\n");
  Print("greedy sublist of mirrored relators already normally generating X_1: ",
        List(res.m1.minimal_indices, i -> Concatenation("r", String(i), "-bar")), "\n");
  Print("\n--- Method 2: mix with the enantiomorphic group ---\n");
  Print("|Mix| = |<(S1,S1^-1),(S2,S1^2 S2),(S3,S3)>| = ", Size(res.m2.Mix), "\n");
  Print("|Gamma| * |X_1| = ", res.order * Size(res.m1.X),
        "   equal to |Mix|: ", res.mix_order_ok, "\n");
  Print("both projections surjective: ", res.m2.proj1_surjective and res.m2.proj2_surjective, "\n");
  Print("|X_2| = |first coordinates of ker(projection onto mirror factor)| = ", Size(res.m2.X), "\n");
  Print("|X_2-bar| = |second coordinates of ker(projection onto first factor)| = ", Size(res.m2.Xbar), "\n");
  Print("X_2 = X_1 as subgroups of Gamma: ", res.agree_12, "\n");
  Print("X_2 = X_2-bar as subgroups of Gamma: ", res.agree_2bar, "\n");
  Print("X_2 = kernel computed via explicit homomorphism Mix -> Gamma-bar: ", res.agree_2hom, "\n");
  Print("\n--- Method 3: smallest normal subgroup with mirror-invariant quotient ---\n");
  Print("orders of all normal subgroups of Gamma: ", List(res.m3.all, Size), "\n");
  Print("orders of those N with Gamma/N admitting the mirror automorphism: ",
        List(res.m3.invariant, Size), "\n");
  Print("smallest such N has order ", Size(res.m3.smallest),
        "; equals X_1: ", res.agree_13, "\n");
  Print("every such N contains X_1: ", res.invariant_all_contain_X,
        ";  the set of such N is closed under intersection: ", res.invariant_closed_under_intersection, "\n");
  Print("orders of normal subgroups containing X_1 whose quotient is NOT mirror-invariant: ",
        List(res.contains_X_but_not_invariant, Size), "\n");
  Print("\n--- The chirality group X(P) ---\n");
  Print("|X(P)| = ", Size(res.X), "\n");
  Print("X(P) normal in Gamma: ", res.X_normal, "\n");
  Print("[Gamma : X(P)] = ", res.index, "\n");
  Print("StructureDescription(X(P)) = ", res.X_desc.structure, "\n");
  Print("IdGroup(X(P)) = ", res.X_desc.idgroup, "\n");
  Print("StructureDescription(Gamma/X(P)) = ", res.quotient_desc.structure, "\n");
  Print("IdGroup(Gamma/X(P)) = ", res.quotient_desc.idgroup, "\n");
  Print("Gamma/X(P) admits the mirror automorphism: ", res.quotient_mirror <> fail, "\n");
  Print("Gamma/X(P) = W^+/M^W: generator orders ", res.quotient_gens_orders,
        ", string relations hold: ", res.quotient_strings_hold,
        ", intersection property: ", res.quotient_ip,
        ", coset f-vector ", res.quotient_fvector, "\n");
  Print("Mix = W^+/M_W (smallest regular cover): generator orders ", res.mix_gens_orders,
        ", string relations hold: ", res.mix_strings_hold,
        ", mirror automorphism exists: ", res.mix_mirror <> fail,
        ", intersection property: ", res.mix_ip,
        ", coset f-vector ", res.mix_fvector, "\n");
  Print("directly regular (X trivial): ", res.directly_regular, "\n");
  Print("totally chiral (X = Gamma): ", res.totally_chiral, "\n");
  Print("\n--- Defect elements ---\n");
  Print("A = (S1 S3)^", s.ord_S1invS3, "  [mirror of the relator (S1^-1 S3)^",
        s.ord_S1invS3, "]: order ", Order(res.defect_A),
        ", |normal closure| = ", Size(res.defect_A_closure),
        ", equals X(P): ", res.defect_A_generates_X, "\n");
  Print("B = (S1^-1 S3)^", s.ord_S1S3, "  [mirror of the relator (S1 S3)^",
        s.ord_S1S3, "]: order ", Order(res.defect_B),
        ", |normal closure| = ", Size(res.defect_B_closure),
        ", equals X(P): ", res.defect_B_generates_X, "\n");
end;

## Print words in S1,S2,S3 for a list of elements.
CG.PrintWords := function(res, elts, label)
  local g;
  Print(label, "\n");
  for g in elts do
    Print("  ", CG.Word(res.epi, g), "   (order ", Order(g), ")\n");
  od;
end;

## A small generating set of a subgroup (drops the redundant generators that
## NormalClosure leaves behind).
CG.SmallGens := function(H)
  if IsTrivial(H) then return []; fi;
  return SmallGeneratingSet(H);
end;
