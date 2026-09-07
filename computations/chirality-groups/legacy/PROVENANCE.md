# Legacy GAP scripts (unmodified copies)

The files in this directory are **verbatim, unmodified copies** of the GAP
scripts written for the master's thesis and the paper *Two new chiral
4-polytopes of full rank*.  They are included only so that the definitions
transcribed into `../rolis-cube/compute.g` and `../12-over-1-5-3-5/compute.g`
can be checked against their source without leaving this repository.  They
are **not** executed by `../run.sh` (two of them load the optional package
`sonata`, which the new computation avoids).

Source of the copies (local checkouts, identical in both):

* `~/github/daniel/skeletal-polytopes/` (git remote `sergunchik/daniel`,
  commit `35c663e`, 2025-10-20, "Renamed GAP scripts file extension");
* `~/github/cayleypy/thesis/` (identical byte-for-byte).

The paper points to <https://github.com/danimalabares/tesina> for the
scripts; the older checkout `~/github/tesina` (remote `dan-gc/tesina`)
contains `abstract.txt` and `geometric.txt`.  `geometric.txt` is
byte-identical to `geometric.g`; `abstract.txt` lacks only the last 14 lines
of `abstract.g` (an unused `IsomorphismFpGroup` / `IsomorphismPermGroup`
experiment).  The other four legacy scripts have no counterpart there; its
remaining `.txt` files (`abstract-dual.txt`, `geometric-dual.txt`,
`int-prop.txt`, `int-prop-dual.txt`) are dual-polytope and
intersection-property scripts that are not copied here.

SHA-256 checksums of the copies are in `SHA256SUMS`
(`shasum -a 256 -c SHA256SUMS`).

| file | what it defines | used for |
|------|-----------------|----------|
| `combinatorially-chiral-cube.g` | Coxeter group `[4,3,3]` as an fp group on `E0..E3`; `S1:=E0*E1*E3*E2; S2:=E2*E1; S3:=E3*E2`; the Schulte–Weiss mirror test | Roli's cube, abstract triple |
| `cube.g` | the four reflection matrices of the 4-cube and the same words `S1,S2,S3` as matrices; Wythoff face counts | Roli's cube, geometric cross-check |
| `combinatorially-chiral.g` | Coxeter group `[3,3,5]`; `P0:=E0; P1:=E1*E2*E3*E2*E1*E0*E1*E2*E3*E2*E1; P2:=E3; P3:=E2`; `S1:=P0*P1*P3*P2; S2:=P2*P1; S3:=P3*P2`; mirror test | `{12/(1,5),3,5}`, abstract triple |
| `abstract.g` | same definitions plus string relations, coset face counts, intersection property, mirror test | `{12/(1,5),3,5}`, abstract triple |
| `geometric.g` | reflection matrices of the 600-cell (golden ratio), the same `P_i`, `S_i` as matrices, base vertex `w0`, Wythoff face counts and stabilisers | `{12/(1,5),3,5}`, geometric cross-check |
| `chiral.g` | earlier version of `geometric.g` (matrix version with face counts) | reference only |
