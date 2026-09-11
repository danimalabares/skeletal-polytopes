# Certificates

All matrices act on row vectors from the right (`x -> x*M`, GAP convention); `E(n) = exp(2 pi i/n)`.  Every equation below was verified **exactly** in cyclotomic arithmetic by at least three independent programs (Method 1 in GAP, Method 2 in Sage `CyclotomicField(40)`, the author's GAP check; Method 4 re-verifies Method 1's matrices in a from-scratch `Q(zeta_40)` implementation over Python `Fraction`s).  Nothing is numerical; the decimal values are for orientation only.

## How to read a similarity certificate

A certificate for the ordered pair `a -> b` is a `4 x 4` matrix `M` with

* `M M^T = lambda I` exactly, where `lambda = |w_b|^2 / |w_a|^2` is the ratio of the squared norms of the stored base vertices (all vertices of one realisation have the same norm);
* `det M = + lambda^2` exactly (so `M` is a **proper** similarity: `M = c Q` with `c = sqrt(lambda) > 0`, `Q in SO(4)`; the translation part is `b = 0` because both vertex sets have centroid `0`);
* `x -> x M` maps the stored vertex set of `a` **onto** that of `b`, the edge set onto the edge set, the set of 2-faces onto the set of 2-faces and the set of cells onto the set of cells (each face as the set of its vertices/edges);
* `M^-1 {S1, S2, X_a} M` lies in `Gamma_b` and `M {S1, S2, X_b} M^-1` lies in `Gamma_a`, so `M` conjugates the distinguished group `Gamma_a` onto `Gamma_b`; the conjugated triple `(M^-1 S1 M, M^-1 S2 M, M^-1 X_a M)` is `Gamma_b`-conjugate to the **mirror triple** `(S1^-1, S1^2 S2, X_b)`, i.e. the base flag of `a` is carried to an odd flag of `b` (Method 1, exact).

Consequences.  (i) As **stored**, `a` and `b` are similar with ratio `c = sqrt(lambda) != 1`; they are **not** congruent.  (ii) After the PETCOX normalisation `w -> w/|w|` (every vertex on the unit sphere `S^3`), the matrix `M' = M |w_a|/|w_b|` satisfies `M' M'^T = lambda |w_a|^2/|w_b|^2 I = I` exactly, so the normalised realisations are **properly congruent**: same handedness, not mirror images.  (iii) The pair of stored *generating triples* `(S1,S2,X_a)` and `(S1,S2,X_b)` are enantiomorphic labellings of one and the same geometric polytope.

## The twelve similarity certificates

### 1. `L3-{4,3,3}-1`  (alpha = 1/2)  ~  `L3-{4,3,3}-6`  (alpha = 0)

* row `T = {4,3,3}`, f-vector `(16,32,12,4)`, `|Gamma| = 192`; stored `|w_a|^2 = 3` (~3.000000000000), `|w_b|^2 = 4` (~4.000000000000).
* **Method 1 certificate** (`L3-{4,3,3}-1 -> L3-{4,3,3}-6`, flag-anchored `odd` candidate, hits the intended flag of `b`): `lambda = 4/3` (~1.3333333333333333), `det M = 16/9` (`= +lambda^2`, sign +1), conjugated triple orientation: `mirror`.

    M =
    `2/3`  `0`  `-2/3`  `2/3`
    `0`  `-2/3`  `2/3`  `2/3`
    `-2/3`  `2/3`  `0`  `2/3`
    `2/3`  `2/3`  `2/3`  `0`

    exact checks: traversal True, `M M^T = lambda I` True, `det = +-lambda^2` True, vertices True, edges True, 2-faces True, cells True, `M^-1 S1 M, M^-1 S2 M, M^-1 X_a M in Gamma_b` True/True/True, `M S1 M^-1, M S2 M^-1, M X_b M^-1 in Gamma_a` True/True/True.

* **Method 2 certificate** (`L3-{4,3,3}-1 -> L3-{4,3,3}-6`, `M = B_a^-1 B_b` from the canonical minimising bases; independent Sage arithmetic): `lambda = 4/3` (~1.333333), `det M = 16/9`, sign +1; checks `M M^T = lambda I` True, `det = sign lambda^2` True, vertices True, edges True, faces True, cells True; exhaustive count of similarities fixing `w_a -> w_b`: 12 (det signs `+`).

    M =
    `2/3`  `2/3`  `0`  `-2/3`
    `0`  `2/3`  `-2/3`  `2/3`
    `-2/3`  `2/3`  `2/3`  `0`
    `2/3`  `0`  `2/3`  `2/3`

* **Author's check** (`L3-{4,3,3}-1 -> L3-{4,3,3}-6`): `M = M0 / c` with `M0` the anti-automorphism realiser of the row (below) and `c = 3/2` (exact: `w_a M0 = c w_b` is true); `lambda = 4/3` (`= |w_b|^2/|w_a|^2`: true), `det M = 16/9` (`> 0`: true); structure carried onto `b`: vertices true, edges true, 2-faces true, cells true; `lambda = 1` (isometry as stored): **false**.

* **Method 4 re-verification** (pure Python `Q(zeta_40)`): 4 certificate line(s) for this pair, fields: case_a=L3-{4,3,3}-6, case_b=L3-{4,3,3}-1, candidate=even, lambda_json=3/4, lambda_exact_powerbasis=3/4, lambda_float=0.750000, isometry=False, lambda_ok=True, lambda_real=True, M_real=True, MMt_ok=True, det_json=9/16, det_exact_powerbasis=9/16, det_sign_json=1, det_sign_computed=1, det_ok=True, det_matches_json=True, vertices_onto=True, edges_onto=True, faces_onto=True, cells_onto=True, w_maps_to_w=True, image_flag_orbit_json=odd, image_flag_orbit_computed=odd, flag_orbit_agrees=True, flag_image_kind=base_flag_other_cell, flag_image_agrees=True, anchor_images_agree=True, M_in_Gamma_b=n/a, represents_own_coset_json=False, triple_orientation_json=mirror, all_ok=True; case_a=L3-{4,3,3}-6, case_b=L3-{4,3,3}-1, candidate=odd, lambda_json=3/4, lambda_exact_powerbasis=3/4, lambda_float=0.750000, isometry=False, lambda_ok=True, lambda_real=True, M_real=True, MMt_ok=True, det_json=9/16, det_exact_powerbasis=9/16, det_sign_json=1, det_sign_computed=1, det_ok=True, det_matches_json=True, vertices_onto=True, edges_onto=True, faces_onto=True, cells_onto=True, w_maps_to_w=True, image_flag_orbit_json=odd, image_flag_orbit_computed=odd, flag_orbit_agrees=True, flag_image_kind=2-adjacent(w,e,fS2,c), flag_image_agrees=True, anchor_images_agree=True, M_in_Gamma_b=n/a, represents_own_coset_json=True, triple_orientation_json=mirror, all_ok=True

### 2. `L3-{4,3,3}-2`  (alpha = 2)  ~  `L3-{4,3,3}-3`  (alpha = infinity)

* row `T = {4,3,3}`, f-vector `(16,32,12,4)`, `|Gamma| = 192`; stored `|w_a|^2 = 3/4` (~0.750000000000), `|w_b|^2 = 1` (~1.000000000000).
* **Method 1 certificate** (`L3-{4,3,3}-2 -> L3-{4,3,3}-3`, flag-anchored `odd` candidate, hits the intended flag of `b`): `lambda = 4/3` (~1.3333333333333333), `det M = 16/9` (`= +lambda^2`, sign +1), conjugated triple orientation: `mirror`.

    M =
    `-2/3`  `0`  `2/3`  `-2/3`
    `0`  `2/3`  `-2/3`  `-2/3`
    `2/3`  `-2/3`  `0`  `-2/3`
    `-2/3`  `-2/3`  `-2/3`  `0`

    exact checks: traversal True, `M M^T = lambda I` True, `det = +-lambda^2` True, vertices True, edges True, 2-faces True, cells True, `M^-1 S1 M, M^-1 S2 M, M^-1 X_a M in Gamma_b` True/True/True, `M S1 M^-1, M S2 M^-1, M X_b M^-1 in Gamma_a` True/True/True.

* **Method 2 certificate** (`L3-{4,3,3}-2 -> L3-{4,3,3}-3`, `M = B_a^-1 B_b` from the canonical minimising bases; independent Sage arithmetic): `lambda = 4/3` (~1.333333), `det M = 16/9`, sign +1; checks `M M^T = lambda I` True, `det = sign lambda^2` True, vertices True, edges True, faces True, cells True; exhaustive count of similarities fixing `w_a -> w_b`: 12 (det signs `+`).

    M =
    `2/3`  `0`  `2/3`  `2/3`
    `-2/3`  `2/3`  `2/3`  `0`
    `0`  `-2/3`  `2/3`  `-2/3`
    `-2/3`  `-2/3`  `0`  `2/3`

* **Author's check** (`L3-{4,3,3}-2 -> L3-{4,3,3}-3`): `M = M0 / c` with `M0` the anti-automorphism realiser of the row (below) and `c = -3/2` (exact: `w_a M0 = c w_b` is true); `lambda = 4/3` (`= |w_b|^2/|w_a|^2`: true), `det M = 16/9` (`> 0`: true); structure carried onto `b`: vertices true, edges true, 2-faces true, cells true; `lambda = 1` (isometry as stored): **false**.

* **Method 4 re-verification** (pure Python `Q(zeta_40)`): 4 certificate line(s) for this pair, fields: case_a=L3-{4,3,3}-3, case_b=L3-{4,3,3}-2, candidate=even, lambda_json=3/4, lambda_exact_powerbasis=3/4, lambda_float=0.750000, isometry=False, lambda_ok=True, lambda_real=True, M_real=True, MMt_ok=True, det_json=9/16, det_exact_powerbasis=9/16, det_sign_json=1, det_sign_computed=1, det_ok=True, det_matches_json=True, vertices_onto=True, edges_onto=True, faces_onto=True, cells_onto=True, w_maps_to_w=True, image_flag_orbit_json=odd, image_flag_orbit_computed=odd, flag_orbit_agrees=True, flag_image_kind=base_flag_other_cell, flag_image_agrees=True, anchor_images_agree=True, M_in_Gamma_b=n/a, represents_own_coset_json=False, triple_orientation_json=mirror, all_ok=True; case_a=L3-{4,3,3}-3, case_b=L3-{4,3,3}-2, candidate=odd, lambda_json=3/4, lambda_exact_powerbasis=3/4, lambda_float=0.750000, isometry=False, lambda_ok=True, lambda_real=True, M_real=True, MMt_ok=True, det_json=9/16, det_exact_powerbasis=9/16, det_sign_json=1, det_sign_computed=1, det_ok=True, det_matches_json=True, vertices_onto=True, edges_onto=True, faces_onto=True, cells_onto=True, w_maps_to_w=True, image_flag_orbit_json=odd, image_flag_orbit_computed=odd, flag_orbit_agrees=True, flag_image_kind=2-adjacent(w,e,fS2,c), flag_image_agrees=True, anchor_images_agree=True, M_in_Gamma_b=n/a, represents_own_coset_json=True, triple_orientation_json=mirror, all_ok=True

### 3. `L3-{5,3,3}-3`  (alpha = 2*E(40)^7-3*E(40)^8-2*E(40)^13-E(40)^16-E(40)^21+2*E(40)^23-E(40)^24-E(40)^29+E(40)^31-3*E(40)^32-2*E(40)^37+E(40)^39)  ~  `L3-{5,3,3}-8`  (alpha = 0)

* row `T = {5,3,3}`, f-vector `(600,1200,120,5)`, `|Gamma| = 7200`; stored `|w_a|^2 = 356+220*E(40)^8-220*E(40)^12` (~491.967477524977), `|w_b|^2 = 40+24*E(40)^8-24*E(40)^12` (~54.832815729997).
* **Method 1 certificate** (`L3-{5,3,3}-3 -> L3-{5,3,3}-8`, flag-anchored `odd` candidate, hits the intended flag of `b`): `lambda = -26*E(5)-10*E(5)^2-10*E(5)^3-26*E(5)^4` (~0.11145618000168243), `det M = -932*E(5)-356*E(5)^2-356*E(5)^3-932*E(5)^4` (`= +lambda^2`, sign +1), conjugated triple orientation: `mirror`.

    M =
    `-7/2*E(5)-3/2*E(5)^2-3/2*E(5)^3-7/2*E(5)^4`  `0`  `E(5)+1/2*E(5)^2+1/2*E(5)^3+E(5)^4`  `5/2*E(5)+E(5)^2+E(5)^3+5/2*E(5)^4`
    `0`  `-1/2*E(5)-1/2*E(5)^4`  `4*E(5)+3/2*E(5)^2+3/2*E(5)^3+4*E(5)^4`  `-3/2*E(5)-1/2*E(5)^2-1/2*E(5)^3-3/2*E(5)^4`
    `E(5)+1/2*E(5)^2+1/2*E(5)^3+E(5)^4`  `4*E(5)+3/2*E(5)^2+3/2*E(5)^3+4*E(5)^4`  `E(5)+1/2*E(5)^2+1/2*E(5)^3+E(5)^4`  `E(5)+1/2*E(5)^2+1/2*E(5)^3+E(5)^4`
    `5/2*E(5)+E(5)^2+E(5)^3+5/2*E(5)^4`  `-3/2*E(5)-1/2*E(5)^2-1/2*E(5)^3-3/2*E(5)^4`  `E(5)+1/2*E(5)^2+1/2*E(5)^3+E(5)^4`  `3*E(5)+E(5)^2+E(5)^3+3*E(5)^4`

    exact checks: traversal True, `M M^T = lambda I` True, `det = +-lambda^2` True, vertices True, edges True, 2-faces True, cells True, `M^-1 S1 M, M^-1 S2 M, M^-1 X_a M in Gamma_b` True/True/True, `M S1 M^-1, M S2 M^-1, M X_b M^-1 in Gamma_a` True/True/True.

* **Method 2 certificate** (`L3-{5,3,3}-3 -> L3-{5,3,3}-8`, `M = B_a^-1 B_b` from the canonical minimising bases; independent Sage arithmetic): `lambda = 10-16*E(40)^8+16*E(40)^12` (~0.111456), `det M = 356-576*E(40)^8+576*E(40)^12`, sign +1; checks `M M^T = lambda I` True, `det = sign lambda^2` True, vertices True, edges True, faces True, cells True; exhaustive count of similarities fixing `w_a -> w_b`: 12 (det signs `+`).

    M =
    `1/2*E(40)^8-1/2*E(40)^12`  `-1+3/2*E(40)^8-3/2*E(40)^12`  `-1+3/2*E(40)^8-3/2*E(40)^12`  `-1+3/2*E(40)^8-3/2*E(40)^12`
    `1-3/2*E(40)^8+3/2*E(40)^12`  `1/2-1/2*E(40)^8+1/2*E(40)^12`  `-1+2*E(40)^8-2*E(40)^12`  `1/2-E(40)^8+E(40)^12`
    `-1+3/2*E(40)^8-3/2*E(40)^12`  `1-2*E(40)^8+2*E(40)^12`  `-1/2+E(40)^8-E(40)^12`  `-1/2+1/2*E(40)^8-1/2*E(40)^12`
    `1-3/2*E(40)^8+3/2*E(40)^12`  `1/2-E(40)^8+E(40)^12`  `1/2-1/2*E(40)^8+1/2*E(40)^12`  `-1+2*E(40)^8-2*E(40)^12`

