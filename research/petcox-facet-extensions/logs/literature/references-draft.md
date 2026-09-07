# Literature audit: PETCOX facet extensions

Target question. Whether the published literature contains a construction of a chiral
4-polytope of type {30,3,3} whose facets (cells) are the helical-faced chiral polyhedra
H_0({5,3,3}) and H_0({5/2,3,3}) = H_1({3,3,5/2}) of Bracho, Hubard and Pellicer, and what
the literature does establish about the facet claim made on p. 25 of that paper.

Access window. All retrievals reported here were made on 2026-09-07, except where a record
states 2026-09-06 (the session began on 2026-09-06 and rolled over); those items are marked
"accessed 2026-09-06 to 2026-09-07".

Evidence base. Six retrieval modalities and three verification passes:
(i) reverse-citation sweep of PETCOX; (ii) reverse-citation sweep of Roli's cube;
(iii) full-rank chiral polytope sweep; (iv) rank-4 extension-theory sweep;
(v) recent skeletal/geometric chiral polytope surveys 2019-2026;
(vi) author-site, companion-code and code-repository sweep;
plus verification passes on bibliographic data and citation counts, on atlas and list
lookups, and on the novelty claim itself.

Status vocabulary used on every item below.

- CONFIRMED: retrieved from a primary or authoritative source on the stated date, and the
  content quoted is what that source says.
- CORRECTED: the item as it entered the audit was wrong in a stated respect; the corrected
  form is given.
- REFUTED: a claim that entered the audit was checked against the primary source and does
  not hold.
- UNVERIFIABLE: could not be retrieved in this session (paywall, HTTP block, licence
  withholding, out-of-coverage list). Absence of retrieval is never treated as evidence of
  absence of content.

Two mechanical caveats that affect quotation fidelity.

1. Every PDF quotation below was produced by local text extraction (PyPDF2, and pypdf 6.17.0
   in a virtual environment, because macOS has no pdftotext). Ligatures, inter-word spaces
   and sub/superscripts are flattened by the extractors, so Schläfli symbols such as
   {30_(1,11),3} are reconstructions of flattened strings such as "f30 1;11;3g" or
   "{30|(1,11)|,3}". Where a reconstruction was made, this is said.
2. Two records reached this report truncated by the input channel: the GitHub record of
   Briseida Trejo's thesis appendix (truncated inside a verbatim quotation about the map
   identification) and the last record of the third verification pass (truncated at
   "Pellicer, 'Abstract Chiral Polytopes' (CUP 2025) - chapter 6 'Skeletal Polytopes' a").
   Both are reported with that truncation flagged. Status of the truncated tails:
   UNVERIFIABLE.

---

## 1. Primary sources

### 1.1 Paper (A), "PETCOX"

J. Bracho, I. Hubard, D. Pellicer, "Chiral Polyhedra in 3-Dimensional Geometries and from a
Petrie-Coxeter Construction", Discrete & Computational Geometry 66 (2021), no. 3, 1025-1052.

- DOI 10.1007/s00454-021-00317-0. ISSN 0179-5376 (print), 1432-0444 (electronic).
- Received 12 September 2019; revised 25 January 2021; accepted 9 June 2021; published
  online 30 August 2021; print issue October 2021.
- Crossref: volume 66, issue 3, page "1025-1052", publisher "Springer Science and Business
  Media LLC", reference-count 29; authors Javier Bracho, Isabel Hubard (ORCID
  0000-0002-0960-3671), Daniel Pellicer; funders PAPIIT-UNAM IN109218 and IN100518, Conacyt
  A1-S-21678.
- Other identifiers: zbMATH Zbl 1475.52019, document id 7402640, MSC 52B15, 51M20, 52B10,
  reviewer Rolf Schneider; OpenAlex W3197857784 (biblio volume 66, issue 3, first_page 1025,
  last_page 1052, is_oa false, one location, Springer); Semantic Scholar paperId
  3dabc07ad7dba6e30cbf71e3e768230536427cf8, CorpusId 237550664; DBLP journals/dcg/BrachoHP21.
- No arXiv version. Five arXiv API queries found none: all:"Petrie-Coxeter" AND all:chiral
  (1 hit, math/0512157 only); ti:"Chiral polyhedra in 3-dimensional geometries" (0);
  ti:"chiral polyhedra" (5 hits, PETCOX absent); abs:"helical faces" (1 hit); au:"Bracho"
  (21 entries) and au:"Hubard" (50 entries), PETCOX absent from both. Crossref "relation"
  field empty.
- An author preprint does exist outside arXiv:
  https://www.matem.unam.mx/~roli/investigacion/articulos/PetrieCoxeterFinal2.pdf
  (HTTP 200, application/pdf, 32 pages, title page dated "January 19, 2021", server
  Last-Modified 2021-04-07). All page numbers quoted for (A) in this audit are PREPRINT page
  numbers. The published pagination of the p. 25 statement inside DCG 66, 1025-1052 was NOT
  retrieved, because link.springer.com issues HTTP 303 to idp.springer.com for this article.

Status: CONFIRMED (accessed 2026-09-07). Sub-item "no arXiv version": CONFIRMED. Sub-item
"published page number of the p. 25 facet statement": UNVERIFIABLE.

Load-bearing verbatim content of (A), from the author preprint (accessed 2026-09-07):

> p. 25: "The type of Hα({5, 3, 3}) is { 30 1,11, 3}, and for α = 0 no vertices identify, so
> that H0({5, 3, 3}) can be taken as facet of a chiral 4-polytope, but not H1({5, 3, 3}) in
> which four vertices come together."

> p. 23: "The general Hα({4, 3, 3}) has type { 8 1,3, 3}. In this case, for α = 0 no vertices
> come together, so we still have a chiral polyhedron H0({4, 3, 3}), which was taken as facet
> of a chiral 4-polytope in S3 (or R4) in [3]."

> p. 25 (starry case): "For {3,3,5/2} the type of H_α is {30_{7,13},3}. Vertices that
> collapse at α = 0,1 are 4,1 respectivelly. The group G is of order 1440."

> p. 25 (the other 7200 case): "the type of H is {15_1,4; 5/2}" and "The group G is of order
> 7200".

> p. 26, Figure 8 caption: "The part of H_0({5,3,3}) that touches the (central) dodecahedral
> facet of {5,3,3}, and an outside view of it with a face highlighted in red."

> p. 28, summary table "Summary of chiral polyhedra from the regular polytopes", columns
> (Polytope T | Type of H_α(T) | #(G) | [G:Γ+] | Collapses at α=(0,1)):
> {3,3,3} | {5_{1,2},3} | 60 | 1 | (4,4);
> {4,3,3} | {8_{1,3},3} | 48 | 4 | (1,2);
> {3,4,3} | {12_{1,5},4} | 192 | 3 | (2,2);
> {5,3,3} | {30_{1,11},3} | 1440 | 5 | (1,4);
> {3,5,5/2} | {20_{1,9},5} | 1200 | 6 | (2,2);
> {5,5/2,5} | {15_{1,4},5/2} | 7200 | 1 | (12,12);
> {5,3,5/2} | {12_{1,5},3} | 144 | 50 | (1,1);
> {3,3,5/2} | {30_{7,13},3} | 1440 | 5 | (4,1);
> {3,5/2,5} | {20_{3,7},5/2} | 1200 | 6 | (2,2);
> {5/2,5,5/2} | {15_{2,7},5} | 7200 | 1 | (12,12).

> p. 29: "The regular polyhedra PT arising from the polytopes T = {4, 3, 3}, T = {3, 4, 3}
> and T = {5, 3, 5/2} can be found in Michael Hartely's Atlas of Regular Abstract Polytopes
> ([17]). In fact, they correspond to the polytopes {8, 3}*96, {12, 4}*384e and {12, 3}*288
> of such atlas, respectively." and "the regular polyhedra arising from T = {5, 3, 3} and
> T = {3, 3, 5/2} are isomorphic of type {30, 3} and are listed as R97.9. The polyhedra from
> the polytopes T = {3, 5, 5/2} and T = {3, 5/2, 5} are of type {20, 5} and also isomorphic,
> listed as R.151.11."

> p. 25 (group identification): "Finally, in the cases when the symmetry group G of the
> chiral polyhedra H_alpha(T) has size 7,200, we note that G is precisely the orientation
> preserving subgroup of the Coxeter group [3,3,5]."

> p. 31: "The interested reader can find the source code for computing the matrices for each
> of the polyhedra, together with more pictures of them in the website
> https://www.matem.unam.mx/~roli/PetrieCoxeter.html"

Status of all quotations in this subsection: CONFIRMED (accessed 2026-09-07), with braces,
subscripts and fraction bars reconstructed from flattened extractor output as noted above.

Two internal points worth flagging for the write-up, both CONFIRMED (2026-09-07):

- (A)'s own table gives #(G) = 1440 for T = {5,3,3} and for T = {3,3,5/2}; the two entries
  where (A) records #(G) = 7200 are T = {5,5/2,5} and T = {5/2,5,5/2}, NOT {5,3,3}. So the
  number 7200 occurs in (A) in a different role from the one it plays in the claim under
  audit (there, as the order of the rotation group of the rank-4 object).
- Doubling every #(G) in (A)'s table gives 120, 96, 384, 2880, 2400, 14400, 288, 2880, 2400,
  14400, matching the full automorphism-group orders of the underlying regular maps; (A)
  states that these polyhedra are combinatorially regular and that the groups G are their
  rotational subgroups.

### 1.2 The DOI that does not resolve

10.1007/s00454-021-00306-x is not a registered DOI. Three independent checks:
api.crossref.org returned "Resource not found."; doi.org returned HTTP 404 with no redirect;
api.openalex.org returned HTTP 404 "Not Found".

- Nearest registered DOI in the same numeric block: 10.1007/s00454-021-00306-3 =
  J. Aguilar-Guzman, J. Gonzalez, T. Hoekstra-Mendoza, "Farley-Sabalka's Morse-Theory Model
  and the Higher Topological Complexity of Ordered Configuration Spaces on Trees", Discrete
  Comput. Geom. 67 (2021), no. 1, 258-286. Unrelated to polytopes.
- Also in the same block: 10.1007/s00454-021-00304-5 = P. McMullen, "Quasi-Regular Polytopes
  of Full Rank", Discrete Comput. Geom. 66 (2021), no. 2, 475-509, Zbl 1471.51011 (zbMATH
  7382950), the paper whose predecessor's Theorem 11.2 the 2014 Roli's-cube paper refutes.

Status: CORRECTED (accessed 2026-09-07). The correct DOI for (A) is
10.1007/s00454-021-00317-0.

### 1.3 Paper (B), Roli's cube

J. Bracho, I. Hubard, D. Pellicer, "A Finite Chiral 4-Polytope in R^4", Discrete &
Computational Geometry 52 (2014), no. 4, 799-805.

- DOI 10.1007/s00454-014-9631-4; published online 2014-09-09, print 2014-12; Crossref
  is-referenced-by-count 8, references-count 12.
- arXiv:1311.1558, single version v1, submitted 2013-11-07, primary category math.CO, title
  "A finite chiral 4-polytope in $\mathbb{R}^4$". The arXiv record carries no journal-ref and
  no DOI field, so the arXiv-to-DCG link rests on title and author matching, plus (A)'s own
  Crossref reference 317_CR3 and Monson's published bibliography entry [3].
- arXiv abstract, verbatim: "In this paper, we give an example of a chiral 4-polytope in
  projective 3-space. This example naturally yields a finite chiral 4-polytope in Euclidean
  4-space, giving a counterexample to Theorem 11.2 of [2]."
- zbMATH document 6394874 = Zbl 1306.05260. The only editorial contribution attached is of
  type "summary" and its text is literally "zbMATH Open Web Interface contents unavailable
  due to conflicting licenses.", so no review text for (B) exists in retrievable form.
- Author copy: https://www.matem.unam.mx/~roli/investigacion/articulos/AfiniteChiral.pdf
  (317 K, last modified 2021-04-07).
- Type {8,3,3}; facet H_0({4,3,3}), the map {8,3}*96.

Status: CONFIRMED (accessed 2026-09-07). Sub-item "zbMATH review of (B)": UNVERIFIABLE
(licence withheld).

### 1.4 Monson, "On Roli's cube"

B. Monson, "On Roli's cube", The Art of Discrete and Applied Mathematics 5 (2022), no. 3,
Paper No. #P3.10, 17 pp.

- DOI 10.26493/2590-9770.1411.6ee; ISSN 2590-9770; publisher recorded by Crossref as
  University of Primorska Press; issue titled "The Marston Conder Issue of ADAM".
- Received 6 April 2021, accepted 4 June 2021, published online 26 July 2022. The published
  PDF's first-page header reads "ISSN 2590-9770 / The Art of Discrete and Applied Mathematics
  5 (2022) #P3.10 / https://doi.org/10.26493/2590-9770.1411.6ee" and "Received 6 April 2021,
  accepted 4 June 2021, published online 26 July 2022". PDF CreationDate D:20220726113946.
- arXiv:2102.08796, v1 submitted 2021-02-17, arXiv title capitalised "On Roli's Cube".
- MSC 51M20 (primary), 52B15. zbMATH Zbl 1507.51024 (document 7612292), source string
  "Art Discrete Appl. Math. 5, No. 3, Paper No. P3.10, 17 p. (2022)".
- PDF: https://adam-journal.eu/index.php/ADAM/article/download/1411/1406/8303
  (a separate earlier attempt reported an expired TLS certificate on the ADAM site; the
  download later succeeded, HTTP 200, 17 pages).

Verbatim, abstract: "First described in 2014, Roli's cube R is a chiral 4-polytope,
faithfully realized in Euclidean 4-space (a situation earlier thought to be impossible). Here
we describe R in a new way, determine its minimal regular cover, and reveal connections to
the Möbius-Kantor configuration."

Verbatim, Section 1 (Introduction), the paper's only statement on the existence of further
full-rank chiral polytopes: "Chiral polytopes with realizations of 'full rank' had
(incorrectly) been shown not to exist by Peter McMullen in [11, Theorem 11.2]. Mind you,
these objects do seem to be elusive. Pellicer has proved in [15] that chiral polytopes of
full rank can exist only in ranks 4 or 5." The preceding sentence: "First described by Javier
(Roli) Bracho, Isabel Hubard and Daniel Pellicer in [3], R is a chiral 4-polytope of type
{8,3,3}, faithfully realized in E4 (a situation earlier thought impossible)." Also
"Theorem 6.1. (a) The 4-polytope R is abstractly chiral of type {8,3,3}." and "(b) The
corresponding regular 4-polytope T has type {8,3,3} and is faithfully realized in E^8".
The identical sentences were verified in the arXiv v1 source (file rc3.tex, lines 135-140),
so the quotation is stable across versions.

Monson's reference [11] is McMullen, "Regular polytopes of full rank", DCG 32 (2004) 1-35;
his [15] is Pellicer, "Chiral polytopes of full rank exist only in ranks 4 and 5", Beitr.
Algebra Geom. 62 (2021) 651-665.

Important negatives inside Monson, all CONFIRMED by full-text reading of both versions
(accessed 2026-09-07): he nowhere asserts that Roli's cube is the only known chiral polytope
of full rank; poses no conjecture or open problem about further examples; does not mention
Pellicer's chiral 5-polytope of full rank; does not cite (A); and the string
"Petrie-Coxeter" does not occur in the article. The word "elusive" is the strongest statement
he makes. His "Petrie" occurrences all concern Petrie polygons of the 4-cube (Section 4).

Status: CONFIRMED (accessed 2026-09-07). Note that two earlier modality records date this
paper 2021 (the arXiv year); the published year is 2022. That is recorded as a correction in
Section 10.

### 1.5 Pellicer's full-rank sequence

- D. Pellicer, "A chiral 4-polytope in R^3", Ars Mathematica Contemporanea 12 (2017), no. 2,
  315-327; DOI 10.26493/1855-3974.1055.0f4; zbMATH 6774882. Abstract, verbatim: "In this
  paper we describe an infinite chiral 4-polytope in the Euclidean 3-space. This builds on
  previous work of Bracho, Hubard and the author, where a finite chiral 4-polytope in the
  Euclidean 4-space is constructed. These two polytopes show that there are finite and
  infinite chiral polytopes of full rank as defined by McMullen." Status: CONFIRMED
  (accessed 2026-09-06 to 2026-09-07).
- D. Pellicer, "Chiral 4-polytopes in ordinary space", Beiträge zur Algebra und Geometrie 58
  (2017), no. 4, 655-677; DOI 10.1007/s13366-017-0342-x; Zbl 1385.52010. Abstract, verbatim:
  "In this paper we list three chiral 4-polytopes in Euclidean space, and show that this list
  is complete. This concludes the classification of chiral polytopes of full rank in 3-space.
  We also prove that these three chiral 4-polytopes are combinatorially chiral." Full text
  paywalled. Status: CONFIRMED for abstract and bibliographic data; UNVERIFIABLE for the body
  (accessed 2026-09-06 to 2026-09-07).
- D. Pellicer, "Chiral polytopes of full rank exist only in ranks 4 and 5", Beiträge zur
  Algebra und Geometrie 62 (2021), no. 3, 651-665; DOI 10.1007/s13366-020-00545-0; received
  16 June 2020, accepted 20 October 2020, online 2020-11-04; zbMATH 7375630 (Zbl 1470.52017).
  Abstract, verbatim: "Skeletal chiral polytopes of rank n in a Euclidean space must have as
  ambient space R^d for some d >= n if they are finite, or some d >= n-1 if they are infinite.
  If the dimension attains the lower bound just mentioned, we say that the polytope is of full
  rank. In this article it is proven that a chiral polytope of full rank can only have rank 4
  or 5." zbMATH review fragment, verbatim: "It is known that chiral polytopes of full rank do
  not exist if n=2 or n=3 and that they do exist for n=4 and n=5." Its Crossref reference list
  (24 refs) contains Bracho-Hubard-Pellicer 2014 and 2016 and Pellicer 2017 but NOT (A).
  Structurally this is a rank restriction, not a classification, so it cannot pre-empt a new
  rank-4 example. Status: CONFIRMED (accessed 2026-09-06 to 2026-09-07); one later re-check
  of the Springer abstract went through a search-engine summary rather than a direct fetch,
  so treat any wording beyond the two sentences quoted above as paraphrase.
- D. Pellicer, "A chiral 5-polytope of full rank", Discrete Mathematics 344 (2021), no. 6,
  Paper No. 112370, 10 pp.; DOI 10.1016/j.disc.2021.112370; zbMATH 7340595, reviewer
  R. Schneider; DBLP journals/dm/Pellicer21; OpenAlex W3135933121; Crossref reference-count
  22. zbMATH review fragment, verbatim: this paper "constructs the first chiral 5-polytope of
  full rank." Unpaywall: is_oa = false, no OA location; ScienceDirect and ResearchGate both
  returned HTTP 403. Status: CONFIRMED for bibliographic data; UNVERIFIABLE for the body,
  including whether it discusses H_alpha(T) as facets (accessed 2026-09-06 to 2026-09-07).

### 1.6 The two monographs

D. Pellicer, "Abstract Chiral Polytopes", New Mathematical Monographs 49, Cambridge
University Press, 2025; viii+484 pp.; ISBN 978-1-108-49324-6 (hardback), 978-1-108-69504-6
(ebook); DOI 10.1017/9781108695046; published online 23 March 2025 (print 3 April 2025 per
one record); zbMATH Zbl 1570.52001 (document 7990062, reviewer Enrico Jabara).

Chapter and appendix pagination, from Crossref and OpenAlex (CONFIRMED, accessed
2026-09-07):

| Part | Pages | DOI |
| --- | --- | --- |
| Chapter 4 (constructions from other polytopes) | 208-262 | 10.1017/9781108695046.005 |
| Chapter 5, "Families of Chiral Polytopes" | 263-341 | 10.1017/9781108695046.006 |
| Chapter 6, "Skeletal Polytopes" | 342-448 | 10.1017/9781108695046.007 |
| Appendix A, "A Few Treats on Euclidean Geometry" | 449-455 | not retrieved |
| Appendix B, "A Few Words about Numbers" | 456-458 | not retrieved |
| Appendix C, "Open Problems" | 459-465 | 10.1017/9781108695046.010 |
| References | 466-480 | not applicable |
| Index | 481-484 | not applicable |

Chapter 6 publisher summary, reconstructed verbatim from the OpenAlex inverted index of the
publisher-supplied abstract (accessed 2026-09-07): "chiral polytopes are intrinsically
combinatorial objects. In this chapter a geometric meaning is given to many of them. This
follows the ideas of Grünbaum of skeletal polyhedra. As part of the discussion, chiral
polyhedra in Euclidean three-dimensional space are described in a different way from the one
in which they were originally found by Schulte. Chiral polytopes of full rank are those that
attain a certain upper bound with respect to their dimensions; this is the same bound used to
define regular polytopes of full rank. It is proven that chiral polytopes of full rank exist
only in ranks 4 and 5. This is an unexpected contrast with regular polytopes of full rank,
which exist in every rank."

