# Literature audit

Access window: 2026-09-06 to 2026-09-07 (the session crossed midnight; items
retrieved before midnight are marked 2026-09-06).  Status tags: **CONFIRMED**
(retrieved from a primary or authoritative source on the stated date),
**CORRECTED** (the item as it entered the audit was wrong in the stated
respect), **REFUTED** (a claim was checked against the primary source and does
not hold), **UNVERIFIABLE** (could not be retrieved: paywall, HTTP block,
licence withholding, or out of a census's coverage).  Absence of retrieval is
never treated as evidence of absence.

The full raw audit, with every verbatim quotation, every URL, every negative
search and the per-modality JSON, is in `logs/literature/`
(`references-draft.md`, 2074 lines, plus `citing-petcox.json`,
`citing-bhp.json`, `full-rank-chiral.json`, `extensions-theory.json`).  This
file is the condensed version.  Quotations from PDFs were produced by local
text extraction, so Schlaefli symbols in them are reconstructions of flattened
strings; that is flagged where it matters.

## 1. Primary sources

| item | data | status |
|---|---|---|
| **[PETCOX]** J. Bracho, I. Hubard, D. Pellicer, *Chiral polyhedra in 3-dimensional geometries and from a Petrie-Coxeter construction* | Discrete Comput. Geom. **66** (2021), no. 3, 1025-1052; DOI 10.1007/s00454-021-00317-0; received 12 Sep 2019, revised 25 Jan 2021, accepted 9 Jun 2021, online 30 Aug 2021; zbMATH Zbl 1475.52019 (document 7402640, reviewer Rolf Schneider); no arXiv version (five arXiv API queries); author copy `https://www.matem.unam.mx/~roli/investigacion/articulos/PetrieCoxeterFinal2.pdf`, 32 pp., dated 19 January 2021 | CONFIRMED |
| the DOI used in our working notes, 10.1007/s00454-021-00306-x | unregistered; Crossref and Semantic Scholar return 404 | CORRECTED |
| **[BHP]** J. Bracho, I. Hubard, D. Pellicer, *A finite chiral 4-polytope in R^4* | Discrete Comput. Geom. **52** (2014) 799-805; DOI 10.1007/s00454-014-9631-4; arXiv:1311.1558 | CONFIRMED |
| **[SW]** E. Schulte, A. I. Weiss, *Chiral polytopes* | DIMACS Ser. Discrete Math. Theoret. Comput. Sci. **4** (1991) 493-516; DOI 10.1090/dimacs/004/39 | CONFIRMED |
| B. Monson, *On Roli's cube* | Art Discrete Appl. Math. **5** (2022) #P3.10; DOI 10.26493/2590-9770.1411.6ee; arXiv:2102.08796 | CONFIRMED |
| P. McMullen, *Geometric Regular Polytopes* | Cambridge University Press, 2020; DOI 10.1017/9781108778992 | CONFIRMED bibliographically, content UNVERIFIABLE |
| D. Pellicer, *Abstract Chiral Polytopes* | Cambridge University Press, 2025; DOI 10.1017/9781108695046; Chapter 6 "Skeletal Polytopes", Appendix C "Open Problems" | CONFIRMED bibliographically; chapter text UNVERIFIABLE (Cambridge Core returned HTTP 429 on every attempt) |
| **[Thesis]** J. Bracho, D. Gonzalez-Casanova, I. Hubard, *Two new chiral 4-polytopes of full rank* | unpublished manuscript; cited as "In preparation" in Hubard-Schulte, arXiv:2604.00185v1, reference [1] | CONFIRMED as unpublished |

The sentence under audit, [PETCOX] author copy p. 25, verbatim from the
extracted text: "The type of Halpha({5, 3, 3}) is { 30 1,11, 3}, and for
alpha = 0 no vertices identify, so that H0({5, 3, 3}) can be taken as facet of
a chiral 4-polytope, but not H1({5, 3, 3}) in which four vertices come
together."  And p. 23: "for alpha = 0 no vertices come together, so we still
have a chiral polyhedron H0({4, 3, 3}), which was taken as facet of a chiral
4-polytope in S3 (or R4) in [3]."  Status: CONFIRMED (2026-09-07).  The page
numbers of these sentences in the published version were not retrieved.

## 2. Works citing PETCOX

Exactly two locatable citing works, from the union of Semantic Scholar,
Google Scholar, zbMATH reverse citation (`rf:7402640`), Crossref cited-by,
OpenAlex and OpenCitations (the last four report zero):

1. I. Hubard, E. Schulte, *Two-Orbit Polytopes*, arXiv:2604.00185v1
   (31 March 2026), 37 pp.  Cites [PETCOX] once, in a survey list of skeletal
   chiral polytopes in higher-dimensional Euclidean spaces.  Says nothing
   about `H_alpha(T)` as facets.  Its bibliography is the only public trace of
   both unpublished items in Section 6 below.  CONFIRMED.
2. D. Pellicer, *A chiral 5-polytope of full rank*, Discrete Math. **344**
   (2021) 112370, DOI 10.1016/j.disc.2021.112370.  Cites [PETCOX] as
   "accepted for publication"; concerns an infinite chiral 5-polytope of full
   rank, not a 4-polytope.  The citing passage was not retrieved
   (ScienceDirect HTTP 403, no open-access copy).  CONFIRMED that it cites;
   UNVERIFIABLE what it says.

zbMATH lists Monson, *On Roli's cube*, as "cited in" [PETCOX]; full-text
reading of both versions of Monson shows it does not cite [PETCOX] at all
(the zbMATH review of Monson misattributes the 2014 abstract to the 2021
record).  Status: **REFUTED**.

## 3. Works citing Roli's cube

Eleven distinct citing works, from the union of Google Scholar (12 hits, 11
distinct), OpenAlex (10), Semantic Scholar (8) and zbMATH (7): [PETCOX] 2021;
Cunningham-Pellicer, *Open problems on k-orbit polytopes*, Discrete Math. 341
(2018) 1645-1661; Schulte-Weiss, *Skeletal geometric complexes and their
symmetries*, Math. Intelligencer 39 (2017) 5-16; Pellicer, *Chiral
4-polytopes in ordinary space*, Beitr. Algebra Geom. 58 (2017); Pellicer,
*A chiral 4-polytope in R^3*, Ars Math. Contemp. 12 (2017), DOI
10.26493/1855-3974.1055.0f4; Pellicer, *Chiral polytopes of full rank exist
only in ranks 4 and 5*, Beitr. Algebra Geom. (2021), DOI
10.1007/s13366-020-00545-0; Pellicer, *A chiral 5-polytope of full rank*
(2021); McMullen, *Quasi-regular polytopes of full rank*, Discrete Comput.
Geom. (2021), DOI 10.1007/s00454-021-00304-5; Pellicer, *The higher
dimensional hemicuboctahedron* (2016); Monson, *On Roli's cube* (2022);
Hubard-Schulte (2026).  **None constructs a finite chiral 4-polytope in `E^4`
other than Roli's cube**, and only [PETCOX] says anything about `H_alpha(T)`
as facets.  Monson, arXiv:2102.08796: full-rank chiral polytopes "do seem to
be elusive".  Status: CONFIRMED (2026-09-07).

## 4. Rank-4 extension theory

* **[SW] Section 6** (pp. 511-515): Proposition 12, the universal
  `{P1,P2}` is directly regular iff both `P1` and `P2` are; Theorem 2, if
  `P1, P2` are (oriented) chiral or directly regular and **not both directly
  regular**, and the class is nonempty, then the universal chiral
  `{P1,P2}^ch` exists; Theorem 3, if both are directly regular, the universal
  regular `{P1,P2}` covers every member of both classes, so the chiral class
  contains no universal member.  CONFIRMED.
* **G. Cunningham, D. Pellicer, *Chiral extensions of chiral polytopes***,
  Discrete Math. **330** (2014) 51-60: their Theorem 1 requires a **chiral**
  facet.  CONFIRMED.
* **A. Montero (2021) and related chiral-extension results**: same hypothesis,
  a chiral facet.  CONFIRMED for the hypothesis.
* **D. Pellicer, *A construction of higher rank chiral polytopes***, Discrete
  Math. **310** (2010) 1222-1237, and Montero-Toledo: the only tools located
  that build chiral polytopes with prescribed **regular** facets.  CONFIRMED
  bibliographically.
* **D. Pellicer, *Developments and open problems on chiral polytopes***
  (2012): Problems 27 and 28 ask exactly for chiral extensions of orientably
  regular facets; both open.  CONFIRMED.
* **Cunningham-Pellicer 2018**, Problem 20: classify the chiral polytopes of
  full rank.  CONFIRMED.

Consequence for this report: every published extension theorem retrieved
requires a chiral facet, whereas the PETCOX cells are combinatorially
regular, so none of them applies here.  This is the theoretical reason the
constructions in RESULT.md had to be found geometrically rather than
abstractly, and it is consistent with [SW] Theorem 3 (theory.md Section G).

## 5. Atlas and census lookups

All CONFIRMED on 2026-09-07 unless stated.

* **Hartley, Atlas of Small Regular Abstract Polytopes**
  (`https://www.abstract-polytopes.com/atlas/`).  Coverage, verbatim: "All
  regular polytopes with n flags, for n at most 2000 (except 1024 and 1536)."
  Entries confirmed verbatim: `{8,3}*96` = SmallGroup(96,193), (V,E,F) =
  (16,24,6), "Order of s0 s1 s2: 12"; `{12,3}*288` = SmallGroup(288,847),
  (48,72,12), Petrie 24; `{12,4}*384e` = SmallGroup(384,18044), (48,96,16),
  Petrie 24.  **CORRECTED:** there is no `{30,3}*2880` and no `{20,5}*2400`;
  those maps exceed the atlas coverage, so the PETCOX cells of rows 4, 5, 6,
  8, 9, 10 have no atlas name.
* **Conder, census of regular orientable maps**
  (`https://www.math.auckland.ac.nz/~conder/RegularOrientableMaps301.txt`,
  3874162 bytes, genus 2 to 301, up to isomorphism **and duality**).
  **CORRECTED:** the URL printed in [PETCOX] reference [6]
  (`.../OrientableRegularMaps301.txt`) returns HTTP 404; the words are
  transposed.  Entries retrieved verbatim: `R97.9 : Type {3,30}_20 Order 2880 mV = 2
  mF = 1` (line 12683) and `R97.10 : Type {3,30}_40 Order 2880 mV = 2 mF = 1`
  (line 12687), which are the only two maps of type `{3,30}` and order 2880 in
  the whole file; `R151.10 : Type {5,20}_12 Order 2400` (line 24067) and
  `R151.11 : Type {5,20}_60 Order 2400` (line 24071), likewise the only two of
  that type and order.  Header, verbatim: the list is of "all fully regular
  (rotary and reflexible) maps on ... orientable surfaces of genus 2 to 301,
  up to isomorphism and duality", 15824 maps.  The file itself does not define
  `mV`, `mF`, the generators `R, S, T`, or the meaning of the type subscript.
* **Conder, census of chiral polytopes with up to 4000 flags**
  (`https://www.math.auckland.ac.nz/~conder/ChiralPolytopesWithUpTo4000Flags-ByType.txt`,
  791468 bytes; live but not linked from his index page, which still links
  only the 2000-flag files).  Coverage, verbatim: "a complete list of all
  abstract chiral polytopes (with maximum symmetry) up to 4000 flags, up to
  isomorphism, reflection and duality", built "by finding and analysing all
  normal subgroups of index up to 2000 in the relevant Coxeter groups";
  maximum group order 2000; ranks 3, 4, 5 only; 406 rank-4 entries.  Tags,
  verbatim: "properly self-dual ('PSD')", "improperly self-dual ('ISD')",
  "otherwise non-self-dual ('NSD')".  Retrieved entries used below:

      Chiral 4-polytope with group of order 192   NSD  Type [ 3, 3, 8 ]
      [ A.1^3, A.2^3, (A.1^-1 * A.2^-1)^2, (A.2^-1 * A.3^-1)^2, A.3^-1 * A.2 * A.1^-1 * A.3 * A.1, A.3^-1 * A.1 * A.3 * A.2^-1 * A.1 * A.3^-2 * A.2 ]

      Chiral 4-polytope with group of order 1152   NSD  Type [ 4, 3, 12 ]
      [ A.1^4, A.2^3, (A.1^-1 * A.2^-1)^2, (A.2^-1 * A.3^-1)^2, A.3^-1 * A.2 * A.1^-1 * A.3 * A.1, A.3^-1 * A.1 * A.3 * A.2^-1 * A.1 * A.3^-2 * A.2 ]

  (ByType lines 7637-7638 and 8073-8074; the two lists differ only in
  `A.1^3` versus `A.1^4`.)  There is **no** rank-4 entry of type `[3,3,30]`,
  `[30,3,3]` or `[3,30,3]`, and none of group order 2880 or 7200, because
  those exceed the coverage.

### Identifications carried out here (gap/conder-check.g, 41 assertions)

* Roli's cube's abstract polytope **is** Conder's order-192 `[3,3,8]` entry:
  the dual-and-mirror variant of our distinguished triple satisfies every one
  of Conder's relators and both groups have order 192.
* The class-5 polytope of RESULT.md (type `{12,3,4}`, `|Gamma| = 1152`) **is**
  Conder's order-1152 `[4,3,12]` entry, by the same test.  So that abstract
  polytope is already published; what is new is its realisation in `E^4`.
* **CORRECTED, a correction to [PETCOX] p. 29: the `{30,3}` cell is Conder's
  `R97.10`, not `R97.9`.**  Two independent identifications:
  * *By Petrie length.*  The cell of rows 4 and 8 (type `{30,3}`, 480
    vertices, 720 edges, 48 faces, group order 2880, genus 97) has Petrie
    polygon length **40**, computed twice: as `2 ord(S1^2 S2^2)` and as
    `ord(rho0 rho1 rho2)` in the full automorphism group built as a
    semidirect product.  The same two methods reproduce the published Petrie
    lengths 12, 24, 24 of `{8,3}*96`, `{12,3}*288`, `{12,4}*384e` and 10 of
    the dodecahedron.  Conder prints `R97.9` with subscript 20 and `R97.10`
    with subscript 40.
  * *By defining relations*, which needs no convention at all.  Building the
    full automorphism group `Gamma(P_T) = G . <rho_0>` of order 2880 and
    putting `R = S2^{-1}`, `S = S1^{-1}`, `T = rho_1 = rho_0 S1` (Conder's `T`
    inverts both `R` and `S`, so it is a `rho_1`-type reflection; his entry is
    the dual of our cell, and duality fixes `rho_1`), **every** relator of
    `R97.10` is trivial and the last relator of `R97.9` is not.  Since our
    group and both candidate groups have order 2880, this identifies the cell
    with `R97.10`.
  * The identification of rows 5 and 9 made in the same sentence of [PETCOX]
    is **confirmed** by the same two tests: the `{20,5}` cell has Petrie
    length 60 and satisfies every relator of `R151.11` (and not those of
    `R151.10`).
  [conder-check.g, 47 assertions.]

## 6. Novelty assessment

**No published construction of a chiral 4-polytope in `E^4` (or `S^3`) with
cells `H_alpha({5,3,3})` or `H_alpha({5/2,3,3})`, and no published chiral
4-polytope of type `{30,3,3}`, `{12,3,3}` or a second one of type `{12,3,5}`,
was located in the sources searched.**  The sources searched were: arXiv (API
and author listings), zbMATH Open (API), Crossref, OpenAlex, OpenCitations,
Semantic Scholar, DBLP, Google Scholar, Google Books, Hartley's atlas,
Conder's censuses of regular orientable maps and of chiral polytopes, the
Polytope Wiki, the authors' own pages (Bracho's Petrie-Coxeter companion site,
Hubard's site including her students page, Pellicer's CCM page), the UNAM
repositories (`repositorio.unam.mx`, TESIUNAM), GitHub, the DGAPA-PAPIIT
transparency reports, and the two monographs of 2020 and 2025.  Nobody repeats
the p. 25 facet claim: the zbMATH review of [PETCOX], Hubard-Schulte, Monson
and the companion website all omit it.