* **Author's check** (`L3-{5,3,3}-3 -> L3-{5,3,3}-8`): `M = M0 / c` with `M0` the anti-automorphism realiser of the row (below) and `c = 4*E(5)+10*E(5)^2+10*E(5)^3+4*E(5)^4` (exact: `w_a M0 = c w_b` is true); `lambda = -26*E(5)-10*E(5)^2-10*E(5)^3-26*E(5)^4` (`= |w_b|^2/|w_a|^2`: true), `det M = -932*E(5)-356*E(5)^2-356*E(5)^3-932*E(5)^4` (`> 0`: true); structure carried onto `b`: vertices true, edges true, 2-faces true, cells true; `lambda = 1` (isometry as stored): **false**.

* **Method 4 re-verification** (pure Python `Q(zeta_40)`): 4 certificate line(s) for this pair, fields: case_a=L3-{5,3,3}-8, case_b=L3-{5,3,3}-3, candidate=even, lambda_json=-5/2*E(5)-13/2*E(5)^2-13/2*E(5)^3-5/2*E(5)^4, lambda_exact_powerbasis=13/2+4*E(40)^8-4*E(40)^12, lambda_float=8.972136, isometry=False, lambda_ok=True, lambda_real=True, M_real=True, MMt_ok=True, det_json=-89/4*E(5)-233/4*E(5)^2-233/4*E(5)^3-89/4*E(5)^4, det_exact_powerbasis=233/4+36*E(40)^8-36*E(40)^12, det_sign_json=1, det_sign_computed=1, det_ok=True, det_matches_json=True, vertices_onto=True, edges_onto=True, faces_onto=True, cells_onto=True, w_maps_to_w=True, image_flag_orbit_json=odd, image_flag_orbit_computed=odd, flag_orbit_agrees=True, flag_image_kind=base_flag_other_cell, flag_image_agrees=True, anchor_images_agree=True, M_in_Gamma_b=n/a, represents_own_coset_json=False, triple_orientation_json=mirror, all_ok=True; case_a=L3-{5,3,3}-8, case_b=L3-{5,3,3}-3, candidate=odd, lambda_json=-5/2*E(5)-13/2*E(5)^2-13/2*E(5)^3-5/2*E(5)^4, lambda_exact_powerbasis=13/2+4*E(40)^8-4*E(40)^12, lambda_float=8.972136, isometry=False, lambda_ok=True, lambda_real=True, M_real=True, MMt_ok=True, det_json=-89/4*E(5)-233/4*E(5)^2-233/4*E(5)^3-89/4*E(5)^4, det_exact_powerbasis=233/4+36*E(40)^8-36*E(40)^12, det_sign_json=1, det_sign_computed=1, det_ok=True, det_matches_json=True, vertices_onto=True, edges_onto=True, faces_onto=True, cells_onto=True, w_maps_to_w=True, image_flag_orbit_json=odd, image_flag_orbit_computed=odd, flag_orbit_agrees=True, flag_image_kind=2-adjacent(w,e,fS2,c), flag_image_agrees=True, anchor_images_agree=True, M_in_Gamma_b=n/a, represents_own_coset_json=True, triple_orientation_json=mirror, all_ok=True

### 4. `L3-{5,3,5/2}-1`  (alpha = 2/3*E(40)^7-1/3*E(40)^8-2/3*E(40)^13-2/3*E(40)^16-2/3*E(40)^21+2/3*E(40)^23-2/3*E(40)^24-2/3*E(40)^29+2/3*E(40)^31-1/3*E(40)^32-2/3*E(40)^37+2/3*E(40)^39)  ~  `L3-{5,3,5/2}-4`  (alpha = E(40)^7-E(40)^13-E(40)^16-E(40)^21+E(40)^23-E(40)^24-E(40)^29+E(40)^31-E(40)^37+E(40)^39)

* row `T = {5,3,5/2}`, f-vector `(240,480,120,20)`, `|Gamma| = 2880`; stored `|w_a|^2 = 208-90*E(40)-90*E(40)^3-56*E(40)^5+90*E(40)^7+128*E(40)^8-90*E(40)^9-128*E(40)^12+146*E(40)^15` (~1.970286052727), `|w_b|^2 = 20-8*E(40)-8*E(40)^3-5*E(40)^5+8*E(40)^7+12*E(40)^8-8*E(40)^9-12*E(40)^12+13*E(40)^15` (~2.039375162967).
* **Method 1 certificate** (`L3-{5,3,5/2}-1 -> L3-{5,3,5/2}-4`, flag-anchored `odd` candidate, hits the intended flag of `b`): `lambda = 1/3*E(40)^7-5/6*E(40)^8-1/3*E(40)^13-2/3*E(40)^16-1/3*E(40)^21+1/3*E(40)^23-2/3*E(40)^24-1/3*E(40)^29+1/3*E(40)^31-5/6*E(40)^32-1/3*E(40)^37+1/3*E(40)^39` (~1.0350655226660492), `det M = 5/9*E(40)^7-17/18*E(40)^8-5/9*E(40)^13-25/36*E(40)^16-4/9*E(40)^21+5/9*E(40)^23-25/36*E(40)^24-4/9*E(40)^29+4/9*E(40)^31-17/18*E(40)^32-5/9*E(40)^37+4/9*E(40)^39` (`= +lambda^2`, sign +1), conjugated triple orientation: `mirror`.

    M =
    `1/2*E(40)^7-1/4*E(40)^8-1/2*E(40)^13-1/4*E(40)^16-1/4*E(40)^21+1/2*E(40)^23-1/4*E(40)^24-1/4*E(40)^29+1/4*E(40)^31-1/4*E(40)^32-1/2*E(40)^37+1/4*E(40)^39`  `0`  `1/12*E(40)^7-1/6*E(40)^8-1/12*E(40)^13-5/12*E(40)^16-1/6*E(40)^21+1/12*E(40)^23-5/12*E(40)^24-1/6*E(40)^29+1/6*E(40)^31-1/6*E(40)^32-1/12*E(40)^37+1/6*E(40)^39`  `1/12*E(40)^7-1/12*E(40)^8-1/12*E(40)^13-1/6*E(40)^16-1/12*E(40)^21+1/12*E(40)^23-1/6*E(40)^24-1/12*E(40)^29+1/12*E(40)^31-1/12*E(40)^32-1/12*E(40)^37+1/12*E(40)^39`
    `0`  `1/4*E(40)^7-1/4*E(40)^8-1/4*E(40)^13-1/2*E(40)^16-1/4*E(40)^21+1/4*E(40)^23-1/2*E(40)^24-1/4*E(40)^29+1/4*E(40)^31-1/4*E(40)^32-1/4*E(40)^37+1/4*E(40)^39`  `-5/12*E(40)^7+1/6*E(40)^8+5/12*E(40)^13+1/12*E(40)^16+1/6*E(40)^21-5/12*E(40)^23+1/12*E(40)^24+1/6*E(40)^29-1/6*E(40)^31+1/6*E(40)^32+5/12*E(40)^37-1/6*E(40)^39`  `1/6*E(40)^7-1/12*E(40)^8-1/6*E(40)^13-1/12*E(40)^16-1/12*E(40)^21+1/6*E(40)^23-1/12*E(40)^24-1/12*E(40)^29+1/12*E(40)^31-1/12*E(40)^32-1/6*E(40)^37+1/12*E(40)^39`
    `1/12*E(40)^7-1/6*E(40)^8-1/12*E(40)^13-5/12*E(40)^16-1/6*E(40)^21+1/12*E(40)^23-5/12*E(40)^24-1/6*E(40)^29+1/6*E(40)^31-1/6*E(40)^32-1/12*E(40)^37+1/6*E(40)^39`  `-5/12*E(40)^7+1/6*E(40)^8+5/12*E(40)^13+1/12*E(40)^16+1/6*E(40)^21-5/12*E(40)^23+1/12*E(40)^24+1/6*E(40)^29-1/6*E(40)^31+1/6*E(40)^32+5/12*E(40)^37-1/6*E(40)^39`  `-1/4*E(40)^7+1/6*E(40)^8+1/4*E(40)^13+1/4*E(40)^16+1/6*E(40)^21-1/4*E(40)^23+1/4*E(40)^24+1/6*E(40)^29-1/6*E(40)^31+1/6*E(40)^32+1/4*E(40)^37-1/6*E(40)^39`  `-1/12*E(40)^7+1/12*E(40)^13-1/12*E(40)^16-1/12*E(40)^23-1/12*E(40)^24+1/12*E(40)^37`
    `1/12*E(40)^7-1/12*E(40)^8-1/12*E(40)^13-1/6*E(40)^16-1/12*E(40)^21+1/12*E(40)^23-1/6*E(40)^24-1/12*E(40)^29+1/12*E(40)^31-1/12*E(40)^32-1/12*E(40)^37+1/12*E(40)^39`  `1/6*E(40)^7-1/12*E(40)^8-1/6*E(40)^13-1/12*E(40)^16-1/12*E(40)^21+1/6*E(40)^23-1/12*E(40)^24-1/12*E(40)^29+1/12*E(40)^31-1/12*E(40)^32-1/6*E(40)^37+1/12*E(40)^39`  `-1/12*E(40)^7+1/12*E(40)^13-1/12*E(40)^16-1/12*E(40)^23-1/12*E(40)^24+1/12*E(40)^37`  `-1/2*E(40)^7+1/3*E(40)^8+1/2*E(40)^13+1/2*E(40)^16+1/3*E(40)^21-1/2*E(40)^23+1/2*E(40)^24+1/3*E(40)^29-1/3*E(40)^31+1/3*E(40)^32+1/2*E(40)^37-1/3*E(40)^39`

    exact checks: traversal True, `M M^T = lambda I` True, `det = +-lambda^2` True, vertices True, edges True, 2-faces True, cells True, `M^-1 S1 M, M^-1 S2 M, M^-1 X_a M in Gamma_b` True/True/True, `M S1 M^-1, M S2 M^-1, M X_b M^-1 in Gamma_a` True/True/True.

* **Method 2 certificate** (`L3-{5,3,5/2}-1 -> L3-{5,3,5/2}-4`, `M = B_a^-1 B_b` from the canonical minimising bases; independent Sage arithmetic): `lambda = 2/3+1/3*E(40)^5-1/6*E(40)^8+1/6*E(40)^12-1/3*E(40)^15` (~1.035066), `det M = 25/36-1/9*E(40)-1/9*E(40)^3+5/9*E(40)^5+1/9*E(40)^7-1/4*E(40)^8-1/9*E(40)^9+1/4*E(40)^12-4/9*E(40)^15`, sign +1; checks `M M^T = lambda I` True, `det = sign lambda^2` True, vertices True, edges True, faces True, cells True; exhaustive count of similarities fixing `w_a -> w_b`: 12 (det signs `+`).

    M =
    `5/12+1/3*E(40)^5-1/6*E(40)^8+1/6*E(40)^12-1/3*E(40)^15`  `-1/12+1/12*E(40)+1/12*E(40)^3-1/6*E(40)^5-1/12*E(40)^7-1/4*E(40)^8+1/12*E(40)^9+1/4*E(40)^12+1/12*E(40)^15`  `1/6+1/12*E(40)^5+1/12*E(40)^8-1/12*E(40)^12-1/12*E(40)^15`  `1/6+1/12*E(40)+1/12*E(40)^3+1/12*E(40)^5-1/12*E(40)^7+1/12*E(40)^9-1/6*E(40)^15`
    `1/12-1/12*E(40)-1/12*E(40)^3+1/6*E(40)^5+1/12*E(40)^7+1/4*E(40)^8-1/12*E(40)^9-1/4*E(40)^12-1/12*E(40)^15`  `5/12+1/3*E(40)^5-1/6*E(40)^8+1/6*E(40)^12-1/3*E(40)^15`  `-1/6-1/12*E(40)-1/12*E(40)^3-1/12*E(40)^5+1/12*E(40)^7-1/12*E(40)^9+1/6*E(40)^15`  `1/6+1/12*E(40)^5+1/12*E(40)^8-1/12*E(40)^12-1/12*E(40)^15`
    `1/6+1/12*E(40)^5+1/12*E(40)^8-1/12*E(40)^12-1/12*E(40)^15`  `1/6+1/12*E(40)+1/12*E(40)^3+1/12*E(40)^5-1/12*E(40)^7+1/12*E(40)^9-1/6*E(40)^15`  `1/4+1/6*E(40)+1/6*E(40)^3-1/6*E(40)^7-1/6*E(40)^8+1/6*E(40)^9+1/6*E(40)^12-1/6*E(40)^15`  `-5/12+1/12*E(40)+1/12*E(40)^3-1/3*E(40)^5-1/12*E(40)^7+1/12*E(40)^8+1/12*E(40)^9-1/12*E(40)^12+1/4*E(40)^15`
    `-1/6-1/12*E(40)-1/12*E(40)^3-1/12*E(40)^5+1/12*E(40)^7-1/12*E(40)^9+1/6*E(40)^15`  `1/6+1/12*E(40)^5+1/12*E(40)^8-1/12*E(40)^12-1/12*E(40)^15`  `5/12-1/12*E(40)-1/12*E(40)^3+1/3*E(40)^5+1/12*E(40)^7-1/12*E(40)^8-1/12*E(40)^9+1/12*E(40)^12-1/4*E(40)^15`  `1/4+1/6*E(40)+1/6*E(40)^3-1/6*E(40)^7-1/6*E(40)^8+1/6*E(40)^9+1/6*E(40)^12-1/6*E(40)^15`

* **Author's check** (`L3-{5,3,5/2}-1 -> L3-{5,3,5/2}-4`): `M = M0 / c` with `M0` the anti-automorphism realiser of the row (below) and `c = -8/5*E(40)^7-12/5*E(40)^8+8/5*E(40)^13-28/5*E(40)^16+12/5*E(40)^21-8/5*E(40)^23-28/5*E(40)^24+12/5*E(40)^29-12/5*E(40)^31-12/5*E(40)^32+8/5*E(40)^37-12/5*E(40)^39` (exact: `w_a M0 = c w_b` is true); `lambda = 1/3*E(40)^7-5/6*E(40)^8-1/3*E(40)^13-2/3*E(40)^16-1/3*E(40)^21+1/3*E(40)^23-2/3*E(40)^24-1/3*E(40)^29+1/3*E(40)^31-5/6*E(40)^32-1/3*E(40)^37+1/3*E(40)^39` (`= |w_b|^2/|w_a|^2`: true), `det M = 5/9*E(40)^7-17/18*E(40)^8-5/9*E(40)^13-25/36*E(40)^16-4/9*E(40)^21+5/9*E(40)^23-25/36*E(40)^24-4/9*E(40)^29+4/9*E(40)^31-17/18*E(40)^32-5/9*E(40)^37+4/9*E(40)^39` (`> 0`: true); structure carried onto `b`: vertices true, edges true, 2-faces true, cells true; `lambda = 1` (isometry as stored): **false**.

