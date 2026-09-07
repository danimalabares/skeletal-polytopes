# Combinatorial chirality groups of Roli's cube and of {12/(1,5),3,5}

This directory contains a self-contained, reproducible GAP computation of the
**chirality group** `X(P)` (Breda D'Azevedo–Jones–Schulte) of the abstract
polytopes underlying two geometrically chiral skeletal 4-polytopes in `ℝ⁴`:

1. **Roli's cube**, the polytope `Q̂` of Bracho, Hubard and Pellicer (2014)
   (the name comes from the thesis; BHP write `Q̂`), of Schläfli type
   `{8,3,3}`, whose rotation group is `[4,3,3]⁺` (order 192);
2. **`{12/(1,5),3,5}`** of the master's thesis / paper *Two new chiral
   4-polytopes of full rank*, of type `{12,3,5}`, whose rotation group is
   `[3,3,5]⁺` (order 7200).

Full bibliographic details are in [`references.md`](references.md).  Everything
below labelled **[verified]** is asserted by `verify.g` and recorded in the
transcripts under `results/`; **[transcript]** marks details that are printed
in the transcripts of GAP 4.14.0 but depend on GAP's choice of presentation
and are therefore not asserted; everything labelled **[deduction]** is a
mathematical argument from the cited sources, and **[cited]** marks facts
taken from the sources without recomputation.  `StructureDescription`
strings are quoted as GAP prints them; GAP documents that they are not
isomorphism invariants, so isomorphism types are always established by
`IsomorphismGroups` or `IdGroup`.

## 0. Results

| | Roli's cube | `{12/(1,5),3,5}` |
|---|---|---|
| Coxeter group containing `Γ` | `[4,3,3]`, order 384 | `[3,3,5]`, order 14400 |
| `Γ = Γ⁺(P) = ⟨S₁,S₂,S₃⟩` | `[4,3,3]⁺` | `[3,3,5]⁺` |
| `|Γ|` | **192** | **7200** |
| orders of `S₁,S₂,S₃` (type) | 8, 3, 3 (`{8,3,3}`) | 12, 3, 5 (`{12,3,5}`) |
| f-vector of `P` | (16, 32, 12, 4) | (120, 720, 300, 50) |
| mirror map `S₁↦S₁⁻¹, S₂↦S₁²S₂, S₃↦S₃` extends to `Aut(Γ)` | **no** | **no** |
| `ord(S₁⁻¹S₃)` vs `ord(S₁S₃)` | 4 vs 8 | 5 vs 15 |
| **`X(P)`** | **`C₂ = Z(Γ) = ⟨S₁⁴⟩ = {±I}`** | **`SL(2,5)` (binary icosahedral group)** |
| `|X(P)|` (chirality index) | **2** | **120** |
| `[Γ : X(P)]` | **96** | **60** |
| `Γ/X(P)` | `[4,3,3]⁺/{±I}`, IdGroup `[96,227]`, StructureDescription `(C2 x C2) : S4` | **`A₅`** |
| `IdGroup(X(P))` | `[2,1]` | `[120,5]` |
| normal generator of `X(P)` | `(S₁S₃)⁴ = S₁⁴` | `(S₁S₃)⁵` (an element of order 3) |
| `|Γ ◊ Γ̄| = |Γ|·|X(P)|` | 384 | 864 000 |
| combinatorial status | **chiral**, not totally chiral | **chiral**, not totally chiral |

Both polytopes are combinatorially chiral (their abstract polytopes are not
regular), confirming the thesis for `{12/(1,5),3,5}`; but neither is totally
chiral.  The largest directly regular quotient `P/X(P)` of Roli's cube has
rotation group `[4,3,3]⁺/{±I}` with generators of orders (4,3,3) and coset
f-vector (8,16,12,4): it is the projective polytope `Q ≅ {4,3,3}/2` of
Bracho–Hubard–Pellicer, which they prove to be combinatorially regular.  For
`{12/(1,5),3,5}` the quotient `W⁺/M^W ≅ A₅` has generators of orders (2,3,5)
and fails the intersection property, so the "largest regular quotient" is only
polytope-like (as BJS warn), while the smallest regular cover
`P ◊ P̄` has rotation group of order 864 000, satisfies the intersection
property and has f-vector (14400, 86400, 36000, 6000).

## 1. The chirality group (definition)

Following [BJS, §4] (see `references.md` for page numbers), let
`W = ⟨r₀,r₁,r₂,r₃⟩` be the universal string Coxeter group `[∞,∞,∞]` and
`W⁺ = ⟨s₁,s₂,s₃⟩`, `sᵢ = r_{i-1} rᵢ`, its rotation subgroup, with presentation

    (s₁s₂)² = (s₂s₃)² = (s₁s₂s₃)² = 1.                                   (W⁺)

For a chiral or directly regular 4-polytope `P` with base flag `Φ`, the
rotation group is a quotient `Γ⁺(P) = W⁺/M` via `sᵢ ↦ σᵢ`.  Conjugation by
`r₀` is an automorphism of `W⁺` acting on the generators by

    s₁ ↦ s₁⁻¹,   s₂ ↦ s₁² s₂,   s₃ ↦ s₃,                                 (mirror)

and `M^{r₀} := r₀ M r₀` is the normal subgroup of the enantiomorphic polytope
`P̄` (same faces, base flag `Φ⁰`).  Put `M_W := M ∩ M^{r₀}` and
`M^W := M M^{r₀}`.  The **chirality group** is

    X(P) := M^W / M  ≅  M^{r₀} / (M ∩ M^{r₀})  ≅  M / M_W  ≅  M^W / M^{r₀}

[BJS, Lemma 4.1].  It is a normal subgroup of `Γ⁺(P) = W⁺/M` with
`Γ⁺(P)/X(P) = W⁺/M^W` [BJS, eq. (13)].  `X(P)` is trivial iff `P` is directly
regular; `P` is *totally chiral* iff `X(P) = Γ⁺(P)`.  Its order is the
chirality index.  Cunningham [Cun, §4] describes the same group as the kernel
of the natural map `Γ⁺(P) ◊ Γ⁺(P̄) → Γ⁺(P)` and, isomorphically, as the kernel
of `Γ⁺(P) → Γ⁺(P) □ Γ⁺(P̄)`, where `P ◊ P̄` is the smallest directly regular
cover and `P □ P̄` the largest directly regular quotient.

Because `W = W⁺ ∪ r₀W⁺` and `M ⊴ W⁺`, conjugating by any `rᵢ` gives the same
`M^{r₀}`; the group `X(P)` does not depend on the choice of `r₀`.  [deduction]

## 2. Generator conventions, and why the mirror is `(S₁⁻¹, S₁²S₂, S₃)`

**The sources.**  Schulte–Weiss [SW, §2–3], BJS [§2] and Cunningham [§2.3]
all use `σᵢ = ρ_{i-1}ρᵢ`.  The orientation of a chiral polytope's generators
is fixed in [SW, p. 496] and [BJS, p. 4] by `σᵢ(F'ᵢ) = Fᵢ` (`F'ᵢ` the other
`i`-face between `F_{i-1}` and `F_{i+1}`), and equivalently in [Cun, p. 4] by
"`σᵢ` sends `Φ` to `Φ^{i,i-1}`".  In this convention the distinguished generators satisfy
`(σ₁σ₂)² = (σ₂σ₃)² = (σ₁σ₂σ₃)² = 1` — note `σ₁σ₂σ₃ = ρ₀ρ₃` — and the polytope
is directly regular iff there is an involutory automorphism with
`σ₁ ↦ σ₁⁻¹`, `σ₂ ↦ σ₁²σ₂`, `σ₃ ↦ σ₃` [SW, Thm. 1; BJS, p. 5–6; Cun, p. 4].
This is conjugation by `ρ₀`: `ρ₀(ρ₀ρ₁)ρ₀ = ρ₁ρ₀ = σ₁⁻¹`,
`ρ₀(ρ₁ρ₂)ρ₀ = (ρ₀ρ₁)²(ρ₁ρ₂) = σ₁²σ₂` (using `ρ₀ρ₂ = ρ₂ρ₀`), `ρ₀(ρ₂ρ₃)ρ₀ = ρ₂ρ₃`.
The thesis (`two-chiral.tex`, §3.1) adopts exactly this convention and this
criterion, and the legacy scripts `combinatorially-chiral*.g`, `abstract.g`
test exactly this assignment.

**The opposite convention would change the formula.**  If one used
`τᵢ = ρᵢρ_{i-1} = σᵢ⁻¹` instead, the natural relation would be
`(τ₃τ₂τ₁)² = 1` (not `(τ₁τ₂τ₃)² = 1`) and conjugation by `ρ₀` would read
`τ₂ ↦ τ₂τ₁²`, not `τ₁²τ₂`.  So the formula cannot be applied blindly; the
convention of the triple must be checked.

**The repository's triples are in the `σ`-convention.**  Three independent
checks:

* *Algebraic* [verified]: `ord(S₁S₂S₃) = 2` but `ord(S₃S₂S₁) = 4` (Roli),
  `= 5` (`{12/(1,5),3,5}`).  A triple in the `τ`-convention would have
  `(S₃S₂S₁)² = 1`, so this excludes the inverse triple `(S₁⁻¹,S₂⁻¹,S₃⁻¹)`.
  It does not by itself exclude every other candidate: `(−S₁, S₂, S₃)`, with
  `−I = S₁⁴` resp. `S₁⁶` central, satisfies the same relations and
  intersection condition; it is excluded by the orientation check below.
* *Geometric — the orientation of each `Sᵢ` on the base flag* [verified,
  `CG.GeometricFlagData`]: with GAP's right action on row vectors and the
  base flag of the thesis, `v` (fixed by `S₂,S₃`, moved by `S₁`),
  `e = v⟨S₁S₂⟩ = {v, vS₁⁻¹} = {v, vP₀}`, `f = e⟨S₁⟩`, `c = f⟨S₁,S₂⟩`, the
  scripts check for `i = 1,2,3` that `Fᵢ·Sᵢ` is an `i`-face different from
  `Fᵢ`, incident with `F_{i-1}` and `F_{i+1}`, and that exactly two such
  `i`-faces exist (diamond condition): `e·S₁ = {v, vS₁}` is the other edge of
  `f` at `v`; `f·S₂` is the other 2-face of `c` containing `e`; `c·S₃` is the
  other cell containing `f`.  They also check that `(−S₁,S₂,S₃)` fails the
  `i = 1` test and that the geometric face stabilisers are `⟨S₂,S₃⟩`,
  `⟨S₃,S₁S₂⟩`, `⟨S₁,S₂S₃⟩`, `⟨S₁,S₂⟩` [SW, Prop. 6].  GAP multiplies "left to
  right" (`x*y` acts as `x` first, then `y`), whereas [SW] compose
  automorphisms as functions (right to left, cf. the proof of [SW, Lemma 1]);
  the map `g ↦ g⁻¹` is an isomorphism between the two conventions, and under
  it [SW]'s `σᵢ(F'ᵢ) = Fᵢ` becomes exactly `Fᵢ·Sᵢ = F'ᵢ`.  Hence
  `(S₁,S₂,S₃)` are the SW-oriented distinguished generators of the geometric
  base flag. [deduction + verified]

  A word of caution about the letters `Pᵢ`: they are the reflections of the
  *regular* polytope `Q` (`{4,3,3}`, resp. `{5/2,3,5}`), not of `P`.  With
  respect to `Q`'s own rotations `σᵢ^Q = P_{i-1}Pᵢ` the triple reads
  `(S₁,S₂,S₃) = (σ₁^Q (σ₃^Q)⁻¹, (σ₂^Q)⁻¹, (σ₃^Q)⁻¹)`, and indeed
  `S₁S₂ = P₀P₃`, `S₁S₂S₃ = P₀P₂` [verified] is the reverse of the pattern
  `σ₁σ₂ = ρ₀ρ₂`, `σ₁σ₂σ₃ = ρ₀ρ₃` that holds for `Q`.  This is not a
  contradiction: `P` shares only the vertices and edges of `Q`; its base
  2-face `f` and base cell `c` are different faces, and relative to
  `(v,e,f,c)` the orientation of `S₂, S₃` is the correct one, as the direct
  checks show.  Reading `Pᵢ = ρᵢ` literally and applying the convention to
  `Q` would wrongly suggest the `τ`-convention.
