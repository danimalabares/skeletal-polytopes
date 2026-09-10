# Reproducibility record — fresh-session Fable 5.1 audit of `research/petcox-facet-extensions`

## Identity of the audited object

| item | value |
|---|---|
| repository | `~/github/skeletal-polytopes`, branch `main`, working tree used directly (no branch created, nothing committed or pushed) |
| audited commit | `71ef1cda7ca927b090068c796bfdcc10ca097a2c` ("Add preliminary PETCOX facet-extension classification") |
| `git status` at start | only the untracked `zoom-5-sept.md` (not read, not modified, not added, not deleted during the audit) |
| frozen producer output | `research/petcox-facet-extensions/` (46 files in the working tree: 35 tracked + 11 git-ignored `logs/*.log` transcripts) |
| producer-directory hashes before the audit | `logs/producer-sha256-before-audit.txt` (46 lines); recomputed at the end of the audit and identical (see AUDIT.md, "Integrity") |
| `AGENTS.md` | none exists anywhere in the repository or its parent directories (`find` from repo root; `~/AGENTS.md`, `~/github/AGENTS.md` absent) |
| auditor | Claude Fable 5.1 (`claude-fable-5-1`), fresh session 2026-09-09, effort xhigh; the producer output was itself produced by Fable and completed by Opus, so this is a **fresh-session Fable audit, not an independent-model audit** |
| skill | `cross-model-mathematical-audit` v1.0.0 read completely (SHA256SUMS verified), protocol taken from its sibling `mathematical-paper-audit` v1.0.0 (claim ledger, evidence classification, reproducibility, source verification); neither skill modified |

## Environment

* macOS 12.7.6 (Darwin 21.6.0), x86_64.
* GAP 4.14.0 (`x86_64-apple-darwin24-default64-kv9`) from the SageMath 10.7 bundle,
  `/private/var/tmp/sage-10.7-current/local/bin/gap`, started with `-q -A --quitonbreak`;
  packages loaded with `-A`: gapdoc 1.6.7, primgrp 3.4.4, smallgrp 1.5.4, transgrp 3.6.5
  (`GaloisType` and `IdGroup` used by the audit scripts need transgrp and smallgrp).