* **Method 4 re-verification** (pure Python `Q(zeta_40)`): 4 certificate line(s) for this pair, fields: case_a=L3-{5,3,5/2}-4, case_b=L3-{5,3,5/2}-1, candidate=even, lambda_json=-4/3*E(40)^7-8/3*E(40)^8+4/3*E(40)^13-14/3*E(40)^16+8/3*E(40)^21-4/3*E(40)^23-14/3*E(40)^24+8/3*E(40)^29-8/3*E(40)^31-8/3*E(40)^32+4/3*E(40)^37-8/3*E(40)^39, lambda_exact_powerbasis=14/3-4/3*E(40)-4/3*E(40)^3-4/3*E(40)^5+4/3*E(40)^7+2*E(40)^8-4/3*E(40)^9-2*E(40)^12+8/3*E(40)^15, lambda_float=0.966122, isometry=False, lambda_ok=True, lambda_real=True, M_real=True, MMt_ok=True, det_json=-112/9*E(40)^7-164/9*E(40)^8+112/9*E(40)^13-392/9*E(40)^16+272/9*E(40)^21-112/9*E(40)^23-392/9*E(40)^24+272/9*E(40)^29-272/9*E(40)^31-164/9*E(40)^32+112/9*E(40)^37-272/9*E(40)^39, det_exact_powerbasis=392/9-160/9*E(40)-160/9*E(40)^3-112/9*E(40)^5+160/9*E(40)^7+76/3*E(40)^8-160/9*E(40)^9-76/3*E(40)^12+272/9*E(40)^15, det_sign_json=1, det_sign_computed=1, det_ok=True, det_matches_json=True, vertices_onto=True, edges_onto=True, faces_onto=True, cells_onto=True, w_maps_to_w=True, image_flag_orbit_json=odd, image_flag_orbit_computed=odd, flag_orbit_agrees=True, flag_image_kind=base_flag_other_cell, flag_image_agrees=True, anchor_images_agree=True, M_in_Gamma_b=n/a, represents_own_coset_json=False, triple_orientation_json=mirror, all_ok=True; case_a=L3-{5,3,5/2}-4, case_b=L3-{5,3,5/2}-1, candidate=odd, lambda_json=-4/3*E(40)^7-8/3*E(40)^8+4/3*E(40)^13-14/3*E(40)^16+8/3*E(40)^21-4/3*E(40)^23-14/3*E(40)^24+8/3*E(40)^29-8/3*E(40)^31-8/3*E(40)^32+4/3*E(40)^37-8/3*E(40)^39, lambda_exact_powerbasis=14/3-4/3*E(40)-4/3*E(40)^3-4/3*E(40)^5+4/3*E(40)^7+2*E(40)^8-4/3*E(40)^9-2*E(40)^12+8/3*E(40)^15, lambda_float=0.966122, isometry=False, lambda_ok=True, lambda_real=True, M_real=True, MMt_ok=True, det_json=-112/9*E(40)^7-164/9*E(40)^8+112/9*E(40)^13-392/9*E(40)^16+272/9*E(40)^21-112/9*E(40)^23-392/9*E(40)^24+272/9*E(40)^29-272/9*E(40)^31-164/9*E(40)^32+112/9*E(40)^37-272/9*E(40)^39, det_exact_powerbasis=392/9-160/9*E(40)-160/9*E(40)^3-112/9*E(40)^5+160/9*E(40)^7+76/3*E(40)^8-160/9*E(40)^9-76/3*E(40)^12+272/9*E(40)^15, det_sign_json=1, det_sign_computed=1, det_ok=True, det_matches_json=True, vertices_onto=True, edges_onto=True, faces_onto=True, cells_onto=True, w_maps_to_w=True, image_flag_orbit_json=odd, image_flag_orbit_computed=odd, flag_orbit_agrees=True, flag_image_kind=2-adjacent(w,e,fS2,c), flag_image_agrees=True, anchor_images_agree=True, M_in_Gamma_b=n/a, represents_own_coset_json=True, triple_orientation_json=mirror, all_ok=True

### 5. `L3-{5,3,5/2}-2`  (alpha = -2/3*E(40)^7-1/3*E(40)^8+2/3*E(40)^13-2/3*E(40)^16+2/3*E(40)^21-2/3*E(40)^23-2/3*E(40)^24+2/3*E(40)^29-2/3*E(40)^31-1/3*E(40)^32+2/3*E(40)^37-2/3*E(40)^39)  ~  `L3-{5,3,5/2}-3`  (alpha = -E(40)^7+E(40)^13-E(40)^16+E(40)^21-E(40)^23-E(40)^24+E(40)^29-E(40)^31+E(40)^37-E(40)^39)

* row `T = {5,3,5/2}`, f-vector `(240,480,120,20)`, `|Gamma| = 2880`; stored `|w_a|^2 = 208+90*E(40)+90*E(40)^3+56*E(40)^5-90*E(40)^7+128*E(40)^8+90*E(40)^9-128*E(40)^12-146*E(40)^15` (~572.246415067246), `|w_b|^2 = 20+8*E(40)+8*E(40)^3+5*E(40)^5-8*E(40)^7+12*E(40)^8+8*E(40)^9-12*E(40)^12-13*E(40)^15` (~52.793440567030).
* **Method 1 certificate** (`L3-{5,3,5/2}-2 -> L3-{5,3,5/2}-3`, flag-anchored `odd` candidate, hits the intended flag of `b`): `lambda = -1/3*E(40)^7-5/6*E(40)^8+1/3*E(40)^13-2/3*E(40)^16+1/3*E(40)^21-1/3*E(40)^23-2/3*E(40)^24+1/3*E(40)^29-1/3*E(40)^31-5/6*E(40)^32+1/3*E(40)^37-1/3*E(40)^39` (~0.09225648108398585), `det M = -5/9*E(40)^7-17/18*E(40)^8+5/9*E(40)^13-25/36*E(40)^16+4/9*E(40)^21-5/9*E(40)^23-25/36*E(40)^24+4/9*E(40)^29-4/9*E(40)^31-17/18*E(40)^32+5/9*E(40)^37-4/9*E(40)^39` (`= +lambda^2`, sign +1), conjugated triple orientation: `mirror`.

    M =
    `-1/2*E(40)^7-1/4*E(40)^8+1/2*E(40)^13-1/4*E(40)^16+1/4*E(40)^21-1/2*E(40)^23-1/4*E(40)^24+1/4*E(40)^29-1/4*E(40)^31-1/4*E(40)^32+1/2*E(40)^37-1/4*E(40)^39`  `0`  `-1/12*E(40)^7-1/6*E(40)^8+1/12*E(40)^13-5/12*E(40)^16+1/6*E(40)^21-1/12*E(40)^23-5/12*E(40)^24+1/6*E(40)^29-1/6*E(40)^31-1/6*E(40)^32+1/12*E(40)^37-1/6*E(40)^39`  `-1/12*E(40)^7-1/12*E(40)^8+1/12*E(40)^13-1/6*E(40)^16+1/12*E(40)^21-1/12*E(40)^23-1/6*E(40)^24+1/12*E(40)^29-1/12*E(40)^31-1/12*E(40)^32+1/12*E(40)^37-1/12*E(40)^39`
    `0`  `-1/4*E(40)^7-1/4*E(40)^8+1/4*E(40)^13-1/2*E(40)^16+1/4*E(40)^21-1/4*E(40)^23-1/2*E(40)^24+1/4*E(40)^29-1/4*E(40)^31-1/4*E(40)^32+1/4*E(40)^37-1/4*E(40)^39`  `5/12*E(40)^7+1/6*E(40)^8-5/12*E(40)^13+1/12*E(40)^16-1/6*E(40)^21+5/12*E(40)^23+1/12*E(40)^24-1/6*E(40)^29+1/6*E(40)^31+1/6*E(40)^32-5/12*E(40)^37+1/6*E(40)^39`  `-1/6*E(40)^7-1/12*E(40)^8+1/6*E(40)^13-1/12*E(40)^16+1/12*E(40)^21-1/6*E(40)^23-1/12*E(40)^24+1/12*E(40)^29-1/12*E(40)^31-1/12*E(40)^32+1/6*E(40)^37-1/12*E(40)^39`
    `-1/12*E(40)^7-1/6*E(40)^8+1/12*E(40)^13-5/12*E(40)^16+1/6*E(40)^21-1/12*E(40)^23-5/12*E(40)^24+1/6*E(40)^29-1/6*E(40)^31-1/6*E(40)^32+1/12*E(40)^37-1/6*E(40)^39`  `5/12*E(40)^7+1/6*E(40)^8-5/12*E(40)^13+1/12*E(40)^16-1/6*E(40)^21+5/12*E(40)^23+1/12*E(40)^24-1/6*E(40)^29+1/6*E(40)^31+1/6*E(40)^32-5/12*E(40)^37+1/6*E(40)^39`  `1/4*E(40)^7+1/6*E(40)^8-1/4*E(40)^13+1/4*E(40)^16-1/6*E(40)^21+1/4*E(40)^23+1/4*E(40)^24-1/6*E(40)^29+1/6*E(40)^31+1/6*E(40)^32-1/4*E(40)^37+1/6*E(40)^39`  `1/12*E(40)^7-1/12*E(40)^13-1/12*E(40)^16+1/12*E(40)^23-1/12*E(40)^24-1/12*E(40)^37`
    `-1/12*E(40)^7-1/12*E(40)^8+1/12*E(40)^13-1/6*E(40)^16+1/12*E(40)^21-1/12*E(40)^23-1/6*E(40)^24+1/12*E(40)^29-1/12*E(40)^31-1/12*E(40)^32+1/12*E(40)^37-1/12*E(40)^39`  `-1/6*E(40)^7-1/12*E(40)^8+1/6*E(40)^13-1/12*E(40)^16+1/12*E(40)^21-1/6*E(40)^23-1/12*E(40)^24+1/12*E(40)^29-1/12*E(40)^31-1/12*E(40)^32+1/6*E(40)^37-1/12*E(40)^39`  `1/12*E(40)^7-1/12*E(40)^13-1/12*E(40)^16+1/12*E(40)^23-1/12*E(40)^24-1/12*E(40)^37`  `1/2*E(40)^7+1/3*E(40)^8-1/2*E(40)^13+1/2*E(40)^16-1/3*E(40)^21+1/2*E(40)^23+1/2*E(40)^24-1/3*E(40)^29+1/3*E(40)^31+1/3*E(40)^32-1/2*E(40)^37+1/3*E(40)^39`

    exact checks: traversal True, `M M^T = lambda I` True, `det = +-lambda^2` True, vertices True, edges True, 2-faces True, cells True, `M^-1 S1 M, M^-1 S2 M, M^-1 X_a M in Gamma_b` True/True/True, `M S1 M^-1, M S2 M^-1, M X_b M^-1 in Gamma_a` True/True/True.

* **Method 2 certificate** (`L3-{5,3,5/2}-2 -> L3-{5,3,5/2}-3`, `M = B_a^-1 B_b` from the canonical minimising bases; independent Sage arithmetic): `lambda = 2/3-1/3*E(40)^5-1/6*E(40)^8+1/6*E(40)^12+1/3*E(40)^15` (~0.092256), `det M = 25/36+1/9*E(40)+1/9*E(40)^3-5/9*E(40)^5-1/9*E(40)^7-1/4*E(40)^8+1/9*E(40)^9+1/4*E(40)^12+4/9*E(40)^15`, sign +1; checks `M M^T = lambda I` True, `det = sign lambda^2` True, vertices True, edges True, faces True, cells True; exhaustive count of similarities fixing `w_a -> w_b`: 12 (det signs `+`).

    M =
    `5/12-1/3*E(40)^5-1/6*E(40)^8+1/6*E(40)^12+1/3*E(40)^15`  `-1/12-1/12*E(40)-1/12*E(40)^3+1/6*E(40)^5+1/12*E(40)^7-1/4*E(40)^8-1/12*E(40)^9+1/4*E(40)^12-1/12*E(40)^15`  `1/6-1/12*E(40)^5+1/12*E(40)^8-1/12*E(40)^12+1/12*E(40)^15`  `1/6-1/12*E(40)-1/12*E(40)^3-1/12*E(40)^5+1/12*E(40)^7-1/12*E(40)^9+1/6*E(40)^15`
    `1/12+1/12*E(40)+1/12*E(40)^3-1/6*E(40)^5-1/12*E(40)^7+1/4*E(40)^8+1/12*E(40)^9-1/4*E(40)^12+1/12*E(40)^15`  `5/12-1/3*E(40)^5-1/6*E(40)^8+1/6*E(40)^12+1/3*E(40)^15`  `-1/6+1/12*E(40)+1/12*E(40)^3+1/12*E(40)^5-1/12*E(40)^7+1/12*E(40)^9-1/6*E(40)^15`  `1/6-1/12*E(40)^5+1/12*E(40)^8-1/12*E(40)^12+1/12*E(40)^15`
    `1/6-1/12*E(40)^5+1/12*E(40)^8-1/12*E(40)^12+1/12*E(40)^15`  `1/6-1/12*E(40)-1/12*E(40)^3-1/12*E(40)^5+1/12*E(40)^7-1/12*E(40)^9+1/6*E(40)^15`  `1/4-1/6*E(40)-1/6*E(40)^3+1/6*E(40)^7-1/6*E(40)^8-1/6*E(40)^9+1/6*E(40)^12+1/6*E(40)^15`  `-5/12-1/12*E(40)-1/12*E(40)^3+1/3*E(40)^5+1/12*E(40)^7+1/12*E(40)^8-1/12*E(40)^9-1/12*E(40)^12-1/4*E(40)^15`
    `-1/6+1/12*E(40)+1/12*E(40)^3+1/12*E(40)^5-1/12*E(40)^7+1/12*E(40)^9-1/6*E(40)^15`  `1/6-1/12*E(40)^5+1/12*E(40)^8-1/12*E(40)^12+1/12*E(40)^15`  `5/12+1/12*E(40)+1/12*E(40)^3-1/3*E(40)^5-1/12*E(40)^7-1/12*E(40)^8+1/12*E(40)^9+1/12*E(40)^12+1/4*E(40)^15`  `1/4-1/6*E(40)-1/6*E(40)^3+1/6*E(40)^7-1/6*E(40)^8-1/6*E(40)^9+1/6*E(40)^12+1/6*E(40)^15`

* **Author's check** (`L3-{5,3,5/2}-2 -> L3-{5,3,5/2}-3`): `M = M0 / c` with `M0` the anti-automorphism realiser of the row (below) and `c = 8/5*E(40)^7-12/5*E(40)^8-8/5*E(40)^13-28/5*E(40)^16-12/5*E(40)^21+8/5*E(40)^23-28/5*E(40)^24-12/5*E(40)^29+12/5*E(40)^31-12/5*E(40)^32-8/5*E(40)^37+12/5*E(40)^39` (exact: `w_a M0 = c w_b` is true); `lambda = -1/3*E(40)^7-5/6*E(40)^8+1/3*E(40)^13-2/3*E(40)^16+1/3*E(40)^21-1/3*E(40)^23-2/3*E(40)^24+1/3*E(40)^29-1/3*E(40)^31-5/6*E(40)^32+1/3*E(40)^37-1/3*E(40)^39` (`= |w_b|^2/|w_a|^2`: true), `det M = -5/9*E(40)^7-17/18*E(40)^8+5/9*E(40)^13-25/36*E(40)^16+4/9*E(40)^21-5/9*E(40)^23-25/36*E(40)^24+4/9*E(40)^29-4/9*E(40)^31-17/18*E(40)^32+5/9*E(40)^37-4/9*E(40)^39` (`> 0`: true); structure carried onto `b`: vertices true, edges true, 2-faces true, cells true; `lambda = 1` (isometry as stored): **false**.