* *Structural* [deduction]: by [SW, Thm. 1] / [BJS, p. 5], any group
  `Γ = ⟨S₁,S₂,S₃⟩` satisfying the (W⁺)-relations and the rank-4 intersection
  condition is the rotation group of a unique chiral-or-directly-regular
  polytope `P(Γ)` whose distinguished generators *in the σ-convention* are the
  `Sᵢ`; the chirality group of `P(Γ)` is therefore computed with the (mirror)
  substitution above.  Combined with the orientation checks, `P(Γ)` is the
  abstract polytope of the skeletal polytope *with the thesis's base flag*,
  not its enantiomorph.

**Consequence.**  The enantiomorphic substitution to be used for both
polytopes is `S₁ ↦ S₁⁻¹, S₂ ↦ S₁²S₂, S₃ ↦ S₃`, as stated in the task; no
correction of the formula was necessary.

## 3. Why `Γ = ⟨S₁,S₂,S₃⟩` is the rotation group of the *abstract* polytope

The chirality group is an invariant of the abstract polytope `P`, i.e. of
`(Γ⁺(P); σ₁,σ₂,σ₃)`.  It is **not** an invariant of a realization, and the
geometric symmetry group of a realization can be a proper subgroup of
`Γ(P)` (BHP's projective polytope `Q` is combinatorially regular, but its
isometry group is only `Γ⁺(Q)`, of index 2 in `Γ(Q)`).  The argument that the groups
used here are the abstract rotation groups is:

1. **[verified]** `Γ` satisfies `(S₁S₂)² = (S₂S₃)² = (S₁S₂S₃)² = 1` and the
   rank-4 intersection condition
   `⟨S₁⟩∩⟨S₂⟩ = 1 = ⟨S₂⟩∩⟨S₃⟩`, `⟨S₁,S₂⟩∩⟨S₂,S₃⟩ = ⟨S₂⟩`.
2. **[cited, SW Thm. 1 / BJS p. 5]** Hence the coset construction with
   `Γ⁰ = ⟨S₂,S₃⟩`, `Γ¹ = ⟨S₃,S₁S₂⟩`, `Γ² = ⟨S₁,S₂S₃⟩`, `Γ³ = ⟨S₁,S₂⟩` yields
   a chiral or directly regular abstract 4-polytope `P(Γ)` with
   `Γ⁺(P(Γ)) = Γ` and distinguished generators `S₁,S₂,S₃`.
3. **[verified]** The coset f-vectors `(|Γ:Γ⁰|, …, |Γ:Γ³|)` are (16,32,12,4)
   and (120,720,300,50), and they equal the geometric f-vectors, computed
   here as the orbit sizes of the base vertex, edge, 2-face and cell under
   the matrix group (octagons and 6 faces per cell for Roli's cube;
   12-gons and 12 faces per cell for `{12/(1,5),3,5}`).  Moreover the
   geometric stabilisers of the base faces are exactly the abstract face
   groups `Γ⁰,…,Γ³`, so `Γ^iφ ↦ F_iφ` is a bijection in every rank.  This
   agrees with BHP (1-skeleton of the 4-cube, 4 facets `{8,3}` with 6
   octagons each) and with the thesis (120, 720, 300, 50), and with the
   counts printed by the legacy `cube.g`, `geometric.g`, `abstract.g`.