Chapter 4 summary, verbatim as retrieved through a reader proxy of the DOI landing page:
"The idea of this chapter is to show ways to construct polytopes from other polytopes, with
emphasis on constructions yielding chiral polytopes ... The last construction, called the
mix, uses two polytopes to obtain a third polytope that covers the other two."

Chapter 5 summary is available only as a fetch-tool paraphrase: it covers chiral polyhedra,
tight chiral polytopes, examples from geometry including "Coxeter's twisted honeycombs and
Roli's cube", and constructions of high-rank chiral polytopes by amalgamation and extensions.
Book blurb, paraphrase: "featuring examples, exercises, figures, and 75 open problems".

What could NOT be retrieved and why. The body of Chapter 6 (pp. 342-448), the summary and
body of Appendix C (pp. 459-465), and the reference list (pp. 466-480). Cambridge Core
(www.cambridge.org, resolve.cambridge.org) returned HTTP 429 "Too many automated requests
from this network" (Varnish) on every attempt across the whole session (7 separate attempts
in one pass, 5 or more in two others, via both WebFetch and curl with a browser user agent);
assets.cambridge.org front-matter and index PDFs for ISBN 9781108493246 timed out (HTTP 000);
the Google Books API returned totalItems null or HTTP 429 for intitle:"Abstract Chiral
Polytopes" and for search-inside queries on "Petrie-Coxeter", "helical", "Roli" and "facet of
a chiral"; the zbMATH review is licence-withheld.

Status: bibliographic data and pagination CONFIRMED (accessed 2026-09-07); Chapter 6 body,
Appendix C, and the reference list UNVERIFIABLE. This is the single most important gap in the
audit, because a 107-page skeletal chapter written by one of (A)'s three authors is the most
plausible published place for the H_alpha(T)-as-facet idea to have been developed, and
Appendix C is the most plausible place for it to be posed as an open problem.

P. McMullen, "Geometric Regular Polytopes", Encyclopedia of Mathematics and its Applications
172, Cambridge University Press, 2020; xi+603 pp.; ISBN 978-1-108-48958-4 (hardback),
978-1-108-77899-2 (ebook); DOI 10.1017/9781108778992; bibliography pp. 583-591; zbMATH
Zbl 1454.51002 (document 7162762, reviewer Uma Kant Sahoo). A separate book review exists:
Nieuw Archief voor Wiskunde (5) 23 (2022), no. 2, 124-125, Zbl 1541.00029.

Both zbMATH reviews and the Nieuw Archief review return the placeholder "zbMATH Open Web
Interface contents unavailable due to conflicting licenses."; the bibliography PDF on
Cambridge Core returned HTTP 429; Google Books in-book searches for "Bracho" and "chiral"
(volume id hLbPDwAAQBAJ) produced no snippets, and the Books API returned HTTP 429. The only
retrievable characterisation of its scope is from Hubard and Schulte, arXiv:2604.00185v1,
Introduction, verbatim: "The recent Geometric Regular Polytopes monograph by McMullen [39]
offers a comprehensive account on geometric realizations of abstract regular polytopes in
Euclidean spaces." It is not listed as citing (B) by OpenAlex, Semantic Scholar, zbMATH or
Google Scholar, and Hubard and Schulte do not include it among their references for skeletal
chiral polytopes in higher-dimensional Euclidean spaces.

Status: bibliographic data CONFIRMED (accessed 2026-09-06 to 2026-09-07); content
UNVERIFIABLE, including whether it contains a remark correcting Theorem 11.2 of McMullen 2004.

### 1.7 Extension-theory primaries

- E. Schulte, A. Ivić Weiss, "Chiral polytopes", in Applied Geometry and Discrete Mathematics
  (The Victor Klee Festschrift), DIMACS Series in Discrete Mathematics and Theoretical
  Computer Science 4, AMS (1991), pp. 493-516; DOI 10.1090/dimacs/004/39. Bibliographic data
  confirmed via Crossref and A. I. Weiss's York publication list. Full text NOT retrieved: no
  open-access copy found, and the AMS chapter page https://www.ams.org/books/dimacs/004/39
  returned HTTP 403. Status: bibliographic data CONFIRMED (accessed 2026-09-06 to
  2026-09-07); the text of Section 6, including Theorems 2 and 3 on the universal
  {P_1,P_2}^ch, UNVERIFIABLE.
- E. Schulte, A. Ivić Weiss, "Free extensions of chiral polytopes", Canadian Journal of
  Mathematics 47 (1995), no. 3, 641-654; DOI 10.4153/cjm-1995-033-7. Status: bibliographic
  data CONFIRMED; body UNVERIFIABLE (only a fetch-tool paraphrase of the abstract was
  obtained, quoted in Section 5 below).
- B. Nostrand, E. Schulte, "Chiral polytopes from hyperbolic honeycombs", Discrete &
  Computational Geometry 13 (1995), no. 1, 17-39; DOI 10.1007/BF02574026. Springer redirected
  to a login page; Semantic Scholar and Crossref carry no abstract. Status: bibliographic data
  CONFIRMED (accessed 2026-09-06 to 2026-09-07); theorem statements UNVERIFIABLE. This is a
  CORRECTED attribution: the paper is by Nostrand and Schulte, 1995, not Schulte and Weiss,
  1994.
- E. Schulte, A. Ivić Weiss, "Chirality and projective linear groups", Discrete Mathematics
  131 (1994), nos. 1-3, 221-261; DOI 10.1016/0012-365X(94)90387-5. ScienceDirect HTTP 403.
  Abstract from a search snippet: "The correspondence of groups and polytopes is used to
  construct infinite series of chiral and regular polytopes whose facets or vertex-figures
  are chiral or regular toroidal maps. In particular, the groups PSL2(Zm) are used to
  construct chiral polytopes, while PSL2(Zm[i]) and PSL2(Zm[ω]) are used to construct regular
  polytopes." Status: bibliographic data CONFIRMED; body UNVERIFIABLE.
- D. Pellicer, "A construction of higher rank chiral polytopes", Discrete Mathematics 310
  (2010), nos. 6-7, 1222-1237; DOI 10.1016/j.disc.2009.11.034. ScienceDirect HTTP 403; only
  the abstract (via the Semantic Scholar API) and second-hand descriptions were obtained.
  Abstract, verbatim: "In this paper we describe a construction for chiral polytopes with
  preassigned regular facets. Furthermore we show that this construction implies the existence
  of chiral d-polytopes, for every rank d>=3." Status: bibliographic data and abstract
  CONFIRMED (accessed 2026-09-06 to 2026-09-07); theorem numbers and hypotheses UNVERIFIABLE.
- G. Cunningham, D. Pellicer, "Chiral extensions of chiral polytopes", Discrete Mathematics
  330 (2014) 51-60; DOI 10.1016/j.disc.2014.04.014; arXiv:1307.7007 (v2, 4 April 2014).
  Full arXiv text retrieved and extracted. Status: CONFIRMED (accessed 2026-09-06 to
  2026-09-07). Quotations in Section 4.2.
- D. Pellicer, "Developments and open problems on chiral polytopes", Ars Mathematica
  Contemporanea 5 (2012), no. 2, 333-354; PDF
  https://amc-journal.eu/index.php/amc/article/download/183/179. Status: CONFIRMED (accessed
  2026-09-07). Quotations in Sections 4.5 and 5.
- M. Conder, I. Hubard, T. Pisanski, "Constructions for chiral polytopes", Journal of the
  London Mathematical Society (2) 77 (2008), no. 1, 115-129; DOI 10.1112/jlms/jdm093;
  preprint https://www.math.auckland.ac.nz/~conder/preprints/chiralpolytopes.pdf dated
  22 September 2006, downloaded and extracted. Status: CONFIRMED (accessed 2026-09-06 to
  2026-09-07).
- M. I. Hartley, I. Hubard, D. Leemans, "Two atlases of abstract chiral polytopes for small
  groups", Ars Mathematica Contemporanea 5 (2012) 371-382; DOI 10.26493/1855-3974.204.f8b;
  PDF https://amc-journal.eu/index.php/amc/article/download/204/192, downloaded and
  extracted. Status: CONFIRMED (accessed 2026-09-06 to 2026-09-07).
- A. Breda D'Azevedo, G. A. Jones, E. Schulte, "Constructions of Chiral Polytopes of Small
  Rank", Canadian Journal of Mathematics 63 (2011) 1254-1283 (as cited by Cunningham and
  Pellicer, reference [1]); arXiv:1008.1080 (5 August 2010), PDF downloaded and extracted.
  Status: CONFIRMED (accessed 2026-09-07).
- A. Montero, "On the Schläfli symbol of chiral extensions of polytopes", Discrete
  Mathematics 344 (2021) 112507; DOI 10.1016/j.disc.2021.112507; arXiv:2003.02933.
  Status: CONFIRMED for abstract and bibliographic data (accessed 2026-09-06 to 2026-09-07).
- A. Montero, M. Toledo, "Chiral extensions of regular toroids", Combinatorica 45 (2025),
  article 5 (online 2024); DOI 10.1007/s00493-024-00132-0; arXiv:2405.09434 (v1 submitted
  15 May 2024), 33 pages, PDF downloaded and string-searched. Status: CONFIRMED (accessed
  2026-09-06 to 2026-09-07). CORRECTED attribution: Montero and Toledo, not Cunningham and
  Pellicer.
- H. S. M. Coxeter, "Twisted honeycombs", CBMS Regional Conference Series in Mathematics 4,
  AMS, Providence 1970 (ISBN 9780821816530, from bookseller listings); H. S. M. Coxeter,
  A. Ivić Weiss, "Twisted honeycombs {3,5,3}_t and their groups", Geometriae Dedicata 17
  (1984), no. 2, 169-179; DOI 10.1007/BF00151504. Content of the 1970 book NOT retrieved.
  Status: bibliographic data CONFIRMED (accessed 2026-09-06 to 2026-09-07); content
  UNVERIFIABLE.
- G. Cunningham, D. Pellicer, "Open problems on k-orbit polytopes", Discrete Mathematics 341
  (2018), no. 6, 1645-1661; DOI 10.1016/j.disc.2018.03.004; arXiv:1608.07993 (29 August 2016,
  v. dated 1 July 2018); Zbl 1475.51013. Status: CONFIRMED (accessed 2026-09-06 to
  2026-09-07).
- M. Conder, "An update on polytopes with many symmetries", Fields Institute Discrete
  Geometry programme slides, 2013/2014;
  https://www2.fields.utoronto.ca/programs/scientific/13-14/discretegeom/Slides/Conder.pdf.
  Status: CONFIRMED (accessed 2026-09-07).
- E. Schulte, "Classification of Regular and Chiral Polytopes by Topology", Fields Institute
  slides, 2013/2014;
  https://www.fields.utoronto.ca/programs/scientific/13-14/discretegeom/Slides/Schulte.pdf.
  Status: CONFIRMED (accessed 2026-09-07).
- M. Conder, "Regular maps and hypermaps of Euler characteristic -1 to -200", cited in (A)'s
  bibliography as reference [6]: "Marston Conder, Regular maps and hypermaps of Euler
  characteristic -1 to -200, J. Combinatorial Theory, Series B, 99 (2009), 455-459.
  https://www.math.auckland.ac.nz/~conder/OrientableRegularMaps301.txt". The URL printed
  there is dead (see Section 7.2). Status: CONFIRMED as (A)'s printed reference (accessed
  2026-09-07).
- M. I. Hartley, "An Atlas of Small Regular Abstract Polytopes", Periodica Mathematica
  Hungarica 53 (2006) 149-156, cited in (A) as reference [17]. Status: CONFIRMED as (A)'s
  printed reference (accessed 2026-09-07).

### 1.8 Companion material, grey literature and unpublished items

- Companion page of (A): "Chiral polyhedra in the 3-sphere",
  https://www.matem.unam.mx/~roli/investigacion/programs/PetrieCoxeter.html (9656 bytes,
  HTTP 200), reached from https://www.matem.unam.mx/~roli/PetrieCoxeter.html, which does NOT
  return 404 but serves an 88-byte body that is exactly a meta refresh, verbatim and
  complete: `<meta http-equiv="refresh" content="0; URL=investigacion/programs/PetrieCoxeter.html" />`.
  Page footer: "(February, 2021; Page done with support from PAPIIT-UNAM project IN109218)";
  server Last-Modified 2021-04-07; licence CC BY 4.0. Status: CONFIRMED (accessed
  2026-09-07). Content quoted in Sections 6 and 8.
- PAPIIT IN109023 Informe Final 2023, "Poliedros esqueléticos altamente simétricos en
  espacios de dimensión 3 y 4", responsable Isabel Alicia Hubard Escalera, Instituto de
  Matemáticas UNAM, 12 pages, "Fecha de actualización: 02/07/2025";
  https://dgapa.unam.mx/images/papiit/transparencia/proyxanio/2025/segundo/IN109023_Informe_Final_2023.pdf
  Status: CONFIRMED (accessed 2026-09-07); text extracted per-font from the PDF's embedded
  ToUnicode CMaps. Content quoted in Section 8.4.
- B. Trejo, public GitHub repository "TesisDoctorado", single file calculos-gap-github.pdf
  (201169 bytes, 42 pages); https://github.com/briseida/TesisDoctorado ; raw file
  https://raw.githubusercontent.com/briseida/TesisDoctorado/main/calculos-gap-github.pdf ;
  commit https://github.com/briseida/TesisDoctorado/commit/fb9d7c53680173f62b2e2409d0e93baac6015f0e
  Repository created 2024-04-07; first commit 2025-07-03; the rank-4 computations were added
  2025-11-23. Thesis title as given on the document: "Chiral polyhedra contained in the
  skeletons of convex regular 4-polytopes", directed by Isabel Hubard. Its bibliography cites
  exactly four items: [1] Bracho's PetrieCoxeter.html page, [2] (A) as DCG 66:1025-1052
  (2021), [3] Conder's RegularOrientableMaps301.txt, [4] GAP 4.8.10.
  Status: CONFIRMED as a public document (accessed 2026-09-07). Content quoted in Section 8.2.
- I. Hubard, B. Trejo, "A family of skeletal chiral 3- and 4-polytopes in R^4", Preprint. No
  copy located anywhere. Its only bibliographic trace is reference [31] of arXiv:2604.00185.
  Status: existence CONFIRMED as a cited preprint (accessed 2026-09-07); content UNVERIFIABLE.
- J. Bracho, D. González-Casanova, I. Hubard, "Two new chiral 4-polytopes of full rank", In
  preparation. No copy located. Its only bibliographic trace is reference [1] of
  arXiv:2604.00185, plus the narrative in the PAPIIT report. Status: existence CONFIRMED as a
  cited manuscript (accessed 2026-09-07); content UNVERIFIABLE.
- B. G. Trejo Escamilla, "Panales quirales", M.Sc. thesis (Maestría en Ciencias
  (Matemáticas)), UNAM, 2018, advisor Isabel Alicia Hubard Escalera; repository handle
  TES01000782306, https://hdl.handle.net/20.500.14330/TES01000782306. Hubard's own students
  page lists the same master's degree under the title "Twisted honeycombs", examination date
  9 January 2019. Status: repository record CONFIRMED (accessed 2026-09-06 to 2026-09-07);
  content UNVERIFIABLE (handle page timed out). The two recorded titles for the same degree
  are noted in Section 10.
- Isabel Hubard, students page,
  https://sites.google.com/im.unam.mx/isahubard/home-page/students. Verbatim: PhD in
  progress, "Briseida Trejo, 'Chiral polytopes in Euclidian 4-space,' Posgrado en Ciencias
  Matemáticas, UNAM"; Honours in progress, "Arturo Flores, 'A full rank chiral 4-polytope'"
  and "Óscar Henney, 'Skeletal two orbit polyhedra from the hypercube'"; Master's completed,
  "Briseida Trejo Escamilla, 'Twisted honeycombs' (January 9, 2019)". Daniel González
  Casanova is not listed. Status: CONFIRMED (accessed 2026-09-07).
- Polytope Wiki, "Roli's cube", https://polytope.miraheze.org/wiki/Roli%27s_cube, last edited
  by user Sycamore916 on 7 May 2026. Verbatim: "Roli's cube is a chiral polychoron of full
  rank. Its faces are half of the Petrie polygons of the tesseract and the skeleta of its
  cells are the Möbius-Kantor graph." and "Roli's cube is the vertex figure of P(3,8,3,3), a
  chiral 5-polytope of full rank." Retrieved with curl in one pass; WebFetch and several
  other access routes returned HTTP 403. Tertiary source. Status: CONFIRMED as retrieved text
  in one pass, UNVERIFIABLE in others (accessed 2026-09-07).
- D. Pellicer, colloquium talk "Politopos quirales de rango 4 en el espacio euclidiano",
  Coloquio, Instituto de Matemáticas UNAM, 8 May 2018;
  https://www.matem.unam.mx/actividades/coloquio/cu/actividades/politopos-quirales-de-rango-4-en-el-espacio-euclidiano
  Verbatim: "En 2004 McMullen probó un teorema que afirma, entre otras cosas, que no hay
  politopos quirales de rango 4 en el espacio euclidiano ... El teorema resultó ser falso y en
  esta plática presentaremos la clasificación de dichos politopos." The abstract does not
  specify the ambient dimension; on the retrievable record this is the E^3 classification
  (Pellicer 2017, Beiträge). Status: CONFIRMED as page text (accessed 2026-09-06 to
  2026-09-07); the dimension referred to is an inference and is flagged as such.
- Gaceta UNAM, "Mundos imaginarios con matemáticas visibles" (Diana Saavedra, 19 March 2020),
  and outreach talks "¿Qué es eso del hipercubo quiral mexicano?" (Coloquio Oaxaqueño IMUNAM,
  5 February 2025, and others 2023-2025). Verbatim from the Gaceta: "una experiencia inmersiva
  por el hipercubo quiral mexicano, una figura geométrica descubierta por los matemáticos
  mexicanos Javier Bracho, Isabel Jubard [sic] y Daniel Pellicer". Status: CONFIRMED (accessed
  2026-09-06 to 2026-09-07). Relevance: as late as February 2025 the outreach record presents
  Roli's cube as the single 4-dimensional chiral object.

---

## 2. Works citing PETCOX (2021)

Complete union found across all indexes queried: exactly TWO genuine citing works, plus one
spurious index entry (refuted) and one unverifiable candidate.

| # | Citing work | Which index found it | Relevance in one line | Status |
| --- | --- | --- | --- | --- |
| 1 | I. Hubard, E. Schulte, "Two-Orbit Polytopes", arXiv:2604.00185v1, 31 March 2026, 37 pp., 2 figures, math.CO and math.MG, MSC 52B15, 51M20, 05E16, 20B25, DOI 10.48550/arXiv.2604.00185, Semantic Scholar paperId 184ee7cc5291134c5aa5e1838563be83d7fbb23d, CorpusId 287021591 | Semantic Scholar (citationCount 1); Google Scholar "Cited by 2"; NOT in OpenAlex, OpenCitations, Crossref, Dimensions, zbMATH | Cites (A) exactly once, as reference [4] inside an undifferentiated list of eleven references on skeletal chiral polytopes in higher-dimensional Euclidean spaces; says nothing about H_alpha(T), helical faces, facets, Roli's cube, {30,3,3} or chirality groups | CONFIRMED (2026-09-07) |
| 2 | D. Pellicer, "A chiral 5-polytope of full rank", Discrete Mathematics 344 (2021), no. 6, Paper No. 112370, 10 pp., DOI 10.1016/j.disc.2021.112370 | zbMATH reverse query rf:7402640 (1 result); Google Scholar "Cited by 2"; systematic Crossref reference-list scan of 15 candidate papers; NOT in Semantic Scholar, OpenAlex or OpenCitations | Cites (A) while it was still in press, as an unstructured reference without a DOI, which is why no citation index registers it; constructs a chiral 5-polytope of full rank in rank 5, not a 4-polytope, so it is not a competing construction; its body could not be read to check for any H_alpha(T) discussion | CONFIRMED for the citation; UNVERIFIABLE for the citing passage (2026-09-07) |
| 3 | B. Monson, "On Roli's cube", ADAM 5 (2022) #P3.10 | zbMATH "cited in" query ci:1475.52019 (1 result, Zbl 1507.51024) | Does NOT cite (A) in either version; the zbMATH entry is a reference-matching error | REFUTED (2026-09-07), see Section 10.2 |
| 4 | D. Pellicer, "Abstract Chiral Polytopes", CUP 2025 | Inferred only from its subject matter and from being reference [56] of arXiv:2604.00185 | Almost certainly cites (A), but Cambridge Core is unreachable and zbMATH lists no references for the book, so this is not established | UNVERIFIABLE (2026-09-07) |