Two qualifications, both of which must accompany any claim of novelty.

1. **Announced but unpublished prior art.**  Hubard-Schulte (arXiv:2604.00185,
   31 March 2026) cite, as their reference [31], "I. Hubard and B. Trejo,
   *A family of skeletal chiral 3- and 4-polytopes in R^4*. Preprint".
   Trejo's PhD project is listed on Hubard's students page as "Chiral
   polytopes in Euclidian 4-space".  Her abstract for the 10th Slovenian
   Conference on Graph Theory (Kranjska Gora, June 2023, book of abstracts
   p. 151, retrieved through the Internet Archive) says: "In this talk, we
   will classify the chiral polyhedra with helical faces whose skeleton is
   contained in the skeleton of the regular convex 4-polytopes in R^4."  The
   final report of UNAM-PAPIIT project IN109023 (updated 2 July 2025) states
   that exactly four such polyhedra exist, that it was determined which of
   them extend to chiral 4-polytopes in `E^4`, and that the write-up was in
   progress.  The audit further reports a public GitHub GAP appendix
   associated with Trejo's thesis that computes an object with f-vector
   (600, 1200, 120, 5), group order 7200, cell group order 1440 and
   vertex-figure group order 12, i.e. the invariants of class 2 of RESULT.md.
   Neither the preprint nor the thesis is deposited
   (`repositorio.unam.mx` has only Trejo's 2018 master's thesis).  **The
   honest formulation is therefore: no published construction was located,
   while the extension of `H_0({5,3,3})` to a chiral 4-polytope is announced
   as achieved in unpublished work of Hubard and Trejo and is computed in
   public in a GitHub GAP appendix.**  Class 2 of RESULT.md must not be
   claimed as new.