* **Method 4 re-verification** (pure Python `Q(zeta_40)`): 4 certificate line(s) for this pair, fields: case_a=L3-{5,3,5/2}-3, case_b=L3-{5,3,5/2}-2, candidate=even, lambda_json=4/3*E(40)^7-8/3*E(40)^8-4/3*E(40)^13-14/3*E(40)^16-8/3*E(40)^21+4/3*E(40)^23-14/3*E(40)^24-8/3*E(40)^29+8/3*E(40)^31-8/3*E(40)^32-4/3*E(40)^37+8/3*E(40)^39, lambda_exact_powerbasis=14/3+4/3*E(40)+4/3*E(40)^3+4/3*E(40)^5-4/3*E(40)^7+2*E(40)^8+4/3*E(40)^9-2*E(40)^12-8/3*E(40)^15, lambda_float=10.839347, isometry=False, lambda_ok=True, lambda_real=True, M_real=True, MMt_ok=True, det_json=112/9*E(40)^7-164/9*E(40)^8-112/9*E(40)^13-392/9*E(40)^16-272/9*E(40)^21+112/9*E(40)^23-392/9*E(40)^24-272/9*E(40)^29+272/9*E(40)^31-164/9*E(40)^32-112/9*E(40)^37+272/9*E(40)^39, det_exact_powerbasis=392/9+160/9*E(40)+160/9*E(40)^3+112/9*E(40)^5-160/9*E(40)^7+76/3*E(40)^8+160/9*E(40)^9-76/3*E(40)^12-272/9*E(40)^15, det_sign_json=1, det_sign_computed=1, det_ok=True, det_matches_json=True, vertices_onto=True, edges_onto=True, faces_onto=True, cells_onto=True, w_maps_to_w=True, image_flag_orbit_json=odd, image_flag_orbit_computed=odd, flag_orbit_agrees=True, flag_image_kind=base_flag_other_cell, flag_image_agrees=True, anchor_images_agree=True, M_in_Gamma_b=n/a, represents_own_coset_json=False, triple_orientation_json=mirror, all_ok=True; case_a=L3-{5,3,5/2}-3, case_b=L3-{5,3,5/2}-2, candidate=odd, lambda_json=4/3*E(40)^7-8/3*E(40)^8-4/3*E(40)^13-14/3*E(40)^16-8/3*E(40)^21+4/3*E(40)^23-14/3*E(40)^24-8/3*E(40)^29+8/3*E(40)^31-8/3*E(40)^32-4/3*E(40)^37+8/3*E(40)^39, lambda_exact_powerbasis=14/3+4/3*E(40)+4/3*E(40)^3+4/3*E(40)^5-4/3*E(40)^7+2*E(40)^8+4/3*E(40)^9-2*E(40)^12-8/3*E(40)^15, lambda_float=10.839347, isometry=False, lambda_ok=True, lambda_real=True, M_real=True, MMt_ok=True, det_json=112/9*E(40)^7-164/9*E(40)^8-112/9*E(40)^13-392/9*E(40)^16-272/9*E(40)^21+112/9*E(40)^23-392/9*E(40)^24-272/9*E(40)^29+272/9*E(40)^31-164/9*E(40)^32-112/9*E(40)^37+272/9*E(40)^39, det_exact_powerbasis=392/9+160/9*E(40)+160/9*E(40)^3+112/9*E(40)^5-160/9*E(40)^7+76/3*E(40)^8+160/9*E(40)^9-76/3*E(40)^12-272/9*E(40)^15, det_sign_json=1, det_sign_computed=1, det_ok=True, det_matches_json=True, vertices_onto=True, edges_onto=True, faces_onto=True, cells_onto=True, w_maps_to_w=True, image_flag_orbit_json=odd, image_flag_orbit_computed=odd, flag_orbit_agrees=True, flag_image_kind=2-adjacent(w,e,fS2,c), flag_image_agrees=True, anchor_images_agree=True, M_in_Gamma_b=n/a, represents_own_coset_json=True, triple_orientation_json=mirror, all_ok=True

### 6. `L3-{5,3,5/2}-5`  (alpha = -E(40)^7+E(40)^8+E(40)^13-E(40)^23+E(40)^32+E(40)^37)  ~  `L3-{5,3,5/2}-8`  (alpha = -E(40)^8-2*E(40)^16-E(40)^21-2*E(40)^24-E(40)^29+E(40)^31-E(40)^32+E(40)^39)

* row `T = {5,3,5/2}`, f-vector `(48,144,48,8)`, `|Gamma| = 1152`; stored `|w_a|^2 = 20-8*E(40)-8*E(40)^3-5*E(40)^5+8*E(40)^7+12*E(40)^8-8*E(40)^9-12*E(40)^12+13*E(40)^15` (~2.039375162967), `|w_b|^2 = 8-3*E(40)-3*E(40)^3-E(40)^5+3*E(40)^7+4*E(40)^8-3*E(40)^9-4*E(40)^12+4*E(40)^15` (~2.193185558814).
* **Method 1 certificate** (`L3-{5,3,5/2}-5 -> L3-{5,3,5/2}-8`, flag-anchored `odd` candidate, hits the intended flag of `b`): `lambda = 4/3*E(40)^7-7/3*E(40)^8-4/3*E(40)^13-4/3*E(40)^16-2/3*E(40)^21+4/3*E(40)^23-4/3*E(40)^24-2/3*E(40)^29+2/3*E(40)^31-7/3*E(40)^32-4/3*E(40)^37+2/3*E(40)^39` (~1.0754203535670737), `det M = 68/9*E(40)^7-98/9*E(40)^8-68/9*E(40)^13-41/9*E(40)^16-28/9*E(40)^21+68/9*E(40)^23-41/9*E(40)^24-28/9*E(40)^29+28/9*E(40)^31-98/9*E(40)^32-68/9*E(40)^37+28/9*E(40)^39` (`= +lambda^2`, sign +1), conjugated triple orientation: `mirror`.

    M =
    `-3/4*E(40)^7+1/2*E(40)^8+3/4*E(40)^13+1/4*E(40)^21-3/4*E(40)^23+1/4*E(40)^29-1/4*E(40)^31+1/2*E(40)^32+3/4*E(40)^37-1/4*E(40)^39`  `0`  `-1/6*E(40)^8-1/2*E(40)^16-1/12*E(40)^21-1/2*E(40)^24-1/12*E(40)^29+1/12*E(40)^31-1/6*E(40)^32+1/12*E(40)^39`  `-1/12*E(40)^7+1/12*E(40)^13-1/6*E(40)^16-1/12*E(40)^23-1/6*E(40)^24+1/12*E(40)^37`
    `0`  `-1/4*E(40)^7+1/4*E(40)^13-1/2*E(40)^16-1/4*E(40)^23-1/2*E(40)^24+1/4*E(40)^37`  `2/3*E(40)^7-1/2*E(40)^8-2/3*E(40)^13-1/6*E(40)^16-1/4*E(40)^21+2/3*E(40)^23-1/6*E(40)^24-1/4*E(40)^29+1/4*E(40)^31-1/2*E(40)^32-2/3*E(40)^37+1/4*E(40)^39`  `-1/4*E(40)^7+1/6*E(40)^8+1/4*E(40)^13+1/12*E(40)^21-1/4*E(40)^23+1/12*E(40)^29-1/12*E(40)^31+1/6*E(40)^32+1/4*E(40)^37-1/12*E(40)^39`
    `-1/6*E(40)^8-1/2*E(40)^16-1/12*E(40)^21-1/2*E(40)^24-1/12*E(40)^29+1/12*E(40)^31-1/6*E(40)^32+1/12*E(40)^39`  `2/3*E(40)^7-1/2*E(40)^8-2/3*E(40)^13-1/6*E(40)^16-1/4*E(40)^21+2/3*E(40)^23-1/6*E(40)^24-1/4*E(40)^29+1/4*E(40)^31-1/2*E(40)^32-2/3*E(40)^37+1/4*E(40)^39`  `1/3*E(40)^7-1/6*E(40)^8-1/3*E(40)^13+1/6*E(40)^16-1/12*E(40)^21+1/3*E(40)^23+1/6*E(40)^24-1/12*E(40)^29+1/12*E(40)^31-1/6*E(40)^32-1/3*E(40)^37+1/12*E(40)^39`  `1/6*E(40)^7-1/6*E(40)^8-1/6*E(40)^13-1/6*E(40)^16-1/12*E(40)^21+1/6*E(40)^23-1/6*E(40)^24-1/12*E(40)^29+1/12*E(40)^31-1/6*E(40)^32-1/6*E(40)^37+1/12*E(40)^39`
    `-1/12*E(40)^7+1/12*E(40)^13-1/6*E(40)^16-1/12*E(40)^23-1/6*E(40)^24+1/12*E(40)^37`  `-1/4*E(40)^7+1/6*E(40)^8+1/4*E(40)^13+1/12*E(40)^21-1/4*E(40)^23+1/12*E(40)^29-1/12*E(40)^31+1/6*E(40)^32+1/4*E(40)^37-1/12*E(40)^39`  `1/6*E(40)^7-1/6*E(40)^8-1/6*E(40)^13-1/6*E(40)^16-1/12*E(40)^21+1/6*E(40)^23-1/6*E(40)^24-1/12*E(40)^29+1/12*E(40)^31-1/6*E(40)^32-1/6*E(40)^37+1/12*E(40)^39`  `2/3*E(40)^7-1/3*E(40)^8-2/3*E(40)^13+1/3*E(40)^16-1/6*E(40)^21+2/3*E(40)^23+1/3*E(40)^24-1/6*E(40)^29+1/6*E(40)^31-1/3*E(40)^32-2/3*E(40)^37+1/6*E(40)^39`

    exact checks: traversal True, `M M^T = lambda I` True, `det = +-lambda^2` True, vertices True, edges True, 2-faces True, cells True, `M^-1 S1 M, M^-1 S2 M, M^-1 X_a M in Gamma_b` True/True/True, `M S1 M^-1, M S2 M^-1, M X_b M^-1 in Gamma_a` True/True/True.

* **Method 2 certificate** (`L3-{5,3,5/2}-5 -> L3-{5,3,5/2}-8`, `M = B_a^-1 B_b` from the canonical minimising bases; independent Sage arithmetic): `lambda = 4/3-2/3*E(40)-2/3*E(40)^3+4/3*E(40)^5+2/3*E(40)^7-E(40)^8-2/3*E(40)^9+E(40)^12-2/3*E(40)^15` (~1.075420), `det M = 41/9-40/9*E(40)-40/9*E(40)^3+68/9*E(40)^5+40/9*E(40)^7-19/3*E(40)^8-40/9*E(40)^9+19/3*E(40)^12-28/9*E(40)^15`, sign +1; checks `M M^T = lambda I` True, `det = sign lambda^2` True, vertices True, edges True, faces True, cells True; exhaustive count of similarities fixing `w_a -> w_b`: 24 (det signs `+`).

    M =
    `1/6+1/3*E(40)+1/3*E(40)^3-1/3*E(40)^5-1/3*E(40)^7+1/6*E(40)^8+1/3*E(40)^9-1/6*E(40)^12`  `-1/2+1/3*E(40)+1/3*E(40)^3-1/2*E(40)^5-1/3*E(40)^7+1/3*E(40)^8+1/3*E(40)^9-1/3*E(40)^12+1/6*E(40)^15`  `1/3+1/6*E(40)+1/6*E(40)^3-1/6*E(40)^5-1/6*E(40)^7+1/3*E(40)^8+1/6*E(40)^9-1/3*E(40)^12`  `1/6*E(40)+1/6*E(40)^3-1/6*E(40)^7+1/6*E(40)^8+1/6*E(40)^9-1/6*E(40)^12-1/6*E(40)^15`
    `1/2-1/3*E(40)-1/3*E(40)^3+1/2*E(40)^5+1/3*E(40)^7-1/3*E(40)^8-1/3*E(40)^9+1/3*E(40)^12-1/6*E(40)^15`  `1/6+1/3*E(40)+1/3*E(40)^3-1/3*E(40)^5-1/3*E(40)^7+1/6*E(40)^8+1/3*E(40)^9-1/6*E(40)^12`  `-1/6*E(40)-1/6*E(40)^3+1/6*E(40)^7-1/6*E(40)^8-1/6*E(40)^9+1/6*E(40)^12+1/6*E(40)^15`  `1/3+1/6*E(40)+1/6*E(40)^3-1/6*E(40)^5-1/6*E(40)^7+1/3*E(40)^8+1/6*E(40)^9-1/3*E(40)^12`
    `1/3+1/6*E(40)+1/6*E(40)^3-1/6*E(40)^5-1/6*E(40)^7+1/3*E(40)^8+1/6*E(40)^9-1/3*E(40)^12`  `1/6*E(40)+1/6*E(40)^3-1/6*E(40)^7+1/6*E(40)^8+1/6*E(40)^9-1/6*E(40)^12-1/6*E(40)^15`  `1/6-1/3*E(40)-1/3*E(40)^3+2/3*E(40)^5+1/3*E(40)^7-1/2*E(40)^8-1/3*E(40)^9+1/2*E(40)^12-1/3*E(40)^15`  `-1/6-1/6*E(40)^5-1/3*E(40)^8+1/3*E(40)^12+1/6*E(40)^15`
    `-1/6*E(40)-1/6*E(40)^3+1/6*E(40)^7-1/6*E(40)^8-1/6*E(40)^9+1/6*E(40)^12+1/6*E(40)^15`  `1/3+1/6*E(40)+1/6*E(40)^3-1/6*E(40)^5-1/6*E(40)^7+1/3*E(40)^8+1/6*E(40)^9-1/3*E(40)^12`  `1/6+1/6*E(40)^5+1/3*E(40)^8-1/3*E(40)^12-1/6*E(40)^15`  `1/6-1/3*E(40)-1/3*E(40)^3+2/3*E(40)^5+1/3*E(40)^7-1/2*E(40)^8-1/3*E(40)^9+1/2*E(40)^12-1/3*E(40)^15`

* **Author's check** (`L3-{5,3,5/2}-5 -> L3-{5,3,5/2}-8`): `M = M0 / c` with `M0` the anti-automorphism realiser of the row (below) and `c = 2/5*E(40)^7-4/5*E(40)^8-2/5*E(40)^13-16/5*E(40)^16+2/5*E(40)^21+2/5*E(40)^23-16/5*E(40)^24+2/5*E(40)^29-2/5*E(40)^31-4/5*E(40)^32-2/5*E(40)^37-2/5*E(40)^39` (exact: `w_a M0 = c w_b` is true); `lambda = 4/3*E(40)^7-7/3*E(40)^8-4/3*E(40)^13-4/3*E(40)^16-2/3*E(40)^21+4/3*E(40)^23-4/3*E(40)^24-2/3*E(40)^29+2/3*E(40)^31-7/3*E(40)^32-4/3*E(40)^37+2/3*E(40)^39` (`= |w_b|^2/|w_a|^2`: true), `det M = 68/9*E(40)^7-98/9*E(40)^8-68/9*E(40)^13-41/9*E(40)^16-28/9*E(40)^21+68/9*E(40)^23-41/9*E(40)^24-28/9*E(40)^29+28/9*E(40)^31-98/9*E(40)^32-68/9*E(40)^37+28/9*E(40)^39` (`> 0`: true); structure carried onto `b`: vertices true, edges true, 2-faces true, cells true; `lambda = 1` (isometry as stored): **false**.