4. **[cited, thesis §3.2 and §5; BHP Thm. 2]** Wythoff's construction on the
   base vertex gives a faithful and symmetric realization of `P(Γ)`, whose
   face poset is the skeletal polytope; the rank-wise bijectivity in 3 is the
   computable part of faithfulness.  So the abstract polytope associated to
   the skeletal polytope is `P(Γ)` and its rotation group is `Γ` with the
   distinguished generators `Sᵢ`.
5. **[verified]** The abstract Coxeter group and the geometric one are the
   same group: `Eᵢ ↦ Rᵢ` (reflection matrices of `cube.g`, resp. of
   `geometric.g`) is an isomorphism `[4,3,3] → ⟨R₀,…,R₃⟩`, resp.
   `[3,3,5] → ⟨R₀,…,R₃⟩`, carrying the abstract triple to the matrix triple.
   Thus the geometric symmetry group `G(P) = ⟨S₁,S₂,S₃⟩_{matrices}` coincides
   with `Γ⁺(P)` *as a group with distinguished generators*.  This coincidence
   is a property of these two realizations (two flag orbits, adjacent flags
   in different orbits, faithful); it is not what defines `X(P)`.

For `{12/(1,5),3,5}` the group passes through `P₀ = E₀`,
`P₁ = E₁E₂E₃E₂E₁E₀E₁E₂E₃E₂E₁`, `P₂ = E₃`, `P₃ = E₂` (the generators of the
star polytope `{5/2,3,5}`, of type `{5,3,5}`, generating all of `[3,3,5]`
[verified]) and then `S₁ = P₀P₁P₃P₂`, `S₂ = P₂P₁`, `S₃ = P₃P₂`.  For Roli's
cube `S₁ = E₀E₁E₃E₂`, `S₂ = E₂E₁`, `S₃ = E₃E₂` directly in `[4,3,3]`.  In both
cases `Γ` is the full rotation subgroup of the Coxeter group [verified].

## 4. The computations

All three computations are implemented in `common/chirality-group.g` and run
by `rolis-cube/compute.g` and `12-over-1-5-3-5/compute.g`.  `Γ` is a
permutation group (faithful permutation representation of the finite Coxeter
group obtained with `IsomorphismPermGroup`), so every subgroup computed is a
concrete subgroup of one and the same permutation group, and equality of
subgroups is decided exactly.

### Method 1 — normal closure of the mirrored relators [BJS, §4, p. 12]

1. `IsomorphismFpGroupByGenerators(Γ, [S₁,S₂,S₃])` returns a presentation
   whose generators correspond **exactly** to `S₁,S₂,S₃`; the script checks
   `Image(iso, Sᵢ) = i-th generator` and `PreImagesRepresentative(iso, i-th
   generator) = Sᵢ`.  The relators are transported to a free group on
   `S1,S2,S3` and the three (W⁺) relators are prepended.  **No other Tietze
   generator ever appears**, so the mirror substitution is applied to words
   in the distinguished generators only.  (The pitfall with
   `IsomorphismFpGroup(Γ)`, which chooses its own generators, is thereby
   avoided; the legacy `abstract.g` contains such a call, unused.)
   GAP's random sources are reset immediately before this call, so the
   relator set in the transcript does not depend on what was computed
   earlier in the script; it may still differ between GAP versions.
2. The presentation is **certified**: every relator evaluates to `1` in `Γ`,
   and coset enumeration gives `|⟨S1,S2,S3 | R⟩| = |Γ|`.  Together these prove
   that `sᵢ ↦ Sᵢ` is an isomorphism `F/⟨⟨R⟩⟩ → Γ`, i.e. `R` is a complete set
   of defining relators on the distinguished triple.  [verified]
3. Each relator `r ∈ R` is mirrored **as a word**
   (`MappedWord(r, [s1,s2,s3], [s1⁻¹, s1²s2, s3])`), evaluated in `Γ`, and
   `X₁ := ⟨⟨ r̄(S₁,S₂,S₃) : r ∈ R ⟩⟩_Γ` is the normal closure.

Why this is `X(P)`: `M = ⟨⟨R⟩⟩_{W⁺}`, so `M^{r₀} = ⟨⟨R^{r₀}⟩⟩_{W⁺}` since
conjugation by `r₀` is the automorphism (mirror) of `W⁺`; the image of
`M^{r₀}` in `W⁺/M = Γ` is `MM^{r₀}/M = X(P)`, and it is the normal closure of
the image of `R^{r₀}` [BJS, p. 12].  The mirrored (W⁺)-relators are trivial in
`W⁺` (a theorem: the mirror is an automorphism of `W⁺`); their images in `Γ`
are checked to be trivial [verified].

### Method 2 — mix with the enantiomorphic group [BJS §5; Cun §3–4]