2. **Abstract versus geometric.**  The abstract polytopes of classes 1 and 5
   are in Conder's published census (identified exactly above).  Classes 2, 3,
   4 and 6 have 14400, 14400, 5760 and 14400 flags and are beyond every
   published census, so no census can speak to them either way.  What is new
   in all six cases is the geometric statement: a faithful, geometrically
   chiral realisation in `E^4` whose cells are PETCOX polyhedra.

## 7. Negative results (what was searched and not found)

* arXiv API: `all:"chiral" AND all:"full rank"`; `all:chiral AND all:polytope`
  restricted to rank 4, skeletal, Euclidean; `abs:"chiral polyhedra"` by date;
  author queries for Bracho, Hubard, Pellicer, Gonzalez-Casanova, Trejo,
  Mochan, Montero.  No preprint of [Thesis] and none of the Hubard-Trejo
  preprint; no further finite chiral 4-polytope in `E^4`.
* zbMATH Open: `chiral polytope full rank` (9 documents), `Roli cube` (1).
  Nothing new.  Most reviews in this area are licence-withheld
  (UNVERIFIABLE); the review of [PETCOX] was obtained through the REST API.
* Crossref, OpenAlex, OpenCitations, Semantic Scholar, DBLP: no work
  constructing another finite chiral 4-polytope in `E^4`.