* **Method 4 re-verification** (pure Python `Q(zeta_40)`): 4 certificate line(s) for this pair, fields: case_a=L3-{5,3,5/2}-8, case_b=L3-{5,3,5/2}-5, candidate=even, lambda_json=-2/3*E(40)^7-4/3*E(40)^8+2/3*E(40)^13-5/3*E(40)^16+2/3*E(40)^21-2/3*E(40)^23-5/3*E(40)^24+2/3*E(40)^29-2/3*E(40)^31-4/3*E(40)^32+2/3*E(40)^37-2/3*E(40)^39, lambda_exact_powerbasis=5/3-2/3*E(40)^5+1/3*E(40)^8-1/3*E(40)^12+2/3*E(40)^15, lambda_float=0.929869, isometry=False, lambda_ok=True, lambda_real=True, M_real=True, MMt_ok=True, det_json=-16/9*E(40)^7-25/9*E(40)^8+16/9*E(40)^13-34/9*E(40)^16+20/9*E(40)^21-16/9*E(40)^23-34/9*E(40)^24+20/9*E(40)^29-20/9*E(40)^31-25/9*E(40)^32+16/9*E(40)^37-20/9*E(40)^39, det_exact_powerbasis=34/9-4/9*E(40)-4/9*E(40)^3-16/9*E(40)^5+4/9*E(40)^7+E(40)^8-4/9*E(40)^9-E(40)^12+20/9*E(40)^15, det_sign_json=1, det_sign_computed=1, det_ok=True, det_matches_json=True, vertices_onto=True, edges_onto=True, faces_onto=True, cells_onto=True, w_maps_to_w=True, image_flag_orbit_json=odd, image_flag_orbit_computed=odd, flag_orbit_agrees=True, flag_image_kind=base_flag_other_cell, flag_image_agrees=True, anchor_images_agree=True, M_in_Gamma_b=n/a, represents_own_coset_json=False, triple_orientation_json=mirror, all_ok=True; case_a=L3-{5,3,5/2}-8, case_b=L3-{5,3,5/2}-5, candidate=odd, lambda_json=-2/3*E(40)^7-4/3*E(40)^8+2/3*E(40)^13-5/3*E(40)^16+2/3*E(40)^21-2/3*E(40)^23-5/3*E(40)^24+2/3*E(40)^29-2/3*E(40)^31-4/3*E(40)^32+2/3*E(40)^37-2/3*E(40)^39, lambda_exact_powerbasis=5/3-2/3*E(40)^5+1/3*E(40)^8-1/3*E(40)^12+2/3*E(40)^15, lambda_float=0.929869, isometry=False, lambda_ok=True, lambda_real=True, M_real=True, MMt_ok=True, det_json=-16/9*E(40)^7-25/9*E(40)^8+16/9*E(40)^13-34/9*E(40)^16+20/9*E(40)^21-16/9*E(40)^23-34/9*E(40)^24+20/9*E(40)^29-20/9*E(40)^31-25/9*E(40)^32+16/9*E(40)^37-20/9*E(40)^39, det_exact_powerbasis=34/9-4/9*E(40)-4/9*E(40)^3-16/9*E(40)^5+4/9*E(40)^7+E(40)^8-4/9*E(40)^9-E(40)^12+20/9*E(40)^15, det_sign_json=1, det_sign_computed=1, det_ok=True, det_matches_json=True, vertices_onto=True, edges_onto=True, faces_onto=True, cells_onto=True, w_maps_to_w=True, image_flag_orbit_json=odd, image_flag_orbit_computed=odd, flag_orbit_agrees=True, flag_image_kind=2-adjacent(w,e,fS2,c), flag_image_agrees=True, anchor_images_agree=True, M_in_Gamma_b=n/a, represents_own_coset_json=True, triple_orientation_json=mirror, all_ok=True

### 7. `L3-{5,3,5/2}-6`  (alpha = E(40)^7+E(40)^8-E(40)^13+E(40)^23+E(40)^32-E(40)^37)  ~  `L3-{5,3,5/2}-7`  (alpha = -E(40)^8-2*E(40)^16+E(40)^21-2*E(40)^24+E(40)^29-E(40)^31-E(40)^32-E(40)^39)

* row `T = {5,3,5/2}`, f-vector `(48,144,48,8)`, `|Gamma| = 1152`; stored `|w_a|^2 = 20+8*E(40)+8*E(40)^3+5*E(40)^5-8*E(40)^7+12*E(40)^8+8*E(40)^9-12*E(40)^12-13*E(40)^15` (~52.793440567030), `|w_b|^2 = 8+3*E(40)+3*E(40)^3+E(40)^5-3*E(40)^7+4*E(40)^8+3*E(40)^9-4*E(40)^12-4*E(40)^15` (~18.751086351185).
* **Method 1 certificate** (`L3-{5,3,5/2}-6 -> L3-{5,3,5/2}-7`, flag-anchored `odd` candidate, hits the intended flag of `b`): `lambda = -4/3*E(40)^7-7/3*E(40)^8+4/3*E(40)^13-4/3*E(40)^16+2/3*E(40)^21-4/3*E(40)^23-4/3*E(40)^24+2/3*E(40)^29-2/3*E(40)^31-7/3*E(40)^32+4/3*E(40)^37-2/3*E(40)^39` (~0.3551783355998032), `det M = -68/9*E(40)^7-98/9*E(40)^8+68/9*E(40)^13-41/9*E(40)^16+28/9*E(40)^21-68/9*E(40)^23-41/9*E(40)^24+28/9*E(40)^29-28/9*E(40)^31-98/9*E(40)^32+68/9*E(40)^37-28/9*E(40)^39` (`= +lambda^2`, sign +1), conjugated triple orientation: `mirror`.

    M =
    `3/4*E(40)^7+1/2*E(40)^8-3/4*E(40)^13-1/4*E(40)^21+3/4*E(40)^23-1/4*E(40)^29+1/4*E(40)^31+1/2*E(40)^32-3/4*E(40)^37+1/4*E(40)^39`  `0`  `-1/6*E(40)^8-1/2*E(40)^16+1/12*E(40)^21-1/2*E(40)^24+1/12*E(40)^29-1/12*E(40)^31-1/6*E(40)^32-1/12*E(40)^39`  `1/12*E(40)^7-1/12*E(40)^13-1/6*E(40)^16+1/12*E(40)^23-1/6*E(40)^24-1/12*E(40)^37`
    `0`  `1/4*E(40)^7-1/4*E(40)^13-1/2*E(40)^16+1/4*E(40)^23-1/2*E(40)^24-1/4*E(40)^37`  `-2/3*E(40)^7-1/2*E(40)^8+2/3*E(40)^13-1/6*E(40)^16+1/4*E(40)^21-2/3*E(40)^23-1/6*E(40)^24+1/4*E(40)^29-1/4*E(40)^31-1/2*E(40)^32+2/3*E(40)^37-1/4*E(40)^39`  `1/4*E(40)^7+1/6*E(40)^8-1/4*E(40)^13-1/12*E(40)^21+1/4*E(40)^23-1/12*E(40)^29+1/12*E(40)^31+1/6*E(40)^32-1/4*E(40)^37+1/12*E(40)^39`
    `-1/6*E(40)^8-1/2*E(40)^16+1/12*E(40)^21-1/2*E(40)^24+1/12*E(40)^29-1/12*E(40)^31-1/6*E(40)^32-1/12*E(40)^39`  `-2/3*E(40)^7-1/2*E(40)^8+2/3*E(40)^13-1/6*E(40)^16+1/4*E(40)^21-2/3*E(40)^23-1/6*E(40)^24+1/4*E(40)^29-1/4*E(40)^31-1/2*E(40)^32+2/3*E(40)^37-1/4*E(40)^39`  `-1/3*E(40)^7-1/6*E(40)^8+1/3*E(40)^13+1/6*E(40)^16+1/12*E(40)^21-1/3*E(40)^23+1/6*E(40)^24+1/12*E(40)^29-1/12*E(40)^31-1/6*E(40)^32+1/3*E(40)^37-1/12*E(40)^39`  `-1/6*E(40)^7-1/6*E(40)^8+1/6*E(40)^13-1/6*E(40)^16+1/12*E(40)^21-1/6*E(40)^23-1/6*E(40)^24+1/12*E(40)^29-1/12*E(40)^31-1/6*E(40)^32+1/6*E(40)^37-1/12*E(40)^39`
    `1/12*E(40)^7-1/12*E(40)^13-1/6*E(40)^16+1/12*E(40)^23-1/6*E(40)^24-1/12*E(40)^37`  `1/4*E(40)^7+1/6*E(40)^8-1/4*E(40)^13-1/12*E(40)^21+1/4*E(40)^23-1/12*E(40)^29+1/12*E(40)^31+1/6*E(40)^32-1/4*E(40)^37+1/12*E(40)^39`  `-1/6*E(40)^7-1/6*E(40)^8+1/6*E(40)^13-1/6*E(40)^16+1/12*E(40)^21-1/6*E(40)^23-1/6*E(40)^24+1/12*E(40)^29-1/12*E(40)^31-1/6*E(40)^32+1/6*E(40)^37-1/12*E(40)^39`  `-2/3*E(40)^7-1/3*E(40)^8+2/3*E(40)^13+1/3*E(40)^16+1/6*E(40)^21-2/3*E(40)^23+1/3*E(40)^24+1/6*E(40)^29-1/6*E(40)^31-1/3*E(40)^32+2/3*E(40)^37-1/6*E(40)^39`

    exact checks: traversal True, `M M^T = lambda I` True, `det = +-lambda^2` True, vertices True, edges True, 2-faces True, cells True, `M^-1 S1 M, M^-1 S2 M, M^-1 X_a M in Gamma_b` True/True/True, `M S1 M^-1, M S2 M^-1, M X_b M^-1 in Gamma_a` True/True/True.

* **Method 2 certificate** (`L3-{5,3,5/2}-6 -> L3-{5,3,5/2}-7`, `M = B_a^-1 B_b` from the canonical minimising bases; independent Sage arithmetic): `lambda = 4/3+2/3*E(40)+2/3*E(40)^3-4/3*E(40)^5-2/3*E(40)^7-E(40)^8+2/3*E(40)^9+E(40)^12+2/3*E(40)^15` (~0.355178), `det M = 41/9+40/9*E(40)+40/9*E(40)^3-68/9*E(40)^5-40/9*E(40)^7-19/3*E(40)^8+40/9*E(40)^9+19/3*E(40)^12+28/9*E(40)^15`, sign +1; checks `M M^T = lambda I` True, `det = sign lambda^2` True, vertices True, edges True, faces True, cells True; exhaustive count of similarities fixing `w_a -> w_b`: 24 (det signs `+`).

    M =
    `1/6-1/3*E(40)-1/3*E(40)^3+1/3*E(40)^5+1/3*E(40)^7+1/6*E(40)^8-1/3*E(40)^9-1/6*E(40)^12`  `-1/2-1/3*E(40)-1/3*E(40)^3+1/2*E(40)^5+1/3*E(40)^7+1/3*E(40)^8-1/3*E(40)^9-1/3*E(40)^12-1/6*E(40)^15`  `1/3-1/6*E(40)-1/6*E(40)^3+1/6*E(40)^5+1/6*E(40)^7+1/3*E(40)^8-1/6*E(40)^9-1/3*E(40)^12`  `-1/6*E(40)-1/6*E(40)^3+1/6*E(40)^7+1/6*E(40)^8-1/6*E(40)^9-1/6*E(40)^12+1/6*E(40)^15`
    `1/2+1/3*E(40)+1/3*E(40)^3-1/2*E(40)^5-1/3*E(40)^7-1/3*E(40)^8+1/3*E(40)^9+1/3*E(40)^12+1/6*E(40)^15`  `1/6-1/3*E(40)-1/3*E(40)^3+1/3*E(40)^5+1/3*E(40)^7+1/6*E(40)^8-1/3*E(40)^9-1/6*E(40)^12`  `1/6*E(40)+1/6*E(40)^3-1/6*E(40)^7-1/6*E(40)^8+1/6*E(40)^9+1/6*E(40)^12-1/6*E(40)^15`  `1/3-1/6*E(40)-1/6*E(40)^3+1/6*E(40)^5+1/6*E(40)^7+1/3*E(40)^8-1/6*E(40)^9-1/3*E(40)^12`
    `1/3-1/6*E(40)-1/6*E(40)^3+1/6*E(40)^5+1/6*E(40)^7+1/3*E(40)^8-1/6*E(40)^9-1/3*E(40)^12`  `-1/6*E(40)-1/6*E(40)^3+1/6*E(40)^7+1/6*E(40)^8-1/6*E(40)^9-1/6*E(40)^12+1/6*E(40)^15`  `1/6+1/3*E(40)+1/3*E(40)^3-2/3*E(40)^5-1/3*E(40)^7-1/2*E(40)^8+1/3*E(40)^9+1/2*E(40)^12+1/3*E(40)^15`  `-1/6+1/6*E(40)^5-1/3*E(40)^8+1/3*E(40)^12-1/6*E(40)^15`
    `1/6*E(40)+1/6*E(40)^3-1/6*E(40)^7-1/6*E(40)^8+1/6*E(40)^9+1/6*E(40)^12-1/6*E(40)^15`  `1/3-1/6*E(40)-1/6*E(40)^3+1/6*E(40)^5+1/6*E(40)^7+1/3*E(40)^8-1/6*E(40)^9-1/3*E(40)^12`  `1/6-1/6*E(40)^5+1/3*E(40)^8-1/3*E(40)^12+1/6*E(40)^15`  `1/6+1/3*E(40)+1/3*E(40)^3-2/3*E(40)^5-1/3*E(40)^7-1/2*E(40)^8+1/3*E(40)^9+1/2*E(40)^12+1/3*E(40)^15`

* **Author's check** (`L3-{5,3,5/2}-6 -> L3-{5,3,5/2}-7`): `M = M0 / c` with `M0` the anti-automorphism realiser of the row (below) and `c = -2/5*E(40)^7-4/5*E(40)^8+2/5*E(40)^13-16/5*E(40)^16-2/5*E(40)^21-2/5*E(40)^23-16/5*E(40)^24-2/5*E(40)^29+2/5*E(40)^31-4/5*E(40)^32+2/5*E(40)^37+2/5*E(40)^39` (exact: `w_a M0 = c w_b` is true); `lambda = -4/3*E(40)^7-7/3*E(40)^8+4/3*E(40)^13-4/3*E(40)^16+2/3*E(40)^21-4/3*E(40)^23-4/3*E(40)^24+2/3*E(40)^29-2/3*E(40)^31-7/3*E(40)^32+4/3*E(40)^37-2/3*E(40)^39` (`= |w_b|^2/|w_a|^2`: true), `det M = -68/9*E(40)^7-98/9*E(40)^8+68/9*E(40)^13-41/9*E(40)^16+28/9*E(40)^21-68/9*E(40)^23-41/9*E(40)^24+28/9*E(40)^29-28/9*E(40)^31-98/9*E(40)^32+68/9*E(40)^37-28/9*E(40)^39` (`> 0`: true); structure carried onto `b`: vertices true, edges true, 2-faces true, cells true; `lambda = 1` (isometry as stored): **false**.

