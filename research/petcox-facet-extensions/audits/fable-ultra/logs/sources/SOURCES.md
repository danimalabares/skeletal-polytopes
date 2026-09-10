# Source-phase evidence (fresh-session Fable audit, 2026-09-09)

Retrieval was done AFTER the mathematical discovery phase was frozen (see REPRODUCIBILITY.md, Phases).
Third-party files themselves are kept outside the repository (scratchpad, not redistributed); only hashes and the minimal excerpts needed as evidence are recorded here.

## Files retrieved (SHA-256, size, URL, UTC time of retrieval 2026-09-09 ~16:00-16:10)

```
9d8f6a4e810a60bfc2927ab8827b0bd8249759f749cfa53d19abe2148ebec32a     3874162  RegularOrientableMaps301.txt
c5e47f552334fda396b39e75acd54310bd426e58f69866b420eddd9442ac4e20      791468  ChiralPolytopesWithUpTo4000Flags-ByType.txt
5f31fae5bca62f20622c7f630e71faaeb5a74429d7870f9e5ada7dcc4145a183      410783  arxiv-2604.00185v1.pdf
4a1593009989b124db18ddd6ed19be7322d0472a72b18088e7f3cd8a872b86fa       69682  papiit-IN109023.pdf
b5bf395919e2570317c175256c11af1e6177935b2d49304de4b494c51f6f5b0a      201169  trejo-calculos-gap-github.pdf
ae47846453517acc1902ad5448bb1d2a653ba903d908860b8cf91b13d21d700a       18706  atlas-8-3-96.html
47e9d2635de5ac4c13729f04e172b09a653ffe1ec470308e1494da7b971dc5be       31103  atlas-12-3-288.html
4d58b195fe787d9aa9241e1c88b42ed5911beff4b85b9812bad20e2f38848cdb       28698  atlas-12-4-384-18044-3.html
99b37be62d2e623fa0784e3a7df81bb21ccf39a4f09da2c099064c03f723a36a       53696  atlas-12-4-384-1706-3.html
e81bb86ecb45b271f8671d100438e3e497ff5c182c81fcab1e7da31483e789a4      200383  atlas-r3-index.html
```

URLs: https://www.math.auckland.ac.nz/~conder/RegularOrientableMaps301.txt ; https://www.math.auckland.ac.nz/~conder/ChiralPolytopesWithUpTo4000Flags-ByType.txt ; https://arxiv.org/pdf/2604.00185v1 ; https://dgapa.unam.mx/images/papiit/transparencia/proyxanio/2025/segundo/IN109023_Informe_Final_2023.pdf ; https://api.github.com/repos/briseida/TesisDoctorado/contents/calculos-gap-github.pdf (blob sha 6f453c1c3eb694fd796b692d8ec04873fc1c1703, 201169 bytes; raw.githubusercontent.com returned HTTP 503 twice) ; https://www.abstract-polytopes.com/atlas/r3/... ; Crossref https://api.crossref.org/works/10.1007/s00454-021-00317-0 (read through WebFetch, not saved).

## Conder, RegularOrientableMaps301.txt — verbatim lines
```

Regular orientable maps of genus 2 to 301
-----------------------------------------

Below is a list of all fully regular (rotary and reflexible) maps on 
on orientable surfaces of genus 2 to 301, up to isomorphism and duality.

The notation "Rg.n" is used for the nth regular orientable map of genus g.

These were found by Marston Conder (University of Auckland) in 2011 with the
help of the "LowIndexNormalSubgroups" routine in Magma, and the list extends
the list of those of genus 2 to 101 which he found in 2006.
...
12683:R97.9 :  Type {3,30}_20  Order 2880  mV = 2  mF = 1   
12684-Defining relations for automorphism group:
12685-[ T^2, R^-3, (R * S)^2, (R * T)^2, (S * T)^2, S * R * S^-2 * R * S^-2 * R * S^-1 * R * S^-2 * R * S^2 * R^-1 * S^2, S * R * S^-3 * R^-1 * S^5 * R^-1 * S^-3 * R * S^6 ]
--
12687:R97.10 :  Type {3,30}_40  Order 2880  mV = 2  mF = 1   
12688-Defining relations for automorphism group:
12689-[ T^2, R^-3, (R * S)^2, (R * T)^2, (S * T)^2, (S^-2 * R * S^-1)^3 ]
24067:R151.10 :  Type {5,20}_12  Order 2400  mV = 4  mF = 1  
24068-Defining relations for automorphism group:
24069-[ R^5, T^2, (R * S)^2, (R * T)^2, (S * T)^2, S * R * S^-1 * R * S^-1 * R^2 * S^2 * R^-1 * S * R^-1 ]
--
24071:R151.11 :  Type {5,20}_60  Order 2400  mV = 2  mF = 1  
24072-Defining relations for automorphism group:
24073-[ R^5, T^2, (R * S)^2, (R * T)^2, (S * T)^2, S^-1 * R^-1 * S^2 * R^2 * S^2 * R^-1 * S^-1 ]
```
All genus-97 entries of type {3,30}: 2 (R97.9, R97.10).  All genus-151 entries of type {5,20}: 2 (R151.10, R151.11).  The URL printed in PETCOX ref. [6] (.../OrientableRegularMaps301.txt) returned HTTP 404 (WebFetch).