Positive verification of citation 1 from the primary source rather than from an index: the
LaTeX source of arXiv:2604.00185 was downloaded (https://arxiv.org/e-print/2604.00185, file
finalTwoOrbitArxiv.tex, 68 bibitems in one alphabetical list) and bibliography entry 4, key
BHP2021, reads verbatim: "J. Bracho, I.~Hubard and D. Pellicer, Chiral polyhedra in
3-dimensional geometries and from a Petrie-Coxeter construction, \textit{Discrete Comput.
Geom.} {\bf 66} (2021), no.~3, 1025--1052." The citing sentence in the body reads verbatim:
"Results for skeletal chiral polytopes in higher dimensional Euclidean spaces can be found in
[1, 2, 3, 4, 31, 52, 53, 54, 55, 56, 57]." The immediately preceding sentence reads
verbatim: "Significant progress has also been made in the classification of skeletal chiral
polytopes: those of rank 3 in ordinary space were classified in Schulte [61, 62], while
Pellicer [53] enumerated those of rank 4 in ordinary space." An exhaustive string search of
the extracted text found zero occurrences of "helical", "Roli", "chirality group", "{30",
"120-cell", "sphere" or "facet of a chiral" outside the bibliography. Status: CONFIRMED
(2026-09-07).

Positive verification of citation 2: the Crossref reference list of
10.1016/j.disc.2021.112370 contains reference b1, verbatim: "Javier Bracho, Isabel Hubard,
Daniel Pellicer, Chiral polyhedra in 3-dimensional geometries and from a Petrie-Coxeter
construction, Disc. Comput. Geom., accepted for publication." Status: CONFIRMED (2026-09-07).

Index-by-index accounting for (A), all accessed 2026-09-07:

| Index | Query | Result | Status |
| --- | --- | --- | --- |
| Semantic Scholar | graph/v1/paper/DOI:10.1007/s00454-021-00317-0/citations | citationCount 1: "2026 / Two-Orbit Polytopes / ['I. Hubard', 'E. Schulte'] / {'ArXiv': '2604.00185'}" | CONFIRMED |
| OpenAlex | works/doi:... and works?filter=cites:W3197857784 | cited_by_count 0, cited_by_api_url null, meta.count 0; OpenAlex appears not to index arXiv:2604.00185 at all | CONFIRMED |
| OpenCitations | index/v1 and index/v2 citations for the DOI | empty list, 0 citing entities | CONFIRMED |
| Crossref | works/10.1007/s00454-021-00317-0 | is-referenced-by-count 0 (record indexed 2025-02-21) | CONFIRMED |
| Dimensions | metrics-api.dimensions.ai/doi/... | {"times_cited": 0, "recent_citations": 0, "field_citation_ratio": 0.0} | CONFIRMED |
| zbMATH | rf:7402640 | 1 result: Pellicer, "A chiral 5-polytope of full rank" (document 7340595) | CONFIRMED |
| zbMATH | ci:1475.52019 | 1 result: Monson, "On Roli's cube" (Zbl 1507.51024) | REFUTED as a citation, see Section 10.2 |
| Google Scholar | cluster 7894986772177673053 | "Cited by 2" (Hubard-Schulte 2026; Pellicer 2021); 5 versions of (A) listed (Springer, ProQuest, EBSCO twice, ACM DL) | CONFIRMED in the first pass; a later re-check returned Google Scholar's internal-server-error page twice, so the count could not be re-verified |
| Springer "Cited by" panel | link.springer.com/article/10.1007/s00454-021-00317-0 | HTTP 303 to idp.springer.com; page shows "264 Accesses", no citation count, in the one pass that rendered it | UNVERIFIABLE |
| Scilit | publications?q="Petrie-Coxeter construction" | HTTP 403 | UNVERIFIABLE |

Note the two different zbMATH query forms returning two different single results. The
rf:7402640 result (Pellicer) is corroborated by Crossref reference data; the ci:1475.52019
result (Monson) is refuted by full-text reading. Neither zbMATH figure should be quoted as a
citation count for (A).

Additional hand-checks, all negative and all CONFIRMED (2026-09-07). Reference lists of nine
plausible further citers were inspected via Semantic Scholar and Crossref: arXiv:2603.02543
(Angelone and Schulte, 30 refs), arXiv:2602.03807, arXiv:2503.13243, arXiv:2312.13184,
arXiv:2208.00547, DOI 10.1007/s00454-023-00494-0, plus the systematic Crossref scan named in
Section 9.3. None cites (A). Three Semantic Scholar lookups failed outright
(DOI:10.1007/s00454-021-00300-w and ARXIV:2506.19334 returned "Paper ... not found";
DOI:10.1016/j.disc.2021.112370 and DOI:10.1007/s13366-020-00545-0 returned null reference
data).

Bottom line for Section 2. Five years after publication, (A) is cited by exactly two works
that could be located by any means, and neither takes up the p. 25 facet remark. Because
Google Scholar could not be re-reached and books are poorly indexed for citations, "exactly
two citing works" should be read as a lower bound.

---

## 3. Works citing Roli's cube (2014)

Union across Google Scholar (cluster 18013071674759774703, "Cited by 12": 11 distinct works
plus one duplicate), OpenAlex (filter cites:W1970228947, meta.count 10), Semantic Scholar
(the arXiv-keyed record, paperId 5c0507c9ec4a2e038395af3033f4e44829598894, 8 citations) and
zbMATH (rf:6394874, 7 citing documents): 11 distinct citing works. Crossref reports
is-referenced-by-count 8 but does not expose the list.

| # | Citing work | Which index found it | Relevance in one line | Status |
| --- | --- | --- | --- | --- |
| 1 | (A) PETCOX, DCG 66 (2021) 1025-1052 | OpenAlex, Semantic Scholar, zbMATH, Google Scholar | The only citing work that says anything about which of its polyhedra can serve as facets of chiral 4-polytopes; asserts without construction that H_0({5,3,3}) "can be taken as facet of a chiral 4-polytope", and records that H_0({4,3,3}) "was taken as facet" in (B) | CONFIRMED (2026-09-07) |
| 2 | G. Cunningham, D. Pellicer, "Open problems on k-orbit polytopes", Discrete Math. 341 (2018) 1645-1661 | OpenAlex, Semantic Scholar, zbMATH, Google Scholar | Poses Problem 20, "Describe all chiral polytopes of full rank", and lists exactly one finite chiral 4-polytope in E^4, namely (B) | CONFIRMED (2026-09-07) |
| 3 | E. Schulte, A. Ivić Weiss, "Skeletal Geometric Complexes and Their Symmetries", Math. Intelligencer 39 (2017), no. 3, 5-16 | OpenAlex, Semantic Scholar, zbMATH, Google Scholar | Passing bibliography citation as reference [3]; its Petrie-Coxeter and helical-face discussion is exclusively about regular polyhedra in E^3 | CONFIRMED (2026-09-07) |
| 4 | D. Pellicer, "Chiral 4-polytopes in ordinary space", Beitr. Algebra Geom. 58 (2017) 655-677 | OpenAlex, Semantic Scholar, zbMATH, Google Scholar | Classifies the three infinite chiral 4-polytopes of full rank in E^3; concerns E^3, not E^4 | CONFIRMED for abstract; body UNVERIFIABLE (2026-09-07) |
| 5 | D. Pellicer, "A chiral 4-polytope in R^3", Ars Math. Contemp. 12 (2017), no. 2, 315-327 | OpenAlex, Google Scholar | Builds an infinite full-rank chiral 4-polytope in E^3, explicitly on top of (B); no new finite E^4 example | CONFIRMED (2026-09-07) |
| 6 | D. Pellicer, "Chiral polytopes of full rank exist only in ranks 4 and 5", Beitr. Algebra Geom. 62 (2021) 651-665 | OpenAlex, Semantic Scholar, zbMATH, Google Scholar; also cited by Monson [15] and by Hubard-Schulte | Rank restriction theorem, not a classification; its reference list names (B) as the finite full-rank example | CONFIRMED (2026-09-07) |
| 7 | D. Pellicer, "A chiral 5-polytope of full rank", Discrete Math. 344 (2021) 112370 | OpenAlex, Semantic Scholar, zbMATH, Google Scholar | Rank 5, infinite; per the Polytope Wiki entry (tertiary), (B) is the vertex figure of P(3,8,3,3) | CONFIRMED bibliographically; body UNVERIFIABLE (2026-09-07) |
| 8 | P. McMullen, "Quasi-Regular Polytopes of Full Rank", DCG 66 (2021), no. 2, 475-509 | OpenAlex, Semantic Scholar, zbMATH, Google Scholar | Cites (B) in a full-rank context; classifies quasi-regular polytopes of full rank; no chiral construction accessible | CONFIRMED bibliographically; body UNVERIFIABLE (2026-09-07) |
| 9 | D. Pellicer, "The Higher Dimensional Hemicuboctahedron", Springer Proc. Math. Stat. 159 (2016) 263-271 | OpenAlex, Semantic Scholar, Google Scholar page 2 | Two-orbit, not chiral, full-rank polytopes; its reference list already contains "Isabel Hubard and Egon Schulte. Two-orbit polytopes. In preparation." | CONFIRMED (2026-09-07) |
| 10 | B. Monson, "On Roli's cube", ADAM 5 (2022) #P3.10 | OpenAlex, Google Scholar, web search | The only dedicated follow-up to (B); new description, minimal regular cover, Möbius-Kantor connections; constructs no further chiral 4-polytope, does not cite (A), and its "Petrie" occurrences are Petrie polygons of the 4-cube | CONFIRMED (2026-09-07) |
| 11 | I. Hubard, E. Schulte, "Two-Orbit Polytopes", arXiv:2604.00185 | Google Scholar only (not yet in OpenAlex, Semantic Scholar or zbMATH citation lists) | Cites (B) as reference [2] in the same undifferentiated list; documents the two unpublished manuscripts as [1] and [31] | CONFIRMED (2026-09-07) |

Not indexed as citers, and unverifiable either way: Pellicer's 2025 monograph (almost
certainly cites (B); Cambridge Core HTTP 429) and McMullen's 2020 monograph (not listed as a
citer by any index; bibliography pp. 583-591 unreachable). Status: UNVERIFIABLE
(2026-09-07).

Indexing artifact worth recording: the Semantic Scholar record keyed to (B)'s DOI
(paperId dd023bdec13532a360c3b0e158d4c96e61a5418e) returns citationCount 0 and an empty
citations array, while the arXiv-keyed record for the same paper returns 8 citations. Any
citation count for (B) taken from the DOI-keyed Semantic Scholar record is therefore wrong.
Status: CONFIRMED as an artifact (2026-09-07).

Substantive finding for Section 3, CONFIRMED across all 11 citing works (2026-09-07): none
constructs or names any finite chiral 4-polytope of full rank in E^4 other than Roli's cube.
The strongest statement in the citing literature is Monson's "these objects do seem to be
elusive". The only statements about the H_alpha(T) as facets of chiral 4-polytopes occur
inside (A) itself.

---

## 4. Rank-4 extension theory, with theorem and page pointers

### 4.1 Schulte and Weiss 1991, Section 6

Bibliographic data CONFIRMED (see 1.7); the Section 6 text is UNVERIFIABLE (accessed
2026-09-06 to 2026-09-07). No open-access copy exists, the AMS chapter page returned HTTP
403, and Weiss's own publication list gives only the citation. In particular Theorems 2 and 3
of Section 6, on the universal chiral polytope {P_1,P_2}^ch with prescribed facets P_1 and
vertex-figures P_2, could NOT be retrieved verbatim. What the audit has instead is
second-hand quotation from two papers that do quote it:

Conder, Hubard and Pisanski, "Constructions for chiral polytopes", preprint p. 5, quoting
Schulte and Weiss [23, Theorem 1], verbatim: "Conversely, if Γ is any permutation group
generated by elements σ1,σ2,...,σn−1 which satisfy the relations (3) and the intersection
condition, then there exists a polytope P of rank n which is either directly regular or
chiral, of type {p1,...,pn−1} where pi is the order of σi ... Moreover, P is directly regular
if and only if there exists an involutory group automorphism ρ : Γ → Γ such that ρ(σ1) =
σ1^{-1}, ρ(σ2) = σ1^2 σ2, and ρ(σi) = σi for 3 ≤ i ≤ n−1 ...; see [23, Theorem 1])."

Cunningham and Pellicer, quoting Schulte and Weiss [16, Proposition 9], verbatim: "The facets
and vertex-figures of a chiral polytope must be either orientably regular or chiral, and the
(d−2)-faces must be orientably regular (see [16, Proposition 9])."

Conder, Hubard and Pisanski on the universal object, verbatim: "In fact this is the universal
4-polytope having such facets and vertex figures ... so is isomorphic to the universal
{{4,4}(2,1),{4,4}(1,2)} 4-polytope; see [23]."

Why this matters for the audited claim: the quoted Theorem 1 is exactly the criterion by
which a candidate rotation group (here [3,3,5]^+ of order 7200, generated so that the facet
section is the rotation group of order 1440 of the {30,3} map) is certified to be the group of
a chiral or directly regular 4-polytope, namely the relations plus the intersection
condition, with chirality equivalent to the non-existence of the involutory automorphism.
Status of that reading: CONFIRMED as the content of the second-hand quotations
(2026-09-07); the primary wording remains UNVERIFIABLE.

### 4.2 Cunningham and Pellicer, chiral extensions

"Chiral extensions of chiral polytopes", Discrete Math. 330 (2014) 51-60, arXiv:1307.7007v2.
All quotations CONFIRMED from the extracted arXiv text (accessed 2026-09-06 to 2026-09-07).

- Abstract, verbatim: "Given a chiral d-polytope K with regular facets, we describe a
  construction for a chiral (d+1)-polytope P with facets isomorphic to K. Furthermore, P is
  finite whenever K is finite. We provide explicit examples of chiral 4-polytopes constructed
  in this way from chiral toroidal maps."
- Introduction, verbatim: "An important partial result was given in [12], where it is shown
  how to build a finite chiral polytope of rank d+1 with facets isomorphic to a finite regular
  polytope K of rank d. There are very restrictive conditions on the polytope K, however, so
  more work remains to be done even on this piece of the extension problem (Problem 27 of
  [13])."
- Theorem 1 (p. 2), verbatim: "Every finite chiral d-polytope with regular facets is itself
  the facet of a finite chiral (d+1)-polytope. This gives a partial answer to Problem 26 in
  [13]. We note that the assumption that the chiral d-polytope has regular facets is necessary
  (see [16, Proposition 9])."
- Theorem 10 (Section 4), verbatim: "The graph G_P defined above is a GPR graph of a chiral
  (d+1)-polytope with facets isomorphic to K." Followed by, verbatim: "Theorem 10 does not
  require the polytope K to be finite. However, in [18] another construction was given of an
  infinite chiral (d+1)-polytope whose facets are any given chiral d-polytope with regular
  facets."
- Theorem 11 (Section 5), verbatim: "Let K, σ1, σ2 and τ be defined as in the preceding
  discussion, with n = b^2+c^2 prime. Let Γ = ⟨σ1,σ2,τ⟩. Then Γ is the automorphism group of a
  finite chiral polytope with Schläfli symbol {4,4,2(n−2)} and facets isomorphic to K."
- Theorem 14, verbatim: "Then Γ(P) ≅ (A_n × A_n) ⋊ D4."
- Concluding remark, verbatim: "other possible definitions of τ ... may yield 4-polytopes with
  smaller automorphism groups Γ. However, the determination of Γ in such a general setting
  involves bigger complications and is out of the scope of this paper."
- Further theorem pointers recorded but not quoted: Lemma 3, Theorem 8, Corollary 15.

Consequence for the audited question, CONFIRMED by reading: this theorem does not apply to
the facets in question. Its hypothesis is a CHIRAL d-polytope whose own facets are regular.
H_0({5,3,3}) and H_0({5/2,3,3}) are geometrically chiral but combinatorially (directly)
regular polyhedra, per (A)'s own statement that "these polyhedra are combinatorially regular,
and thus the groups G are their rotational subgroups". As abstract polytopes they are regular,
so the Cunningham-Pellicer machine takes no input here.

### 4.3 Pellicer 2010

"A construction of higher rank chiral polytopes", Discrete Math. 310 (2010) 1222-1237. The
abstract is quoted in 1.7. Theorem numbers and hypotheses are UNVERIFIABLE (ScienceDirect
HTTP 403). What was retrieved is second-hand description:

- Pellicer 2012 (Ars Math. Contemp. 5), verbatim: "The only known general result in this
  direction is given in [49], where chiral extensions were found for minimal regular covers of
  the so-called scattered chiral polytopes. This was used to provide a recursive construction
  of chiral polytopes of all ranks higher than 3. However, very few polytopes are regular
  covers of scattered chiral polytopes."
- Conder's Fields slides, verbatim: "Theorem [Daniel Pellicer (2010)]: For every d ≥ 3, there
  exists a finite chiral polytope of rank d. It is easy to prove that if P is a chiral polytope
  of rank d, then its sub-polytopes of rank d−2 are regular (not chiral), so a recursive
  construction is impossible. Daniel Pellicer's proof involved a construction for chiral
  polytopes with prescribed regular facets. But these can be very large!"
- Cunningham and Pellicer 2014 refer into it as "Lemma 1", "Proposition 7" and
  "Theorem 3.7" of their reference [12].

Consequence: this is the only published general construction of chiral (d+1)-polytopes with
prescribed REGULAR facets, hence the only general tool that could in principle apply to
{8,3}*96, {12,3}*288, {12,4}*384e, R97.9, R151.11 or {5,3}; but its hypotheses (the facet must
be the minimal regular cover of a "scattered" chiral polytope) were not verified against the
primary text and would have to be checked case by case. Status: CONFIRMED as the
second-hand characterisation; UNVERIFIABLE as to the hypotheses (accessed 2026-09-06 to
2026-09-07).

### 4.4 Conder, Hubard and Pisanski 2008

J. London Math. Soc. (2) 77 (2008) 115-129; preprint dated 22 September 2006, downloaded and
extracted. All CONFIRMED (accessed 2026-09-06 to 2026-09-07).

- Abstract, verbatim: "In this paper, we describe a method for constructing finite chiral
  n-polytopes, by seeking particular normal subgroups of the orientation-preserving subgroup
  of n-generator Coxeter group ... This technique is used to identify the smallest examples of
  chiral 3- and 4-polytopes, in both the self-dual and non self-dual cases, and then to give
  the first known examples of finite chiral 5-polytopes".
- Section 2 (history), verbatim: "In 1970 Coxeter [8] used honeycombs to construct a family of
  chiral 4-polytopes, by forcing the right and left Petrie motions of the polytopes to have
  different lengths. Later Schulte and Weiss [24] constructed examples from hyperbolic
  honeycombs, using isometries of hyperbolic 3-space and complex Mobius transformations. Also
  Nostrand [19] has constructed such chiral 4-polytopes whose faces are cubes or dodecahedra."
- Smallest chiral 4-polytopes (Figures 5 and 7), verbatim: self-dual of type {4,4,4}, "All the
  facets and vertex figures of this 4-polytope are isomorphic to the chiral 3-polytope
  associated with the chiral map {4,4}(1,2) ... isomorphic to the universal
  {{4,4}(2,1),{4,4}(1,2)} 4-polytope"; non-self-dual of type {3,4,4}, "the facets are all
  isomorphic to the regular 3-polytope of type {3,4} ... In fact this 4-polytope is isomorphic
  to the universal {{3,4},{4,4}(1,2)} 4-polytope."
- Section 3 (p. 5) carries the Schulte-Weiss Theorem 1 quotation given in 4.1.

Relevance: the method, normal subgroups of the rotation subgroup of a Coxeter group that are
not normalised by the reflections, is exactly the method a search for a chiral {30,3,3} with
prescribed facet group would use. The paper itself contains no example with facets {5,3},
{8,3}*96, {12,3}*288, {12,4}*384e, {30,3} or {20,5}: CONFIRMED by full-text inspection.

### 4.5 Pellicer 2012, the open-problem list

"Developments and open problems on chiral polytopes", Ars Math. Contemp. 5 (2012), no. 2,
333-354; extension problems on pp. 346-348 (Problems 24-30), geometric problems on
pp. 352-353 (Problems 37-39). All quotations CONFIRMED (accessed 2026-09-07).

> "In [53] it was proved that for every regular d-polytope K there exists a universal regular
> extension U(K) ... The equivalent result for chiral polytopes was established in [59].
> Specifically, it was established that every chiral d-polytope K with regular facets admits a
> universal chiral extension U^ch(K) ... However, it is not known yet whether there exists a
> chiral polytope covering all other chiral extensions of a regular polytope K."

> "Little is known about chiral extensions of regular or chiral polytopes. The main result in
> this direction is the construction of U^ch(K) given in [59]."

> "Problem 24 Determine whether for every (any) regular polytope K there exists a chiral
> extension which covers every extension of K."

> "Problem 25 Does every chiral polytope K with regular facets admit a chiral extension with
> prescribed last entry of the Schläfli symbol?"