Let `φ : W⁺ → Γ`, `sᵢ ↦ Sᵢ` (kernel `M`) and `α` the mirror automorphism of
`W⁺`.  Then `φ̄ := φ∘α : sᵢ ↦ S̄ᵢ := (S₁⁻¹, S₁²S₂, S₃)ᵢ` has kernel
`α⁻¹(M) = α(M) = M^{r₀}`, so `(Γ; S̄₁,S̄₂,S̄₃) = Γ⁺(P̄) = W⁺/M^{r₀}`
[Cun, §2.3].  The mix

    Γ ◊ Γ̄ := ⟨ (S₁,S₁⁻¹), (S₂,S₁²S₂), (S₃,S₃) ⟩ ≤ Γ × Γ

is the image of `ψ = (φ, φ̄) : W⁺ → Γ×Γ`, whose kernel is `M ∩ M^{r₀} = M_W`;
hence `Γ ◊ Γ̄ ≅ W⁺/M_W = Γ⁺(P ◊ P̄)` [BJS eq. (16); Cun Prop. 3.1].
Since `π₂∘ψ = φ̄`,

    ker(π₂|_{Γ◊Γ̄}) = ψ(M^{r₀}) = { (φ(w), 1) : w ∈ M^{r₀} },

and the set of **first coordinates** of this kernel is
`φ(M^{r₀}) = M^{r₀}M/M = M^W/M = X(P)` **as a subgroup of `Γ⁺(P)`** — so the
kernel of the projection onto the *mirror* factor, read in the first factor,
realizes `X(P)` inside `Γ⁺(P)`.  Symmetrically `ker(π₁|_{Γ◊Γ̄}) = ψ(M) =
{(1, φ̄(w)) : w ∈ M}`; its second coordinates form `φ̄(M) = φ(α(M)) =
φ(M^{r₀})`, which is `X(P̄) = M^W/M^{r₀}` read in `Γ⁺(P̄) = W⁺/M^{r₀}`.
Abstractly all these kernels are isomorphic to `X(P)` [BJS Lemma 4.1;
Cun Prop. 3.3], but only the first-coordinate reading of `ker π₂` is `X(P)`
*as the specific normal subgroup* `M^W/M` of `Γ⁺(P)`.  Because the mirror
copy here lives inside the same group `Γ`, the two readings give the same
subset `φ(M^{r₀})` of `Γ`.  Also `|Γ ◊ Γ̄| = |Γ|·|ker π₁| = |Γ|·|X(P)|`.

The script computes `X₂ :=` first coordinates of `(Γ◊Γ̄) ∩ (Γ×1)`,
`X̄₂ :=` second coordinates of `(Γ◊Γ̄) ∩ (1×Γ)`, the kernel of the explicit
homomorphism `Γ◊Γ̄ → Γ̄`, and checks `X₂ = X̄₂ = X₁` **as subgroups of the same
permutation group**, as well as `|Γ◊Γ̄| = |Γ|·|X₁|` and surjectivity of both
projections. [verified]

No adjustment of the formulation in the task was needed; the only point to
make precise was *which* factor's kernel, read in *which* coordinate, is
`X(P) ⊴ Γ⁺(P)` (the kernel of the projection onto the mirror factor, read in
the first coordinate).

### Method 3 — lattice characterisation (independent cross-check)

For `N ⊴ Γ` with preimage `Ñ ⊴ W⁺` (`Ñ ⊇ M`), the mirror assignment on the
images of `S₁,S₂,S₃` extends to an automorphism of `Γ/N = W⁺/Ñ` iff
`α(Ñ) = Ñ`, i.e. iff `Ñ ⊴ W`.  The smallest normal subgroup of `W`
containing `M` is `MM^{r₀} = M^W`.  Hence **`X(P)` is the smallest normal
subgroup `N` of `Γ` such that `Γ/N` admits the mirror automorphism**, every
such `N` contains `X(P)`, and the family of such `N` is closed under
intersection.  [deduction]  The script enumerates all normal subgroups of
`Γ`, tests each quotient with `GroupHomomorphismByImages`, and checks these
three statements against `X₁`. [verified]

**Caution (found by this computation).**  The converse "`N ⊇ X(P)` ⇒ `Γ/N`
admits the mirror automorphism" is *false*: for Roli's cube all three normal
subgroups of order 8 contain `X(P) = Z(Γ)`, but only one of them has a
mirror-invariant quotient (the mirror automorphism of `Γ/X(P)` swaps the other
two).  Do not "identify" `X(P)` by that converse.

### Identification of the groups

`StructureDescription` and `IdGroup` are reported but the isomorphism types
are established by `IsomorphismGroups` against explicitly constructed groups
(`CyclicGroup(2)`, `SL(2,5)`, `AlternatingGroup(5)`, `[4,3,3]⁺/Z`) together
with invariants (perfectness, centre, unique involution, simplicity).
[verified]

## 5. Results in detail

### 5.1 Roli's cube (`rolis-cube/compute.g`, `results/rolis-cube.transcript.txt`)

* `|[4,3,3]| = 384`, `Γ = [4,3,3]⁺`, `|Γ| = 192`, IdGroup `[192,1494]`
  (StructureDescription `Q8 : S4`); `Sᵢ` of orders 8, 3, 3; `(S₁S₂)² = (S₂S₃)² =
  (S₁S₂S₃)² = 1`, `ord(S₃S₂S₁) = 4`; intersection property holds;
  f-vector (16,32,12,4).  The mirror assignment does **not** extend to an
  automorphism of `Γ` (the legacy test); `ord(S₁⁻¹S₃) = 4 ≠ 8 = ord(S₁S₃)`.
  [verified]