## Conder, ChiralPolytopesWithUpTo4000Flags-ByType.txt — verbatim
```
Chiral polytopes with up to 4000 flags (ordered by type for each rank)
......................................................................

Below is a complete list of all abstract chiral polytopes (with maximum 
symmetry) up to 4000 flags, up to isomorphism, reflection and duality.

Note that the automorphism group of each such polytope has two orbits 
...
7637:Chiral 4-polytope with group of order 192   NSD  Type [ 3, 3, 8 ]
7638-[ A.1^3, A.2^3, (A.1^-1 * A.2^-1)^2, (A.2^-1 * A.3^-1)^2, A.3^-1 * A.2 * A.1^-1 * A.3 * A.1, A.3^-1 * A.1 * A.3 * A.2^-1 * A.1 * A.3^-2 * A.2 ]
8073:Chiral 4-polytope with group of order 1152   NSD  Type [ 4, 3, 12 ]
8074-[ A.1^4, A.2^3, (A.1^-1 * A.2^-1)^2, (A.2^-1 * A.3^-1)^2, A.3^-1 * A.2 * A.1^-1 * A.3 * A.1, A.3^-1 * A.1 * A.3 * A.2^-1 * A.1 * A.3^-2 * A.2 ]
```
Rank-4 entries: 406; maximum group order in file: 2000; rank-4 entries of type [3,3,30]/[30,3,3]/[3,30,3]/[12,3,5]/[5,3,12]: none; there IS an entry 'Chiral 4-polytope with group of order 1440   NSD  Type [ 3, 3, 12 ]' (not one of the audited polytopes: class 4 has order 2880 and is directly regular).

## arXiv:2604.00185v1 (Hubard–Schulte, Two-Orbit Polytopes, 31 Mar 2026) — verbatim reference lines from the extracted text
```
632:[1] J. Bracho, D. Gonza ́lez-Casanova, I. Hubard. Two new chiral 4-polytopes of full rank. In preparation.
635:[4] J. Bracho, I. Hubard and D. Pellicer, Chiral polyhedra in 3-dimensional geometries and from a Petrie-Coxeter construction, Discrete Comput. Geom. 66 (2021), no. 3, 1025– 1052.
674:[31] I. Hubard and B. Trejo, A family of skeletal chiral 3- and 4-polytopes in R4. Preprint
```

## UNAM PAPIIT IN109023 final report (2023), extracted text, lines 47-49 (Spanish, verbatim)
```
El resultado anterior fue utilizado para atacar otro de los problemas que se planteó en el proyecto: clasificar los poliedros esqueléticos quirales cuyo 1-esqueleto está contenido en la gráfica de un 4-politopo convexo regular. La estudiante Trejo, con apoyo de la Dra. Hubard, logró dar dicha clasificación, obteniendo únicamente 4 ejemplos. Por otra parte, la tesis de doctorado de Briseida Trejo está lista para ser enviada a sinodales, con el objetivo que obtenga el grado en los siguientes meses.
Cabe mencionar que una de las metas del proyecto fue la de usar los poliedros esqueléticos quirales cuyo 1-esqueleto está contenido en la gráfica de un 4-politopo convexo regular para construir 4-politopos quirales en el espacio euclidiano de 4 dimensiones. Este trabajo tuvo buenos resultados: de los 4 poliedros quirales que existen cuyo 1-esqueleto está contenido en la gráfica de un 4-politopo convexo regular, se determinaron cuáles de ellos se pueden extender. En estos momentos nos encontramos terminando de escribir los resultados de esto, en conjunto con los que estarán incluidos en la tesis de Briseida Trejo, para un artículo de investigación que se someterá a publicación próximamente.
Se avanzó aún más en esta dirección: el estudiante González Casanova trabajó con la Dra. Hubard y el Dr. Bracho en construir un par de nuevos 4-politpos quirales en el espacio de 4 dimensiones. Para esto, estudió a profundidad algunos 4-politopos estrellados regulares de dicho espacio y les aplicó una serie de operaciones para obtener poliedros quirales. Después, logró encontrar isometrías que lo han ayudado a extender los poliedros a 4-politopos quirales. Así, se encuentra escribiendo sus resultados para poder titularse de la maestría a la brevedad. Una vez que su trabajo esté concluido, nos enfocaremos a escribir el artículo que contenga los resultados mencionados.
```