* **Method 4 re-verification** (pure Python `Q(zeta_40)`): 4 certificate line(s) for this pair, fields: case_a=L3-{5,3,5/2}-7, case_b=L3-{5,3,5/2}-6, candidate=even, lambda_json=2/3*E(40)^7-4/3*E(40)^8-2/3*E(40)^13-5/3*E(40)^16-2/3*E(40)^21+2/3*E(40)^23-5/3*E(40)^24-2/3*E(40)^29+2/3*E(40)^31-4/3*E(40)^32-2/3*E(40)^37+2/3*E(40)^39, lambda_exact_powerbasis=5/3+2/3*E(40)^5+1/3*E(40)^8-1/3*E(40)^12-2/3*E(40)^15, lambda_float=2.815487, isometry=False, lambda_ok=True, lambda_real=True, M_real=True, MMt_ok=True, det_json=16/9*E(40)^7-25/9*E(40)^8-16/9*E(40)^13-34/9*E(40)^16-20/9*E(40)^21+16/9*E(40)^23-34/9*E(40)^24-20/9*E(40)^29+20/9*E(40)^31-25/9*E(40)^32-16/9*E(40)^37+20/9*E(40)^39, det_exact_powerbasis=34/9+4/9*E(40)+4/9*E(40)^3+16/9*E(40)^5-4/9*E(40)^7+E(40)^8+4/9*E(40)^9-E(40)^12-20/9*E(40)^15, det_sign_json=1, det_sign_computed=1, det_ok=True, det_matches_json=True, vertices_onto=True, edges_onto=True, faces_onto=True, cells_onto=True, w_maps_to_w=True, image_flag_orbit_json=odd, image_flag_orbit_computed=odd, flag_orbit_agrees=True, flag_image_kind=base_flag_other_cell, flag_image_agrees=True, anchor_images_agree=True, M_in_Gamma_b=n/a, represents_own_coset_json=False, triple_orientation_json=mirror, all_ok=True; case_a=L3-{5,3,5/2}-7, case_b=L3-{5,3,5/2}-6, candidate=odd, lambda_json=2/3*E(40)^7-4/3*E(40)^8-2/3*E(40)^13-5/3*E(40)^16-2/3*E(40)^21+2/3*E(40)^23-5/3*E(40)^24-2/3*E(40)^29+2/3*E(40)^31-4/3*E(40)^32-2/3*E(40)^37+2/3*E(40)^39, lambda_exact_powerbasis=5/3+2/3*E(40)^5+1/3*E(40)^8-1/3*E(40)^12-2/3*E(40)^15, lambda_float=2.815487, isometry=False, lambda_ok=True, lambda_real=True, M_real=True, MMt_ok=True, det_json=16/9*E(40)^7-25/9*E(40)^8-16/9*E(40)^13-34/9*E(40)^16-20/9*E(40)^21+16/9*E(40)^23-34/9*E(40)^24-20/9*E(40)^29+20/9*E(40)^31-25/9*E(40)^32-16/9*E(40)^37+20/9*E(40)^39, det_exact_powerbasis=34/9+4/9*E(40)+4/9*E(40)^3+16/9*E(40)^5-4/9*E(40)^7+E(40)^8+4/9*E(40)^9-E(40)^12-20/9*E(40)^15, det_sign_json=1, det_sign_computed=1, det_ok=True, det_matches_json=True, vertices_onto=True, edges_onto=True, faces_onto=True, cells_onto=True, w_maps_to_w=True, image_flag_orbit_json=odd, image_flag_orbit_computed=odd, flag_orbit_agrees=True, flag_image_kind=2-adjacent(w,e,fS2,c), flag_image_agrees=True, anchor_images_agree=True, M_in_Gamma_b=n/a, represents_own_coset_json=True, triple_orientation_json=mirror, all_ok=True

### 8. `L3-{5,3,5/2}-9`  (alpha = 1)  ~  `L3-{5,3,5/2}-12`  (alpha = E(5)+4*E(5)^2+4*E(5)^3+E(5)^4)

* row `T = {5,3,5/2}`, f-vector `(120,720,300,50)`, `|Gamma| = 7200`; stored `|w_a|^2 = 2+E(40)^8-E(40)^12` (~2.618033988750), `|w_b|^2 = 12/5+6/5*E(40)^8-6/5*E(40)^12` (~3.141640786500).
* **Method 1 certificate** (`L3-{5,3,5/2}-9 -> L3-{5,3,5/2}-12`, flag-anchored `odd` candidate, hits the intended flag of `b`): `lambda = 6/5` (~1.2), `det M = 36/25` (`= +lambda^2`, sign +1), conjugated triple orientation: `mirror`.

    M =
    `-9/10*E(5)-3/5*E(5)^2-3/5*E(5)^3-9/10*E(5)^4`  `0`  `-3/10*E(5)-7/10*E(5)^2-7/10*E(5)^3-3/10*E(5)^4`  `-1/5*E(5)-3/10*E(5)^2-3/10*E(5)^3-1/5*E(5)^4`
    `0`  `-3/5*E(5)-9/10*E(5)^2-9/10*E(5)^3-3/5*E(5)^4`  `7/10*E(5)+3/10*E(5)^2+3/10*E(5)^3+7/10*E(5)^4`  `-3/10*E(5)-1/5*E(5)^2-1/5*E(5)^3-3/10*E(5)^4`
    `-3/10*E(5)-7/10*E(5)^2-7/10*E(5)^3-3/10*E(5)^4`  `7/10*E(5)+3/10*E(5)^2+3/10*E(5)^3+7/10*E(5)^4`  `-1/2`  `1/10*E(5)-1/10*E(5)^2-1/10*E(5)^3+1/10*E(5)^4`
    `-1/5*E(5)-3/10*E(5)^2-3/10*E(5)^3-1/5*E(5)^4`  `-3/10*E(5)-1/5*E(5)^2-1/5*E(5)^3-3/10*E(5)^4`  `1/10*E(5)-1/10*E(5)^2-1/10*E(5)^3+1/10*E(5)^4`  `-1`

    exact checks: traversal True, `M M^T = lambda I` True, `det = +-lambda^2` True, vertices True, edges True, 2-faces True, cells True, `M^-1 S1 M, M^-1 S2 M, M^-1 X_a M in Gamma_b` True/True/True, `M S1 M^-1, M S2 M^-1, M X_b M^-1 in Gamma_a` True/True/True.

* **Method 2 certificate** (`L3-{5,3,5/2}-9 -> L3-{5,3,5/2}-12`, `M = B_a^-1 B_b` from the canonical minimising bases; independent Sage arithmetic): `lambda = 6/5` (~1.200000), `det M = 36/25`, sign +1; checks `M M^T = lambda I` True, `det = sign lambda^2` True, vertices True, edges True, faces True, cells True; exhaustive count of similarities fixing `w_a -> w_b`: 60 (det signs `+`).

    M =
    `3/5-3/10*E(40)^8+3/10*E(40)^12`  `0`  `7/10+2/5*E(40)^8-2/5*E(40)^12`  `3/10+1/10*E(40)^8-1/10*E(40)^12`
    `0`  `-3/10-3/5*E(40)^8+3/5*E(40)^12`  `-1/2*E(40)^8+1/2*E(40)^12`  `1/2+1/2*E(40)^8-1/2*E(40)^12`
    `7/10+2/5*E(40)^8-2/5*E(40)^12`  `-1/2*E(40)^8+1/2*E(40)^12`  `-2/5+1/5*E(40)^8-1/5*E(40)^12`  `-3/10-1/10*E(40)^8+1/10*E(40)^12`
    `3/10+1/10*E(40)^8-1/10*E(40)^12`  `1/2+1/2*E(40)^8-1/2*E(40)^12`  `-3/10-1/10*E(40)^8+1/10*E(40)^12`  `1/10+7/10*E(40)^8-7/10*E(40)^12`

* **Author's check** (`L3-{5,3,5/2}-9 -> L3-{5,3,5/2}-12`): `M = M0 / c` with `M0` the anti-automorphism realiser of the row (below) and `c = -2*E(5)^2-2*E(5)^3` (exact: `w_a M0 = c w_b` is true); `lambda = 6/5` (`= |w_b|^2/|w_a|^2`: true), `det M = 36/25` (`> 0`: true); structure carried onto `b`: vertices true, edges true, 2-faces true, cells true; `lambda = 1` (isometry as stored): **false**.

* **Method 4 re-verification** (pure Python `Q(zeta_40)`): 4 certificate line(s) for this pair, fields: case_a=L3-{5,3,5/2}-12, case_b=L3-{5,3,5/2}-9, candidate=even, lambda_json=5/6, lambda_exact_powerbasis=5/6, lambda_float=0.833333, isometry=False, lambda_ok=True, lambda_real=True, M_real=True, MMt_ok=True, det_json=25/36, det_exact_powerbasis=25/36, det_sign_json=1, det_sign_computed=1, det_ok=True, det_matches_json=True, vertices_onto=True, edges_onto=True, faces_onto=True, cells_onto=True, w_maps_to_w=True, image_flag_orbit_json=odd, image_flag_orbit_computed=odd, flag_orbit_agrees=True, flag_image_kind=base_flag_other_cell, flag_image_agrees=True, anchor_images_agree=True, M_in_Gamma_b=n/a, represents_own_coset_json=False, triple_orientation_json=mirror, all_ok=True; case_a=L3-{5,3,5/2}-12, case_b=L3-{5,3,5/2}-9, candidate=odd, lambda_json=5/6, lambda_exact_powerbasis=5/6, lambda_float=0.833333, isometry=False, lambda_ok=True, lambda_real=True, M_real=True, MMt_ok=True, det_json=25/36, det_exact_powerbasis=25/36, det_sign_json=1, det_sign_computed=1, det_ok=True, det_matches_json=True, vertices_onto=True, edges_onto=True, faces_onto=True, cells_onto=True, w_maps_to_w=True, image_flag_orbit_json=odd, image_flag_orbit_computed=odd, flag_orbit_agrees=True, flag_image_kind=2-adjacent(w,e,fS2,c), flag_image_agrees=True, anchor_images_agree=True, M_in_Gamma_b=n/a, represents_own_coset_json=True, triple_orientation_json=mirror, all_ok=True

### 9. `L3-{5,3,5/2}-10`  (alpha = -1)  ~  `L3-{5,3,5/2}-11`  (alpha = E(5)+E(5)^4)

* row `T = {5,3,5/2}`, f-vector `(120,720,300,50)`, `|Gamma| = 7200`; stored `|w_a|^2 = 6+3*E(40)^8-3*E(40)^12` (~7.854101966250), `|w_b|^2 = 4+2*E(40)^8-2*E(40)^12` (~5.236067977500).
* **Method 1 certificate** (`L3-{5,3,5/2}-10 -> L3-{5,3,5/2}-11`, flag-anchored `odd` candidate, hits the intended flag of `b`): `lambda = 2/3` (~0.6666666666666666), `det M = 4/9` (`= +lambda^2`, sign +1), conjugated triple orientation: `mirror`.

    M =
    `1/2*E(5)+1/2*E(5)^4`  `0`  `-1/6*E(5)-1/2*E(5)^2-1/2*E(5)^3-1/6*E(5)^4`  `-1/6*E(5)^2-1/6*E(5)^3`
    `0`  `-1/2*E(5)^2-1/2*E(5)^3`  `-1/2*E(5)-1/6*E(5)^2-1/6*E(5)^3-1/2*E(5)^4`  `1/6*E(5)+1/6*E(5)^4`
    `-1/6*E(5)-1/2*E(5)^2-1/2*E(5)^3-1/6*E(5)^4`  `-1/2*E(5)-1/6*E(5)^2-1/6*E(5)^3-1/2*E(5)^4`  `-1/6*E(5)+1/6*E(5)^2+1/6*E(5)^3-1/6*E(5)^4`  `1/6`
    `-1/6*E(5)^2-1/6*E(5)^3`  `1/6*E(5)+1/6*E(5)^4`  `1/6`  `-1/3*E(5)+1/3*E(5)^2+1/3*E(5)^3-1/3*E(5)^4`

    exact checks: traversal True, `M M^T = lambda I` True, `det = +-lambda^2` True, vertices True, edges True, 2-faces True, cells True, `M^-1 S1 M, M^-1 S2 M, M^-1 X_a M in Gamma_b` True/True/True, `M S1 M^-1, M S2 M^-1, M X_b M^-1 in Gamma_a` True/True/True.

* **Method 2 certificate** (`L3-{5,3,5/2}-10 -> L3-{5,3,5/2}-11`, `M = B_a^-1 B_b` from the canonical minimising bases; independent Sage arithmetic): `lambda = 2/3` (~0.666667), `det M = 4/9`, sign +1; checks `M M^T = lambda I` True, `det = sign lambda^2` True, vertices True, edges True, faces True, cells True; exhaustive count of similarities fixing `w_a -> w_b`: 60 (det signs `+`).

    M =
    `1/2*E(40)^8-1/2*E(40)^12`  `0`  `1/2+1/3*E(40)^8-1/3*E(40)^12`  `1/6+1/6*E(40)^8-1/6*E(40)^12`
    `0`  `-1/2`  `-1/3+1/6*E(40)^8-1/6*E(40)^12`  `1/2+1/6*E(40)^8-1/6*E(40)^12`
    `1/2+1/3*E(40)^8-1/3*E(40)^12`  `-1/3+1/6*E(40)^8-1/6*E(40)^12`  `-1/3*E(40)^8+1/3*E(40)^12`  `-1/6-1/6*E(40)^8+1/6*E(40)^12`
    `1/6+1/6*E(40)^8-1/6*E(40)^12`  `1/2+1/6*E(40)^8-1/6*E(40)^12`  `-1/6-1/6*E(40)^8+1/6*E(40)^12`  `1/2-1/6*E(40)^8+1/6*E(40)^12`

* **Author's check** (`L3-{5,3,5/2}-10 -> L3-{5,3,5/2}-11`): `M = M0 / c` with `M0` the anti-automorphism realiser of the row (below) and `c = -12/5*E(5)-18/5*E(5)^2-18/5*E(5)^3-12/5*E(5)^4` (exact: `w_a M0 = c w_b` is true); `lambda = 2/3` (`= |w_b|^2/|w_a|^2`: true), `det M = 4/9` (`> 0`: true); structure carried onto `b`: vertices true, edges true, 2-faces true, cells true; `lambda = 1` (isometry as stored): **false**.

* **Method 4 re-verification** (pure Python `Q(zeta_40)`): 4 certificate line(s) for this pair, fields: case_a=L3-{5,3,5/2}-11, case_b=L3-{5,3,5/2}-10, candidate=even, lambda_json=3/2, lambda_exact_powerbasis=3/2, lambda_float=1.500000, isometry=False, lambda_ok=True, lambda_real=True, M_real=True, MMt_ok=True, det_json=9/4, det_exact_powerbasis=9/4, det_sign_json=1, det_sign_computed=1, det_ok=True, det_matches_json=True, vertices_onto=True, edges_onto=True, faces_onto=True, cells_onto=True, w_maps_to_w=True, image_flag_orbit_json=odd, image_flag_orbit_computed=odd, flag_orbit_agrees=True, flag_image_kind=base_flag_other_cell, flag_image_agrees=True, anchor_images_agree=True, M_in_Gamma_b=n/a, represents_own_coset_json=False, triple_orientation_json=mirror, all_ok=True; case_a=L3-{5,3,5/2}-11, case_b=L3-{5,3,5/2}-10, candidate=odd, lambda_json=3/2, lambda_exact_powerbasis=3/2, lambda_float=1.500000, isometry=False, lambda_ok=True, lambda_real=True, M_real=True, MMt_ok=True, det_json=9/4, det_exact_powerbasis=9/4, det_sign_json=1, det_sign_computed=1, det_ok=True, det_matches_json=True, vertices_onto=True, edges_onto=True, faces_onto=True, cells_onto=True, w_maps_to_w=True, image_flag_orbit_json=odd, image_flag_orbit_computed=odd, flag_orbit_agrees=True, flag_image_kind=2-adjacent(w,e,fS2,c), flag_image_agrees=True, anchor_images_agree=True, M_in_Gamma_b=n/a, represents_own_coset_json=True, triple_orientation_json=mirror, all_ok=True

### 10. `L3-{5,3,5/2}-13`  (alpha = 2)  ~  `L3-{5,3,5/2}-14`  (alpha = -E(5)-2*E(5)^2-2*E(5)^3-E(5)^4)