* Certified presentation on `S1,S2,S3` [verified: relators hold and coset
  enumeration gives 192].  In GAP 4.14.0 it has 9 relators, the three (W⁺)
  relators first, then
  `S2^3`, `(S1^-1*S2^-1)^2`, `S1^-1*S3*S1*S3^-1*S2`, `(S2^-1*S1*S3^-1)^2`,
  `S2^-1*S1^-1*S3^-2*S1*S2*S3`, `(S3*S1^-1)^4`; all mirrored relators
  evaluate to `1` except the last, `(S3*S1)^4`, which evaluates to an element
  of order 2. [transcript — the shipped transcript; another GAP version may
  choose a different, equally certified relator set; `X(P)` does not depend
  on it]
* **`X(P) = C₂`**, the centre of `Γ`, generated by `S₁⁴ = (S₁S₃)⁴`, which in
  the matrix representation is the central inversion `−I` of `ℝ⁴`.
  `[Γ : X(P)] = 96`. [verified]
* `Γ/X(P) = [4,3,3]⁺/{±I}` (IdGroup `[96,227]`), generated by elements of
  orders (4,3,3) satisfying the string relations and the intersection
  property, with coset f-vector (8,16,12,4), and it admits the mirror
  automorphism.  Independently, `Z([4,3,3]) = {±I}`, `|[4,3,3]/{±I}| = 192`
  (the automorphism group of the hemi-4-cube), its rotation subgroup
  `⟨E₀E₁,E₁E₂,E₂E₃⟩/{±I}` has order 96, and `Sᵢ ↦ Sᵢ{±I}` is an injective
  homomorphism of `Γ/X(P)` onto that rotation subgroup. [verified]  Since `X(P) = {±I}` acts on the skeletal
  polytope by the antipodal map, `P/X(P)` is precisely the projective polytope
  `Q` of BHP, which they prove to be combinatorially regular and isomorphic to
  the hemi-hypercube `{4,3,3}/2` [cited, BHP Thm. 1]; consistently,
  `[4,3,3]⁺/{±I}` is the rotation group of the hemi-hypercube. [deduction]