## Trejo, calculos-gap-github.pdf (42 pp., GitHub briseida/TesisDoctorado, repo description 'Chiral polyhedra contained in the skeletons of convex regular 4-polytopes.', last push 2025-11-23 'Se añaden cálculos de los 4-politopos.')
```
1253:A.5.2 Searching S3 in the 8-cell
1317:Therefore, the 4-polytope found has 16 vertices, 32 edges, 12 faces, and 4 cells.
1363:Therefore, the 4-polytope found has 16 vertices, 32 edges, 12 faces, and 4 cells.
1364:A.5.3 Searching S3 in the 24-cell
1432:Therefore, the 4-polytope found has 16 vertices, 32 edges, 12 faces, and 4 cells.
1476:Therefore, the 4-polytope found has 16 vertices, 32 edges, 12 faces, and 4 cells.
1477:A.5.4 Searching S3 in the 600-cell
1544:Therefore, the 4-polytope found has 120 vertices, 720 edges, 300 faces, and 50 cells.
1578:Therefore, the 4-polytope found has 120 vertices, 720 edges, 300 faces, and 50 cells.
1579:A.5.5 Searching S3 in the 120-cell
1642:Therefore, the 4-polytope found has 600 vertices, 1200 edges, 120 faces, and 5 cells.
1681:Therefore, the 4-polytope found has 600 vertices, 1200 edges, 120 faces, and 5 cells.
--- 120-cell section, group sizes:
Group size.
gap> Size(G);
7200
gap> Size(Group(S2,S3));
12
gap> Size(Group(S3,S1∗S2)); 6
gap> Size(Group(S1,S2∗S3)); 60
gap> Size(Group(S1,S2)); 1440
Therefore, the 4-polytope found has 600 vertices, 1200 edges, 120 faces, and 5 cells.
--- Conder identification in the appendix:
Searching for the polyhedron {30, 3} in the list [3].
Group of the first type polyhedron {30, 3} which appears in [3] listed as : R97.9 : Type {3, 30}20 of order 2880. We will call L the group of this polyhedron.
Group of the second polyhedron of type {30, 3} which appears in [3] listed as: R97.10 : Type {3, 30}40 of order 2880. We will name F the group of this polyhedron.
gap> #R97.10 : Type {3 ,30}_40 Order 2880 mV = 2 mF = 1
Now, we will now see if the only subgroup of F (R97.10) of order 1440 is isomorphic to the group of symmetries of the polyhedron P(S1, S2).
gap> IsIsomorphicGroup(rs2[1],grup303);
true
Therefore the subgroup of rotations of F (R97.10) is isomorphic to the group of P(S1,S2).
```

## Hartley atlas pages (text extracted from HTML)
```
atlas-8-3-96.html :: Group SmallGroup(96,193) Rank 3 Schläfli Type {8,3} Vertices, edges, … 16, 24, 6 Order of s 0 s 1 s 2 12 Order of s 0 s 1 s 2 s 1 8 Also known as
atlas-12-3-288.html :: Group SmallGroup(288,847) Rank 3 Schläfli Type {12,3} Vertices, edges, … 48, 72, 12 Order of s 0 s 1 s 2 24 Order of s 0 s 1 s 2 s 1 12 Also known as
atlas-12-4-384-18044-3.html :: Group SmallGroup(384,18044) Rank 3 Schläfli Type {12,4} Vertices, edges, … 48, 96, 16 Order of s 0 s 1 s 2 24 Order of s 0 s 1 s 2 s 1 8 Also known as
atlas-12-4-384-1706-3.html :: Group SmallGroup(384,1706) Rank 3 Schläfli Type {12,4} Vertices, edges, … 48, 96, 16 Order of s 0 s 1 s 2 24 Order of s 0 s 1 s 2 s 1 4 Also known as
```
