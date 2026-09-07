# PETCOX facets of chiral 4-polytopes in E^4

Research question.  Besides Roli's cube (Bracho, Hubard, Pellicer 2014) and
the two realisations of the thesis / manuscript *Two new chiral 4-polytopes of
full rank*, can further chiral skeletal 4-polytopes in `E^4` (equivalently in
`S^3`) be built with one of the chiral polyhedra `H_alpha(T)` of Bracho,
Hubard and Pellicer, *Chiral polyhedra in 3-dimensional geometries and from a
Petrie-Coxeter construction* (DCG 66, 2021; "PETCOX") as facets?

Short answer (details in `RESULT.md`): **yes, and the answer is now complete.**
Up to congruence and enantiomorphism there are exactly **24** faithful,
geometrically chiral skeletal 4-polytopes in `E^4` whose cells are PETCOX
polyhedra, realising exactly **6** abstract 4-polytopes:

| class | type | f-vector | `|Gamma|` | cells | realisations |
|---|---|---|---|---|---|
| 1 | {8,3,3} | (16,32,12,4) | 192 | `H_alpha({4,3,3})` | 4, one of them Roli's cube |
| 2 | {30,3,3} | (600,1200,120,5) | 7200 | `H_alpha({5,3,3})`, `H_alpha({5/2,3,3})` | 4 |
| 3 | {12,3,5} | (120,720,300,50) | 7200 | `H_alpha({5,3,5/2})` | 4, two of them the thesis polytopes |
| 4 | {12,3,3} | (240,480,120,20) | 2880 | `H_alpha({5,3,5/2})` | 4; directly regular, geometrically chiral |
| 5 | {12,3,4} | (48,144,48,8) | 1152 | `H_alpha({5,3,5/2})` | 4 |
| 6 | {12,3,5} | (120,720,300,50) | 7200 | `H_alpha({5,3,5/2})` | 4; not isomorphic to class 3 |

