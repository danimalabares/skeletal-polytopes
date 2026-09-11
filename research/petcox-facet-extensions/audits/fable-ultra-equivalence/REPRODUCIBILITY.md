# Reproducibility

## Inputs

* Repository `~/github/skeletal-polytopes`, HEAD `ca649f260df19db0e3caad9e1b48932f872d361c`
  (branch `main`); `logs/00-initial-state.txt` records `git status` at the start.
* The only mathematical input is `research/petcox-facet-extensions/logs/alpha-survivors.g`
  **as of the producer commit `71ef1cda7ca927b090068c796bfdcc10ca097a2c`**, obtained with
  `git archive` (never from the working tree).  Its SHA-256 is written to
  `logs/producer-data.sha256` by `scripts/run-all.sh`.
* Primary sources consulted (read-only): `~/dr/skeletal-polytopes/petcox.pdf`
  (SHA-256 `462428270b44ef53deceec14835fafa9379824bb145b0cb2326d68c6a24347d5`),
  `~/dr/skeletal-polytopes/chiral-4-polytope.pdf`
  (`437e4ae4249fbe6e7d851b0b5111589201ba0c0a6b3f78f3c1897469cf58a5ea`), the manuscript
  `two-chiral.tex` of the producer commit, and the producer's documentation.

## Software

* GAP 4.14.0 bundled with SageMath 10.7: `/private/var/tmp/sage-10.7-current/local/bin/gap`,
  always started as `gap -q -A --quitonbreak script.g < /dev/null` (core GAP only).  In the
  development shell `gap` is an alias for `git apply`; the scripts use the full path.
* SageMath 10.7 (`/usr/local/bin/sage`) for Method 2 (`CyclotomicField(40)`, FLINT arithmetic).
* Python 3.11 (`/Library/Frameworks/Python.framework/Versions/3.11/bin/python3`) for
  Method 4 (pure `fractions.Fraction` arithmetic in `Q(zeta_40)`, no third-party packages)
  and for the table builder; `PyPDF2` only for extracting text from the PDFs.
* `logs/environment.txt` records the versions actually used in the final clean run.

## One-command clean run

    cd ~/github/skeletal-polytopes
    research/petcox-facet-extensions/audits/fable-ultra-equivalence/scripts/run-all.sh

`run-all.sh` extracts the producer commit into `build/producer/`, exports
`PETCOX_DATA=build/producer/research/petcox-facet-extensions/logs/alpha-survivors.g`, runs

| step | script | arithmetic | transcript |
|---|---|---|---|
| author's check | `scripts/author-check-antiautomorphism.g` | GAP cyclotomics | `logs/author-check-antiautomorphism.log` |
| Method 1 | `scripts/method1-flag-search.g` | GAP cyclotomics | `logs/method1-flag-search.log`, `logs/method1-pairs.tsv`, `logs/method1-certificates.json`, `logs/method1-realisations.json` |
| Method 2 | `scripts/method2-canonical.sage`, then `scripts/method2-verify-certificates.g` (GAP re-check of Method 2's matrices) | Sage `CyclotomicField(40)`; GAP | `logs/method2-canonical.log`, `logs/method2-classes.tsv`, `logs/method2-pairs.tsv`, `logs/method2-certificates.json`, `logs/method2-certificates.g`, `logs/method2-verify-certificates.log` |
| Method 3 | `scripts/method3-anti-automorphism.g` | GAP cyclotomics | `logs/method3-anti-automorphism.log`, `logs/method3-pairing.tsv` |
| Method 4 | `scripts/method4-verify-certificates.py` | Python `Fraction` in `Q(zeta_40)` | `logs/method4-verify-certificates.log`, `logs/method4-results.tsv`, `logs/method4-invariants.tsv` |
| previous audit | `scripts/extract-previous-audit-certificates.py` (transcribes the 12 matrices from `audits/fable-ultra/logs/audit-runs/congruence-certify.log`), then `scripts/previous-audit-check.g` | Python; GAP cyclotomics | `logs/previous-audit-certificates.g`, `logs/extract-previous-audit-certificates.log`, `logs/previous-audit-check.log` |
| table | `scripts/make-table.py` | - | `EQUIVALENCE-TABLE.tsv`, `logs/make-table.log` |
| certificates | `scripts/make-certificates.py` | - | `CERTIFICATES.md`, `logs/make-certificates.log` |
| sources | `scripts/extract-sources.py` (text extraction and quotation self-check for `logs/sources-quotes.md`; run once by the source reader, transcript `logs/extract-sources.log`) | Python `PyPDF2` | `logs/sources-quotes.md` |

Methods 1-4 and the source quotations were produced by four independent implementers working only
from the preregistered specification; the audit author's later edits to their scripts are limited to
the data-path lines (environment variable `PETCOX_DATA`, relative output paths) and, in Method 3, the
rename of a variable that collided with a GAP built-in; each such edit is marked in the script.

then prints `git status`, refuses to succeed if anything outside this audit directory (or the
pre-existing untracked `zoom-5-sept.md`) changed, and writes `MANIFEST.sha256` with
`scripts/make-manifest.sh`.  Each GAP/Sage/Python transcript must end with its `Done:` sentinel;
any `FAIL`, `Error` or non-zero exit makes `run-all.sh` exit non-zero.

Every script also runs stand-alone from `scripts/` with `PETCOX_DATA` set (or unset, in which case
it falls back to the path of the session's scratch extraction; that fallback exists only for the
development session and is not needed by `run-all.sh`).

## What was and was not modified

No pre-existing file of the repository was modified, and nothing was committed or pushed.  All
new files live under `research/petcox-facet-extensions/audits/fable-ultra-equivalence/`.  The
final `git status` is in `logs/final-git-status.txt`.  The `build/` directory is a disposable
extraction of the producer commit and is excluded from the manifest.

## Independence protocol as executed

1. `AGENTS.md`: none exists in the tree (checked with `find`).
2. HEAD and `git status` recorded (`logs/00-initial-state.txt`).
3. Producer commit extracted to a scratch directory; all reading in phase 1 was from that copy.
4. `PREREGISTRATION.md` written (definitions, algorithms, expected certificates) before any pairwise
   comparison was run; its hash is in the manifest.
5. Methods 1-4 were implemented by four independent workers from the preregistered specification
   only (they were forbidden to open `audits/fable-ultra/` or the preregistration itself); the
   author's own check was written and run separately.  Only after all of them had reported was
   `audits/fable-ultra/` opened for the comparison in `AUDIT.md`.