* row `T = {5,3,5/2}`, f-vector `(120,720,300,50)`, `|Gamma| = 7200`; stored `|w_a|^2 = 3/2+3/4*E(40)^8-3/4*E(40)^12` (~1.963525491562), `|w_b|^2 = 2` (~2.000000000000).
* **Method 1 certificate** (`L3-{5,3,5/2}-13 -> L3-{5,3,5/2}-14`, flag-anchored `odd` candidate, hits the intended flag of `b`): `lambda = -16/3*E(5)-8/3*E(5)^2-8/3*E(5)^3-16/3*E(5)^4` (~1.0185760300002804), `det M = -320/9*E(5)-128/9*E(5)^2-128/9*E(5)^3-320/9*E(5)^4` (`= +lambda^2`, sign +1), conjugated triple orientation: `mirror`.

    M =
    `-2*E(5)-E(5)^2-E(5)^3-2*E(5)^4`  `0`  `-1/3*E(5)-2/3*E(5)^2-2/3*E(5)^3-1/3*E(5)^4`  `1/3`
    `0`  `1`  `5/3*E(5)+2/3*E(5)^2+2/3*E(5)^3+5/3*E(5)^4`  `-2/3*E(5)-1/3*E(5)^2-1/3*E(5)^3-2/3*E(5)^4`
    `-1/3*E(5)-2/3*E(5)^2-2/3*E(5)^3-1/3*E(5)^4`  `5/3*E(5)+2/3*E(5)^2+2/3*E(5)^3+5/3*E(5)^4`  `E(5)+2/3*E(5)^2+2/3*E(5)^3+E(5)^4`  `1/3*E(5)+1/3*E(5)^4`
    `1/3`  `-2/3*E(5)-1/3*E(5)^2-1/3*E(5)^3-2/3*E(5)^4`  `1/3*E(5)+1/3*E(5)^4`  `2*E(5)+4/3*E(5)^2+4/3*E(5)^3+2*E(5)^4`

    exact checks: traversal True, `M M^T = lambda I` True, `det = +-lambda^2` True, vertices True, edges True, 2-faces True, cells True, `M^-1 S1 M, M^-1 S2 M, M^-1 X_a M in Gamma_b` True/True/True, `M S1 M^-1, M S2 M^-1, M X_b M^-1 in Gamma_a` True/True/True.

* **Method 2 certificate** (`L3-{5,3,5/2}-13 -> L3-{5,3,5/2}-14`, `M = B_a^-1 B_b` from the canonical minimising bases; independent Sage arithmetic): `lambda = 8/3-8/3*E(40)^8+8/3*E(40)^12` (~1.018576), `det M = 128/9-64/3*E(40)^8+64/3*E(40)^12`, sign +1; checks `M M^T = lambda I` True, `det = sign lambda^2` True, vertices True, edges True, faces True, cells True; exhaustive count of similarities fixing `w_a -> w_b`: 60 (det signs `+`).

    M =
    `4/3-2/3*E(40)^8+2/3*E(40)^12`  `-1/3*E(40)^8+1/3*E(40)^12`  `1/3-1/3*E(40)^8+1/3*E(40)^12`  `1/3`
    `1/3*E(40)^8-1/3*E(40)^12`  `4/3-2/3*E(40)^8+2/3*E(40)^12`  `-1/3`  `1/3-1/3*E(40)^8+1/3*E(40)^12`
    `1/3-1/3*E(40)^8+1/3*E(40)^12`  `1/3`  `4/3*E(40)^8-4/3*E(40)^12`  `-2/3+1/3*E(40)^8-1/3*E(40)^12`
    `-1/3`  `1/3-1/3*E(40)^8+1/3*E(40)^12`  `2/3-1/3*E(40)^8+1/3*E(40)^12`  `4/3*E(40)^8-4/3*E(40)^12`

* **Author's check** (`L3-{5,3,5/2}-13 -> L3-{5,3,5/2}-14`): `M = M0 / c` with `M0` the anti-automorphism realiser of the row (below) and `c = -3/5*E(5)-12/5*E(5)^2-12/5*E(5)^3-3/5*E(5)^4` (exact: `w_a M0 = c w_b` is true); `lambda = -16/3*E(5)-8/3*E(5)^2-8/3*E(5)^3-16/3*E(5)^4` (`= |w_b|^2/|w_a|^2`: true), `det M = -320/9*E(5)-128/9*E(5)^2-128/9*E(5)^3-320/9*E(5)^4` (`> 0`: true); structure carried onto `b`: vertices true, edges true, 2-faces true, cells true; `lambda = 1` (isometry as stored): **false**.

* **Method 4 re-verification** (pure Python `Q(zeta_40)`): 4 certificate line(s) for this pair, fields: case_a=L3-{5,3,5/2}-14, case_b=L3-{5,3,5/2}-13, candidate=even, lambda_json=-3/8*E(5)-3/4*E(5)^2-3/4*E(5)^3-3/8*E(5)^4, lambda_exact_powerbasis=3/4+3/8*E(40)^8-3/8*E(40)^12, lambda_float=0.981763, isometry=False, lambda_ok=True, lambda_real=True, M_real=True, MMt_ok=True, det_json=-9/32*E(5)-45/64*E(5)^2-45/64*E(5)^3-9/32*E(5)^4, det_exact_powerbasis=45/64+27/64*E(40)^8-27/64*E(40)^12, det_sign_json=1, det_sign_computed=1, det_ok=True, det_matches_json=True, vertices_onto=True, edges_onto=True, faces_onto=True, cells_onto=True, w_maps_to_w=True, image_flag_orbit_json=odd, image_flag_orbit_computed=odd, flag_orbit_agrees=True, flag_image_kind=base_flag_other_cell, flag_image_agrees=True, anchor_images_agree=True, M_in_Gamma_b=n/a, represents_own_coset_json=False, triple_orientation_json=mirror, all_ok=True; case_a=L3-{5,3,5/2}-14, case_b=L3-{5,3,5/2}-13, candidate=odd, lambda_json=-3/8*E(5)-3/4*E(5)^2-3/4*E(5)^3-3/8*E(5)^4, lambda_exact_powerbasis=3/4+3/8*E(40)^8-3/8*E(40)^12, lambda_float=0.981763, isometry=False, lambda_ok=True, lambda_real=True, M_real=True, MMt_ok=True, det_json=-9/32*E(5)-45/64*E(5)^2-45/64*E(5)^3-9/32*E(5)^4, det_exact_powerbasis=45/64+27/64*E(40)^8-27/64*E(40)^12, det_sign_json=1, det_sign_computed=1, det_ok=True, det_matches_json=True, vertices_onto=True, edges_onto=True, faces_onto=True, cells_onto=True, w_maps_to_w=True, image_flag_orbit_json=odd, image_flag_orbit_computed=odd, flag_orbit_agrees=True, flag_image_kind=2-adjacent(w,e,fS2,c), flag_image_agrees=True, anchor_images_agree=True, M_in_Gamma_b=n/a, represents_own_coset_json=True, triple_orientation_json=mirror, all_ok=True

### 11. `L3-{5,3,5/2}-15`  (alpha = -5*E(5)-2*E(5)^2-2*E(5)^3-5*E(5)^4)  ~  `L3-{5,3,5/2}-16`  (alpha = 0)

* row `T = {5,3,5/2}`, f-vector `(120,720,300,50)`, `|Gamma| = 7200`; stored `|w_a|^2 = 78+48*E(40)^8-48*E(40)^12` (~107.665631459995), `|w_b|^2 = 8+4*E(40)^8-4*E(40)^12` (~10.472135955000).
* **Method 1 certificate** (`L3-{5,3,5/2}-15 -> L3-{5,3,5/2}-16`, flag-anchored `odd` candidate, hits the intended flag of `b`): `lambda = -10/3*E(5)-4/3*E(5)^2-4/3*E(5)^3-10/3*E(5)^4` (~0.09726535583354363), `det M = -136/9*E(5)-52/9*E(5)^2-52/9*E(5)^3-136/9*E(5)^4` (`= +lambda^2`, sign +1), conjugated triple orientation: `mirror`.

    M =
    `-3/2*E(5)-1/2*E(5)^2-1/2*E(5)^3-3/2*E(5)^4`  `0`  `1/6*E(5)^2+1/6*E(5)^3`  `-1/6*E(5)-1/6*E(5)^4`
    `0`  `-1/2*E(5)-1/2*E(5)^4`  `4/3*E(5)+1/2*E(5)^2+1/2*E(5)^3+4/3*E(5)^4`  `-1/2*E(5)-1/6*E(5)^2-1/6*E(5)^3-1/2*E(5)^4`
    `1/6*E(5)^2+1/6*E(5)^3`  `4/3*E(5)+1/2*E(5)^2+1/2*E(5)^3+4/3*E(5)^4`  `2/3*E(5)+1/6*E(5)^2+1/6*E(5)^3+2/3*E(5)^4`  `1/3*E(5)+1/6*E(5)^2+1/6*E(5)^3+1/3*E(5)^4`
    `-1/6*E(5)-1/6*E(5)^4`  `-1/2*E(5)-1/6*E(5)^2-1/6*E(5)^3-1/2*E(5)^4`  `1/3*E(5)+1/6*E(5)^2+1/6*E(5)^3+1/3*E(5)^4`  `4/3*E(5)+1/3*E(5)^2+1/3*E(5)^3+4/3*E(5)^4`

    exact checks: traversal True, `M M^T = lambda I` True, `det = +-lambda^2` True, vertices True, edges True, 2-faces True, cells True, `M^-1 S1 M, M^-1 S2 M, M^-1 X_a M in Gamma_b` True/True/True, `M S1 M^-1, M S2 M^-1, M X_b M^-1 in Gamma_a` True/True/True.

* **Method 2 certificate** (`L3-{5,3,5/2}-15 -> L3-{5,3,5/2}-16`, `M = B_a^-1 B_b` from the canonical minimising bases; independent Sage arithmetic): `lambda = 4/3-2*E(40)^8+2*E(40)^12` (~0.097265), `det M = 52/9-28/3*E(40)^8+28/3*E(40)^12`, sign +1; checks `M M^T = lambda I` True, `det = sign lambda^2` True, vertices True, edges True, faces True, cells True; exhaustive count of similarities fixing `w_a -> w_b`: 60 (det signs `+`).

    M =
    `2/3-2/3*E(40)^8+2/3*E(40)^12`  `1/6-1/2*E(40)^8+1/2*E(40)^12`  `1/6-1/3*E(40)^8+1/3*E(40)^12`  `-1/6*E(40)^8+1/6*E(40)^12`
    `-1/6+1/2*E(40)^8-1/2*E(40)^12`  `2/3-2/3*E(40)^8+2/3*E(40)^12`  `1/6*E(40)^8-1/6*E(40)^12`  `1/6-1/3*E(40)^8+1/3*E(40)^12`
    `1/6-1/3*E(40)^8+1/3*E(40)^12`  `-1/6*E(40)^8+1/6*E(40)^12`  `-1/3+E(40)^8-E(40)^12`  `-1/6+1/6*E(40)^8-1/6*E(40)^12`
    `1/6*E(40)^8-1/6*E(40)^12`  `1/6-1/3*E(40)^8+1/3*E(40)^12`  `1/6-1/6*E(40)^8+1/6*E(40)^12`  `-1/3+E(40)^8-E(40)^12`

* **Author's check** (`L3-{5,3,5/2}-15 -> L3-{5,3,5/2}-16`): `M = M0 / c` with `M0` the anti-automorphism realiser of the row (below) and `c = 18/5*E(5)+42/5*E(5)^2+42/5*E(5)^3+18/5*E(5)^4` (exact: `w_a M0 = c w_b` is true); `lambda = -10/3*E(5)-4/3*E(5)^2-4/3*E(5)^3-10/3*E(5)^4` (`= |w_b|^2/|w_a|^2`: true), `det M = -136/9*E(5)-52/9*E(5)^2-52/9*E(5)^3-136/9*E(5)^4` (`> 0`: true); structure carried onto `b`: vertices true, edges true, 2-faces true, cells true; `lambda = 1` (isometry as stored): **false**.

* **Method 4 re-verification** (pure Python `Q(zeta_40)`): 4 certificate line(s) for this pair, fields: case_a=L3-{5,3,5/2}-16, case_b=L3-{5,3,5/2}-15, candidate=even, lambda_json=-3*E(5)-15/2*E(5)^2-15/2*E(5)^3-3*E(5)^4, lambda_exact_powerbasis=15/2+9/2*E(40)^8-9/2*E(40)^12, lambda_float=10.281153, isometry=False, lambda_ok=True, lambda_real=True, M_real=True, MMt_ok=True, det_json=-117/4*E(5)-153/2*E(5)^2-153/2*E(5)^3-117/4*E(5)^4, det_exact_powerbasis=153/2+189/4*E(40)^8-189/4*E(40)^12, det_sign_json=1, det_sign_computed=1, det_ok=True, det_matches_json=True, vertices_onto=True, edges_onto=True, faces_onto=True, cells_onto=True, w_maps_to_w=True, image_flag_orbit_json=odd, image_flag_orbit_computed=odd, flag_orbit_agrees=True, flag_image_kind=base_flag_other_cell, flag_image_agrees=True, anchor_images_agree=True, M_in_Gamma_b=n/a, represents_own_coset_json=False, triple_orientation_json=mirror, all_ok=True; case_a=L3-{5,3,5/2}-16, case_b=L3-{5,3,5/2}-15, candidate=odd, lambda_json=-3*E(5)-15/2*E(5)^2-15/2*E(5)^3-3*E(5)^4, lambda_exact_powerbasis=15/2+9/2*E(40)^8-9/2*E(40)^12, lambda_float=10.281153, isometry=False, lambda_ok=True, lambda_real=True, M_real=True, MMt_ok=True, det_json=-117/4*E(5)-153/2*E(5)^2-153/2*E(5)^3-117/4*E(5)^4, det_exact_powerbasis=153/2+189/4*E(40)^8-189/4*E(40)^12, det_sign_json=1, det_sign_computed=1, det_ok=True, det_matches_json=True, vertices_onto=True, edges_onto=True, faces_onto=True, cells_onto=True, w_maps_to_w=True, image_flag_orbit_json=odd, image_flag_orbit_computed=odd, flag_orbit_agrees=True, flag_image_kind=2-adjacent(w,e,fS2,c), flag_image_agrees=True, anchor_images_agree=True, M_in_Gamma_b=n/a, represents_own_coset_json=True, triple_orientation_json=mirror, all_ok=True

### 12. `L3-{3,3,5/2}-1`  (alpha = 1)  ~  `L3-{3,3,5/2}-4`  (alpha = -E(40)^7+E(40)^13+2*E(40)^16+2*E(40)^21-E(40)^23+2*E(40)^24+2*E(40)^29-2*E(40)^31+E(40)^37-2*E(40)^39)

* row `T = {3,3,5/2}`, f-vector `(600,1200,120,5)`, `|Gamma| = 7200`; stored `|w_a|^2 = 5/2-4*E(40)^8+4*E(40)^12` (~0.027864045000), `|w_b|^2 = 5-8*E(40)^8+8*E(40)^12` (~0.055728090001).
* **Method 1 certificate** (`L3-{3,3,5/2}-1 -> L3-{3,3,5/2}-4`, flag-anchored `odd` candidate, hits the intended flag of `b`): `lambda = 2` (~2.0), `det M = 4` (`= +lambda^2`, sign +1), conjugated triple orientation: `mirror`.

    M =
    `-E(5)-1/2*E(5)^2-1/2*E(5)^3-E(5)^4`  `0`  `-1/2*E(5)-E(5)^2-E(5)^3-1/2*E(5)^4`  `1/2`
    `0`  `1/2*E(5)-1/2*E(5)^2-1/2*E(5)^3+1/2*E(5)^4`  `1/2*E(5)+1/2*E(5)^4`  `1/2*E(5)^2+1/2*E(5)^3`
    `-1/2*E(5)-E(5)^2-E(5)^3-1/2*E(5)^4`  `1/2*E(5)+1/2*E(5)^4`  `-1/2*E(5)-1/2*E(5)^4`  `1/2*E(5)+1/2*E(5)^4`
    `1/2`  `1/2*E(5)^2+1/2*E(5)^3`  `1/2*E(5)+1/2*E(5)^4`  `-1`

    exact checks: traversal True, `M M^T = lambda I` True, `det = +-lambda^2` True, vertices True, edges True, 2-faces True, cells True, `M^-1 S1 M, M^-1 S2 M, M^-1 X_a M in Gamma_b` True/True/True, `M S1 M^-1, M S2 M^-1, M X_b M^-1 in Gamma_a` True/True/True.