> "Problem 26 Does every chiral finite polytope K with regular facets admit a finite chiral
> extension with prescribed last entry of the Schläfli symbol?"

> "A necessary condition for a regular polytope to admit chiral extensions is orientability."

> "Problem 27 Does every orientably regular d-polytope admit a chiral extension (d ≥ 2)?"

> "Problem 28 Does every orientably regular finite d-polytope admit a finite chiral extension
> (d ≥ 2)?"

> "Problem 29 Does every orientably regular polytope admit an infinite chiral extension?"

> "Problem 30 Does every convex regular polytope admit a chiral extensions?"

> "Problem 37 Classify all finite and infinite chiral k-polytopes in R^d (where k < d ..."

> "Problem 38 Classify all finite chiral polyhedra in E^4."

> "Problem 39 Classify all infinite chiral 4-polytopes in E^4."

Problems 27 and 28 are precisely the abstract form of the audited question for a directly
regular facet, and they are stated as open. Problems 37 to 39 are the geometric forms.

### 4.6 Cunningham and Pellicer 2018, Problem 20

Discrete Math. 341 (2018) 1645-1661; Section 5 "Realizations", p. 22 of the arXiv version,
Problems 20, 21 and 23. Verbatim (CONFIRMED, accessed 2026-09-06 to 2026-09-07):

> "Regular polytopes of full rank were classified in [46, Theorem 11.2], where it is also
> stated that there are no chiral polytopes of full rank. This claim turned out to be false;
> there are both finite chiral 4-polytopes in E4 [5] and infinite 4-polytopes in E3 [66]. It
> is natural now to ask for the classification of full rank chiral polytopes. Problem 20.
> Describe all chiral polytopes of full rank."

> "The following is a more challenging problem than Problem 20. Problem 21. Describe all
> chiral polytopes of nearly full rank."

> "Problem 23. Describe all two-orbit polytopes of full rank."

Their reference [5] is (B). This is the canonical statement of the open problem that a new
finite chiral 4-polytope in E^4 partially answers, and it lists exactly one such object.
CORRECTION recorded in Section 10.9: a web-search summary attributed these numbered problems
to Appendix C of Pellicer's 2025 monograph; the retrieved source of "Problem 20" and
"Problem 21" is this 2018 paper.

### 4.7 Hartley, Hubard and Leemans, the atlases

Ars Math. Contemp. 5 (2012) 371-382. All CONFIRMED (accessed 2026-09-06 to 2026-09-07).

- Abstract, verbatim: "We construct chiral abstract polytopes in two different ways. Firstly
  we seek them as quotients of regular polytopes arising from the Atlas of Small Regular
  Polytopes (http://www.abstract-polytopes.com/atlas/); the resulting atlas of chiral
  polytopes atlas is available on the website http://www.abstract-polytopes.com/chiral/.
  Secondly, for each almost simple group Γ such that S ≤ Γ ≤ Aut(S) where S is a simple group
  and Γ is a group of order less than 900,000 listed in the Atlas of Finite Groups, we give,
  up to isomorphism, the number of abstract chiral polytopes on which Γ acts regularly."
- Theorem 3.1, verbatim: "The polytope Q = P/N is chiral if and only if N_Γ(P)(N) has index 2
  in Γ(P), and contains none of the generators ρ0,...,ρn−1."
- Section 5, verbatim: "In the first atlas, in total, 56 chiral polytopes were discovered, 48
  of rank 3, and 8 of rank 4."
- Table 1 (p. 376), rank-4 chiral quotients of small regular polytopes, verbatim rows:
  "{3,3,8}*768b   ((Q8 × 2) ⋊ 2) ⋊ S4   Q8 ⋊ S4"; "{3,6,9}*972a   3^3 ⋊ (D9 × 2)
  (3^3 ⋊ 3) ⋊ 2"; "{3,6,18}*1944a ..."; "{6,6,9}*1944a ...".
- Table 4, verbatim row: "PGL(2,11)  PGL(2,11)  1320  78  24 = 0 + 24", that is, 24 chiral
  polytopes of rank 4 and none of rank 3.
- Coverage statement, verbatim: "The Atlas of Chiral Polytopes With Small Regular Covers
  contains information about all chiral polytopes whose regular covers have automorphism group
  of order at most 2000, but not 1024 or 1536", and the second atlas covers "each almost
  simple group Γ such that S <= Γ <= Aut(S) where S is a simple group and Γ is a group of
  order less than 900,000 listed in the Atlas of Finite Groups".

Note the two different figures for the almost-simple bound retrieved in this session: the AMC
paper says "order less than 900,000", while Leemans' Atlas of Chiral Polytopes page states,
verbatim: "This Atlas contains all chiral polytopes whose automorphism group is an almost
simple group G such that S <= G <= Aut(S) and S is a simple group of order less than 1
million appearing in the Atlas of Finite Groups by Conway et al." Both are recorded as
retrieved; either way [3,3,5]^+ of order 7200 is not almost simple, and no group of order
7200 appears there. Status: both statements CONFIRMED as retrieved text (2026-09-07).

### 4.8 Other rank-4 extension results retrieved

- Schulte's Fields slides, verbatim: "Extension problem: Chiral n-polytope P as the facet of a
  chiral (n+1)-polytope Q? Facets of P regular! (a) Universal: Γ(Q) ≅ Γ(P) *_{Γ+(F)} Γ(F)
  (Weiss & S., 1994) (b) Finite Q, if P is finite. (Cunningham & Pellicer, 2013)"; and "Open
  Problem: Classify all locally toroidal chiral polytopes!" Status: CONFIRMED (2026-09-07).
- Breda D'Azevedo, Jones and Schulte, arXiv:1008.1080, Section 7 "Locally spherical
  polytopes", Theorems 7.1, 7.2 and 7.3 (pp. 18-19 of v1). Theorem 7.1, verbatim: "Let p be a
  prime, let p ≡ ±1 mod 5 or p = 5, and let Q be a finite locally spherical directly regular
  4-polytope of type {5,3,5} such that p(p^2−1) does not divide |Γ(Q)|. Then there exists a
  locally spherical chiral 4-polytope of type {5,3,5} with group L2(p) × Γ+(Q)." Followed
  verbatim by: "For instance, let Q be the classical regular star-polytope {5/2,3,5} (of type
  {5,3,5}) in euclidean 4-space ... Hence Theorem 7.1 applies (if p ≠ 5) and yields locally
  spherical chiral 4-polytopes of type {5,3,5} with groups isomorphic to L2(p) × H4^+."
  Theorem 7.2, verbatim: "... Then there exists a locally spherical chiral 4-polytope of type
  {3,5,3} with group L2(p) × Γ+(Q)." Theorem 7.3, verbatim: "Let p be a prime with p ≡ ±1 or
  ±9 mod 40, with either 1+√5 or 1−√5 a square mod p. Let Q be a finite locally spherical
  directly regular 4-polytope of type {5,3,4} such that p(p^2−1) does not divide |Γ(Q)|. Then
  there exists a locally spherical chiral 4-polytope of type {5,3,4} with group L2(p) ×
  Γ+(Q)." Status: CONFIRMED (2026-09-07).
- Montero 2021, abstract, verbatim: "Given an abstract n-polytope K, an abstract
  (n+1)-polytope P is an extension of K if all the facets of P are isomorphic to K. A chiral
  polytope is a polytope with maximal rotational symmetry that does not admit any reflections.
  If P is a chiral extension of K, then all but the last entry of the Schläfli symbol of P are
  determined. In this paper we introduce some constructions of chiral extensions P of certain
  chiral polytopes in such a way that the last entry of the Schläfli symbol of P is arbitrarily
  large." Applies to chiral K. Status: CONFIRMED (2026-09-06 to 2026-09-07).
- Montero and Toledo, abstract, verbatim: "In this paper we build chiral polytopes whose
  facets (maximal faces) are isomorphic to a prescribed regular cubic tessellation of the
  n-dimensional torus (n ≥ 2). As a consequence, we prove that for every d ≥ 3 there exist
  infinitely many chiral d-polytopes." Their introduction, verbatim: "Finding examples of
  chiral polytopes of higher ranks has proved to be a rather difficult problem. Some examples
  of chiral 4-polytopes have been built from hyperbolic tilings in [2, 24, 32]." A companion
  talk abstract by Pellicer (CMS Winter 2018,
  https://www2.cms.math.ca/Events/winter18/res/pdf/dcg-dp.pdf) states the general status
  verbatim: "it is still not known whether a given regular polytope of rank n is the facet of
  a chiral polytope of rank n+1. In this talk I will present a construction that shows that
  all but finitely many regular toroidal polytopes of rank n and type {4,3^{n−3},4} are facets
  of chiral polytopes of rank n+1." Status: CONFIRMED (2026-09-06 to 2026-09-07). This is the
  most recent general result on chiral extensions of regular facets, and it covers only cubic
  toroids.
- Conder's flag inequality, from the Fields slides, verbatim: "[Joint work with Dimitri
  Leemans (2012/13)] We now have complete lists of all regular polytopes with up to 4000 flags
  and all chiral polytopes with up to 4000 flags. ... if P is a regular/chiral polytope of type
  {k1,k2,...,kn−1}, and its facets have m flags, then P has at least m·kn−1 flags. Up to 4000
  flags, the largest rank for regular is 6, and the largest rank for chiral is 5." Status:
  CONFIRMED (2026-09-07). This inequality is what puts any 4-polytope with facet R97.9
  (2880 flags) or R151.11 (2400 flags) out of reach of every published census.
- Conder, Hubard and O'Reilly-Regueiro, "Construction of chiral polytopes of large rank with
  alternating or symmetric automorphism group", Advances in Mathematics 452 (2024) 109819, DOI
  10.1016/j.aim.2024.109819. OpenAlex abstract fragment, verbatim: "Extends a construction for
  4-polytopes...to produce two infinite families". Purely combinatorial, simplex facets, all
  ranks at least 4. Related theorem from Conder's slides, verbatim: "Theorem [Hubard,
  O'Reilly-Regueiro, Pellicer & MC] For all but finitely many n, there exists a chiral
  4-polytope P of type {3,3,k} for some k, with Aut P = Alt(n) or Sym(n)." Status: CONFIRMED
  bibliographically (2026-09-06 to 2026-09-07).

---

## 5. Universal chiral polytopes with prescribed facets

What the literature proves, as retrieved.

1. For a CHIRAL d-polytope K whose own facets are regular, a universal chiral extension
   exists. Schulte and Weiss 1995 ("Free extensions of chiral polytopes", Canad. J. Math. 47,
   641-654) is the source; its abstract, as paraphrased by the fetch tool and therefore NOT a
   verbatim quotation, reads: "if P is a chiral polytope with regular facets Q, then among all
   chiral polytopes with facets P exists a universal polytope P̃ whose group is an amalgamated
   product of the groups of P and Q. Finite extensions receive discussion as well." Schulte's
   own slides state the group form verbatim: "Universal: Γ(Q) ≅ Γ(P) *_{Γ+(F)} Γ(F) (Weiss &
   S., 1994)". Status: CONFIRMED as the slide wording; UNVERIFIABLE as to the paper's exact
   theorem statement and numbering (accessed 2026-09-07).
2. Pellicer 2012 states the same result and its limitation, verbatim (quoted in full in
   Section 4.5): "every chiral d-polytope K with regular facets admits a universal chiral
   extension U^ch(K) ... However, it is not known yet whether there exists a chiral polytope
   covering all other chiral extensions of a regular polytope K." Status: CONFIRMED
   (2026-09-07).
3. The extensions-theory modality records, in its own commentary rather than in a
   verbatim-quote field, the further formulation attributed to Pellicer 2012: "In this sense,
   U^ch(K) does not exist for regular K". Status: CONFIRMED as recorded commentary;
   UNVERIFIABLE as a verbatim quotation from the paper (2026-09-07).
4. For a REGULAR facet K, the universal object that does exist is the regular extension U(K)
   of Schulte's earlier work, cited as [53] by Pellicer 2012 in the passage quoted above.
   Status: CONFIRMED as recorded in that passage (2026-09-07).
5. A necessary condition, Pellicer 2012, verbatim: "A necessary condition for a regular
   polytope to admit chiral extensions is orientability." Status: CONFIRMED (2026-09-07).
6. Finiteness for chiral input: Cunningham and Pellicer 2014, Theorem 1, verbatim: "Every
   finite chiral d-polytope with regular facets is itself the facet of a finite chiral
   (d+1)-polytope." Status: CONFIRMED (2026-09-06 to 2026-09-07).
7. Prescribed-regular-facet constructions that do exist: Pellicer 2010 (restrictive
   hypotheses, see 4.3) and Montero-Toledo 2024/2025 (regular cubic toroids only, see 4.8).
   Status: CONFIRMED (2026-09-06 to 2026-09-07).

What this implies for facets that are directly regular maps, which is the case at hand.

- H_0({5,3,3}) and H_0({5/2,3,3}) = H_1({3,3,5/2}) are geometrically chiral but
  combinatorially regular, on (A)'s own statement that "these polyhedra are combinatorially
  regular, and thus the groups G are their rotational subgroups", and (A) identifies the
  underlying abstract map as an orientably regular map of type {30,3} listed as R97.9. So as
  ABSTRACT polytopes the intended facets are directly regular, not chiral.
- Therefore none of the universal-extension theorems applies. Schulte-Weiss 1995 and
  Cunningham-Pellicer 2014 both require a chiral facet; Montero 2021 likewise. For a directly
  regular facet the universal chiral object is not known to exist at all (Pellicer 2012,
  Problem 24), and whether a (finite) chiral extension exists is Problem 27 (Problem 28 in the
  finite case), open as of 2012 and, per Pellicer's 2018 CMS talk abstract, still open in
  general as of 2018.
- The orientability necessary condition IS satisfied: R97.9 comes from Conder's list of
  regular ORIENTABLE maps, so the facet is orientably regular. That removes the one known
  obstruction but supplies no construction.
- Consequently, a chiral 4-polytope with these facets cannot be obtained from any published
  general theorem; it must be exhibited by hand, for instance by the Conder-Hubard-Pisanski
  method of Section 4.4 together with the Schulte-Weiss criterion of Section 4.1, which is
  what the GAP computation described in Section 8.2 does.
- The abstract question for a directly regular facet is nevertheless known to have positive
  answers in specific spherical cases: the dodecahedron {5,3} is the facet of finite chiral
  4-polytopes of types {5,3,5} and {5,3,4} by Breda D'Azevedo, Jones and Schulte, Theorems 7.1
  and 7.3; Nostrand and Schulte 1995 construct chiral 4-polytopes "whose faces are cubes or
  dodecahedra" (per Conder, Hubard and Pisanski); and Conder's 4000-flag census contains a
  chiral 4-polytope of type [4,3,5] with group of order 1320 and one of type [5,3,6] with
  group of order 1920. Status: CONFIRMED (2026-09-07). So the phenomenon "directly regular
  spherical facet, chiral 4-polytope" is established in the literature; what is missing is any
  treatment of the specific higher-genus facets R97.9 and R151.11.

---

## 6. Citations of the H_0({5,3,3}) facet claim of PETCOX p. 25

Who repeats it: nobody, in any published source located.

- The zbMATH Open review of (A) (Zbl 1475.52019, document 7402640, reviewer Rolf Schneider,
  retrieved in the clear through the zbMATH REST API on 2026-09-07 after the zbmath.org HTML
  page returned HTTP 403) covers the Petrie-Coxeter part of the paper without mentioning any
  facet claim. Verbatim: "The second part uses the Petrie-Coxeter construction and skeletal
  \(4\)-polytopes with planar faces in \({\mathscr X}\) to produce many examples of chiral
  polyhedra with helical faces in the spherical space \({\mathbb S}^3\). They are described in
  detail and illustrated by remarkable figures. ... For example: if \({\mathscr P}\) is a
  chiral polyhedron in \({\mathscr X}\) with helical faces, then it is combinatorially
  regular." The reviewer did not pick up the p. 25 remark. Status: CONFIRMED (2026-09-07).
- Hubard and Schulte 2026, the only arXiv-visible citer, cites (A) once inside a list of
  eleven references and makes no statement about facets; a string search of the extracted text
  found zero occurrences of "helical", "Roli", "chirality group", "{30", "120-cell", "sphere"
  or "facet of a chiral". Status: CONFIRMED (2026-09-07).
- Monson 2022 does not cite (A) at all, and "Petrie-Coxeter" does not occur in his paper.
  Status: CONFIRMED (2026-09-07).
- Pellicer 2021, "A chiral 5-polytope of full rank", cites (A) but its body could not be read
  (paywalled, is_oa false). Whether it repeats or uses the facet remark is UNVERIFIABLE
  (2026-09-07).
- Pellicer's 2025 monograph, Chapter 6 and Appendix C: UNVERIFIABLE (Cambridge Core HTTP 429).
  The publisher's Chapter 6 summary (quoted in 1.6) mentions neither the Petrie-Coxeter
  construction, nor helical faces, nor S^3, nor Roli's cube, nor facets; it advertises only a
  re-derivation of Schulte's E^3 chiral polyhedra and the full-rank rank-4-or-5 theorem. That
  is evidence about the summary, not about the chapter.
- Pellicer and Williams, "On infinite 2-orbit polyhedra in classes 2_0 and 2_2", Beitr.
  Algebra Geom. 65 (2024), no. 2, 241-277, DOI 10.1007/s13366-023-00686-y, Zbl 1570.52018
  (zbMATH 7881023, reviewer Geir Agnarsson): its Petrie-Coxeter content concerns the three
  classical Petrie-Coxeter polyhedra in E^3, not the PC_alpha(T) construction of (A), and
  Crossref confirms (A) is not in its 28-item reference list. Review text, verbatim: "There
  are three families in the class \(2_2\) and they are all continuous deformations of the
  three Petrie-Coxeter polyhedra. There are six families in the class \(2_0\) and these are
  Petrie duals of the chiral (non-regular with adjacent flags belonging to distinct orbits)
  polyhedra." Status: CONFIRMED (2026-09-07).
- Gévay and Schulte, "Realizations of lattice quotients of Petrie-Coxeter polyhedra", Art
  Discrete Appl. Math. 4 (2021) P3.04, the only other 2019-2026 zbMATH hit for
  "Petrie-Coxeter" besides (A) and Pellicer-Williams, concerns regular maps embedded in the
  3-torus and realized in E^5 and E^6, with no chirality and no S^3. Status: CONFIRMED
  (2026-09-07).
- The authors' own companion page for (A) states the construction and the ten cases but makes
  no 4-polytope claim. Verbatim: "As proved there: to a spherical 4-polytope and its dual,
  there corresponds a continuous family of chiral polyhedra with helicoidal faces --obtained
  as the Half 2-hole of its Petrie-Coxeter polyhedron and denoted H2H_. For each case, we
  present: -the Mathematica code -the file containing the Group of matrices with their
  corresponding words -and some images obtained from the Mathematica program." The sweep
  records that the only occurrence of the string "4-polytope" on that page is in the sentence
  describing the INPUT to the rank-3 construction. Status: CONFIRMED (2026-09-07).

Who acts on it: three items, none of them a publication.

1. The PAPIIT IN109023 final report (2023, file updated 02/07/2025) states that Trejo, with
   Hubard, classified the chiral skeletal polyhedra whose 1-skeleton lies in the graph of a
   convex regular 4-polytope, obtaining exactly four examples, and that it was determined
   which of those four extend to chiral 4-polytopes in E^4. Full quotations in Section 8.4.
   Status: CONFIRMED as report text (2026-09-07).
2. Briseida Trejo's public GitHub GAP appendix constructs a chiral 4-polytope with the exact
   invariants of the audited object. Full quotations in Section 8.2. Status: CONFIRMED as a
   public document (2026-09-07).
3. Manuscript (C), Bracho, González-Casanova and Hubard, extends the DIFFERENT facets
   H_0({5,3,5/2}) and H_1({5,3,5/2}), whose type (A) records as {12_{1,5},3} with group order
   144. So (C) acts on the same idea but not on the {5,3,3} case. Status: CONFIRMED as far as
   the cited title and the report narrative go; the manuscript itself is UNVERIFIABLE
   (2026-09-07).

Page-pointer caveat. The facet sentence is on p. 25 of the January 2021 author preprint. Its
page number in the published article (DCG 66, 1025-1052) was NOT retrieved, because Springer
returns HTTP 303 to an authentication endpoint. One extraction pass could not even recover
preprint page boundaries and recommended writing "not retrieved" for the page number; a
second pass, using a page-marked extraction, places it on preprint p. 25 and Figure 8 on
p. 26. The audit therefore cites "author preprint p. 25", with the published page number
UNVERIFIABLE (2026-09-07).

---

## 7. Atlas and list lookups

### 7.1 Hartley's Atlas of Small Regular Polytopes