Three of the 24 are known (Roli's cube and the two thesis realisations).  For
class 2, which is the case PETCOX p. 25 points at, unpublished work of Hubard
and Trejo is announced with exactly these invariants and a public GitHub GAP
appendix computes them, so it is not claimed as new; the remaining
realisations are apparently unpublished.  The classification is complete: the
third generator is uniquely determined by the base vertex, the vertex-figure
must be a Platonic solid, and the resulting finitely many equations are solved
exactly over `Q(sqrt 5)`.

## Contents

| file | content |
|---|---|
| `RESULT.md` | the mathematical answer, with the classification of every case |
| `theory.md` | derivation of the extension conditions, the allowed `alpha`, the chirality argument |
| `census.md` | the ten PETCOX families, duals, audit of the printed data |
| `source-notes.md` | exact statements and citations from the primary sources, SHA-256 hashes |
| `references.md` | literature audit (through September 2026) |
| `candidate-table.tsv` | one row per tested case with its classification |
| `gap/` | GAP code (exact arithmetic; core GAP only) |
| `logs/` | complete machine-generated transcripts of every run |
| `verify.sh` | reruns every decisive computation and exits non-zero on failure |

## GAP code

| script | purpose |
|---|---|
| `gap/lib.g` | library: reflections, polytope records, exact `alpha`, twist types, intersection condition, Schulte-Weiss mirror test with obstruction, Wythoff structures, stabiliser/diamond/orientation checks, the spanning-face chirality test, comparison of triples |
| `gap/polytopes.g` | the 16 regular 4-polytopes ({3,3,3} in 5 coordinates; {4,3,3}; {3,4,3}; the twelve of the [3,3,5] family derived by an exhaustive search over string quadruples of the 60 mirrors of [3,3,5]) with base vertex `v0` and cell centroid `v3` |
| `gap/canonical.g` | Level 1: canonical extension `S3 = R3R2` for all 16 polytopes; full verification of the survivors; writes `logs/canonical-rows.tsv` |
| `gap/alpha-locus.g` | which `alpha` can be a base vertex: fixed loci, pointwise stabiliser of the PETCOX circle, endpoint nondegeneracy |
| `gap/census-audit.g` | audit of the tetrahedra, matrices, regular base vertices and table columns printed in petcox.pdf |
| `gap/controls.g` | control cases: Roli's cube, the two thesis polytopes (legacy generator words), the p. 25 statement |
| `gap/parent-search.g` | Level 2: exhaustive search for third generators in `W(T)`, in `[3,3,5]`, `[3,4,3]`, `[[3,4,3]]`, and in `N_{O(4)}(G)`; writes `logs/parent-rows.tsv` and `logs/parent-survivors.g` |
| `gap/alpha-complete.g` | **Level 3**: the complete determination over all isometries of `E^4`, by the uniqueness of the third generator, the Platonic vertex-figure bound and the exact solution of the trace equations; writes `logs/alpha-complete-rows.tsv` and `logs/alpha-survivors.g` |
| `gap/roli-alpha-infinity.g` | the geometry of the second realisation of Roli's cube (`alpha = oo`): its edges are the main diagonals of the cubic facets of the 4-cube, and it is congruent neither to Roli's cube nor to its mirror image |
| `gap/compare.g` | deduplication of all candidates up to isomorphism, enantiomorphism, duality and congruence |
| `gap/summary.g` | the final table of all realisations, an orientation-independent word invariant separating the six classes, and the chirality group of a representative of each (uses the repository's `computations/chirality-groups/common/chirality-group.g`, read-only) |
| `gap/conder-check.g` | Petrie lengths of the ten cells, by two independent methods, and exact identification of two of the abstract polytopes with entries of Conder's chiral census |
| `gap/chirality-group.g` | chirality groups of the canonical extensions |

Every script prints `PASS`/`FAIL` lines and a final `Done:` sentinel; a failed
check exits GAP with status 1.

## Reproduction

Requirements: GAP 4 (tested with GAP 4.14.0 bundled with SageMath 10.7,
`/private/var/tmp/sage-10.7-current/local/bin/gap`), started with `-A`; no
packages beyond those GAP always loads.  Note that in the development shell
`gap` is an alias for `git apply`; `verify.sh` never uses aliases.

    cd research/petcox-facet-extensions
    ./verify.sh                       # or:  GAP=/path/to/gap ./verify.sh

This rewrites `logs/*.log`, `logs/canonical-rows.tsv`, `logs/parent-rows.tsv`,
`logs/parent-survivors.g`, `logs/environment.txt` and exits 0 only if all
checks pass.  Runtime about 35-50 minutes (`parent-search.g`, `alpha-complete.g` and
`compare.g` dominate).  Individual scripts (from `gap/`):

    gap -q -A --quitonbreak canonical.g < /dev/null

The transcripts shipped in `logs/` were produced on 2026-09-07 by the same
commands; `candidate-table.tsv` is assembled from
`logs/canonical-rows.tsv`, `logs/parent-rows.tsv` and `logs/compare.log`.

## Scope and limits

* Exact arithmetic throughout (cyclotomic numbers); no floating point is
  used in any decision.
* "Extension" means a Wythoff realisation of a Schulte-Weiss polytope
  `P(<S1,S2,X>)` with the PETCOX generators `S1 = R0R1R3R2`, `S2 = R2R1` kept
  fixed (theory.md, Section A, explains why this loses nothing up to
  congruence and enantiomorphism).
* Level 2 is exhaustive inside the finite parent groups listed above.  Level 3
  (theory.md Section E, `gap/alpha-complete.g`) is exhaustive over **all** of
  `O(4)` and is what makes the classification complete; the Level 2 searches
  are kept as an independent check.
* What is not decided: the abstract existence of chiral 4-polytopes with the
  other PETCOX cells (RESULT.md, "Unresolved limits").
* No existing project file was modified; nothing was committed.
