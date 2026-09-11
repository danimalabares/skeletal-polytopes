# Focused equivalence audit of the 24 stored PETCOX facet-extension realisations

**Verdict: `VERIFIED WITH CORRECTED TERMINOLOGY`**

| question | answer |
|---|---|
| classes up to **literal Euclidean congruence** of the unnormalised stored coordinate sets | **24** |
| classes up to **similarity** (`x -> cQx + b`, any `c > 0`) | **12** |
| classes up to **congruence after the PETCOX unit-sphere normalisation** (`[x] = x/\|x\|`, every vertex on `S^3`) | **12** |
| handedness | the paired realisations have the **same handedness**: every one of the twelve identifications is a **proper** isometry (a half-turn), so **enantiomorphism causes no additional identification** (the count is 12 whether or not mirror images are identified) |

Full evidence, definitions, certificates and the classification of every earlier equivalence claim:
**[`AUDIT.md`](AUDIT.md)**.

## Why the three numbers differ

The producer stores each base vertex as `w = t v0 + v3` with **unnormalised** `v0, v3`, so the 24 stored
vertex sets lie on spheres of different radii.  Every map between two of them is therefore a similarity
with `lambda = |w_b|^2/|w_a|^2 != 1`, never an isometry: as stored there are 24 congruence classes.
PETCOX define `H_alpha(T)` on `S^3` with `[x] := (1/||x||) x`, and on unit-normalised data congruence and
similarity coincide, giving 12.  A map with `g g^T = lambda I`, `lambda != 1`, is a similarity, not an
isometry, and is not called a congruence anywhere in this audit.

## Scope

Only geometric equivalence of the 24 stored realisations and the resulting count.  The producer's global
completeness theorem (that these 24 base vertices are all of them) was **not** audited here.

## Contents

| file | content |
|---|---|
| [`AUDIT.md`](AUDIT.md) | the audit: direct answer, definitions of the seven relations, methods, results, mechanism, special checks, classification of the previous audit's claims, verdict |
| [`PREREGISTRATION.md`](PREREGISTRATION.md) | definitions, algorithms and expected certificates, frozen before any pairwise comparison was run |
| [`EQUIVALENCE-TABLE.tsv`](EQUIVALENCE-TABLE.tsv) | all 24 realisations with their class identifier under each of the seven relations, partner, exact `lambda`, determinant sign |
| [`CERTIFICATES.md`](CERTIFICATES.md) | the twelve similarity certificates (explicit `M`, `lambda`, `det`, all checks exact, three independent sources each) and the exhaustive non-equivalence certificates for the 40 remaining equal-f-vector pairs |
| [`REPRODUCIBILITY.md`](REPRODUCIBILITY.md) | inputs, software, and the one-command clean rerun |
| `scripts/` | five independent exact implementations, the previous-audit re-check, and the drivers |
| `logs/` | complete transcripts and machine-readable outputs |
| `MANIFEST.sha256` | SHA-256 of every file in this directory |

## Reproduce

    research/petcox-facet-extensions/audits/fable-ultra-equivalence/scripts/run-all.sh

It re-extracts the producer commit `71ef1cda7ca927b090068c796bfdcc10ca097a2c` with `git archive`, runs
every verifier (GAP, Sage, pure Python), rebuilds `EQUIVALENCE-TABLE.tsv` and `CERTIFICATES.md`, refuses
to succeed if any pre-existing repository file changed, and rewrites `MANIFEST.sha256`.