Site header, verbatim: "The Atlas of Small Regular Polytopes". Coverage line, verbatim: "All
regular polytopes with n flags, for n at most 2000 (except 1024 and 1536). Feel free to
browse!" (https://www.abstract-polytopes.com/atlas/, HTTP 200, 51532 bytes). The atlas-FAQ
page states the same limit as a group-order limit: "all regular abstract polytopes whose
automorphism groups have order less than 2000", with 512 added in 2007 and 1024 and 1536
excluded. For a regular polytope the number of flags equals the automorphism group order, so
the two statements agree. Browse interface: "Polytopes by Rank" (ranks 1 to 9 with counts,
e.g. "Rank 3 ·5946 nondeg, 993 deg") and "Automorphism Groups by Size" (every even size 2 to
2000, "Multiples of 50 highlighted"); no search form. The rank-3 index says "5946 polytopes,
1257 Schläfli types". Status: CONFIRMED (2026-09-07).

Entries retrieved, verbatim fields:

| Atlas name | Group | V, E, F | Order of s0s1s2 | Order of s0s1s2s1 | Genus | Status |
| --- | --- | --- | --- | --- | --- | --- |
| {8,3}*96 | SmallGroup(96,193) | 16, 24, 6 | 12 | 8 | 2 | CONFIRMED (2026-09-07) |
| {12,3}*288 | SmallGroup(288,847) | 48, 72, 12 | 24 | 12 | 7 | CONFIRMED (2026-09-07) |
| {12,4}*384e | SmallGroup(384,18044) | 48, 96, 16 | 24 | 8 | 17 | CONFIRMED (2026-09-07) |

- {8,3}*96, https://www.abstract-polytopes.com/atlas/96/193/3.html. Verbatim: "Polytope of
  Type {8,3}. Atlas Canonical Name {8,3}*96. Group SmallGroup(96,193). Rank 3. Vertices,
  edges, ... 16, 24, 6. Order of s0 s1 s2: 12. Order of s0 s1 s2 s1: 8. Special Properties:
  Compact Hyperbolic Quotient; Locally Spherical; Orientable. Facet of: {8,3,2}·192,
  {8,3,4}·384, {8,3,6}·576, {8,3,3}·768, {8,3,4}·768, {8,3,4}·768, {8,3,6}·1728. Quotients:
  2-fold {4,3}*48; 4-fold {4,3}*24; 8-fold {2,3}*12. Finitely Presented Group Representation
  (GAP): rels := [ s0*s0, s1*s1, s2*s2, s0*s2*s0*s2, s1*s2*s1*s2*s1*s2,
  s0*s1*s0*s1*s0*s2*s1*s0*s2*s1*s0*s1*s0*s1*s2*s1,
  s0*s1*s0*s1*s0*s1*s0*s1*s0*s1*s0*s1*s0*s1*s0*s1 ];;". The type page sch8.3.html lists ten
  entries including "{8,3}*96 ·SmallGroup(96,193)". The "Also known as" field is EMPTY, so the
  atlas itself does not link this entry to a Conder map name. Euler check: 16-24+6 = -2,
  genus 2. Cross-checks: Conder's regular-polytope list has exactly one entry "Regular
  3-polytope with group of order 96 NSD Type [ 3, 8 ]" (line 114 of
  RegularPolytopesWithFewFlags-ByType.txt), and his map list exactly one map of type {3,8} of
  order 96, namely "R2.1 : Type {3,8}_12 Order 96 mV = 2 mF = 1", whose Petrie length 12
  matches the atlas datum "Order of s0 s1 s2: 12".
- {12,3}*288, https://www.abstract-polytopes.com/atlas/288/847/3.html. Verbatim: "Polytope of
  Type {12,3}. Atlas Canonical Name {12,3}*288. Group SmallGroup(288,847). Vertices, edges,
  ... 48, 72, 12. Order of s0 s1 s2: 24. Order of s0 s1 s2 s1: 12. Special Properties: Compact
  Hyperbolic Quotient; Locally Spherical; Orientable. Facet of: {12,3,2}·576, {12,3,4}·1152,
  {12,3,6}·1728. Quotients: 2-fold {6,3}*144; 3-fold {12,3}*96; 6-fold {6,3}*48; 8-fold
  {6,3}*36; 12-fold {3,3}*24; 24-fold {2,3}*12. GAP rels := [ s0*s0, s1*s1, s2*s2,
  s0*s2*s0*s2, s1*s2*s1*s2*s1*s2,
  s0*s1*s0*s2*s1*s0*s2*s1*s0*s2*s1*s0*s1*s0*s2*s1*s0*s2*s1*s0*s2*s1 ];;". The type page lists
  15 entries including "{12,3}*288 ·SmallGroup(288,847)". Euler: 48-72+12 = -12, genus 7.
  Unique in both of Conder's files: one entry "group of order 288 NSD Type [ 3, 12 ]"
  (line 198) and one map "R7.2 : Type {3,12}_24 Order 288 mV = 2 mF = 1".
- {12,4}*384e, https://www.abstract-polytopes.com/atlas/384/18044/3.html. Verbatim: "Polytope
  of Type {12,4}. Atlas Canonical Name {12,4}*384e. Group SmallGroup(384,18044). Vertices,
  edges, ... 48, 96, 16. Order of s0 s1 s2: 24. Order of s0 s1 s2 s1: 8. Special Properties:
  Compact Hyperbolic Quotient; Locally Spherical; Orientable. Facet of: {12,4,2}·768.
  Quotients: 2-fold {6,4}*192b; 4-fold {6,4}*96; 8-fold {6,4}*48a, {3,4}*48, {6,4}*48b,
  {6,4}*48c; ... GAP rels := [ s0*s0, s1*s1, s2*s2, s0*s2*s0*s2, s1*s2*s1*s2*s1*s2*s1*s2,
  s0*s1*s2*s0*s1*s2*s0*s1*s0*s1*s2*s0*s1*s2*s0*s1 ];;". The type page says "52 in this atlas"
  and lists, verbatim, "{12,4}*384a ·SmallGroup(384,1706) | {12,4}*384b ·SmallGroup(384,5567)
  | {12,4}*384c ·SmallGroup(384,5567) | {12,4}*384d ·SmallGroup(384,17873) | {12,4}*384e
  ·SmallGroup(384,18044)". Euler: 48-96+16 = -32, genus 17. The suffix letter is load-bearing:
  of the five {12,4} entries of order 384, exactly three carry the Orientable flag (384a with
  Petrie 24 and hole 4; 384d with Petrie 12 and hole 4; 384e with Petrie 24 and hole 8), and
  384b and 384c do not. Conder's genus-17 list has exactly three maps of type {4,12} of order
  384: R17.10 {4,12}_12, R17.11 {4,12}_24 with mV = 2, R17.12 {4,12}_24 with mV = 3; and his
  regular-polytope list has exactly five entries "group of order 384 NSD Type [ 4, 12 ]".
  RESIDUAL AMBIGUITY, not resolved in this session: which of R17.11 and R17.12 equals
  {12,4}*384e; both have Petrie length 24 and differ only in Conder's mV. Status of the
  ambiguity: UNVERIFIABLE (2026-09-07).

Names that do NOT exist in the atlas, because they exceed its coverage (all CONFIRMED
2026-09-07):

- No {30,3}*2880. The atlas has exactly three type-{30,3} entries, verbatim from sch30.3.html:
  "Polytopes of this Type | 3 in this atlas | {30,3}*720 ·SmallGroup(720,771) | {30,3}*900
  ·SmallGroup(900,95) | {30,3}*1500 ·SmallGroup(1500,37)". Conder's regular-polytope list
  likewise has exactly three [ 3, 30 ] entries, of orders 720, 900 and 1500. So the facet of
  the audited polytope has NO Hartley-atlas name, and the write-up should not print
  "{30,3}*2880"; the correct primary identifier is Conder's map label.
- No {20,5}*2400. The atlas has only {20,5}*480, *640a, *640b, *1200, *1280, *1600; Conder's
  regular-polytope list has exactly six [ 5, 20 ] entries of orders 480, 640, 640, 1200, 1280,
  1600.
- No {15,5}*14400. Verbatim from sch15.5.html: "1 in this atlas | {15,5}*600
  ·SmallGroup(600,146)"; Conder's list has exactly one [ 5, 15 ] entry, of order 600.

This is consistent with (A) itself, which gives Hartley-atlas names only for the three cases
with group orders 96, 288 and 384 and switches to Conder's map list for the 2880 and 2400
cases. Status: CONFIRMED (2026-09-07).

### 7.2 Conder's list of regular orientable maps

Correct URL: https://www.math.auckland.ac.nz/~conder/RegularOrientableMaps301.txt
(HTTP 200, 3874162 bytes). The URL with the words transposed,
https://www.math.auckland.ac.nz/~conder/OrientableRegularMaps301.txt, returns HTTP 404, and
so do OrientableRegularMaps101.txt and OrientableRegularMaps501.txt; the genus-101
predecessor is RegularOrientableMaps101.txt (HTTP 200, 737526 bytes). The correct name was
recovered from the anchor text on Conder's own homepage, verbatim: "all regular orientable
maps on surfaces of genus 2 to 301, up to isomorphism and duality, with defining relations
for their automorphism groups". Provenance point: the dead URL is the one printed in (A)'s own
bibliography, reference [6]. Status: CORRECTED (2026-09-07).

Header, verbatim: "Regular orientable maps of genus 2 to 301 ... Below is a list of all fully
regular (rotary and reflexible) maps on on orientable surfaces of genus 2 to 301, up to
isomorphism and duality. The notation \"Rg.n\" is used for the nth regular orientable map of
genus g. ... Total number of maps in list below: 15824 ... Marston Conder August 2012" (one
pass also records a correction date of 18 February 2013). The highest genus header present in
the file is "Genus 301". Status: CONFIRMED (2026-09-07).

Entry R97.9, file line 12683, verbatim:

> R97.9 :  Type {3,30}_20  Order 2880  mV = 2  mF = 1
> Defining relations for automorphism group:
> [ T^2, R^-3, (R * S)^2, (R * T)^2, (S * T)^2, S * R * S^-2 * R * S^-2 * R * S^-1 * R * S^-2 * R * S^2 * R^-1 * S^2, S * R * S^-3 * R^-1 * S^5 * R^-1 * S^-3 * R * S^6 ]

Reading. Conder prints p as the face size and q as the valency, and the list is explicitly
"up to isomorphism and duality". As printed, R97.9 has 48 vertices, 720 edges and 480
triangular faces; the type-{30,3} map with 480 vertices, 720 edges and 48 faces is its dual,
with the same name, the same genus 97 and the same group order 2880. Arithmetic check: order
2880 = 4E gives E = 720; type {3,30} gives F = 2E/3 = 480 and V = 2E/30 = 48; 48-720+480 =
-192 = 2-2g, so g = 97. Petrie polygon length 20 (the subscript in {3,30}_20). Status:
CORRECTED (2026-09-07): the numbers (480, 720, 48, 2880, 97) are right, but they are the dual
reading; the write-up should say "the dual of Conder's R97.9" or "R97.9, listed as
{3,30}_20", not "R97.9 has type {30,3}". (A) makes the same elision on its p. 29.

Entry R151.11, file line 24071, verbatim:

> R151.11 :  Type {5,20}_60  Order 2400  mV = 2  mF = 1
> Defining relations for automorphism group:
> [ R^5, T^2, (R * S)^2, (R * T)^2, (S * T)^2, S^-1 * R^-1 * S^2 * R^2 * S^2 * R^-1 * S^-1 ]

Reading. As printed: 60 vertices, 600 edges, 240 pentagonal faces; the type-{20,5} map with
240 vertices, 600 edges and 60 faces is its dual. Arithmetic: 2400 = 4E gives E = 600; {5,20}
gives F = 240 and V = 60; 60-600+240 = -300 = 2-2g, so g = 151. Petrie length 60. Status:
CORRECTED (2026-09-07), same dual-reading point. Note also that (A) p. 29 prints this label
with a stray period, as "R.151.11".

Uniqueness of these identifications: NOT forced by type and order alone. Verbatim from the
same file:

> R97.10 :  Type {3,30}_40  Order 2880  mV = 2  mF = 1
> Defining relations: [ T^2, R^-3, (R * S)^2, (R * T)^2, (S * T)^2, (S^-2 * R * S^-1)^3 ]
> (file line 12687)

> R151.10 :  Type {5,20}_12  Order 2400  mV = 4  mF = 1
> (file line 24067)

A grep of the whole genus 2 to 301 file finds exactly these two sibling pairs. So each of
R97.9 and R151.11 has exactly one sibling of the same type and the same group order,
distinguished only by Petrie polygon length (20 versus 40; 60 versus 12). Status: REFUTED
(2026-09-07) for the claim that the identifications are forced. Concrete discriminator for
the write-up: exhibit the Petrie polygon length of the facet, equivalently the order of
s0s1s2 or of RS in Conder's generators; length 20 gives R97.9 and length 40 gives R97.10, and
for the {20,5} facet length 60 gives R151.11 and length 12 gives R151.10. Neither (A) nor the
claim as put to the verification pass records the Petrie length. This is the single most
attackable point in the map identifications, and it is directly contradicted by the Trejo GAP
appendix, which concludes R97.10 (Section 10.15).

No Conder name exists for the {15,5} map with 1440 vertices, 3600 edges, 480 faces, group
order 14400 and genus 841. Coverage limits, verbatim where quoted (all CONFIRMED 2026-09-07):

- RegularOrientableMaps301.txt covers genus 2 to 301; genus 841 is out of range by a factor of
  about 2.8, so no label R841.x can exist in the public files.
- Searches inside that file: "Type {15,5}" and "Type {5,15}" give only two hits, "R36.8 : Type
  {5,15}_10 Order 600" and "R127.12 : Type {5,15}_10 Order 2160", neither of order 14400;
  "Order 14400" gives three hits, all genus 301 and of other types (R301.2 {3,12}_60, R301.4
  {4,6}_10, R301.5 {4,6}_12).
- RegularMapsWithUpTo1000Edges.txt covers "all (fully) regular maps (on closed surfaces)
  having at most 1000 edges"; the map in question has 3600 edges.
- OrientablyRegularMaps-RotationGroupsUpToOrder400.txt covers rotation group order at most
  400; the rotation group here has order 7200.
- RegularMapsOfSmallCharacteristic-ByType.txt (April 2022): the highest genus appearing in it
  is 202, and searches for "{15,5}" and for "841" returned nothing; the map has Euler
  characteristic -1680.
- Internal consistency check of the audited row: 3600 edges of type {15,5} give F = 2E/15 =
  480, V = 2E/5 = 1440, |Aut| = 4E = 14400, and 1440-3600+480 = -1680 = 2-2g, so g = 841.

This matches (A), which gives Conder labels only for the four T whose rotation groups have
order 1440 or 1200 and gives no label for the two T with rotation group of order 7200.

### 7.3 Conder's chiral-polytope lists

Two generations of file exist (all CONFIRMED 2026-09-07):

1. ChiralPolytopesWithFewFlags-ByType.txt and -ByOrder.txt, linked from Conder's homepage as
   "all chiral polytopes with up to 2000 flags, up to isomorphism, reflection and duality"
   (199244 bytes for the ByType file). Header, verbatim: "Chiral polytopes with up to 2000
   flags (ordered by type for each rank) ... Below is a complete list of all abstract chiral
   polytopes (with maximum symmetry) up to 2000 flags, up to isomorphism, reflection and
   duality. Note that the automorphism group of each such polytope has two orbits on flags,
   with any two adjacent flags lying in different orbits. Hence the number of flags is twice
   the order of the automorphism group. ... This list was created by finding and analysing all
   normal subgroups of index up to 1000 in the relevant Coxeter groups, with the help of the
   MAGMA system. ... Marston Conder September 2012". Also verbatim: "Note that up to
   isomorphism, reflection and duality there is just one chiral 5-polytope with at most 2000
   flags (namely an ISD 5-polytope of type [3,4,4,3]), and there are none of rank 6 or more."
   The rank-4 section runs from line 2254 to line 2583; one pass counts 108 rank-4 entries and
   44 distinct rank-4 types; the largest group order occurring anywhere in the file is 1000.
2. ChiralPolytopesWithUpTo4000Flags-ByType.txt and -ByOrder.txt, live but NOT linked from
   Conder's homepage (791468 bytes for the ByType file). Header, verbatim: "Below is a complete
   list of all abstract chiral polytopes (with maximum symmetry) up to 4000 flags, up to
   isomorphism, reflection and duality. ... This list was created by finding and analysing all
   normal subgroups of index up to 2000 in the relevant Coxeter groups, with the help of the
   MAGMA system. Note that up to isomorphism, reflection and duality there are just three
   chiral 5-polytopes with at most 4000 flags, and there are none of rank 6 or more." Rank-4
   section lines 7625 to 8853, 406 entries, 124 distinct rank-4 types; largest group order
   occurring is 2000. Probes for ...UpTo6000/8000/10000/16000/20000Flags-ByType.txt all
   returned HTTP 404, so 4000 flags (group order 2000) is the largest published coverage as of
   2026-09-07.

Entries retrieved that bear on the audited question, verbatim:

- "Chiral 4-polytope with group of order 192   NSD  Type [ 3, 3, 8 ]  [ A.1^3, A.2^3,
  (A.1^-1 * A.2^-1)^2, (A.2^-1 * A.3^-1)^2, A.3^-1 * A.2 * A.1^-1 * A.3 * A.1, A.3^-1 * A.1 *
  A.3 * A.2^-1 * A.1 * A.3^-2 * A.2 ]"
- "Chiral 4-polytope with group of order 768   NSD  Type [ 3, 3, 8 ]  [ A.1^3, A.2^3, A.3^8,
  (A.1^-1 * A.2^-1)^2, (A.2^-1 * A.3^-1)^2, A.3^-1 * A.2 * A.1^-1 * A.3 * A.1, (A.3 * A.1^-1 *
  A.3)^3 ]"
- "Chiral 4-polytope with group of order 1320   NSD  Type [ 4, 3, 5 ]  [ A.1^4, A.2^3, A.3^5,
  (A.1^-1 * A.2^-1)^2, (A.2^-1 * A.3^-1)^2, A.3^-1 * A.2 * A.1^-1 * A.3 * A.1, A.2^-1 * A.1 *
  A.3 * A.2 * A.1^-2 * A.3 * A.2^-1 * A.1 * A.3 ]"
- "Chiral 4-polytope with group of order 1920   NSD  Type [ 5, 3, 6 ]  [ A.1^5, A.2^3, A.3^6,
  (A.1^-1 * A.2^-1)^2, (A.2^-1 * A.3^-1)^2, A.3^-1 * A.2 * A.1^-1 * A.3 * A.1, (A.1^-1 *
  A.3^-2)^3 ]"

Type counts recorded from the 4000-flag file: [3,3,8] twice; [6,3,8] ten times (orders 384,
384, 1152, 1152, 1344, 1536 five times); [8,3,12] three times (768, 768, 1536); [3,3,12] once
(1440); [4,3,12] three times (1152, 1536, 1536); [6,3,12] twice (1344, 1728); [3,4,12] eight
times; [4,4,12] nine times; [6,4,12] four times; [4,3,5] once (1320); [5,3,6] once (1920);
[3,5,10] twice (1320).

Negative searches inside both files, all CONFIRMED (2026-09-07): the substring "30,3,3" gives
no hits; "14400" gives no hits; enumerating every distinct rank-4 "Type [ ... ]" string (44
types in the 2000-flag file, 124 in the 4000-flag file) shows that neither [ 30, 3, 3 ] nor
its dual [ 3, 3, 30 ] appears, and the only rank-4 type containing 30 in the larger file is
[ 9, 6, 30 ]. Absent as well: [12,3,5] and [5,3,12]; [20,5,q] and [q,5,20]; [q,3,5] with q
other than 4; [5,3,q] with q other than 6. Largest rank-4 group orders present are 1920 and
2000.

Coverage caveat that must accompany any use of these negatives. The audited polytope has
automorphism group of order 7200, hence 14400 flags, 3.6 times the largest published list.
Moreover, by Conder's own flag inequality a chiral 4-polytope with facet R97.9 (2880 flags)
would need at least 2880·3 = 8640 flags, and with facet R151.11 (2400 flags) at least
2400·3 = 7200 flags. So its absence from these catalogues is a statement about coverage, NOT
independent evidence of novelty. What the lists DO establish is that the audited polytope is
not one of the roughly 514 catalogued chiral 4-polytopes.

### 7.4 The chiral atlases of Hartley, Hubard and Leemans, and of Leemans

- https://www.abstract-polytopes.com/chiral/ , coverage verbatim: "This atlas contains
  information about all chiral polytopes whose regular covers have automorphism group of order
  at most 2000, and not 1024 or 1536".
- Rank-4 index https://www.abstract-polytopes.com/chiral/r4 , verbatim: "8 polytopes in all,
  with 8 different Schlafli types: {3,3,8} (1 polytope), {3,6,9}, {3,6,18}, {6,6,9}, {8,3,3},
  {9,6,3}, {9,6,6}, {18,6,3}". Note that the path /chiral/sch8.3.3.html is 404; the entry
  lives under /chiral/r4/.