* `Γ ◊ Γ̄` has order 384 = 192·2, generators of orders (8,3,3), admits the
  mirror automorphism and has the intersection property, with coset f-vector
  (32,64,24,8): the smallest directly regular cover `P ◊ P̄` is a directly
  regular polytope of type `{8,3,3}` with 32 vertices (a 2-fold cover of
  Roli's cube). [verified + deduction]
* Normal subgroups of `Γ` have orders 1, 2, 8, 8, 8, 32, 96, 192; those with
  mirror-invariant quotient have orders 2, 8, 32, 96, 192. [verified]
* Status: **combinatorially chiral, chirality index 2, not totally chiral.**
  Geometrically: Roli's cube is geometrically chiral [cited, BHP Thm. 2] and
  its abstract polytope is chiral as well, but only "minimally so": it
  becomes regular after identifying antipodal vertices.

### 5.2 `{12/(1,5),3,5}` (`12-over-1-5-3-5/compute.g`, `results/12-over-1-5-3-5.transcript.txt`)

* `|[3,3,5]| = 14400`; the `Pᵢ` are involutions with `(P₀P₁, P₁P₂, P₂P₃)` of
  orders (5,3,5) and `P₀P₂, P₀P₃, P₁P₃` of order 2, generating all of
  `[3,3,5]`; `Γ = [3,3,5]⁺`, `|Γ| = 7200`,
  `Γ ≅ (SL(2,5) × SL(2,5))/⟨(−1,−1)⟩` by an explicit isomorphism
  (StructureDescription `SL(2,5) : A5`); `Sᵢ` of orders 12, 3, 5; string
  relations hold with `ord(S₃S₂S₁) = 5`; intersection property holds;
  f-vector (120,720,300,50).  The mirror assignment does **not** extend (the
  thesis's test); `ord(S₁⁻¹S₃) = 5 ≠ 15 = ord(S₁S₃)`. [verified]
* Certified presentation on `S1,S2,S3` [verified: relators hold and coset
  enumeration gives 7200].  In the shipped transcript (GAP 4.14.0) it has
  12 relators; the mirrored relators evaluate to elements of orders
  1,1,1,1,1,1,1,1,10,10,1,2 and the single mirrored relator `r9-bar` already
  normally generates `X(P)`. [transcript]
* **`X(P) ≅ SL(2,5)`** (IdGroup `[120,5]`), the binary icosahedral group:
  perfect, centre of order 2 (`= Z(Γ)`), unique involution, `X/Z(X) ≅ A₅`;
  `[Γ : X(P)] = 60`; `X(P) = ⟨⟨(S₁S₃)⁵⟩⟩_Γ`, and `(S₁S₃)⁵` has order 3.
  [verified]
* **`Γ/X(P) ≅ A₅`** (simple), generated by images of orders (2,3,5); the
  quotient triple violates the intersection property (coset f-vector
  (1,6,15,10)), so the largest directly regular quotient `W⁺/M^W` is a
  degenerate polytope-like object with one vertex, not a polytope. [verified]
  `X(P)` is one of the two normal subgroups of order 120 of `[3,3,5]⁺`; its
  centraliser is the other one, `X · C_Γ(X) = Γ`, `X ∩ C_Γ(X) = Z(Γ)`.
  In the geometric representation every element of `X(P)` (and of its
  centraliser) is a Clifford translation of `S³` (isoclinic rotation:
  `M + Mᵀ` scalar), while `Γ` itself contains non-isoclinic rotations.
  [verified]  Writing `ℝ⁴ = ℍ` and `[3,3,5]⁺ = {x ↦ a x b : a,b unit icosians}`,
  `X(P)` is the group of left (or right) multiplications by the 120 unit
  icosians, i.e. `2I = SL(2,5)`, and `Γ/X(P) ≅ A₅` is the image of the other
  factor. [deduction]
* `Γ ◊ Γ̄` has order 864 000 = 7200·120, generators of orders (12,3,5),
  admits the mirror automorphism and **has the intersection property**, with
  coset f-vector (14400, 86400, 36000, 6000): the smallest directly regular
  cover `P ◊ P̄` is a directly regular 4-polytope of type `{12,3,5}` with
  rotation group of order 864 000. [verified + deduction]
* Normal subgroups of `Γ` have orders 1, 2, 120, 120, 7200; those with
  mirror-invariant quotient have orders 120, 7200. [verified]
* Status: **combinatorially chiral, chirality index 120, not totally chiral.**

### 5.3 The `ord(S₁⁻¹S₃)` versus `ord(S₁S₃)` obstruction

By [BJS, Lemma 2.1] a directly regular group gives equal periods to a word and
its mirror.  Here the relator `(S₁⁻¹S₃)^k` with `k = ord(S₁⁻¹S₃)` (4, resp. 5)
mirrors to `(S₁S₃)^k`, whose value `A` is non-trivial (order 2, resp. 3),
proving chirality without any presentation.  The *other* relator
`(S₁S₃)^{k'}`, `k' = ord(S₁S₃)` (8, resp. 15), mirrors to `(S₁⁻¹S₃)^{k'} = 1`
because `k | k'`, and gives nothing.  The normal closure of the defect `A`
**does** equal the whole chirality group in both cases [verified] — this is
a computed fact, not something implied by the theory (in general the normal
closure of one mirrored relator is only a subgroup of `X(P)`).

## 6. Geometric versus combinatorial chirality

* A skeletal polytope is **geometrically chiral** if its isometry group
  `G(P)` has two flag orbits with adjacent flags in different orbits
  (thesis §2; BHP).  This is a property of the realization.
* An abstract polytope is **combinatorially chiral** if `Γ(P)` has two flag
  orbits with adjacent flags in different orbits; equivalently, there is no
  involutory automorphism of `Γ⁺(P)` with `σ₁ ↦ σ₁⁻¹, σ₂ ↦ σ₁²σ₂, σ₃ ↦ σ₃`
  [SW Thm. 1]; equivalently `X(P) ≠ 1` [BJS §4].  `X(P)` refines this to a
  measure of how far `P` is from regular.
* Geometric chirality does not imply combinatorial chirality: BHP's projective
  polytope `Q` is geometrically chiral yet combinatorially regular
  (`≅ {4,3,3}/2`), and the facets of both polytopes studied here are
  geometrically chiral but combinatorially regular (BHP; thesis).  For the two
  4-polytopes here the abstract polytopes turn out to be chiral too, with the
  chirality groups above.  Roli's cube illustrates the gap between geometric
  and combinatorial chirality most sharply: its chirality group is the
  smallest possible non-trivial one, and it is exactly the central inversion
  whose quotient is BHP's combinatorially regular `Q`.

## 7. Reproducing the computation

Requirements: GAP 4 (tested with GAP 4.14.0 as bundled with SageMath 10.7)
started with `-A`; only the packages GAP itself always loads (`gapdoc`,
`primgrp`, `smallgrp` for `IdGroup`, `transgrp`).  `sonata` is **not**
needed.  The GAP binary is found via the `GAP` environment variable, then
`gap` on the `PATH`, then the hard-coded SageMath 10.7 location of the
development machine (`/private/var/tmp/sage-10.7-current/local/bin/gap`,
skipped when absent), then `sage -gap`.

    cd computations/chirality-groups
    ./run.sh                         # or:  GAP=/path/to/gap ./run.sh

This writes `results/environment.txt`, `results/rolis-cube.transcript.txt`,
`results/12-over-1-5-3-5.transcript.txt` and `results/verify.transcript.txt`.
It exits with status 1 if a GAP run exits non-zero (a failed assertion calls
`QuitGap(1)`; runtime errors exit non-zero under `--quitonbreak`), if any
transcript contains an `Error`, `Syntax error` or `Syntax warning` line (GAP
exits 0 after a syntax error, which only truncates the file), if a compute
transcript lacks its final `Done:` sentinel, or if `verify.g` does not print
`ALL CHECKS PASSED`.  The whole pipeline takes about half a minute.
Running the pipeline twice gives byte-identical transcripts.

Individual GAP commands (from this directory):

    gap -q -A --quitonbreak rolis-cube/compute.g        < /dev/null
    gap -q -A --quitonbreak 12-over-1-5-3-5/compute.g   < /dev/null
    gap -q -A --quitonbreak verify.g                    < /dev/null

Interactively (`gap -A`, then inside GAP):

    Read("common/chirality-group.g");
    Read("rolis-cube/compute.g");           # defines ROLI.res, prints the report
    Read("12-over-1-5-3-5/compute.g");      # defines TW.res
    ROLI.res.X;  TW.res.X;                  # the chirality groups as permutation groups
    StructureDescription(TW.res.X);         # "SL(2,5)"
    CG_PRINT_REPORT := false;  Read("verify.g");   # 142 assertions

The core GAP calls, in order, are: `FreeGroup`/`/` (Coxeter group as an fp
group, verbatim from the legacy scripts), `IsomorphismPermGroup`,
`Subgroup`, `Order`, `Intersection`, `Index`, `GroupHomomorphismByImages`
(mirror test), `IsomorphismFpGroupByGenerators`, `RelatorsOfFpGroup`,
`MappedWord` (mirror substitution and evaluation), `Size` of the fp group
(coset enumeration certificate), `NormalClosure` (Method 1),
`DirectProduct`/`Embedding`/`Projection`/`Intersection`/`Kernel` (Method 2),
`NormalSubgroups`/`NaturalHomomorphismByNormalSubgroup` (Method 3),
`IsNormal`, `StructureDescription`, `IdGroup`, `IsomorphismGroups`,
`Centre`, `Centralizer`, `IsPerfectGroup`, `IsSimpleGroup`,
`EpimorphismFromFreeGroup`/`PreImagesRepresentative` (words).
Note that `gap` may be shadowed by a shell alias (on the development machine
`gap` was aliased to `git apply`); `run.sh` ignores aliases.

## 8. What is deduced and what is computer-verified

| statement | status |
|---|---|
| definition of `X(P)`, `X(P) = ⟨⟨R^{r₀}⟩⟩_Γ`, `X(P) ⊴ Γ⁺(P)`, `Γ⁺(P)/X(P) = W⁺/M^W` | cited [BJS §4] |
| mirror substitution = conjugation by `ρ₀` in the `σᵢ = ρ_{i-1}ρᵢ` convention | deduction (§2), agrees with [SW], [BJS], [Cun], thesis |
| the repository triples are in the `σ`-convention | verified (`ord(S₁S₂S₃)=2`, `ord(S₃S₂S₁)≠2`; orientation checks `Fᵢ·Sᵢ = F'ᵢ` for `i = 1,2,3` on the geometric base flag; `(−S₁,S₂,S₃)` excluded) + deduction (GAP's product order vs. function composition) |
| `Γ ◊ Γ̄ ≅ W⁺/M_W`; first coordinates of `ker π₂` equal `X(P) ⊴ Γ⁺(P)` | deduction (§4, Method 2) from [BJS], [Cun] |
| `X(P)` = smallest `N ⊴ Γ` with mirror-invariant `Γ/N` | deduction (§4, Method 3) |
| `(Γ; S₁,S₂,S₃)` is `Γ⁺` of the abstract polytope of the skeletal polytope | verified (relations, intersection property, coset = geometric f-vectors, geometric face stabilisers = abstract face groups, `Eᵢ ↦ Rᵢ` isomorphism) + cited (SW Thm. 1; thesis faithfulness) |
| Roli's cube and `{12/(1,5),3,5}` are geometrically chiral | cited [BHP Thm. 2; thesis §5] |
| all orders, equalities of subgroups, quotient/mix data, isomorphism types, normal generators, defect elements, normal-subgroup lattices | verified (142 assertions in `verify.g`) |
| the specific relator lists and the orders of the mirrored relators' values | transcript only (depend on GAP's choice of presentation) |
| `P/X(P)` for Roli's cube is BHP's `Q ≅ {4,3,3}/2` | deduction from `X = {±I}` + cited [BHP Thm. 1]; consistent with verified data (4,3,3), (8,16,12,4) and the verified embedding of `Γ/X` onto the rotation subgroup of `[4,3,3]/{±I}` |
| `X(P)` for `{12/(1,5),3,5}` is the group of left (or right) icosian multiplications | verified (Clifford translations, normal subgroup structure) + deduction (structure of `[3,3,5]⁺`) |

Hypotheses that were tested and **refuted** by the computation (and are not
claimed): "`N ⊇ X(P)` implies `Γ/N` mirror-invariant" (false for Roli's cube);
"the generator images in `Γ/X(P)` for `{12/(1,5),3,5}` have orders (3,3,5)"
(they have orders (2,3,5)).

## 9. Files

    README.md                         this document
    references.md                     bibliography with section/page pointers
    run.sh                            runs everything, writes results/
    verify.g                          142 assertions; non-zero exit on failure
    common/chirality-group.g          the three methods, the geometric flag/orientation checks, helpers
    rolis-cube/compute.g              Roli's cube (definitions from cube.g, combinatorially-chiral-cube.g)
    12-over-1-5-3-5/compute.g         {12/(1,5),3,5} (definitions from abstract.g, geometric.g)
    legacy/                           unmodified copies of the thesis scripts + PROVENANCE.md, SHA256SUMS
    results/environment.txt           GAP version, architecture, loaded packages
    results/*.transcript.txt          deterministic transcripts of the three runs