* Python 3.11.4 (only for the producer's `make-candidate-table.py` and for text munging).
* No software was installed.  `pdftoppm` is absent, so the host PDF reader could not render
  pages; PETCOX pages were extracted and rendered with macOS PDFKit through
  `osascript -l JavaScript` (`PDFDocument`, `PDFPage.string`,
  `NSImage.initWithData(page.dataRepresentation)`), see scratchpad scripts `extract.js`,
  `render.js` (kept out of the repository; the rendered PNGs of pp. 19-29 were viewed and
  are not redistributed).
* Network: no paid API.  `curl` and the WebFetch tool were used only in the source phase
  (below) against public URLs.

## Phases (discovery frozen before any external source was consulted)

1. **Freeze and read (15:05-15:45 UTC).**  HEAD, status, tree; skills; all producer
   documents (`README.md`, `RESULT.md`, `theory.md`, `census.md`, `source-notes.md`,
   `references.md`, `candidate-table.tsv`, `make-candidate-table.py`, `verify.sh`), all
   13 GAP scripts under `gap/`, all 11 transcripts and 7 data files under `logs/`,
   `two-chiral.tex`, `computations/chirality-groups/{README,TECHNICAL_NOTES}.md`,
   `common/chirality-group.g`, `legacy/PROVENANCE.md`, `legacy/cube.g`.
2. **Disposable copy and full rerun (15:09-15:27 UTC).**  `git archive 71ef1cd | tar -x`
   into the session scratchpad (`.../scratchpad/frozen/`), then `./verify.sh` there.
   Result: exit 0, 1087 PASS / 0 FAIL / 3 syntax warnings, 17 min 20 s.  Every regenerated
   transcript and data file is byte-identical to the shipped one except the timestamp in
   `logs/environment.txt` (diff listed in `logs/verify-rerun/`).  Note the shipped
   `logs/*.log` are **not in the commit** (`.gitignore` line 17, `*.log`); the disposable
   copy therefore started without them and regenerated all eleven.
3. **Mathematical discovery (15:30-16:20 UTC), web off.**  Reading of the completeness
   argument (theory.md A-G) and of every branch of `alpha-complete.g`; identification of
   the (5,5) vertex-figure gap and of the congruence-dedup gap; independent GAP scripts
   written and run (below).
4. **Source phase (16:00-16:12 UTC), web on.**  Primary sources fetched and hashed:
   Conder's two census files, arXiv:2604.00185v1, the PAPIIT IN109023 report, the Trejo
   GitHub appendix (via the GitHub API after two HTTP 503 from raw.githubusercontent.com),
   Hartley's atlas pages, Crossref record; details and verbatim excerpts in
   `logs/sources/SOURCES.md`.  Third-party files are kept in the scratchpad only.

## Audit scripts (all under `scripts/`, run from that directory with the GAP command above, stdin `/dev/null`)

| script | SHA-256 | purpose | log | result |
|---|---|---|---|---|
| `l3-audit.g` | `191a092a…7ec6f7` (see `sha` below) | independent re-derivation of the whole Level-3 analysis: invariant planes, half-turn `A(t)`, `X(t)`, trace polynomials for **every** target order `m ∈ {2,3,4,5,6,10}` (no a-priori exclusions), factorisation over `Q(ζ5)`, exact roots, own Sturm counts, own Kronecker–Weber test, finiteness of `<S2,X>` and of `Γ` by orbit growth, intersection condition, coset and geometric f-vectors, stabilisers, diamond, spans, mirror test | `logs/audit-runs/l3-audit.log`, `l3-audit-rows.tsv` (105 rows) | 421 pass / 11 "fail" (all 11 are irreducible quartic factors with real roots that the script could not solve by radicals; all are settled by `five-five-audit.g`); **24 survivors, identical to the producer's 24; 0 survivors with a (5,5) vertex-figure** |
| `five-five-audit.g` | `3128e673…78cd` | for each of the 11 unresolved quartic factors: minimal polynomial over `Q` of `tr(S1 X)` in the degree-8 field `Q(√5)(t)` and its Galois group (`GaloisType`); A5 class-structure constants for pairs of order-5 elements with involutory product | `logs/audit-runs/five-five-audit.log` | 13 pass / 0 fail: every unresolved factor has a non-abelian trace field (`C2×D8` or `C2^4:C2`), so `Γ` is infinite there; in A5 no two order-5 elements of the same class have involutory product |
| `congruence-audit.g` | `f3f87102…548d` | independent recomputation of every invariant of the 24 realisations from the producer's stored matrices; abstract isomorphism classes (generator-preserving, both orientations); **congruence up to enantiomorphism decided by an actual similarity search** (four-point basis matching) whenever the scale-free invariants (Gram multiset, edge inner product, 2-face profile, vertex-figure profile) coincide; chirality groups by the mix | `logs/audit-runs/congruence-audit.log` (run 2; run 1 killed and preserved) | 130 pass / 7 "fail": all 24 realisations pass every existence/faithfulness/chirality check; 6 abstract classes of 4; classes 3 ≠ 6; chirality groups as claimed; **but each class has only 2 congruence classes up to enantiomorphism: 12 in total, not 24** (the 7 "fails" are exactly the producer's counts 4 and 24) |
| `congruence-quick.g` | (see hash list) | second, lighter implementation of the same decision with O(n) invariants (edge inner product, 2-face profile, vertex-figure profile, distance distribution from the base vertex) and the same similarity search; self-checks (vertex stabiliser recovered; Roli's cube vs its mirror image recovered with det −1) | `logs/audit-runs/congruence-quick.log` | same result: 12 congruence classes, 2 per abstract class |
| `congruence-certify.g` | (see hash list) | one explicit certificate matrix `g` per congruent pair, verified on vertices, edges, 2-faces, cells and on the groups (`g^{-1}Γ_a g = Γ_b`), with `g g^T = λI`, `det g` sign (handedness) and the test whether `g` is a scalar multiple of the `ρ1`-type half-turn normalising the cell group | `logs/audit-runs/congruence-certify.log` | 12 pass / 0 fail: one verified certificate per pair, all twelve proper similarities (same handedness); none is a scalar multiple of the `ρ1` half-turn; **total 12 realisations up to congruence and enantiomorphism** |
| `xp-audit.g` | (see hash list) | chirality groups of one representative per class by the mix only | `logs/audit-runs/xp-audit.log` | 6/6 as claimed: `C2, SL(2,5), SL(2,5), 1, Q8, SL(2,5)` |
| `printed-data-audit.g` | `f13062c9…529a` | PETCOX misprints D1, D2, H1 from an independent transcription of the rendered pages; coset enumeration of the transcribed R97.9/R97.10 presentations, their Petrie lengths, relator test of the {30,3} cell | `logs/audit-runs/printed-data-audit.log` | 21 pass / 0 fail |
| `atlas-id-audit.g` | `8e906011…b449` | `IdGroup` of the full groups of the {8,3}, {12,3}, {12,4} cells and the two atlas invariants, against Hartley's atlas | `logs/audit-runs/atlas-id-audit.log` | 3/3 match: SmallGroup(96,193), (288,847), (384,18044) |
| `misc-audit.g` | `3ecec08d…73dc` | A5 = <(12345),(12354)> certificate; triangle-group orders; (4,4) excluded in S4; element orders of `[3,3,5]^+` and `±[O×O]`; `S1` fixed-point-free | `logs/audit-runs/misc-audit.log` | all as stated in theory.md except the (5,5) inference (AUDIT.md F1) |

Aborted first attempts are preserved as `*.run1-aborted.log`, `*.run2-aborted.log`,
`congruence-audit.run1-killed.log` (killed by the auditor after a slow matrix-group
enumeration; the check was rewritten to use the permutation image), and the aborted
first runs of `congruence-quick.g`, `congruence-certify.g`, `xp-audit.g` (GAP quirks:
`Conductor(infinity)`, float-vs-integer comparison, the reserved global `X`).  Full SHA-256 list of
scripts and logs: see the end of this file.

The audit scripts read, and do not modify, the producer's `gap/lib.g`, `gap/polytopes.g`
(only for the 16 reflection groups, which the producer's `census-audit.g` and this audit's
`printed-data-audit.g` check against the printed tetrahedra) and
`logs/alpha-survivors.g` (the 24 stored matrices).  Everything decisive is re-implemented.

## Computation classes (per `mathematical-paper-audit/references/reproducibility.md`)

* Producer pipeline and all audit GAP scripts: **exact** (cyclotomic arithmetic, permutation
  groups, coset enumeration, Sturm sequences with exact signs, Galois groups from the
  transitive-groups library).  Floating-point numbers appear only as display values.
* No numerical or heuristic evidence enters any conclusion of this audit.

## Limitations

* Reading of the PDF text layer of PETCOX flattens matrices; every matrix used here was
  read from the rendered page image (pp. 24, 25, 26, 28) and re-typed by the auditor.
* `Size` of the infinite triangle groups was (correctly) not attempted after a first
  attempt hung; the (5,5) certificate is the explicit epimorphism onto A5 instead.
* The Conder chiral-polytope census file was inspected by `grep` on the downloaded file,
  not read in full.
* Cambridge Core monographs (Pellicer 2025, McMullen 2020) were not attempted; the
  producer marks them UNVERIFIABLE and this audit leaves that state unchanged.
* Kranjska Gora 2023 abstract (Internet Archive) not re-fetched: `metadata-only` here,
  corroborated indirectly by the PAPIIT report, which lists the talk title.

## Final integrity check

See AUDIT.md "Integrity": producer hashes before/after identical; `git status` shows only
`zoom-5-sept.md` (pre-existing) and the new `audits/fable-ultra/` directory; nothing
committed or pushed.