- {8,3,3} page https://www.abstract-polytopes.com/chiral/r4/sch8.3.3.html , verbatim: "There
  is 1 polytope of this type in this atlas. Its regular cover is : {8,3,3}*768b with
  automorphism group SmallGroup(768,1086052) = ((Q8 x C2) ⋊ C2) ⋊ S4".
- No entry in the rank-4 chiral atlas has facets {5,3}, {12,3}, {12,4}, {30,3} or {20,5}.
- Leemans' Atlas of Chiral Polytopes, https://leemans.dimitri.web.ulb.be/CHIRAL/index.html ,
  coverage verbatim: "This Atlas contains all chiral polytopes whose automorphism group is an
  almost simple group G such that S <= G <= Aut(S) and S is a simple group of order less than
  1 million appearing in the Atlas of Finite Groups by Conway et al." A group of order 7200 is
  not almost simple and no group of order 7200 appears there. One earlier pass records that
  the older URL http://math.auckland.ac.nz/~dleemans/CHIRAL/ was not fetched.

Status of all of 7.4: CONFIRMED (2026-09-07), except the unfetched older Leemans URL, which is
UNVERIFIABLE.

### 7.5 One local computation, flagged as not-literature

One modality ran its own GAP computation (GAP 4.14.0 bundled with Sage 10.7, script check.g)
over Conder's 4000-flag census, building each listed group from the printed relations,
verifying that the computed order matches the listed order in all 44 tests, and testing the
relevant rank-2 section for a generator-preserving isomorphism onto the rotation subgroup of
the corresponding Hartley-atlas presentation. Reported findings, verbatim excerpts: "type
[3, 3, 8] listed order 192 computed |G|=192 facets=16 vertices=4 section(vf) order 48 map-iso
to m83: true"; "type [4, 3, 12] listed order 1152 computed |G|=1152 facets=48 vertices=8
section(vf) order 144 map-iso to m123: true"; "type [4, 3, 5] listed order 1320 computed
|G|=1320 facets=55 vertices=22 section(vf) order 60 map-iso to A5: true"; "type [5, 3, 6]
listed order 1920 computed |G|=1920 facets=32 vertices=20 section(facet) order 60 map-iso to
A5: true". Summary as reported: within 4000 flags there are chiral 4-polytopes with facets
{8,3}*96 of types {8,3,3} (order 192; 4 facets, 16 vertices), {8,3,6} (eight entries) and
{8,3,12} (two entries); with facets {12,3}*288 exactly one, of type {12,3,4} (order 1152);
with facets {12,4}*384e three, of types {12,4,3} (order 1152) and {12,4,4} (orders 960 and
1920); and with dodecahedral facets two, of types {5,3,4} (order 1320) and {5,3,6} (order
1920). Identification of the order-192 entry with Roli's cube itself was NOT verified against
(B).

Status: this is a session computation, not a literature statement. Treat as UNVERIFIABLE for
citation purposes and re-derive before relying on it.

---

## 8. Novelty assessment for a chiral 4-polytope of type {30,3,3} with facets H_0({5,3,3}) and H_0({5/2,3,3})

The object under assessment, as stated to the verification passes: a chiral 4-polytope of
type {30,3,3} with cells H_0({5,3,3}) (type {30/(1,11),3}) and H_0({5/2,3,3}) =
H_1({3,3,5/2}) (type {30/(7,13),3}), f-vector (600, 1200, 120, 5), tetrahedral
vertex-figures, rotation group [3,3,5]^+ of order 7200, chirality group SL(2,5), and two
realisations in E^4 on the 600 vertices of the 120-cell and of the great grand stellated
120-cell.

### 8.1 Exactly what was searched

Bibliographic and citation indexes: arXiv API (metadata and, where a PDF or e-print source
was available, full text); zbMATH Open REST API (title, free-text, reverse-citation rf: and
cited-in ci: queries); Crossref REST API (records and reference-list scans); OpenAlex;
OpenCitations Index v1 and v2; Semantic Scholar Graph API (records, citations, reference
lists); Dimensions metrics API; DBLP; Google Scholar (clusters and phrase queries; later
attempts blocked); Unpaywall.

Catalogues and lists: Hartley's Atlas of Small Regular Polytopes (type pages sch8.3, sch12.3,
sch12.4, sch30.3, sch20.5, sch15.5, plus the group and detail pages retrieved); the Atlas of
Small Chiral Polytopes with small regular covers (index, rank-4 index, {8,3,3} page); Leemans'
Atlas of Chiral Polytopes; Conder's RegularOrientableMaps301.txt and
RegularOrientableMaps101.txt, RegularMapsWithUpTo1000Edges.txt,
OrientablyRegularMaps-RotationGroupsUpToOrder400.txt,
RegularMapsOfSmallCharacteristic-ByType.txt, RegularPolytopesWithFewFlags-ByType.txt,
ChiralPolytopesWithFewFlags-By{Type,Order}.txt and
ChiralPolytopesWithUpTo4000Flags-By{Type,Order}.txt.

Author and institutional sites: Bracho's directory tree at matem.unam.mx/~roli (open Apache
listings for /investigacion/, /articulos/, /programs/, /programs/PetrieCoxeter/ and
/PetrieCoxeter/grupos/), his publication lists articulos.html and articulos-V.html, and the
ten Galeria_*.html gallery pages plus the ten GrupoH2H_* matrix-group files; Isabel Hubard's
research and students pages; the DGAPA-UNAM PAPIIT transparency portal; repositorio.unam.mx
and ru.dgb.unam.mx (DSpace API); TESIUNAM; UNAM seminar, colloquium and video pages; the 10th
Slovenian Conference on Graph Theory 2023 book of abstracts (via the Internet Archive);
GitHub repository search.

Surveys and handbooks: Schulte's Chapter 18 "Symmetry of polytopes and polyhedra" of the
Handbook of Discrete and Computational Geometry, 3rd ed. (preliminary version at
csun.edu, full text extracted); Schulte-Weiss 2017; Cunningham-Pellicer 2018;
Pellicer 2012; Hubard-Schulte 2026; Conder's and Schulte's Fields Institute slides.

Targeted string and phrase searches: the Schläfli type "{30,3,3}"; the facet types
"{30/(1,11),3}" and "{30/(7,13),3}"; "H_0({5,3,3})" and "H0({5,3,3})"; "R97.9" and
"{30,3}*2880"; the f-vector and the 5-facet condition; "chiral 120-fold cover of {3,3,3}";
"chirality group" together with SL(2,5) and the binary icosahedral group; "Two new chiral
4-polytopes of full rank"; "A family of skeletal chiral 3- and 4-polytopes in R^4";
"González-Casanova"; "Trejo"; "skeletal chiral"; "full rank" with polytope terms.

### 8.2 What was found: prior art that already exists in public

No published construction was located in the sources searched. The sources searched are those
enumerated in Section 8.1, and the specific negative outcomes are listed in Section 9.

What IS already public, and must not be presented as new:

1. The two cell types, their group orders and their identification as one abstract map are
   published in (A) itself. (A)'s summary table (author preprint p. 28) gives
   H_alpha({5,3,3}) of type {30_{1,11},3} with #(G) = 1440 and index [G:Γ+] = 5, and
   H_alpha({3,3,5/2}) of type {30_{7,13},3} with the same invariants, together with the
   collapse data (1,4) and (4,1) that make H_0({5,3,3}) and H_1({3,3,5/2}) = H_0({5/2,3,3})
   genuine polyhedra; and p. 29 states verbatim that "the regular polyhedra arising from
   T = {5, 3, 3} and T = {3, 3, 5/2} are isomorphic of type {30, 3} and are listed as R97.9".
   Status: CONFIRMED (2026-09-07). Note that the index 5 relative to Γ+({5,3,3}) of order 7200
   is also (A)'s datum, so the arithmetic 1440·5 = 7200 is prior art too.
2. The cell types are published on the authors' companion website, with downloadable matrix
   groups, since 2021. Gallery page headings, verbatim: Galeria_5-3-3.html reads "H2H{5,3,3}"
   followed by "Of type {30/(1,11)}" and "(Created: December, 2020)" (the trailing "3" of the
   pair is omitted on this page, unlike its siblings); Galeria_3-3-52.html reads
   "H2H{3,3,5/2}" followed by "Of type {30/(7,13),3}" and "(Created: December, 2020)". The
   complete set of ten declared types, verbatim as retrieved from the ten gallery pages, with
   Bracho's own bracket typos reproduced: H2H{3,3,3} "{5/(1,2),3}"; H2H{3,4,3} "{12/(1,5),4}";
   H2H{4,3,3} "{8/(1,3),3}"; H2H{5,3,3} "{30/(1,11)}"; H2H{3,5,5/2} "{(20/1,9),5}";
   H2H{5,5/2,5} "of type {(15/(1,4),5/2),}."; H2H{5,3,5/2} "{(12/1,5),3}"; H2H{3,3,5/2}
   "{30/(7,13),3}"; H2H{3,5/2,5} "{20/(3,7),5/2}"; H2H{5/2,5,5/2} "{15/(2,7),5}". Status:
   CONFIRMED (2026-09-07).
3. The matrix groups of the two cells are public data. GrupoH2H_5-3-3 (280752 bytes) parses as
   two top-level lists of 1440 entries each (1440 matrices and 1440 words), confirming that
   the rotation group of H_0({5,3,3}) has order 1440; GrupoH2H_3-3-52 (513439 bytes) has four
   blocks of sizes 1440, 1440, 480, 720. For comparison GrupoH2H_3-3-3 gives [60,60],
   GrupoH2H_4-3-3 gives [48,48] and GrupoH2H_5-3-52 gives [144,144,48,72]. The files are
   Mathematica lists of 4-by-4 matrices over the golden field, written with \[Rho] for the
   golden ratio; the opening of GrupoH2H_5-3-3 reads verbatim "{{{{1, 0, 0, 0}, {0, 1, 0, 0},
   {0, 0, 1, 0}, {0, 0, 0, 1}}, {{1, 0, 0, 0}, {0, \[Rho]/2, -1/2, -1/2 + \[Rho]/2}, {0,
   -1/2, 1/2 - \[Rho]/2, \[Rho]/2}, {0, 1/2 - \[Rho]/2, -\[Rho]/2, -1/2}}, ...". Status:
   CONFIRMED (2026-09-07).
