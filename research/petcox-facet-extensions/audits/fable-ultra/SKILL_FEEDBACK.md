# Skill feedback: `cross-model-mathematical-audit` (v1.0.0) used in single-auditor agentic mode

Audit: fresh-session Fable 5.1 audit of `research/petcox-facet-extensions` at commit
`71ef1cda7ca927b090068c796bfdcc10ca097a2c` (2026-09-09).  The installed skill was
read completely (SKILL.md, all nine `references/*.md`, `agents/openai.yaml`, the six
scripts) and was NOT modified.  Installed copy: symlink
`~/.claude/skills/cross-model-mathematical-audit ->
~/github/vinicio-paper-audit-experiment/toolkit/cross-model-mathematical-audit`,
SHA256SUMS of the package verified before use.

## 1. Usability for this task

* **The skill is an orchestration wrapper, not an audit protocol.**  Its own
  description says "do not use for a single audit", and every reference file
  (workflow, conditions-and-isolation, costs-and-approval, manual-mode, operations,
  provenance, comparison) concerns the four-cell OpenAI/Claude matrix, approval
  tokens, blinded judges and cost gating.  None of that is applicable to a
  single-auditor run, and `scripts/cross_model_audit.py` cannot be run without a
  configuration naming two vendors and paid model IDs.  The instruction to "use its
  freezing, claim-ledger, evidence-preservation, and hostile-review protocol in
  single-auditor agentic mode" could only be satisfied by following the *sibling*
  package `mathematical-paper-audit` (v1.0.0), which the cross-model skill names as
  "the canonical mathematical protocol" and whose `references/claim-ledger.md`,
  `evidence-classification.md`, `reproducibility.md`, `source-verification.md` and
  `full-paper-audit.md` were used here.  **Recommendation:** either (a) make the
  cross-model SKILL.md say explicitly "for a single audit, invoke
  `mathematical-paper-audit` directly", or (b) add a `single-auditor` mode to the
  cross-model skill that reuses its freezing/provenance machinery
  (`sha256_manifest.py`, workspace layout) without the vendor matrix.

* **Freezing tooling assumes a supplied file, not a Git tree.**  `prepare` copies one
  source file and hashes it.  The object under audit here is a directory inside a
  repository at a commit, with generated transcripts that are *not* committed
  (`*.log` is git-ignored).  The skill has no notion of "frozen commit + working-tree
  extras", so the essential provenance finding of this audit (the shipped GAP
  transcripts are absent from the audited commit) had to be discovered by hand with
  `git ls-files`/`git check-ignore`.  **Recommendation:** add to
  `references/provenance.md` a checklist for repository-shaped inputs: record the
  commit SHA, `git status --ignored` for the audited path, and hash every file the
  producer's own manifest names, resolving `~` (the producer's `logs/SHA256SUMS`
  uses `~`-prefixed paths, which `shasum -c` cannot expand).

* **No guidance for computational claims whose scripts are the proof.**  The
  producer's result is "226 assertions, 0 failures".  `reproducibility.md` correctly
  says a finite scan proves an infinite claim only with a separate reduction, but the
  skill offers no procedure for auditing the *reduction* (here: which cases the
  scripts were told to skip).  The decisive finding of this audit (the a-priori
  exclusion of the (5,5) vertex-figure case, see AUDIT.md F1) came from reading the
  case split in `alpha-complete.g`, not from running it.  **Recommendation:** add an
  audit lane "enumerate every branch the code skips or excludes a priori and prove
  each exclusion independently".

## 2. Things that worked

* `evidence-classification.md` vocabulary (diagnostic class, proof state vs theorem
  state, evidence kind) transferred directly to `CLAIM_LEDGER.md`.
* `source-verification.md` inspection states (`inspected-primary`, `metadata-only`,
  `unavailable`, ...) were exactly right for the novelty claims.
* The insistence on rendered pages rather than text extraction was decisive for the
  PETCOX misprint claims (D1, D2): the text layer flattens matrices; the rendered
  page shows them.

## 3. Practical gaps encountered

* **PDF rendering dependency.**  The host's `Read` tool needs `pdftoppm`, which was
  absent and could not be installed under the audit constraints.  Neither skill
  mentions a fallback.  macOS PDFKit via `osascript -l JavaScript` (`PDFDocument`,
  `PDFPage.string`, `NSImage.initWithData(page.dataRepresentation)`) extracted text
  and rendered pages with no installation; documenting this fallback in
  `reproducibility.md` would save time.
* **Network policy is under-specified for a single-auditor run.**  The skills say
  "web off during discovery, on in a separate source phase" but do not say how to
  record that separation in the deliverables.  This audit records it in
  REPRODUCIBILITY.md section "Phases".
* **`report-schemas.md` has no schema for the four files this task required**
  (AUDIT.md, CLAIM_LEDGER.md, REPRODUCIBILITY.md, SKILL_FEEDBACK.md) nor for the
  four-valued principal verdict (`VERIFIED / VERIFIED WITH QUALIFICATIONS /
  NOT ESTABLISHED / REFUTED`) or the fatal/major/minor/presentational severity scale
  requested by the user.  Both were mapped by hand onto the skill's
  claim-state and diagnostic-class vocabularies (mapping stated in CLAIM_LEDGER.md).

## 4. Minor

* `SKILL.md` of the cross-model skill uses the phrase "Never draft author-facing
  accusations"; `report-schemas.md` of the sibling asks for neutral wording.  Both
  were followed: this audit uses "candidate proof gap", "not established", etc.
* `validate_release.py`/`SHA256SUMS` made it easy to confirm the installed skill was
  intact; that is good practice and should be kept.