* **Method 2 certificate** (`L3-{3,3,5/2}-1 -> L3-{3,3,5/2}-4`, `M = B_a^-1 B_b` from the canonical minimising bases; independent Sage arithmetic): `lambda = 2` (~2.000000), `det M = 4`, sign +1; checks `M M^T = lambda I` True, `det = sign lambda^2` True, vertices True, edges True, faces True, cells True; exhaustive count of similarities fixing `w_a -> w_b`: 12 (det signs `+`).

    M =
    `1/2-1/2*E(40)^8+1/2*E(40)^12`  `0`  `1+1/2*E(40)^8-1/2*E(40)^12`  `1/2`
    `-1/2-1/2*E(40)^8+1/2*E(40)^12`  `1`  `1/2*E(40)^8-1/2*E(40)^12`  `-1/2`
    `-1/2-1/2*E(40)^8+1/2*E(40)^12`  `0`  `-1/2*E(40)^8+1/2*E(40)^12`  `1/2+E(40)^8-E(40)^12`
    `1/2+1/2*E(40)^8-1/2*E(40)^12`  `1`  `-1/2*E(40)^8+1/2*E(40)^12`  `1/2`

* **Author's check** (`L3-{3,3,5/2}-1 -> L3-{3,3,5/2}-4`): `M = M0 / c` with `M0` the anti-automorphism realiser of the row (below) and `c = -2` (exact: `w_a M0 = c w_b` is true); `lambda = 2` (`= |w_b|^2/|w_a|^2`: true), `det M = 4` (`> 0`: true); structure carried onto `b`: vertices true, edges true, 2-faces true, cells true; `lambda = 1` (isometry as stored): **false**.

* **Method 4 re-verification** (pure Python `Q(zeta_40)`): 4 certificate line(s) for this pair, fields: case_a=L3-{3,3,5/2}-4, case_b=L3-{3,3,5/2}-1, candidate=even, lambda_json=1/2, lambda_exact_powerbasis=1/2, lambda_float=0.500000, isometry=False, lambda_ok=True, lambda_real=True, M_real=True, MMt_ok=True, det_json=1/4, det_exact_powerbasis=1/4, det_sign_json=1, det_sign_computed=1, det_ok=True, det_matches_json=True, vertices_onto=True, edges_onto=True, faces_onto=True, cells_onto=True, w_maps_to_w=True, image_flag_orbit_json=odd, image_flag_orbit_computed=odd, flag_orbit_agrees=True, flag_image_kind=base_flag_other_cell, flag_image_agrees=True, anchor_images_agree=True, M_in_Gamma_b=n/a, represents_own_coset_json=False, triple_orientation_json=mirror, all_ok=True; case_a=L3-{3,3,5/2}-4, case_b=L3-{3,3,5/2}-1, candidate=odd, lambda_json=1/2, lambda_exact_powerbasis=1/2, lambda_float=0.500000, isometry=False, lambda_ok=True, lambda_real=True, M_real=True, MMt_ok=True, det_json=1/4, det_exact_powerbasis=1/4, det_sign_json=1, det_sign_computed=1, det_ok=True, det_matches_json=True, vertices_onto=True, edges_onto=True, faces_onto=True, cells_onto=True, w_maps_to_w=True, image_flag_orbit_json=odd, image_flag_orbit_computed=odd, flag_orbit_agrees=True, flag_image_kind=2-adjacent(w,e,fS2,c), flag_image_agrees=True, anchor_images_agree=True, M_in_Gamma_b=n/a, represents_own_coset_json=True, triple_orientation_json=mirror, all_ok=True

## The anti-automorphism realisers `M0` (author's check)

For each row `T`, `M0` spans the one-dimensional space of matrices with `M0 S1 = S1^-1 M0` and `M0 S2 = S2^-1 M0`; `M0 M0^T = mu I`, `M0^2 = mu I`, `det M0 = +mu^2`, so `M0/sqrt(mu)` is a half-turn about a 2-plane (proper).  Its restriction to the PETCOX circle `Pi = Fix(S2)` is a reflection whose fixed points are exactly the geometrically regular values of alpha printed in PETCOX Section 4.

* row `{4,3,3}`: `M0 = [ [ 0, -1, 1, 1 ], [ -1, 1, 0, 1 ], [ 1, 0, -1, 1 ], [ 1, 1, 1, 0 ] ]`
* row `{5,3,3}`: `M0 = [ [ 2*E(5)+3*E(5)^2+3*E(5)^3+2*E(5)^4, 0, -E(5)-2*E(5)^2-2*E(5)^3-E(5)^4, 1 ], [ 0, -E(5)-E(5)^4, -E(5)^2-E(5)^3, E(5)+3*E(5)^2+3*E(5)^3+E(5)^4 ], [ -E(5)-2*E(5)^2-2*E(5)^3-E(5)^4, -E(5)^2-E(5)^3, -2*E(5)^2-2*E(5)^3, 1 ], [ 1, E(5)+3*E(5)^2+3*E(5)^3+E(5)^4, 1, 1 ] ]`
* row `{5,3,5/2}`: `M0 = [ [ 3/5*E(5)-3/5*E(5)^2-3/5*E(5)^3+3/5*E(5)^4, 0, -4/5*E(5)-11/5*E(5)^2-11/5*E(5)^3-4/5*E(5)^4, -1/5*E(5)-4/5*E(5)^2-4/5*E(5)^3-1/5*E(5)^4 ], [ 0, -3/5*E(5)+3/5*E(5)^2+3/5*E(5)^3-3/5*E(5)^4, -1/5*E(5)-4/5*E(5)^2-4/5*E(5)^3-1/5*E(5)^4, 4/5*E(5)+11/5*E(5)^2+11/5*E(5)^3+4/5*E(5)^4 ], [ -4/5*E(5)-11/5*E(5)^2-11/5*E(5)^3-4/5*E(5)^4, -1/5*E(5)-4/5*E(5)^2-4/5*E(5)^3-1/5*E(5)^4, -1, -2/5*E(5)+2/5*E(5)^2+2/5*E(5)^3-2/5*E(5)^4 ], [ -1/5*E(5)-4/5*E(5)^2-4/5*E(5)^3-1/5*E(5)^4, 4/5*E(5)+11/5*E(5)^2+11/5*E(5)^3+4/5*E(5)^4, -2/5*E(5)+2/5*E(5)^2+2/5*E(5)^3-2/5*E(5)^4, 1 ] ]`
* row `{3,3,5/2}`: `M0 = [ [ -2, 1, E(5)+E(5)^4, -E(5)^2-E(5)^3 ], [ 1, E(5)^2+E(5)^3, E(5)+E(5)^4, 2 ], [ E(5)+E(5)^4, E(5)+E(5)^4, -E(5)-2*E(5)^2-2*E(5)^3-E(5)^4, -E(5)-E(5)^4 ], [ -E(5)^2-E(5)^3, 2, -E(5)-E(5)^4, 1 ] ]`

## Non-equivalence certificates

* **Different f-vector** (448 ordered pairs, i.e. 224 unordered): trivially inequivalent under every relation.

* **Equal f-vector, not similar** (40 unordered pairs): Method 1 enumerated **all** ordered 4-tuples of vertices of `b` whose exact Gram matrix equals `lambda` times that of the anchor `(w_a, w_a S1, w_a S1^2, w_a S1^3)` and found that **none** of them induces a structure map (`exhaustive_similarities = 0`), which exhausts every similarity `a -> b`; Method 2 found **zero** Gram-compatible neighbour triples at `w_b` (and distinct canonical forms), independently.  These 40 pairs are listed in `logs/method1-pairs.tsv` (verdict `R5-similar=no`) and `logs/method2-pairs.tsv` (`eq_scalefree_unoriented = no`, `n_gram_compatible = 0`).  They include the 4 cross-row pairs `{5,3,3}` vs `{3,3,5/2}` (same f-vector `(600,1200,120,5)`, same `|Gamma| = 7200`) and, inside each abstract class of four, the four pairs other than the two certified ones.

* **Not congruent as stored** (all 276 unordered pairs): for the 12 similar pairs `lambda != 1` exactly (Methods 1, 2 and the author's check); for the rest, not even similar.  Hence 24 congruence classes.

* **No improper equivalences anywhere**: every similarity found by the exhaustive enumerations has `det > 0` (Method 1: det-sign set `{+1}` for all 48 similar ordered pairs including `a = b`; Method 2: `sim_det_signs = +`).  In particular every one of the 24 realisations is geometrically chiral (its full similarity group is `Gamma`, of order `|Gamma|`, with no improper element), and no stored realisation is the mirror image of another.

### The 40 non-similar equal-f-vector pairs (unordered), with Method 1's exhaustive tuple counts

| a | b | f-vector | Gram-consistent 4-tuples enumerated | similarities found | Method 2 Gram-compatible triples |
|---|---|---|---|---|---|
| `L3-{4,3,3}-1` | `L3-{4,3,3}-2` | `(16,32,12,4)` | 384 | 0 | 0 |
| `L3-{4,3,3}-1` | `L3-{4,3,3}-3` | `(16,32,12,4)` | 384 | 0 | 0 |
| `L3-{4,3,3}-2` | `L3-{4,3,3}-6` | `(16,32,12,4)` | 384 | 0 | 0 |
| `L3-{4,3,3}-3` | `L3-{4,3,3}-6` | `(16,32,12,4)` | 384 | 0 | 0 |
| `L3-{5,3,3}-3` | `L3-{3,3,5/2}-1` | `(600,1200,120,5)` | 14400 | 0 | 0 |
| `L3-{5,3,3}-3` | `L3-{3,3,5/2}-4` | `(600,1200,120,5)` | 14400 | 0 | 0 |
| `L3-{5,3,3}-8` | `L3-{3,3,5/2}-1` | `(600,1200,120,5)` | 14400 | 0 | 0 |
| `L3-{5,3,3}-8` | `L3-{3,3,5/2}-4` | `(600,1200,120,5)` | 14400 | 0 | 0 |
| `L3-{5,3,5/2}-1` | `L3-{5,3,5/2}-2` | `(240,480,120,20)` | 2880 | 0 | 0 |
| `L3-{5,3,5/2}-1` | `L3-{5,3,5/2}-3` | `(240,480,120,20)` | 2880 | 0 | 0 |
| `L3-{5,3,5/2}-2` | `L3-{5,3,5/2}-4` | `(240,480,120,20)` | 2880 | 0 | 0 |
| `L3-{5,3,5/2}-3` | `L3-{5,3,5/2}-4` | `(240,480,120,20)` | 2880 | 0 | 0 |
| `L3-{5,3,5/2}-5` | `L3-{5,3,5/2}-6` | `(48,144,48,8)` | 2304 | 0 | 0 |
| `L3-{5,3,5/2}-5` | `L3-{5,3,5/2}-7` | `(48,144,48,8)` | 2304 | 0 | 0 |
| `L3-{5,3,5/2}-6` | `L3-{5,3,5/2}-8` | `(48,144,48,8)` | 2304 | 0 | 0 |
| `L3-{5,3,5/2}-7` | `L3-{5,3,5/2}-8` | `(48,144,48,8)` | 2304 | 0 | 0 |
| `L3-{5,3,5/2}-9` | `L3-{5,3,5/2}-10` | `(120,720,300,50)` | 14400 | 0 | 0 |
| `L3-{5,3,5/2}-9` | `L3-{5,3,5/2}-11` | `(120,720,300,50)` | 14400 | 0 | 0 |
| `L3-{5,3,5/2}-9` | `L3-{5,3,5/2}-13` | `(120,720,300,50)` | 14400 | 0 | 0 |
| `L3-{5,3,5/2}-9` | `L3-{5,3,5/2}-14` | `(120,720,300,50)` | 14400 | 0 | 0 |
| `L3-{5,3,5/2}-9` | `L3-{5,3,5/2}-15` | `(120,720,300,50)` | 14400 | 0 | 0 |
| `L3-{5,3,5/2}-9` | `L3-{5,3,5/2}-16` | `(120,720,300,50)` | 14400 | 0 | 0 |
| `L3-{5,3,5/2}-10` | `L3-{5,3,5/2}-12` | `(120,720,300,50)` | 14400 | 0 | 0 |
| `L3-{5,3,5/2}-10` | `L3-{5,3,5/2}-13` | `(120,720,300,50)` | 14400 | 0 | 0 |
| `L3-{5,3,5/2}-10` | `L3-{5,3,5/2}-14` | `(120,720,300,50)` | 14400 | 0 | 0 |
| `L3-{5,3,5/2}-10` | `L3-{5,3,5/2}-15` | `(120,720,300,50)` | 14400 | 0 | 0 |
| `L3-{5,3,5/2}-10` | `L3-{5,3,5/2}-16` | `(120,720,300,50)` | 14400 | 0 | 0 |
| `L3-{5,3,5/2}-11` | `L3-{5,3,5/2}-12` | `(120,720,300,50)` | 14400 | 0 | 0 |
| `L3-{5,3,5/2}-11` | `L3-{5,3,5/2}-13` | `(120,720,300,50)` | 14400 | 0 | 0 |
| `L3-{5,3,5/2}-11` | `L3-{5,3,5/2}-14` | `(120,720,300,50)` | 14400 | 0 | 0 |
| `L3-{5,3,5/2}-11` | `L3-{5,3,5/2}-15` | `(120,720,300,50)` | 14400 | 0 | 0 |
| `L3-{5,3,5/2}-11` | `L3-{5,3,5/2}-16` | `(120,720,300,50)` | 14400 | 0 | 0 |
| `L3-{5,3,5/2}-12` | `L3-{5,3,5/2}-13` | `(120,720,300,50)` | 14400 | 0 | 0 |
| `L3-{5,3,5/2}-12` | `L3-{5,3,5/2}-14` | `(120,720,300,50)` | 14400 | 0 | 0 |
| `L3-{5,3,5/2}-12` | `L3-{5,3,5/2}-15` | `(120,720,300,50)` | 14400 | 0 | 0 |
| `L3-{5,3,5/2}-12` | `L3-{5,3,5/2}-16` | `(120,720,300,50)` | 14400 | 0 | 0 |
| `L3-{5,3,5/2}-13` | `L3-{5,3,5/2}-15` | `(120,720,300,50)` | 14400 | 0 | 0 |
| `L3-{5,3,5/2}-13` | `L3-{5,3,5/2}-16` | `(120,720,300,50)` | 14400 | 0 | 0 |
| `L3-{5,3,5/2}-14` | `L3-{5,3,5/2}-15` | `(120,720,300,50)` | 14400 | 0 | 0 |
| `L3-{5,3,5/2}-14` | `L3-{5,3,5/2}-16` | `(120,720,300,50)` | 14400 | 0 | 0 |