* Google Scholar: `"chiral polytopes of full rank"`, `"Two new chiral
  4-polytopes of full rank"`, `"skeletal chiral 3- and 4-polytopes"`,
  `"Gonzalez-Casanova" chiral polytope`.  The manuscript [Thesis] appears
  only as reference [1] of arXiv:2604.00185.
* UNAM repositories and TESIUNAM: no deposit of [Thesis]; no deposit of
  Trejo's doctoral thesis; the DGB Aleph endpoint could not be reached
  (UNVERIFIABLE).
* Cambridge Core: Pellicer's 2025 monograph (Chapter 6, Appendix C) and
  McMullen's 2020 monograph: HTTP 429 or no preview on every attempt
  (UNVERIFIABLE).  Whether either announces a further finite chiral
  4-polytope in `E^4`, or a facet criterion, is therefore unknown.
* ScienceDirect (Pellicer's 2021 chiral 5-polytope): HTTP 403 (UNVERIFIABLE).
* Bracho's companion site
  (`https://www.matem.unam.mx/~roli/investigacion/programs/PetrieCoxeter.html`,
  reached by a meta refresh from the URL printed in [PETCOX]) offers
  Mathematica code, a group file and a gallery for all ten families
  `H2H{...}`, including `H2H{5,3,3}` and `H2H{3,3,5/2}`; it contains no
  4-polytope construction.  CONFIRMED.

## 8. Refuted and corrected items, collected

| item | status | correction |
|---|---|---|
| DOI 10.1007/s00454-021-00306-x for [PETCOX] | CORRECTED | the DOI is 10.1007/s00454-021-00317-0; the former is unregistered |
| zbMATH "cited in" for [PETCOX] naming Monson | REFUTED | Monson does not cite [PETCOX]; the zbMATH review of Monson misattributes the 2014 abstract |
| Hartley atlas names `{30,3}*2880`, `{20,5}*2400` | CORRECTED | they do not exist; the atlas stops at 2000 flags |
| Conder map-census URL of [PETCOX] ref. [6] | CORRECTED | `RegularOrientableMaps301.txt`, not `OrientableRegularMaps301.txt` |
| [PETCOX] p. 29: the `{30,3}` cell "listed as R97.9" | CORRECTED | our cell has Petrie length 40, `R97.9` has 20 (two independent computations here, validated against four published Petrie lengths); the `R151.11` identification in the same sentence is consistent with our data |
| "Conder's ISD means is-self-dual" | CORRECTED | ISD is "improperly self-dual"; PSD is "properly self-dual"; NSD is "non-self-dual" |

## Note on Conder's notation

The file `RegularOrientableMaps301.txt` does not define `mV`, `mF`, the
generator names `R, S, T`, or the meaning of the subscript on the type; those
readings come from Conder's papers and from the structure of the relator lists
(`T` is an involution inverting both `R` and `S`, and the relator pinning the
face size matches the first entry of the type).  The identification of the
`{30,3}` cell with `R97.10` above does not depend on any of that: it is
decided by testing his complete relator set in a group of the same order.