4. A public GitHub document already constructs a chiral 4-polytope with exactly the audited
   invariants. Briseida Trejo's repository briseida/TesisDoctorado contains
   calculos-gap-github.pdf, the GAP-computations appendix of her doctoral thesis "Chiral
   polyhedra contained in the skeletons of convex regular 4-polytopes" (repository created
   2024-04-07, first commit 2025-07-03, the 4-polytope computations added in the commit of
   2025-11-23). Section "A.5.5 Searching S3 in the 120-cell" works with the 120-cell
   reflection matrices over the golden field and reports, verbatim: "gap> rho :=
   (1+Sqrt(5))/2;; #Razon dorada." ... "gap> v :=[1+rho,1,-2+rho,0];; #Vertice base." ...
   "gap> S1 := r0*r1*r2*r3;;" ... "gap> S2p := r3*r2*r1*r2;;" ... "gap> candS3(S1,S2,GS3,P);
   [ x3*x4 ]" ... "gap> S3 := r2*r3;;"; the intersection property as "gap>
   Intersection(Group(S1,S2),Group(S2,S3))=Group(S2); true"; and the group data "gap> Size(G);
   7200 gap> Size(Group(S2,S3)); 12 gap> Size(Group(S3,S1*S2)); 6 gap> Size(Group(S1,S2*S3));
   60 gap> Size(Group(S1,S2)); 1440". Its conclusion, verbatim: "Therefore, the 4-polytope
   found has 600 vertices, 1200 edges, 120 faces, and 5 cells." That sentence appears twice,
   once for each of two choices of S2 and S3 (S3 = r2*r3 and S3 = r3*r2). Sibling sections
   report, verbatim, "16 vertices, 32 edges, 12 faces, and 4 cells" for the 8-cell and 24-cell
   (A.5.2, A.5.3; that is Roli's cube) and "120 vertices, 720 edges, 300 faces, and 50 cells"
   for the 600-cell (A.5.4; that matches the objects of manuscript (C)). Status: CONFIRMED as
   a public document with those contents (2026-09-07).

   What the appendix does NOT contain, as recorded: it does not use the label "{30,3,3}", does
   not compute a chirality group, and works only with the convex 120-cell, with no
   star-polytope or great grand stellated 120-cell realisation. And it disagrees with (A) on
   the map identification: on p. 10 it identifies the {30,3} cell map as Conder R97.10, of type
   {3,30}_40, NOT R97.9 of type {3,30}_20, on the ground that the three order-1440 subgroups of
   R97.9's group are not isomorphic to the polyhedron's group whereas R97.10's unique
   order-1440 subgroup is. The verbatim quotation of that passage reached this report
   TRUNCATED ("Group of the first type polyhedron {30,3} which appears in [3] listed as ...").
   Status: the R97.10 conclusion is CONFIRMED as the appendix's stated conclusion; the full
   wording of the passage is UNVERIFIABLE; and the conflict with (A) p. 29 is unresolved.

   Note also that a GitHub repository search for "chiral 4-polytope" returned exactly two
   repositories, briseida/TesisDoctorado and danimalabares/tesina. Status: CONFIRMED
   (2026-09-07).

5. What is NOT anywhere in the retrievable published record: the rank-4 polytope itself as a
   published construction, its f-vector, its 5 cells, the tetrahedral vertex-figures, the
   identification of its rotation group with [3,3,5]^+, its chirality group, the label
   {30,3,3}, and the two E^4 realisations. Every retrieved discussion of finite chiral
   4-polytopes in E^4 in the window 2014 to 2026 names exactly one object, Roli's cube of type
   {8,3,3}, and Cunningham-Pellicer Problem 20 remains the standing open problem, listing only
   (B).

### 8.3 The novelty statement, in the required wording

No published construction was located in the sources searched of a chiral 4-polytope in E^4
or S^3 with facets H_0({5,3,3}) or H_0({5/2,3,3}), nor of an abstract chiral 4-polytope of
type {30,3,3} with rotation group of order 7200 and f-vector (600, 1200, 120, 5). The sources
searched are: arXiv (API metadata and full text where obtainable); zbMATH Open; Crossref;
OpenAlex; OpenCitations; Semantic Scholar; Dimensions; DBLP; Google Scholar; Unpaywall;
Hartley's Atlas of Small Regular Polytopes; the Atlas of Small Chiral Polytopes with small
regular covers; Leemans' Atlas of Chiral Polytopes; Conder's regular-map, regular-polytope
and chiral-polytope files listed in Section 8.1; the citation graphs of both
Bracho-Hubard-Pellicer papers; Schulte's Handbook chapter 18; the author and institutional
sites listed in Section 8.1; and the targeted phrase searches listed there.

Absence from those sources is not evidence that no such construction exists. Three specific
reasons are on record: (i) the coverage limits of every catalogue consulted fall well below
the group order 7200 and the facet flag counts 2880 and 2400 (Sections 7.1, 7.2, 7.3, 7.4);
(ii) the two most likely published locations, Chapter 6 and Appendix C of Pellicer's 2025
monograph, could not be read at all; (iii) two unpublished manuscripts aimed at exactly this
territory exist and could not be read either, and one doctoral thesis appendix already
computes the object in public (Section 8.2, item 4).

### 8.4 Possible prior art: the two unpublished items

#### 8.4.1 Bracho, González-Casanova and Hubard, "Two new chiral 4-polytopes of full rank"

Everything known:

- Bibliographic trace: exactly one, reference [1] of arXiv:2604.00185v1. Verified in the
  e-print LaTeX source, bibitem 1, key BG-CH2027, verbatim: "J.~Bracho, D.~Gonz\'alez-Casanova,
  I.~Hubard. Two new chiral 4-polytopes of full rank. \textit{In preparation}." No year, no
  arXiv id, no DOI, so nothing beyond title and authors is verifiable. Status: CONFIRMED
  (2026-09-07).
- Narrative description, PAPIIT IN109023 final report, verbatim: "el estudiante González
  Casanova trabajó con la Dra. Hubard y el Dr. Bracho en construir un par de nuevos
  4-politpos quirales en el espacio de 4 dimensiones. Para esto, estudió a profundidad algunos
  4-politopos estrellados regulares de dicho espacio y les aplicó una serie de operaciones para
  obtener poliedros quirales. Después, logró encontrar isometrías que lo han ayudado a extender
  los poliedros a 4-politopos quirales. Así, se encuentra escribiendo sus resultados para poder
  titularse de la maestría a la brevedad." Status: CONFIRMED (2026-09-07).
- Associated thesis, same report, human-resources section, verbatim: "Nombre DANIEL GONZALEZ
  CASANOVA AZUELA / Título de la tesis Dos 4-politops quirales de rango [title truncated in
  the PDF] / Director de la tesis JAVIER BRACHO CARPIZO / Nivel Maestría". Status: CONFIRMED
  (2026-09-07); the truncated title is UNVERIFIABLE.
- Associated talk: IMUNAM Seminario de Becarios, "Politopos estrellados", 3 May 2023,
  https://videos.matem.unam.mx/todos-los-videos/2023/mayo-2023/seminario-de-becarios-mayo-2023/politopos-estrellados
  Status: CONFIRMED as a listed talk (2026-09-06 to 2026-09-07).
- Content as understood in the audit inputs: types {12/(1,5),3,5} and {12/(1,5),3,5/2} with
  facets H_1({5,3,5/2}) and H_0({5,3,5/2}). This is consistent with (A)'s table, which gives
  H_alpha({5,3,5/2}) type {12_{1,5},3} with #(G) = 144 and collapses (1,1), that is, a
  polyhedron at both alpha = 0 and alpha = 1. It is also consistent with the Trejo appendix's
  600-cell section reporting 120 vertices, 720 edges, 300 faces and 50 cells. Status: the
  consistency is CONFIRMED; the manuscript's actual content is UNVERIFIABLE (2026-09-07).
- Availability: not on arXiv (queries all:"chiral 4-polytopes" AND all:"full rank" gave 0;
  all:"González-Casanova" and all:"Gonzalez-Casanova" gave 6 to 11 hits, all unrelated
  subjects and authors; ti:"chiral 4-polytopes of full rank" gave 0). Not on Hubard's research
  page (36 journal papers, 2 book chapters, 2 conference abstracts listed; no entry with
  González-Casanova). Not on Bracho's file server, whose /investigacion/articulos/ directory
  holds 40-plus PDFs all last modified 2021-04-07 or earlier, of which the only
  chiral-polytope items are AfiniteChiral.pdf and PetrieCoxeterFinal2.pdf. Not in
  repositorio.unam.mx: a search for "González Casanova Azuela" returns exactly one record,
  "Las simetrías de las teselaciones en el plano", 2021, licenciatura (handle
  TES01000819758); the master's thesis is not deposited. A SIIA record id 808668 returned
  "TESIS NO ENCONTRADA"; the TESIUNAM Aleph OPAC returned HTTP 404. Bracho's own publication
  lists articulos.html and articulos-V.html stop at 2021, list (A) as "En prensa, 2020", and
  their only "Preprint." entries are unrelated matroid and convexity papers. Status: CONFIRMED
  as searched and not found (2026-09-07); note that non-deposit is not proof of non-existence,
  and a thesis can be defended without prompt deposit.

Why this is NOT the most likely overlap: on every retrieved description it targets the starry
cases with facets H_alpha({5,3,5/2}) of type {12/(1,5),3} and group order 144, and the
resulting types recorded in the audit inputs are {12/(1,5),3,5} and {12/(1,5),3,5/2}, not
{30,3,3}.

#### 8.4.2 Hubard and Trejo, "A family of skeletal chiral 3- and 4-polytopes in R^4"

Everything known:

- Bibliographic trace: reference [31] of arXiv:2604.00185v1, verified in the e-print source,
  bibitem 31, key HT2026+, verbatim: "I.~Hubard and B.~Trejo, A family of skeletal chiral $3$-
  and $4$-polytopes in $\mathbb{R}^4$. \textit{Preprint}". Still labelled "Preprint", not
  published, as of 31 March 2026; no year, arXiv id or DOI. Cited in the body only inside the
  undifferentiated list quoted in Section 2. Status: CONFIRMED (2026-09-07).
- Matching PhD project: Hubard's students page lists, in progress, "Briseida Trejo, 'Chiral
  polytopes in Euclidian 4-space,' Posgrado en Ciencias Matemáticas, UNAM". Status: CONFIRMED
  (2026-09-07).
- Public conference abstract, 10th Slovenian Conference on Graph Theory, Kranjska Gora, 18 to
  24 June 2023, minisymposium "Symmetries of Graphs and Related Structures" (organised by
  Hubard and Šparl), book of abstracts p. 151, retrieved through the Internet Archive because
  the live sicgt.si copy now 404s. Verbatim, with inter-word spaces restored where the
  extractor dropped them and nothing else reconstructed: "A family of chiral polyhedra with
  helical faces in R^4. / Briseida Trejo Escamilla, btbrisi15@gmail.com / National Autonomous
  University of Mexico (UNAM), Mexico / Coauthor: Isabel Hubard / Chiral geometric polyhedra
  have been little studied. In R^3 there aren't finite chiral polyhedra, but there are three
  infinite families (which was proved by Egon Schulte). There are few examples of chiral
  geometric polyhedra in other spaces. / In this talk, we will classify the chiral polyhedra
  with helical faces whose skeleton is contained in the skeleton of the regular convex
  4-polytopes in R^4." The same page also carries "A Wythoff's type construction for chiral
  polyhedra", Ernesto Alejandro Vázquez Navarro, with coauthors Briseida Trejo Escamilla and
  Isabel Hubard, also rank 3. Hubard appears in the author index only at p. 151. Status:
  CONFIRMED (2026-09-07). The abstract's "three infinite families" is reported as written; (A)
  and the Pellicer-Williams review speak of six families of chiral polyhedra in E^3.
- Project report evidence that the rank-4 half exists, PAPIIT IN109023, verbatim: "El
  resultado anterior fue utilizado para atacar otro de los problemas que se planteó en el
  proyecto: clasificar los poliedros esqueléticos quirales cuyo 1-esqueleto está contenido en
  la gráfica de un 4-politopo convexo regular. La estudiante Trejo, con apoyo de la Dra.
  Hubard, logró dar dicha clasificación, obteniendo únicamente 4 ejemplos. Por otra parte, la
  tesis de doctorado de Briseida Trejo está lista para ser enviada a sinodales, con el objetivo
  que obtenga el grado en los siguientes meses." And, verbatim: "Cabe mencionar que una de las
  metas del proyecto fue la de usar los poliedros esqueléticos quirales cuyo 1-esqueleto está
  contenido en la gráfica de un 4-politopo convexo regular para construir 4-politopos quirales
  en el espacio euclidiano de 4 dimensiones. Este trabajo tuvo buenos resultados: de los 4
  poliedros quirales que existen cuyo 1-esqueleto está contenido en la gráfica de un
  4-politopo convexo regular, se determinaron cuáles de ellos se pueden extender. En estos
  momentos nos encontramos terminando de escribir los resultados de esto, en conjunto con los
  que estarán incluidos en la tesis de Briseida Trejo, para un artículo de investigación que se
  someterá a publicación próximamente." Status: CONFIRMED (2026-09-07). The report does NOT
  say which of the four extend, and gives no Schläfli type, group order, f-vector or chirality
  group.
- The GAP appendix of Trejo's thesis, described in Section 8.2 item 4, is the public
  computational trace of exactly this programme, and it constructs the audited object twice.
- Availability of the preprint and thesis: no copy of the preprint was found anywhere
  (searches for its exact title and for "Hubard Trejo 'family of skeletal chiral' polytopes
  R^4 preprint" returned nothing; arXiv au:"Trejo" AND all:polytope gave 0; all:"skeletal
  chiral" gave 0). Trejo's doctoral thesis is NOT deposited: repositorio.unam.mx returns
  exactly one record for "Trejo Escamilla, Briseida", namely the master's thesis (recorded
  there as "Panales quirales", 2018, handle TES01000782306), with no doctoral thesis. Status:
  REFUTED for the claim that these documents are publicly available; CONFIRMED for the search
  results (2026-09-07). Confidence that they are unavailable overall is medium: the separate
  TESIUNAM/DGB catalogue could not be reached (its Aleph endpoint returned nothing or HTTP
  404), and a thesis can be defended without prompt deposit.

Why this is the most likely overlap. Five independent points line up. (i) Its title covers
rank 3 AND rank 4 in R^4, which is exactly the audited setting. (ii) Trejo's PhD topic is
"Chiral polytopes in Euclidian 4-space", and her 2023 talk classifies the chiral polyhedra
with helical faces whose skeleton lies in the skeleton of the convex regular 4-polytopes,
which is the family that contains H_0({5,3,3}) (it lies on the 1-skeleton of the 120-cell).
(iii) The PAPIIT report states that the group determined which of those four polyhedra extend
to chiral 4-polytopes in E^4 and that the write-up was in progress. (iv) Her public GAP
appendix already performs the extension for the 120-cell case and reports precisely the
f-vector (600, 1200, 120, 5), the group order 7200, the cell rotation-group order 1440 and the
vertex-figure rotation-group order 12. (v) The preprint is cited as existing, in a March 2026
survey by Hubard herself. Taken together, the audited rank-4 object is very likely to be
inside the Hubard-Trejo programme already. The report must therefore not be read as asserting
priority: the honest formulation is that no published construction was located, while the
extension of H_0({5,3,3}) to a chiral 4-polytope is announced as achieved in the unpublished
Hubard-Trejo preprint (cited as "Preprint" in arXiv:2604.00185, reference [31]) and in the
2023 final report of UNAM-PAPIIT project IN109023, and is computed in public in the GAP
appendix of Trejo's doctoral thesis on GitHub.

Two further items in the same group, recorded for completeness: an honours thesis in progress
titled "A full rank chiral 4-polytope" (Arturo Flores) and one titled "Skeletal two orbit
polyhedra from the hypercube" (Óscar Henney), both on Hubard's students page; and
"I. Hubard and L. M. García-Velázquez, Finite two-orbit skeletal polyhedra in ordinary 3-space
(in preparation)", reference [34] of arXiv:2604.00185. Status: CONFIRMED as listed
(2026-09-07).

---

## 9. Negative results, grouped by index and site

All entries in this section are searches that were actually run and returned nothing relevant,
or accesses that failed. Status of every entry: CONFIRMED that the search was run and returned
as described; and explicitly NOT evidence about what does not exist. Access dates 2026-09-07
unless the record says 2026-09-06 to 2026-09-07.

### 9.1 arXiv

- ti:"Chiral polyhedra in 3-dimensional geometries": 0. ti:"chiral 5-polytope of full rank": 0.
  (A) and Pellicer's 2021 Discrete Math. paper have no arXiv versions.
- all:"Petrie-Coxeter" AND all:chiral: exactly 1 hit, Hubard-Schulte-Weiss "Petrie-Coxeter Maps
  Revisited" (math/0512157, 2005). abs:"Petrie-Coxeter": 1 hit, the same. Nothing 2019 to 2026.
- ti:"chiral polyhedra": 5 hits (Cunningham 1508.07451; Angelone-Schulte 2603.02543;
  Leemans-Liebeck 1603.07713; Schulte math/0501050; Koca et al. 1006.3149), (A) absent.
  abs:"chiral polyhedra" sorted by date, max 100: 6 hits, most recent Cunningham-Pellicer
  "Tight Chiral Polytopes" (2020-09-09).
- abs:"helical faces": 1 hit (Schulte math/0501050).
- all:"skeletal polytopes": 1 hit (Mochán, "Politopality of 2-orbit maniplexes", 2309.15791).
  abs:"skeletal" AND abs:"polytopes", and abs:"realization" AND abs:"regular polytopes", 2019
  to 2026: no paper constructing or discussing a finite chiral 4-polytope in E^4 beyond
  Roli's cube. all:"polygonal complexes" and all:"two-orbit" AND all:"polyhedra": no 2019 to
  2026 Schulte-school paper on polygonal complexes.
- abs:"full rank" AND abs:"polytopes": 15 hits, all convex geometry, physics or optimization.
  all:"chiral" AND all:"full rank": 3 hits, all physics or vertex operator algebras.
  all:"full rank" AND (polytope OR polytopes OR polyhedra): 17 hits, none about chiral or
  skeletal polytopes.
- ti:"chiral" AND cat:math.CO (21 hits) and ti:"chiral" AND cat:math.MG (4 hits), 2019 to 2026:
  none concerns skeletal chiral polytopes in E^4, H_alpha(T) or type {30,3,3}.
- all:chiral AND polytope(s), 100 most recent: post-2022 entries are Hubard-Schulte
  2604.00185, Angelone-Schulte 2603.02543, Cunningham-Feng-Hou-Schulte 2512.15511, Kong et al.
  2508.20654, Mochán 2506.04406, Conder-Steinmann 2406.13848, Montero-Toledo 2405.09434,
  Hubard-Mochán 2208.00547; none constructs a geometric chiral polytope in E^4 or S^3.
- au:Pellicer AND all:chiral: 5 hits, latest 2020. (au:Hubard OR au:Bracho) AND all:polytope:
  18 hits, no manuscript (C) and no Hubard-Trejo preprint. au:"Bracho": 21 entries;
  au:"Hubard": 50 entries; (A) absent from both. au:Trejo AND chiral AND polyhedra: 0;
  au:"Trejo" AND all:polytope: 0; ti:"skeletal chiral": 0; all:"skeletal chiral": 0.
  au:Casanova AND (polytope OR chiral): 7 unrelated condensed-matter papers.
  all:"González-Casanova": 6 hits, none by the author of (C) and none about polytopes;
  all:"Gonzalez-Casanova": 11 hits, all astrophysics, PDE or biology.
  au:Pellicer_D OR au:Hubard_I OR au:Bracho_J: 0 (query-format artifact).
  https://arxiv.org/a/pellicer_d_1.html: HTTP 404. Hubard's arXiv author listing ends with
  2604.00185.

### 9.2 zbMATH Open

- The zbmath.org HTML interface returned HTTP 403 for title queries and for the record
  an:7402640; the REST API worked throughout.
- Free-text search for "Petrie-Coxeter": 9 hits across all years. The only 2019 to 2026 ones
  are (A) itself, Gévay-Schulte (Art Discrete Appl. Math. 4 (2021) P3.04) and Pellicer-Williams
  (2024). Nothing about H_alpha as facets.
- Search for "chiral polytope full rank": 9 documents (McMullen 2004; Conder-Hubard-Pisanski
  2008; McMullen-Schulte 2006; Pellicer 2017 twice; Hubard et al. 2012; Pellicer 2021 twice;
  Pellicer's 2025 monograph). No finite chiral 4-polytope in E^4 other than Roli's cube.
- Search for "Roli cube": only Monson 2022. A combined query with a results_per_page parameter
  returned HTTP 404.
- Full search for the string "{30,3,3}": 0 documents. Search for chiral AND "7200": 2
  irrelevant items. Search for "chirality group": 8 documents, all on maps and hypermaps
  (Breda d'Azevedo-Jones-Nedela-Škoviera 2009; Breda-Nedela 2006; Jones-Pinto 2010;
  d'Azevedo-Rodrigues-Fernandes 2011; Breda d'Azevedo-Catalano-Duarte 2009), Cunningham's
  mixing and variance papers (2012, 2014), and Pellicer's 2025 book; none attaches SL(2,5) or
  the binary icosahedral group to a chiral 4-polytope.
- Licence-withheld reviews (all return "zbMATH Open Web Interface contents unavailable due to
  conflicting licenses."): (B) Zbl 1306.05260 (document 6394874, contribution type "summary");
  Pellicer, Abstract Chiral Polytopes, Zbl 1570.52001 (document 7990062, reviewer Enrico
  Jabara); McMullen, Geometric Regular Polytopes, Zbl 1454.51002 (document 7162762, reviewer
  Uma Kant Sahoo); the Nieuw Archief book review Zbl 1541.00029; the reviews of McMullen's 2021
  quasi-regular paper.

### 9.3 Crossref, OpenAlex, OpenCitations, Semantic Scholar, Dimensions, DBLP

- Crossref reference-list scan of 15 candidate 2017 to 2025 papers for a citation to
  10.1007/s00454-021-00317-0: only Pellicer, "A chiral 5-polytope of full rank"
  (10.1016/j.disc.2021.112370) cites it. Confirmed NOT citing (A): Pellicer-Williams 2024
  (10.1007/s13366-023-00686-y), Cunningham-Pellicer "Finite 3-orbit polyhedra in ordinary
  space, II" (10.1007/s40590-024-00600-z), Hubard-Mochán-Montero "Voltage Operations"
  (10.1007/s00493-023-00018-7), Conder-Hubard-O'Reilly-Regueiro (10.1016/j.aim.2024.109819),
  McMullen "Quasi-Regular Polytopes of Full Rank" (10.1007/s00454-021-00304-5),
  Cunningham-Pellicer "Tight chiral polytopes" (10.1007/s10801-021-01023-z), Pellicer "Chiral
  polytopes of full rank exist only in ranks 4 and 5" (10.1007/s13366-020-00545-0), "Symmetric
  Circle Configurations from Regular Skeletal Polyhedra" (10.3390/sym17020283), Zhang
  (10.1007/s10801-022-01210-6), Schulte-Weiss (10.1007/s00283-016-9685-7), Cunningham-Pellicer
  "Open problems on k-orbit polytopes" (10.1016/j.disc.2018.03.004), Pellicer "Chiral
  4-polytopes in ordinary space" (10.1007/s13366-017-0342-x).
- Crossref query "chiral polytope full rank" from 2014: 5 results (Pellicer 2021 twice,
  Pellicer 2017, Cameron et al. 2017, Cunningham 2024), none new. Crossref title query "On
  Roli's cube": not found, only unrelated "Roli" items (the DOI lookup does work).
- OpenAlex: cited_by_count 0 and cites-filter count 0 for (A); meta.count 10 for (B);
  searches for "chiral polytope full rank" returned only physics; a search for "chiral
  4-polytope" OR "chiral polytopes of full rank" OR "Roli's cube" returned 8 works, none a new
  geometric example; the works records for the three key DOIs carry no abstracts; a search for
  "Two-Orbit Polytopes" returns only older two-orbit papers, so arXiv:2604.00185 appears not
  to be indexed.
- OpenCitations COCI and Index v2: empty for (A); 8 citing entities for (B).
- Semantic Scholar: title-based paper/search returned HTTP 429 on 7 attempts with varied
  queries; the DOI endpoint worked. Citations of (B) by DOI: empty list (see the artifact note
  in Section 3). Citations of Monson: none. Citations of Pellicer "Chiral 4-polytopes in
  ordinary space": none. Search "chiral polytope full rank" (50 results): 46 hits, no new
  geometric construction.
- Dimensions: times_cited 0 for (A).
- DBLP: Pellicer plus chiral, latest items 2021; Hubard plus polytope since 2019, 5 items, none
  geometric; "full rank polytope", only McMullen 2004, 2011, 2013, 2021 and Pellicer 2021.

### 9.4 Google Scholar

- Cluster 7894986772177673053 for (A): "Cited by 2", 5 versions, no additional counts. Cluster
  18013071674759774703 for (B): "Cited by 12", pages 1 and 2 listing 11 distinct works plus a
  repository duplicate of Pellicer's "A chiral 4-polytope in R^3" at
  repositorioccm.matmor.unam.mx/handle/123456789/163.
- Later re-checks of (A)'s Cited-by count (plain query and hl=en&as_sdt=0,5) both returned
  Google Scholar's internal-server-error page: count NOT re-retrieved. Status: UNVERIFIABLE on
  re-check.
- Phrase searches that returned nothing new: "chiral polytopes of full rank" (11 results);
  since 2022, chiral plus polytope plus "full rank" (46 results, only Hubard-Schulte 2026 and
  Cunningham-Pellicer 2023 about polytopes, the rest physics); "Two new chiral 4-polytopes of
  full rank" (1 result, the citing survey); "González-Casanova" OR "Gonzalez-Casanova" plus
  chiral polytope (the citing survey plus an unrelated library-science document); "skeletal
  chiral 3- and 4-polytopes" (only the citing survey); "Roli's cube" plus chiral (Monson 2021,
  Pellicer 5-polytope 2021); Bracho plus Hubard plus Pellicer plus "chiral 4-polytope" since
  2022 (Hubard-Schulte 2026; Pellicer-Williams 2024); chiral plus "4-polytope" plus
  "Petrie-Coxeter" plus facet (10 results, all abstract or combinatorial or already known);
  since 2022, chiral plus "4-polytope" plus "Euclidean 4-space" or E^4 or R^4 realized (3
  results, all physics about the 24-cell).

### 9.5 Publisher and aggregator access failures

- Cambridge Core (www.cambridge.org, resolve.cambridge.org): HTTP 429 "Too many automated
  requests from this network" (Varnish) on every attempt in every pass, for the "Abstract
  Chiral Polytopes" product page, Preface, Chapter 5, Chapter 6 "Skeletal Polytopes",
  Appendix C "Open Problems", and for the bibliography PDF of McMullen's Geometric Regular
  Polytopes. assets.cambridge.org front-matter and index PDFs for ISBN 9781108493246 timed out
  (HTTP 000).
- Google Books: API queries for intitle:"Abstract Chiral Polytopes" returned totalItems null
  or no items; in-book searches on volume hLbPDwAAQBAJ (McMullen 2020) for "Bracho" and
  "chiral" produced no snippets (no preview); several Books API calls returned HTTP 429.
- Springer (link.springer.com): article pages for 10.1007/s00454-021-00317-0,
  10.1007/s00454-014-9631-4 and 10.1007/s00283-016-9685-7 all issue HTTP 303 redirects to
  idp.springer.com authorization endpoints; publisher abstracts could not be retrieved
  verbatim, and Crossref carries no abstract for (A). Paywalled full texts not retrieved:
  Pellicer 2017 (Beiträge), Pellicer 2021 (Beiträge), McMullen 2021 (DCG), Pellicer 2016
  (hemicuboctahedron chapter), Nostrand-Schulte 1995.
- ScienceDirect: HTTP 403 for Pellicer, "A chiral 5-polytope of full rank" (article and
  abstract pages), for Pellicer 2010, and for Schulte-Weiss 1994. Unpaywall for
  10.1016/j.disc.2021.112370: is_oa false, no OA location. ResearchGate: HTTP 403 for Monson
  and for the Pellicer 5-polytope. X-MOL: login page only.
- AMS: https://www.ams.org/books/dimacs/004/39 (Schulte-Weiss 1991) returned HTTP 403.
- ADAM journal site: one pass recorded an expired TLS certificate; a later pass downloaded the
  Monson PDF successfully.
- MDPI: https://www.mdpi.com/2073-8994/17/2/283 ("Symmetric Circle Configurations from Regular
  Skeletal Polyhedra", Symmetry 17 (2025) 283) returned HTTP 403; Crossref shows its 22
  references do not include (A).
- Scilit: HTTP 403. Polytope Wiki: HTTP 403 via WebFetch, api.php, action=raw and a reader
  proxy in most passes (one curl fetch succeeded); web.archive.org fetches of it were not
  permitted by the tool in one pass.
- repositorioccm.matmor.unam.mx: TLS error "unable to verify the first certificate" via
  WebFetch; with curl -k the /discover query returned "Error: Document Not Found".

### 9.6 Institutional and repository sites

- repositorio.unam.mx and ru.dgb.unam.mx: "politopos quirales" returns 8 theses (Collins 2015,
  Trejo 2018, Montero 2019, Ramos 2014, Mochán 2021, Hunedy 2022, Ruiz 2013, one false
  positive), none on chiral 4-polytopes in E^4; "4-politopos quirales" returns no matches;
  "politopos quirales" also returns two DGAPA project records of Hubard's ("Atlas de politopos
  quirales", "Grupos y gráficas asociados a politopos abstractos"); "González Casanova Azuela
  politopos" returns 0; "González Casanova Azuela" returns only the 2021 licenciatura thesis;
  "Trejo Escamilla Briseida" returns only the 2018 master's thesis. TESIUNAM Aleph OPAC: HTTP
  404. SIIA record id 808668: "TESIS NO ENCONTRADA".
- Isabel Hubard's research page
  (https://sites.google.com/im.unam.mx/isahubard/home-page/research): 36 journal papers, 2
  book chapters, 2 conference abstracts; no entry for manuscript (C), no work co-authored with
  González-Casanova, no work co-authored with Trejo; the Preprints section contains only an
  incomplete Cunningham entry. Students page: González-Casanova not listed.
- Bracho's open Apache listings (directory indexing enabled, so the listings are complete):
  /investigacion/ contains only articulos-V.html, articulos/, articulos.html,
  expositorios.html, programas.html and programs/; /programs/ contains ONLY
  "PetrieCoxeter.html  2021-04-07 07:50  9.4K" and "PetrieCoxeter/  2021-04-06 19:20";
  /programs/PetrieCoxeter/ contains only the ten Galeria_*.html files plus grupos/ and images/;
  /grupos/ contains exactly ten files, "GrupoH2H_3-3-3, GrupoH2H_3-3-52, GrupoH2H_3-4-3,
  GrupoH2H_3-5-52, GrupoH2H_3-52-5, GrupoH2H_4-3-3, GrupoH2H_5-3-3, GrupoH2H_5-3-52,
  GrupoH2H_5-52-5, GrupoH2H_52-5-52"; /articulos/ holds 40 PDFs including
  "PetrieCoxeterFinal2.pdf  2021-04-07 07:49  6.5M" and "AfiniteChiral.pdf  2021-04-07 07:49
  317K". Nothing anywhere on the site concerns a rank-4 extension of the 30-gonal polyhedra.
- DGAPA: the 2026 PAPIIT approved-projects list contains no project by Hubard, Bracho or
  Pellicer (the only "quirales" hit is an unrelated nanomaterials project, IN101126); report
  IN109922 is an unrelated soft-matter project. The IN109023 report itself contains no
  occurrence of "Pellicer", "Petrie", "Roli", "caras helicoidales" or "rango completo", and its
  productivity list (Eur. J. Combin. 2023; Adv. Math. 2024; Aequationes Math. 2024; Bol. Soc.
  Mat. Mexicana 2024) contains no paper on chiral 4-polytopes in E^4.
- 10th Slovenian Conference on Graph Theory book of abstracts: the live URL
  https://sicgt.si/system/admin/files/files/000/000/005/original/book_of_abstracts.pdf returns
  404, as do the Indico event 39 book-of-abstracts and contributions paths and
  sicgt.si/programme/book-of-abstracts.html, and 2023.sicgt.si has a TLS mismatch; the
  abstract was recovered only through the Internet Archive snapshot of 2024-07-14.
- SIGMAP 2018 abstracts page (matmor.unam.mx/SIGMAP/abstracts.html): no talk on full-rank
  chiral polytopes or chiral 4-polytopes in E^4. Pellicer's CCM SRB record 981 lists only
  "Developments and open problems on chiral polytopes" (2012). CMS Winter 2018 Pellicer
  abstract (dcg-dp.pdf): the talk is "Higher rank chiral polytopes with toroidal facets".

### 9.7 Full-text searches inside retrieved papers that found nothing

- Handbook of Discrete and Computational Geometry, 3rd ed., Chapter 18, "Symmetry of polytopes
  and polyhedra" (Schulte; preliminary version at http://www.csun.edu/~ctoth/Handbook/chap18.pdf,
  full text extracted): zero occurrences of "chiral 4-polytope", "Roli", "full rank" or "R4";
  Bracho appears only in two pre-2002 reference entries. This standard survey does not record
  finite chiral 4-polytopes in E^4.
- Schulte-Skacel, "Skeletal Snub Polyhedra in Ordinary Space, I", arXiv:2602.19391v1
  (22 February 2026, 41 pages, extracted): zero occurrences of "Bracho", "Roli", "full rank",
  "E4", "H0" or "{30"; (A) is not cited. It uses the same operation toolkit as (A), verbatim
  "These operations are the duality δ, Petrie duality π, faceting φ2, halving η, and skewing
  σ.", and verbatim "The faces of P can take finite (convex, star, or skew) or infinite
  (zig-zag or helical) forms.", and mentions verbatim "...such as the five Platonic solids, the
  Kepler-Poinsot polyhedra, the Petrie-Coxeter polyhedra, and the Grünbaum-Dress polyhedra...",
  but only in ordinary space E^3.
- Angelone-Schulte, "Chiral Polyhedra from AGL(1,q)", arXiv:2603.02543v1 (3 March 2026, 18
  pages, extracted): zero occurrences of "Petrie", "helical", "Bracho", "Roli" or "full rank";
  (A) and (B) not cited. Abstract, verbatim: "We also establish that subgroups of AGL(1,q)
  cannot serve as full automorphism groups of regular polytopes of rank 3 or higher, nor of
  chiral polytopes of rank 4 or higher, demonstrating that our construction captures all
  polytopes that can arise from this class of affine groups."
- Hubard-Mochán-Montero, "Voltage Operations on Maniplexes, Polytopes and Maps",
  arXiv:2202.05380 (32 pages, extracted; Combinatorica 43 (2023),
  DOI 10.1007/s00493-023-00018-7): zero occurrences of "Petrie-Coxeter", "helical", "Roli",
  "Bracho", "full rank", "E4" or "chiral 4-polytope"; Crossref confirms (A) is not among its 32
  references. Its only skeletal-adjacent line is the bibliography entry, verbatim: "[24] Egon
  Schulte and Abigail Williams. \"Wythoffian Skeletal Polyhedra in Ordinary Space, I\". In:
  Discrete & Computational Geometry 56.3 (2016), pp. 657-692."
- Hubard-Mochán-Montero, "Symmetries of voltage operations on polytopes, maps and maniplexes",
  arXiv:2312.13184v1 (25 pages, extracted): its only "Petrie" occurrence is "Petrie-dual" as an
  example operation, verbatim "Voltage operations, first introduced in [9], are a
  generalisation of classic geometric and topological operations on maps and polytopes (e.g.
  Wythoffian constructions, snub, dual, Petrie-dual, products of polytopes as described in [5],
  and many more)."; zero occurrences of "Petrie-Coxeter", "helical", "Roli", "Bracho", "full
  rank" or "E4".
- Cunningham-Mochán-Montero, "Cayley extensions of maniplexes and polytopes", arXiv:2305.11843v1
  (32 pages, 86866 characters extracted): zero hits for "Petrie", "helical", "Roli",
  "skeletal", "Bracho", "chiral 4-polytope", "full rank", "E4" or "3-sphere".
- Montero-Toledo, arXiv:2405.09434v1 (33 pages, extracted): zero occurrences of
  "Petrie-Coxeter", "helical", "Roli", "Bracho" or "full rank".
- Monson, both versions: zero occurrences of "helical", "chirality group", "H0", "{5,3,3}" or
  "30"; no reference to (A); Crossref lists 0 references for the DOI.
- Conder-Hubard-Pisanski 2008: no chiral 4- or 5-polytope with facets {5,3}, {8,3}*96,
  {12,3}*288, {12,4}*384e, {30,3} or {20,5}; its examples have toroidal or {3,4} facets.
- Schulte-Weiss arXiv:1610.02619: cites (B) as [3] and Pellicer's R^3 paper as [22] only in
  the bibliography; no in-text statement about full-rank chiral examples. Its Petrie-Coxeter
  passages are verbatim "These Petrie-Coxeter polyhedra are precisely the infinite regular
  polyhedra with convex faces in E3." and "For example, the Petrie dual of the Petrie-Coxeter
  polyhedron {6, 4|3} is a regular polyhedron whose faces are helical polygons spiraling over a
  triangular basis...", both about regular polyhedra in E^3; and it lists verbatim "[15] P.
  McMullen, Geometric Regular Polytopes, in preparation."
- Searches across all retrieved citing works for statements about facets of chiral 4-polytopes
  of full rank, or about the maps {8,3}*96, {12,4}*384e, {12,3}*288, R97.9, R151.11 or the
  dodecahedron as facets: only (A) contains such statements. Cunningham-Pellicer discuss facets
  only in the abstract amalgamation setting (their Problems 15, 18, 19); Monson only for the
  cubical facets of the 4-cube and the facet M of Roli's cube.

### 9.8 Targeted symbol and phrase searches that found nothing

- Web searches for a chiral 4-polytope of type "{30,3,3}", with and without the qualifiers
  120-cell, skeletal and facets: nothing found. The Schläfli type {30,3,3} does not appear
  anywhere in the retrievable literature.
- Web searches for "{12,3,5}", "H_0({5,3,3})", "{30/(1,11),3}": no hits containing those
  symbols.
- Web searches for "R97.9" and "{30,3}*2880" in connection with chiral polytopes or facets:
  nothing outside (A)'s own p. 29 identification.
- Web searches for the f-vector (600,1200,120,5), for the 5-facet condition, and for a "chiral
  120-fold cover of {3,3,3}": only Wikipedia pages on the 120-cell and 600-cell and unrelated
  material.
- Web searches for "Coxeter twisted honeycombs chiral 4-polytope geometric realization S^3
  skeletal helical", and for "geometrically chiral" plus "combinatorially regular" 4-polytope
  in projective space or S^3: nothing beyond the known (A), (B) and Schulte-Weiss material.

---

## 10. Refuted or corrected items

Everything a verification pass marked CORRECTED or REFUTED, so that a human can see it.

**10.1 CORRECTED. The DOI for (A).** The DOI 10.1007/s00454-021-00306-x that entered the audit
is not registered at all: Crossref returns "Resource not found.", doi.org returns HTTP 404
with no redirect, OpenAlex returns HTTP 404. The correct DOI is 10.1007/s00454-021-00317-0.
Nearest registered neighbour in the same block: 10.1007/s00454-021-00306-3, an unrelated
configuration-spaces paper (DCG 67 (2021) 258-286). Also nearby: 10.1007/s00454-021-00304-5,
McMullen's "Quasi-Regular Polytopes of Full Rank", DCG 66 (2021) 475-509. Verified
2026-09-07.

**10.2 REFUTED. Monson does not cite (A).** zbMATH's "cited in" query on Zbl 1475.52019
returns exactly one document, Monson's "On Roli's cube", and must not be counted. Both
versions of Monson were read in full: the published ADAM PDF has exactly 17 reference entries,
of which [3] is verbatim "J. Bracho, I. Hubard and D. Pellicer, A finite chiral 4-polytope in
R4, Discrete Comput. Geom. 52 (2014), 799-805, doi:10.1007/s00454-014-9631-4."; there is no
entry for DCG 66 (2021) 1025-1052, and the string "Petrie-Coxeter" does not occur anywhere in
the article. The arXiv v1 source (rc3.tex, 17 bibitems) has a single Bracho entry, key
bracho:2014aa, and grep for "bracho" returns only citations of that key (lines 130, 144, 329,
378, 401, 683). The zbMATH review of Monson (by Eugenia Saorin Gomez, Bremen) states "It was
introduced by J. Bracho et al. [Discrete Comput. Geom. 66, No. 3, 1025-1052 (2021; Zbl
1475.52019)], where an example of a chiral 4-polytope in the projective 3-space is given, which
naturally brings in a finite chiral 4-polytope in the Euclidean 4-space", but that description
is the ABSTRACT OF THE 2014 PAPER, so the review has attached 2014 content to the 2021 record.
Practical consequences: do not cite zbMATH's citation count for (A), and do not state that
Monson discusses the Petrie-Coxeter construction. Verified 2026-09-07.

**10.3 CORRECTED. The union of works citing (A).** The union is exactly one work per the
verification pass that could reach Semantic Scholar and the primary e-print (Hubard-Schulte,
arXiv:2604.00185), and exactly two when the zbMATH rf: query and the Crossref reference-list
scan are included (adding Pellicer, "A chiral 5-polytope of full rank", whose reference to (A)
is unstructured and carries no DOI, which is why no citation index registers it). This audit
reports the union as TWO, with the Pellicer citation evidenced by its Crossref reference entry
b1 quoted in Section 2, and with "two" flagged as a lower bound because Google Scholar could
not be re-reached and books are poorly indexed. Verified 2026-09-07.

**10.4 CORRECTED. Schulte and Weiss, "Skeletal Geometric Complexes and Their Symmetries", is
2017, not 2020.** The Mathematical Intelligencer 39 (2017), no. 3, 5-16, DOI
10.1007/s00283-016-9685-7, Crossref issued date 2017-06-29; arXiv:1610.02619v1 dated 9 October
2016. It therefore predates (A) by five years and cannot mention it; it cites (B) only as a
bibliography entry, and its reference [15] is verbatim "P. McMullen, Geometric Regular
Polytopes, in preparation." Verified 2026-09-07.

**10.5 CORRECTED. Monson's year and venue.** Two modality records date "On Roli's cube" to
2021, which is the arXiv year. The published item is The Art of Discrete and Applied
Mathematics 5 (2022), no. 3, Paper No. #P3.10, 17 pp., published online 26 July 2022. Verified
2026-09-07.

**10.6 CORRECTED. The URL of Conder's regular-map list.** OrientableRegularMaps301.txt returns
HTTP 404 (as do OrientableRegularMaps101.txt and OrientableRegularMaps501.txt). The live file
is RegularOrientableMaps301.txt (HTTP 200, 3874162 bytes); the genus-101 predecessor is
RegularOrientableMaps101.txt. The dead URL is the one printed in (A)'s own bibliography,
reference [6]. Cite the working file, and optionally note (A)'s dead link. Verified
2026-09-07.

**10.7 CORRECTED. R97.9 is printed in its dual form.** The file entry is verbatim "R97.9 :
Type {3,30}_20  Order 2880  mV = 2  mF = 1" (line 12683). Group order 2880 and genus 97 are
right; the type-{30,3} map with 480 vertices, 720 edges and 48 faces is the DUAL of the entry
as printed. Write "the dual of Conder's R97.9" or "R97.9, listed as {3,30}_20", not "R97.9 has
type {30,3}". (A) p. 29 makes the same elision. Verified 2026-09-07.

**10.8 CORRECTED. R151.11 likewise.** The entry is verbatim "R151.11 :  Type {5,20}_60  Order
2400  mV = 2  mF = 1" (line 24071). Order 2400 and genus 151 are right; the type-{20,5} map
with 240 vertices, 600 edges and 60 faces is the dual reading. (A) p. 29 prints the label with
a stray period as "R.151.11". Verified 2026-09-07.

**10.9 REFUTED. R97.9 and R151.11 are NOT the only candidates of their type and order.** Each
has exactly one sibling with the same type and group order, distinguished only by Petrie
polygon length: "R97.10 :  Type {3,30}_40  Order 2880  mV = 2  mF = 1" (line 12687, relations
"[ T^2, R^-3, (R * S)^2, (R * T)^2, (S * T)^2, (S^-2 * R * S^-1)^3 ]") and "R151.10 :  Type
{5,20}_12  Order 2400  mV = 4  mF = 1" (line 24067). A grep of the whole genus 2 to 301 file
finds exactly these two pairs. The identifications are therefore not forced; the discriminator
is the Petrie length (20 versus 40, and 60 versus 12), equivalently the order of s0s1s2, and
neither (A) nor the audited claim records it. Verified 2026-09-07.

**10.10 CORRECTED. There is no Hartley-atlas name "{30,3}*2880".** The atlas contains only
{30,3}*720 (SmallGroup(720,771)), {30,3}*900 (SmallGroup(900,95)) and {30,3}*1500
(SmallGroup(1500,37)), because 2880 flags exceeds its stated coverage of 2000. Likewise there
is no {20,5}*2400 (only *480, *640a, *640b, *1200, *1280, *1600) and no {15,5}*14400 (only
{15,5}*600, SmallGroup(600,146)). Do not print Hartley-style names for these maps; use
Conder's labels. Verified 2026-09-07.

**10.11 CORRECTED. Problems 20 and 21 are Cunningham-Pellicer 2018, not Pellicer's 2025
Appendix C.** A web-search summary attributed the numbered "Problem 20 / Problem 21" on chiral
polytopes of full rank and of nearly full rank to Appendix C of the monograph. The actual
retrieved source is Cunningham and Pellicer, "Open problems on k-orbit polytopes"
(arXiv:1608.07993, Discrete Math. 341 (2018) 1645-1661). The monograph's Appendix C could not
be read, and no claim is made about its contents. Verified 2026-09-07.

**10.12 CORRECTED. Attribution of "Chiral polytopes from hyperbolic honeycombs".** It is by
B. Nostrand and E. Schulte, DCG 13 (1995), no. 1, 17-39, DOI 10.1007/BF02574026, not by
Schulte and Weiss 1994. The Schulte-Weiss 1994 paper is "Chirality and projective linear
groups", Discrete Math. 131 (1994) 221-261. Verified 2026-09-06 to 2026-09-07.

**10.13 CORRECTED. Attribution of "Chiral extensions of regular toroids".** It is by A.
Montero and M. Toledo (Combinatorica 45 (2025), article 5, DOI 10.1007/s00493-024-00132-0,
arXiv:2405.09434), not by Cunningham and Pellicer. Verified 2026-09-06 to 2026-09-07.

**10.14 CORRECTED. Conder's chiral-polytope coverage.** One pass reported that Conder's
homepage lists no chiral-polytope file beyond 2000 flags and that a search-engine summary
claiming a 4000-flag list was not corroborated on the page. A later pass fetched
ChiralPolytopesWithUpTo4000Flags-ByType.txt and -ByOrder.txt successfully (HTTP 200, 791468
bytes for the ByType file, header quoted in Section 7.3). The resolution: the 4000-flag files
exist and are live but are not linked from the homepage. Probes beyond 4000 flags all return
HTTP 404, so 4000 flags (group order 2000) is the largest published coverage as of 2026-09-07.

**10.15 UNRESOLVED CONFLICT, recorded as a correction candidate. R97.9 versus R97.10 for the
facet map.** (A) p. 29 states verbatim that the regular polyhedra arising from T = {5,3,3} and
T = {3,3,5/2} "are isomorphic of type {30, 3} and are listed as R97.9". The GAP appendix of
Briseida Trejo's doctoral thesis (public on GitHub) states on its p. 10 the opposite
identification, R97.10 of type {3,30}_40, on the ground that none of the three order-1440
subgroups of R97.9's automorphism group is isomorphic to the polyhedron's group whereas
R97.10's unique order-1440 subgroup is. The verbatim text of that passage reached this report
truncated. Both sources agree on genus 97, type {30,3} and group order 2880. This conflict is
NOT resolved by anything retrieved, and it is the same point as 10.9: computing the Petrie
polygon length of the facet settles it (20 gives R97.9, 40 gives R97.10). Status: UNVERIFIABLE
as to which is right; both claims CONFIRMED as claims of their respective sources
(2026-09-07).

**10.16 REFUTED. The Trejo doctoral thesis and the González-Casanova master's thesis are not
publicly deposited.** repositorio.unam.mx returns exactly one record for "Trejo Escamilla,
Briseida" (the master's thesis) and exactly one for "González Casanova Azuela" (a 2021
licenciatura thesis on plane tessellations); no doctoral thesis and no master's thesis on
chiral polytopes appear. The separate TESIUNAM/DGB catalogue could not be reached (Aleph
endpoint returned nothing, or HTTP 404), so confidence that they are unavailable overall is
medium, and a thesis can be defended without prompt deposit. Note however that the GAP
computations appendix of Trejo's thesis IS public, on GitHub (Section 8.2, item 4). Verified
2026-09-07.

**10.17 REFUTED. A fetch-tool summary claimed Conder's 2000-flag chiral list has "no rank-4
entries".** The raw file has a rank-4 section at lines 2254 to 2583. Any claim resting only on
a summarizer, rather than on the raw file, should be treated with caution. Verified
2026-09-07.

**10.18 CORRECTED. Semantic Scholar's DOI-keyed record for (B) reports zero citations.** The
DOI-keyed record (paperId dd023bdec13532a360c3b0e158d4c96e61a5418e) returns citationCount 0
and an empty citations array, while the arXiv-keyed record for the same paper (paperId
5c0507c9ec4a2e038395af3033f4e44829598894) returns 8. Do not quote the DOI-keyed figure.
Verified 2026-09-07.

**10.19 CORRECTED. The URL https://www.matem.unam.mx/~roli/PetrieCoxeter.html does not 404.**
It returns HTTP 200 with an 88-byte body that is exactly a meta refresh to
investigacion/programs/PetrieCoxeter.html. A WebFetch of the first URL sees only the stub;
curl plus the redirect target gives the real page (9656 bytes). Verified 2026-09-07.

**10.20 Minor corrections and typographical notes, all verified 2026-09-07.**

- (A) misspells Hartley as "Hartely" and gives the atlas title as "Atlas of Regular Abstract
  Polytopes"; the site header is "The Atlas of Small Regular Polytopes" and (A)'s own
  reference [17] gives Hartley's paper title as "An Atlas of Small Regular Abstract Polytopes.
  Period Math Hung 53 (2006), 149-156".
- (A)'s pairing of T with atlas names is {4,3,3} to {8,3}*96, {3,4,3} to {12,4}*384e, and
  {5,3,5/2} to {12,3}*288, in that order.
- Bracho's gallery page for H2H{5,3,3} prints the type as "{30/(1,11)}", omitting the trailing
  3 that its sibling pages carry; other gallery pages carry bracket typos, reproduced verbatim
  in Section 8.2.
- Trejo's SiCGT 2023 abstract says there are "three infinite families" of chiral polyhedra in
  R^3, where (A) and the Pellicer-Williams review speak of six; reported as written.
- The same master's degree of Briseida Trejo is recorded as "Panales quirales" in
  repositorio.unam.mx (2018) and as "Twisted honeycombs" on Hubard's students page
  (examination 9 January 2019).
- Pellicer's IMUNAM colloquium abstract of 8 May 2018 promises "la clasificación de dichos
  politopos" without naming the ambient dimension; on the retrievable record this is the E^3
  classification (Pellicer 2017, Beiträge), but the inference is not from the page itself and
  should be confirmed with the author before being relied on.
- Two records in the audit inputs reached this report truncated: the verbatim map-identification
  passage of the Trejo GitHub appendix, and the final record of the third verification pass on
  Pellicer's 2025 monograph, Chapter 6. Both tails are UNVERIFIABLE.
