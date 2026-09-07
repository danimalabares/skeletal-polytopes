# Chirality groups of two skeletal 4-polytopes

## The question

The paper asks whether the mirror-generator rule

$$
S_1\mapsto S_1^{-1},\qquad S_2\mapsto S_1^2S_2,\qquad S_3\mapsto S_3
$$

defines an automorphism of the rotation group $\Gamma$. Here we ask the
sharper question: what is the complete group-theoretic obstruction when it
does not?

## The answer

The **chirality group** $X(\mathcal P)$ is the smallest normal subgroup of
$\Gamma$ that must be factored out so that the mirror-generator rule becomes
a well-defined automorphism of $\Gamma/X(\mathcal P)$.

| Polytope | $\lvert\Gamma\rvert$ | $X(\mathcal P)$ | $\Gamma/X(\mathcal P)$ |
|---|---:|---|---|
| Roli's cube | $192$ | $C_2=\langle S_1^4\rangle$ | order $96$ |
| $\{12/(1,5),3,5\}$ | $7200$ | $\mathrm{SL}(2,5)$, order $120$ | $A_5$ |

For Roli's cube the chirality group is the smallest possible nontrivial one:
the mirror defect is a single central involution.

For $\{12/(1,5),3,5\}$, the familiar obstruction

$$
(S_1^{-1}S_3)^5=1,\qquad (S_1S_3)^5\ne1
$$

is only the first visible defect. Its normal closure is the entire chirality
group:

$$
\left\langle\!\left\langle(S_1S_3)^5\right\rangle\!\right\rangle_\Gamma
=X(\mathcal P)\cong\mathrm{SL}(2,5).
$$

Thus the computation upgrades “$\rho$ does not exist” to an identification of
the complete obstruction. In this precise group-theoretic sense, the
combinatorial chirality of $\{12/(1,5),3,5\}$ is much larger than that of
Roli's cube.

## Why compute this?

The immediate goals are to quantify combinatorial chirality rather than merely
detect it, and to understand how one obstructing relation normally generates
the full chirality group.

**Research directions (not established theorems):** compare full-rank finite
chiral 4-polytopes by their chirality groups, and use these computations as a
starting point for the paper and for searches for related constructions or
families.

The results were verified by two exact GAP methods: the normal closure of the
mirrored defining relators and the kernel obtained from the mix with the
enantiomorphic group. A normal-subgroup-lattice calculation supplies a further
cross-check. AI helped construct and inspect the programs; the evidence is the
reproducible group computation and its explicit assertions, not trust in an AI
answer.

Run everything from this directory with `./run.sh`.

## File map

- [`run.sh`](run.sh): one-command reproduction.
- [`verify.g`](verify.g): all assertions and checks.
- [`rolis-cube/compute.g`](rolis-cube/compute.g) and
  [`12-over-1-5-3-5/compute.g`](12-over-1-5-3-5/compute.g): the two computations.
- [`common/chirality-group.g`](common/chirality-group.g): shared exact methods.
- [`results/`](results/): saved transcripts and verification output.
- [`references.md`](references.md): sources and precise pointers.
- [`TECHNICAL_NOTES.md`](TECHNICAL_NOTES.md): definitions, derivations,
  implementation notes, and the full verification record.
