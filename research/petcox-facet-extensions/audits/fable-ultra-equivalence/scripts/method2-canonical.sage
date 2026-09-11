# method2-canonical.sage
# ---------------------------------------------------------------------------
# METHOD 2 of the fable-ultra-equivalence audit: canonical forms of the
# weighted incidence / distance structure of the 24 stored PETCOX realisations,
# computed in SageMath with EXACT arithmetic in K = Q(zeta_40) = CyclotomicField(40).
#
# Run (transcript):
#   cd $AUDIT/scripts && /usr/local/bin/sage method2-canonical.sage 2>&1 | tee ../logs/method2-canonical.log
#
# Input : $DATA = alpha-survivors.g (the 24 records "Add(PX.Saved, rec(...))"),
#         parsed here by regex; NOTHING else from the producer is used (no lib.g,
#         no producer functions).  Conventions (from the task statement):
#         matrices act on ROW vectors from the right, v*M; A*B = "A first, then B".
# Output: ../logs/method2-classes.tsv, ../logs/method2-pairs.tsv,
#         ../logs/method2-certificates.json, ../logs/method2-certificates.g (GAP copy of the
#         certificates, re-verified independently by method2-verify-certificates.g)  (+ this transcript).
#
# Every decision below is made with exact arithmetic in K (or in Z for the
# incidence structure).  Floating point (200-bit) is used ONLY to (a) order the
# finitely many exact inner-product values that occur (after proving each is
# real by exact conjugation invariance and that distinct values are separated by
# more than 1e-30) and (b) to display numbers.
#
# ---------------------------------------------------------------------------
# COMPLETENESS ARGUMENT for the canonical form (why "equal CF" <=> "equivalent"):
#
#  * A finite set of vectors spanning E^4 is determined up to O(4) by its Gram
#    matrix (indexed by a fixed enumeration): if (u_i.u_j) = (u'_i.u'_j) for all
#    i,j then, choosing 4 independent u_i, the linear map sending u_i -> u'_i is
#    orthogonal and sends every u_k to u'_k (the coordinates of u_k in the basis
#    are (Gram_4)^-1 (u_k.u_i), which are equal on both sides).
#  * Our key for an admissible basis b = (v0,v1,v2,v3) (v0 = base vertex,
#    v1,v2,v3 edge-neighbours of v0, the four vectors linearly independent) lists
#    the vertices in the order given by the label 4-tuple (u.v0,u.v1,u.v2,u.v3),
#    which is injective because v0..v3 span E^4 (u is determined by its inner
#    products with a basis); in that order it records the full Gram matrix of
#    the vertex set (as labels) together with the edge, 2-face and cell lists.
#    Labels are a GLOBAL order-preserving injection of the exact inner-product
#    values into Z, so equal labels <=> equal exact values.
#  * Hence key(b_P) = key(b_Q) for bases b_P of P and b_Q of Q gives a vertex
#    bijection P -> Q preserving every inner product and every edge/face/cell,
#    i.e. a linear map M in O(4) carrying P onto Q (vertex set to vertex set,
#    edge set to edge set, face set to face set, cell set to cell set), with
#    B_P*M = B_Q.  Conversely such an M maps every admissible basis of P to an
#    admissible basis of Q with the same key.  So the SET of keys of P equals
#    the set of keys of Q iff such an M exists, and then the minimum key (the
#    canonical form CF) agrees.  Conversely equal CF => the two minimising bases
#    have equal key => an M exists.  With RAW inner products M is an isometry;
#    with SCALEFREE inner products (u.v)/(w.w) the same argument gives a
#    SIMILARITY, M*M^T = lambda*I, lambda = (w_Q.w_Q)/(w_P.w_P).
#  * ORIENTED form: we append sign det[v0;v1;v2;v3] to the key and minimise
#    (-1 < +1).  M constructed from two bases with equal (key, sign) has
#    det M = det B_Q / det B_P > 0, i.e. is PROPER; conversely a proper M maps
#    (key, sign) to (key, sign).  So equal oriented CF <=> a proper similarity
#    (resp. isometry) exists; equal unoriented CF with different oriented CF
#    <=> only improper maps exist.
#  * Restriction to v0 = w (the base vertex): Gamma = <S1,S2,X> is exactly
#    orthogonal (checked) and acts transitively on the vertex set (the vertex
#    set IS the Gamma-orbit of w by construction) and preserves the edge/face/
#    cell sets (they are Gamma-orbits).  Therefore every admissible basis at any
#    vertex v = w*g is the image under the isometry g of an admissible basis at
#    w with the same key.  If all generators are proper the sign is preserved as
#    well and the minimum over bases at w equals the minimum over ALL bases.  If
#    some generator is improper, the set of (key,sign) over all bases is the set
#    at w closed under sign flip, and we take that closure explicitly (flag
#    "improper").  Either way CF is the minimum over ALL admissible bases of the
#    realisation, which is the invariant used in the argument above.
# ---------------------------------------------------------------------------

import re, os, sys, json, hashlib, time
from itertools import permutations
from operator import itemgetter
from collections import deque

T0 = time.time()
def elapsed():
    return "%.1fs" % (time.time() - T0)

SCRIPTNAME = "method2-canonical.sage"
DATA = os.environ.get("M2_DATA",
    "/private/tmp/claude-501/-Users-daniel-github-skeletal-polytopes/d4b2e626-5fbc-48d1-9c01-c9dc4a79290e/scratchpad/producer/research/petcox-facet-extensions/logs/alpha-survivors.g")
AUDIT = os.environ.get("M2_AUDIT",
    "/Users/daniel/github/skeletal-polytopes/research/petcox-facet-extensions/audits/fable-ultra-equivalence")
LOGDIR = os.path.join(AUDIT, "logs")
ONLY = os.environ.get("M2_ONLY", "")   # optional ";"-separated case filter (development aid only)

print("=== %s ===" % SCRIPTNAME)
print("Sage version:", version())
print("DATA  =", DATA)
print("LOGDIR=", LOGDIR)
print("sha256(DATA) =", hashlib.sha256(open(DATA, "rb").read()).hexdigest())

# ---------------------------------------------------------------- the field K
K = CyclotomicField(40)
z = K.gen()                        # zeta_40 = exp(2*pi*i/40) under the complex embedding
conj = K.hom([z**-1])              # complex conjugation, z -> z^-1 (exact field automorphism)
assert conj(z) == z**39 and conj(conj(z)) == z
emb = K.complex_embedding(200)     # z -> exp(2*pi*i/40) at 200 bits
RR200 = RealField(200)
TINY = RR200(1) / RR200(10)**30    # 1e-30 separation threshold
assert abs(emb(z) - ComplexField(200)(exp(2*pi*I/40))) < TINY, "embedding convention"

FAILURES = []
def check(cond, msg):
    tag = "[ok]  " if cond else "[FAIL]"
    print("  %s %s" % (tag, msg))
    if not cond:
        FAILURES.append(msg)
    return bool(cond)

def real_value(x):
    """Exact reality check (conj(x) == x), then a 200-bit real approximation."""
    x = K(x)
    assert conj(x) == x, "value is not real: %s" % x
    c = emb(x)
    assert abs(c.imag()) < TINY
    return c.real()

def sign_of(x):
    """Exact sign of a nonzero real element of K (via the real embedding after exact reality check)."""
    x = K(x)
    assert x != 0, "sign of zero requested"
    r = real_value(x)
    assert abs(r) > TINY, "real value too close to 0 for sign determination: %s" % x
    return int(1) if r > 0 else int(-1)

def flt(x):
    return float(real_value(x))

def gapstr(x):
    """GAP input notation for x in K: sum of c*E(40)^k with rational c (power basis z^0..z^15)."""
    x = K(x)
    cs = x.list()
    terms = []
    for k, c in enumerate(cs):
        if c == 0:
            continue
        c = QQ(c)
        if k == 0:
            t = str(c)
        else:
            mono = "E(40)" if k == 1 else "E(40)^%d" % k
            if c == 1:
                t = mono
            elif c == -1:
                t = "-" + mono
            else:
                t = "%s*%s" % (c, mono)
        terms.append(t)
    if not terms:
        return "0"
    s = terms[0]
    for t in terms[1:]:
        s += t if t.startswith("-") else "+" + t
    return s

def gapvec(v):
    return "[ " + ", ".join(gapstr(x) for x in v) + " ]"

def gapmat(M):
    return "[ " + ", ".join(gapvec(r) for r in M) + " ]"

# ---------------------------------------------------------------- parsing $DATA
E_RE = re.compile(r"E\((\d+)\)(?:\^(\d+))?")

def gap_to_K(s):
    """Convert a GAP cyclotomic/rational expression to K exactly; 'infinity' -> None."""
    s = s.strip()
    if s == "infinity":
        return None
    def rep(m):
        n = int(m.group(1))
        k = int(m.group(2)) if m.group(2) else 1
        assert 40 % n == 0, "E(%d) is not in Q(E(40))" % n
        return "(z**%d)" % ((k * 40) // n)
    t = E_RE.sub(rep, s)
    assert "E" not in t, t
    val = sage_eval(t, locals={"z": z})      # preparser on: 1/2 is an exact Rational
    return K(val)

def parse_vector(s):
    s = s.strip()
    assert s[0] == "[" and s[-1] == "]", s
    return tuple(gap_to_K(t) for t in s[1:-1].split(","))

def parse_matrix(s):
    rows = re.findall(r"\[([^\[\]]*)\]", s)
    M = [tuple(gap_to_K(t) for t in r.split(",")) for r in rows]
    assert len(M) == 4 and all(len(r) == 4 for r in M), s
    return M

REC_RE = re.compile(
    r'Add\(PX\.Saved, rec\(case := "([^"]*)", T := "([^"]*)", parent := "([^"]*)", '
    r'alpha := ([^,]*), ab := \[ ([^\]]*) \], '
    r'S1 := (\[ \[.*?\] \]), S2 := (\[ \[.*?\] \]), X := (\[ \[.*?\] \]), '
    r'w := (\[ [^\]]* \]), skeletal := (\w+), directly_regular := (\w+)\)\);')

def parse_data(path):
    text = open(path).read()
    nlines = sum(1 for ln in text.splitlines() if ln.startswith("Add(PX.Saved"))
    recs = []
    for m in REC_RE.finditer(text):
        case, T, parent, alpha, ab, S1, S2, X, w, sk, dr = m.groups()
        r = dict(case=case, T=T, parent=parent,
                 alpha_gap=alpha.strip(), alpha=gap_to_K(alpha),
                 ab_gap=ab.strip(), ab=[gap_to_K(t) for t in ab.split(",")],
                 S1=parse_matrix(S1), S2=parse_matrix(S2), X=parse_matrix(X),
                 w=parse_vector(w), skeletal=sk, directly_regular=dr)
        mnum = re.search(r"-(\d+)$", case)
        r["casenum"] = int(mnum.group(1))
        recs.append(r)
    check(nlines == 24, "data file has 24 'Add(PX.Saved' lines (found %d)" % nlines)
    check(len(recs) == 24, "regex parsed all 24 records (parsed %d)" % len(recs))
    return recs

# ---------------------------------------------------------------- linear algebra helpers (row convention)
ID4 = [tuple(K(1) if i == j else K(0) for j in range(4)) for i in range(4)]

def vec_mul(v, M):
    """row vector v times matrix M (list of 4 rows)."""
    return tuple(sum((v[i] * M[i][j] for i in range(4)), K(0)) for j in range(4))

def mat_mul(A, B):
    return [vec_mul(A[i], B) for i in range(4)]

def mat_T(A):
    return [tuple(A[i][j] for i in range(4)) for j in range(4)]

def mat_eq(A, B):
    return all(A[i][j] == B[i][j] for i in range(4) for j in range(4))

def det4(A):
    return matrix(K, [list(r) for r in A]).det()

def mat_order(A, cap=1000):
    P = A
    for k in range(1, cap + 1):
        if mat_eq(P, ID4):
            return k
        P = mat_mul(P, A)
    raise ValueError("order > %d" % cap)

def inner(u, v):
    return sum((u[i] * v[i] for i in range(4)), K(0))

def orbit_bfs(start, actions):
    """Closure of one element under a list of functions.  Returns (list in BFS order, index dict)."""
    items = [start]
    index = {start: 0}
    q = deque([start])
    while q:
        x = q.popleft()
        for act in actions:
            y = act(x)
            if y not in index:
                index[y] = len(items)
                items.append(y)
                q.append(y)
    return items, index

def expected_fvector(T, casenum):
    if T == "{4,3,3}":
        return (16, 32, 12, 4)
    if T in ("{5,3,3}", "{3,3,5/2}"):
        return (600, 1200, 120, 5)
    if T == "{5,3,5/2}":
        if 1 <= casenum <= 4:
            return (240, 480, 120, 20)
        if 5 <= casenum <= 8:
            return (48, 144, 48, 8)
        if 9 <= casenum <= 16:
            return (120, 720, 300, 50)
    raise ValueError("no expected f-vector for %s %d" % (T, casenum))

# ---------------------------------------------------------------- reconstruction of one realisation
def reconstruct(rec):
    case = rec["case"]
    print("\n--- reconstructing %s  (T=%s, alpha=%s)  [%s]" % (case, rec["T"], rec["alpha_gap"], elapsed()))
    S1, S2, X, w = rec["S1"], rec["S2"], rec["X"], rec["w"]
    gens = [S1, S2, X]
    gnames = ["S1", "S2", "X"]
    # exact orthogonality and determinants of the generators
    dets = []
    for g, nm in zip(gens, gnames):
        check(mat_eq(mat_mul(g, mat_T(g)), ID4), "%s is exactly orthogonal (%s*%s^T = I)" % (nm, nm, nm))
        d = det4(g)
        check(d == 1 or d == -1, "det %s = %s in {+1,-1}" % (nm, d))
        dets.append(int(d))
    improper = any(d == -1 for d in dets)
    print("  generator determinants (S1,S2,X) = %s ; Gamma contains improper elements: %s" % (dets, improper))
    check(all(conj(x) == x for g in gens for r in g for x in r) and all(conj(x) == x for x in w),
          "all matrix and vector entries are real (conj-invariant)")

    # vertices: BFS orbit of w under S1, S2, X (row action)
    verts, vindex = orbit_bfs(w, [lambda v, g=g: vec_mul(v, g) for g in gens])
    n = len(verts)
    assert verts[0] == w
    # permutation action of the generators on vertex indices
    perms = [[vindex[vec_mul(v, g)] for v in verts] for g in gens]
    for p, nm in zip(perms, gnames):
        assert sorted(p) == list(range(n)), "%s does not permute the vertex set" % nm

    # edges
    S1inv = [tuple(r) for r in matrix(K, [list(r) for r in S1]).inverse().rows()]
    check(mat_eq(mat_mul(S1, S1inv), ID4), "S1^-1 computed exactly")
    wS1inv = vec_mul(w, S1inv)
    j = vindex[wS1inv]
    check(j != 0, "base edge {w, w*S1^-1} has two distinct vertices")
    e0 = frozenset({int(0), j})
    edge_acts = [lambda e, p=p: frozenset(p[x] for x in e) for p in perms]
    edges, eindex = orbit_bfs(e0, edge_acts)

    # base 2-face: p-cycle w*S1^k, p = Order(S1) (computed by iteration)
    p = mat_order(S1)
    cyc = [int(0)]
    for k in range(1, p):
        cyc.append(perms[0][cyc[-1]])
    check(perms[0][cyc[-1]] == 0, "w*S1^p = w  (p = Order(S1) = %d)" % p)
    check(len(set(cyc)) == p, "the p = %d vertices w*S1^k are pairwise distinct" % p)
    f0 = frozenset(frozenset({cyc[k], cyc[(k + 1) % p]}) for k in range(p))
    check(len(f0) == p, "base face has p = %d distinct edges" % p)
    check(all(e in eindex for e in f0), "all edges of the base face belong to the edge orbit")
    face_acts = [lambda f, a=a: frozenset(a(e) for e in f) for a in edge_acts]
    faces, findex = orbit_bfs(f0, face_acts)

    # base cell: closure of {f0} under S1, S2 only; cells: Gamma-orbit
    cell0_faces, _ = orbit_bfs(f0, face_acts[:2])
    c0 = frozenset(cell0_faces)
    cell_acts = [lambda c, a=a: frozenset(a(f) for f in c) for a in face_acts]
    cells, cindex = orbit_bfs(c0, cell_acts)

    fvec = (n, len(edges), len(faces), len(cells))
    exp = expected_fvector(rec["T"], rec["casenum"])
    check(fvec == exp, "f-vector %s equals expected %s" % (fvec, exp))
    print("  base face is a %d-gon; base cell has %d faces; vertex degree %d" %
          (p, len(c0), sum(1 for e in edges if 0 in e)))
    print("  vertex-transitivity: the vertex set is by construction the Gamma-orbit of w (BFS closure), "
          "so Gamma is transitive on vertices; the edge/face/cell sets are Gamma-orbits, so Gamma preserves them.")

    # geometric sanity: centroid, common norm, rank
    vsum = tuple(sum((v[i] for v in verts), K(0)) for i in range(4))
    check(all(x == 0 for x in vsum), "vertex sum is exactly zero (centroid at origin)")
    ww = inner(w, w)
    check(all(inner(v, v) == ww for v in verts), "all vertices have the same exact norm w.w = %s" % gapstr(ww))
    Vm = matrix(K, n, 4, [x for v in verts for x in v])
    rk = Vm.rank()
    # rank over K equals rank over R (rank is invariant under field extension; entries are real)
    check(rk == 4, "vertex set spans a 4-dimensional space (rank %d over K, hence over R)" % rk)

    # order of Gamma via its faithful permutation action on the (spanning) vertex set
    PG = PermutationGroup([[int(p[i]) + 1 for i in range(n)] for p in perms])
    order = int(PG.order())
    check(order in (192, 7200, 2880, 1152), "|Gamma| = %d is one of 192, 7200, 2880, 1152" % order)

    # exact Gram matrix of the vertex set, as local value indices
    t = time.time()
    G = Vm * Vm.transpose()
    Glist = G.list()
    local_vals = []
    local_index = {}
    Lidx = []
    for i in range(n):
        row = []
        base = i * n
        for jj in range(n):
            x = Glist[base + jj]
            k = local_index.get(x)
            if k is None:
                k = len(local_vals)
                local_index[x] = k
                local_vals.append(x)
            row.append(k)
        Lidx.append(row)
    check(Lidx[0][0] == local_index[ww], "Gram[0][0] = w.w")
    print("  Gram matrix: %d x %d, %d distinct exact inner-product values  (%.1fs)" % (n, n, len(local_vals), time.time() - t))
    # distance distribution from w (informational)
    from collections import Counter
    cnt = Counter(Lidx[0])
    dist = sorted(((flt(local_vals[k]), gapstr(local_vals[k]), c) for k, c in cnt.items()), reverse=True)
    print("  inner products with w (value ~ float, exact, multiplicity):")
    for fv, gs, c in dist:
        print("     %12.8f   %-60s x%d" % (fv, gs, c))

    # coordinate-level structures (for R1 comparisons between cases)
    Vset = frozenset(verts)
    Ecoord = {e: frozenset(verts[x] for x in e) for e in edges}
    Fcoord = {f: frozenset(Ecoord[e] for e in f) for f in faces}
    Ccoord = {c: frozenset(Fcoord[f] for f in c) for c in cells}

    return dict(rec=rec, case=case, T=rec["T"], n=n, verts=verts, vindex=vindex, perms=perms,
                gens=gens, dets=dets, improper=improper,
                edges=edges, eindex=eindex, faces=faces, findex=findex, cells=cells, cindex=cindex,
                E_pairs=[tuple(sorted(e)) for e in edges],
                F_list=[[tuple(sorted(e)) for e in f] for f in faces],
                C_list=[[[tuple(sorted(e)) for e in f] for f in c] for c in cells],
                fvec=fvec, p=p, ww=ww, order=order,
                local_vals=local_vals, Lidx=Lidx,
                Vset=Vset, Eset=frozenset(Ecoord.values()), Fset=frozenset(Fcoord.values()),
                Cset=frozenset(Ccoord.values()))

# ---------------------------------------------------------------- canonical forms
def admissible_bases(C):
    verts, edges = C["verts"], C["edges"]
    nbrs = sorted({x for e in edges if 0 in e for x in e if x != 0})
    bases = []
    ndep = 0
    for (i1, i2, i3) in permutations(nbrs, int(3)):
        d = matrix(K, [list(verts[0]), list(verts[i1]), list(verts[i2]), list(verts[i3])]).det()
        if d == 0:
            ndep += 1
            continue
        bases.append(((int(0), i1, i2, i3), sign_of(d)))
    return nbrs, bases, ndep

def canonical_form(L, bases, n, E_pairs, F_list, C_list, improper):
    """Return (CF_unoriented, minimising bases [(B,sign)], oriented sign, #stage-1 minimisers)."""
    best = None
    minimisers = []
    for (B, s) in bases:
        i0, i1, i2, i3 = B
        gram4 = tuple(tuple(L[a][b] for b in B) for a in B)
        keyof = [(L[u][i0], L[u][i1], L[u][i2], L[u][i3]) for u in range(n)]
        order = sorted(range(n), key=keyof.__getitem__)
        klist = tuple(keyof[u] for u in order)
        # injectivity of the sorting key (guaranteed since v0..v3 span E^4; asserted anyway)
        assert len(set(klist)) == n, "sorting key not injective for basis %s" % (B,)
        s1 = (gram4, klist)
        if best is None or s1 < best:
            best = s1
            minimisers = [(B, s, order)]
        elif s1 == best:
            minimisers.append((B, s, order))
    n_stage1 = len(minimisers)
    bestfull = None
    full_min = []
    for (B, s, order) in minimisers:
        inv = [0] * n
        for newi, oldi in enumerate(order):
            inv[oldi] = newi
        getter = itemgetter(*order)
        fullG = tuple(getter(L[order[a]]) for a in range(n))
        def ne(e):
            a, b = inv[e[0]], inv[e[1]]
            return (a, b) if a < b else (b, a)
        def nf(f):
            return tuple(sorted(ne(e) for e in f))
        def nc(c):
            return tuple(sorted(nf(f) for f in c))
        edges_new = tuple(sorted(ne(e) for e in E_pairs))
        faces_new = tuple(sorted(nf(f) for f in F_list))
        cells_new = tuple(sorted(nc(c) for c in C_list))
        key = best + (fullG, edges_new, faces_new, cells_new)
        if bestfull is None or key < bestfull:
            bestfull = key
            full_min = [(B, s)]
        elif key == bestfull:
            full_min.append((B, s))
    signs = {s for (B, s) in full_min}
    if improper:
        signs |= {-s for s in signs}
    smin = min(signs)
    return bestfull, full_min, int(smin), n_stage1

def sha(obj):
    return hashlib.sha256(repr(obj).encode()).hexdigest()

# ---------------------------------------------------------------- similarity certificate for a pair
def map_structure(Ca, Cb, Mrows):
    """Check that x -> x*M carries vertices/edges/faces/cells of Ca onto those of Cb (exactly)."""
    phi = []
    for v in Ca["verts"]:
        u = vec_mul(v, Mrows)
        j = Cb["vindex"].get(u)
        if j is None:
            return dict(vertices=False, edges=False, faces=False, cells=False, phi=None)
        phi.append(j)
    vert_ok = (len(set(phi)) == len(phi) == Cb["n"])
    if not vert_ok:
        return dict(vertices=False, edges=False, faces=False, cells=False, phi=None)
    def me(e):
        return frozenset(phi[x] for x in e)
    def mf(f):
        return frozenset(me(e) for e in f)
    def mc(c):
        return frozenset(mf(f) for f in c)
    edges_ok = len(Ca["edges"]) == len(Cb["edges"]) and all(me(e) in Cb["eindex"] for e in Ca["edges"])
    faces_ok = len(Ca["faces"]) == len(Cb["faces"]) and all(mf(f) in Cb["findex"] for f in Ca["faces"])
    cells_ok = len(Ca["cells"]) == len(Cb["cells"]) and all(mc(c) in Cb["cindex"] for c in Ca["cells"])
    return dict(vertices=True, edges=bool(edges_ok), faces=bool(faces_ok), cells=bool(cells_ok), phi=phi)

def verify_similarity(Ca, Cb, Mmat, lam):
    Mrows = [tuple(Mmat.row(i)) for i in range(4)]
    MMt = Mmat * Mmat.transpose()
    ok_sim = (MMt == lam * identity_matrix(K, 4))
    dM = Mmat.det()
    sgn = sign_of(dM)
    ok_det = (dM == sgn * lam**2)
    st = map_structure(Ca, Cb, Mrows)
    return dict(M=Mmat, Mrows=Mrows, lambda_=lam, MMt_eq_lambdaI=bool(ok_sim), det=dM, det_sign=int(sgn),
                det_eq_sign_lambda2=bool(ok_det), vertices=st["vertices"], edges=st["edges"],
                faces=st["faces"], cells=st["cells"],
                all_ok=bool(ok_sim and ok_det and st["vertices"] and st["edges"] and st["faces"] and st["cells"]))

def build_certificate(Ca, Cb, key):
    """M = B_a^-1 * B_b from minimising bases of the given flavour key ('sf' or 'raw')."""
    mins_a = Ca["cf"][key]["minimisers"]
    mins_b = Cb["cf"][key]["minimisers"]
    Ba, sa = mins_a[0]
    same = [B for (B, s) in mins_b if s == sa]
    Bb = same[0] if same else mins_b[0][0]
    A = matrix(K, [list(Ca["verts"][i]) for i in Ba])
    Bm = matrix(K, [list(Cb["verts"][i]) for i in Bb])
    M = A.inverse() * Bm
    lam = Cb["ww"] / Ca["ww"]
    res = verify_similarity(Ca, Cb, M, lam)
    res["basis_a"] = Ba
    res["basis_b"] = Bb
    res["alt"] = None
    # if a proper map is known to exist (equal oriented forms) but M is improper, compose with an
    # improper generator of Gamma_b (which preserves b) to exhibit a proper certificate as well
    if res["det_sign"] < 0 and Ca["cf"][key]["oriented"] == Cb["cf"][key]["oriented"] and Cb["improper"]:
        for g, d in zip(Cb["gens"], Cb["dets"]):
            if d == -1:
                M2 = M * matrix(K, [list(r) for r in g])
                res["alt"] = verify_similarity(Ca, Cb, M2, lam)
                break
    return res

# ---------------------------------------------------------------- exhaustive cross-check (independent of the canonical forms)
def exhaustive_similarities(Ca, Cb):
    """Enumerate ALL linear similarities x -> x*M carrying realisation a onto realisation b with w_a -> w_b.

    Completeness: let M be any similarity (M*M^T = lambda*I) carrying a onto b (vertices, edges, faces,
    cells).  Then lambda = (w_b.w_b)/(w_a.w_a) (all vertices of a have norm w_a.w_a, all of b norm w_b.w_b),
    and w_a*M is a vertex of b; composing with g in Gamma_b (orthogonal, preserves b, transitive on its
    vertices) we may assume w_a*M = w_b.  Fix an admissible basis (v0=w_a, v1, v2, v3) of a; the v_i (i>0)
    are edge-neighbours of w_a, so their images are edge-neighbours u_i of w_b, and (u_i.u_j) = lambda*(v_i.v_j)
    exactly.  M is determined by the u_i (M = B_a^-1 * B_b).  Hence enumerating all ordered triples
    (u1,u2,u3) of neighbours of w_b with the right exact Gram matrix and testing each resulting M finds every
    such similarity; if none is found, NO similarity carries a onto b.  Because all generators of Gamma_b
    are proper (checked; otherwise both det signs would occur anyway), the set of det signs of the
    similarities found equals the set of det signs of ALL similarities a -> b.
    Returns (list of (U, det_sign) for the similarities found, number of Gram-compatible triples)."""
    lam = Cb["ww"] / Ca["ww"]
    B = Ca["cf"]["sf"]["minimisers"][0][0]
    def val(C, i, j):
        return C["local_vals"][C["Lidx"][i][j]]
    target = [[lam * val(Ca, B[i], B[j]) for j in range(4)] for i in range(4)]
    A = matrix(K, [list(Ca["verts"][i]) for i in B])
    Ainv = A.inverse()
    found = []
    ngram = 0
    for (u1, u2, u3) in permutations(Cb["nbrs"], int(3)):
        U = (int(0), u1, u2, u3)
        if not all(val(Cb, U[i], U[j]) == target[i][j] for i in range(4) for j in range(i, 4)):
            continue
        ngram += 1
        M = Ainv * matrix(K, [list(Cb["verts"][i]) for i in U])
        res = verify_similarity(Ca, Cb, M, lam)
        if res["all_ok"]:
            found.append((U, res["det_sign"]))
    return found, ngram

# ---------------------------------------------------------------- main
def main():
    print("\n### 1. parsing")
    recs = parse_data(DATA)
    if ONLY:
        keep = set(ONLY.split(";"))
        recs = [r for r in recs if r["case"] in keep]
        print("  M2_ONLY filter active: %d records" % len(recs))
    for r in recs:
        print("  %-18s T=%-10s alpha=%s" % (r["case"], r["T"], r["alpha_gap"]))
    # within one row T all records share S1, S2
    byT = {}
    for r in recs:
        byT.setdefault(r["T"], []).append(r)
    for T, rs in byT.items():
        check(all(mat_eq(r["S1"], rs[0]["S1"]) and mat_eq(r["S2"], rs[0]["S2"]) for r in rs),
              "row %s: all %d records share S1, S2" % (T, len(rs)))

    print("\n### 2. reconstruction")
    cases = [reconstruct(r) for r in recs]

    print("\n### 3. global label dictionary  [%s]" % elapsed())
    allvals = set()
    for C in cases:
        for x in C["local_vals"]:
            allvals.add(x)
            allvals.add(x / C["ww"])
    allvals = list(allvals)
    approx = []
    for x in allvals:
        approx.append((real_value(x), x))    # asserts exact reality
    approx.sort(key=lambda t: t[0])
    for i in range(len(approx) - 1):
        gap = approx[i + 1][0] - approx[i][0]
        assert gap > TINY, "two distinct exact values closer than 1e-30: %s, %s" % (approx[i][1], approx[i + 1][1])
    LABEL = {x: int(i) for i, (r, x) in enumerate(approx)}
    print("  %d distinct exact inner-product values (RAW and SCALEFREE together); all real (conj-invariant); "
          "min separation of consecutive values = %.3e" %
          (len(LABEL), float(min(approx[i + 1][0] - approx[i][0] for i in range(len(approx) - 1)))))
    for (r, x) in approx:
        print("     label %3d  ~ %14.10f   %s" % (LABEL[x], float(r), gapstr(x)))

    print("\n### 4. canonical forms  [%s]" % elapsed())
    for C in cases:
        t = time.time()
        nbrs, bases, ndep = admissible_bases(C)
        C["nbrs"] = nbrs
        print("\n--- %s: %d neighbours of w, %d ordered triples, %d admissible (independent) bases, %d dependent" %
              (C["case"], len(nbrs), len(nbrs) * (len(nbrs) - 1) * (len(nbrs) - 2), len(bases), ndep))
        check(len(bases) > 0, "at least one admissible basis at w")
        n = C["n"]
        lab_raw = [LABEL[x] for x in C["local_vals"]]
        lab_sf = [LABEL[x / C["ww"]] for x in C["local_vals"]]
        L_raw = [[lab_raw[k] for k in row] for row in C["Lidx"]]
        L_sf = [[lab_sf[k] for k in row] for row in C["Lidx"]]
        C["cf"] = {}
        for key, L in (("raw", L_raw), ("sf", L_sf)):
            cf, mins, smin, n1 = canonical_form(L, bases, n, C["E_pairs"], C["F_list"], C["C_list"], C["improper"])
            cfo = (cf, smin)
            C["cf"][key] = dict(unoriented=cf, oriented=cfo, minimisers=mins, sign=smin,
                                sha_unoriented=sha(cf), sha_oriented=sha(cfo), n_stage1=n1)
            print("  %-3s: %d stage-1 minimisers, %d minimising bases %s, signs %s -> oriented sign %+d" %
                  (key.upper(), n1, len(mins), [B for (B, s) in mins][:8], sorted({s for (B, s) in mins}), smin))
            print("       sha256(unoriented) = %s" % C["cf"][key]["sha_unoriented"])
            print("       sha256(oriented)   = %s" % C["cf"][key]["sha_oriented"])
            B0 = mins[0][0]
            print("       minimising basis b = %s :" % (B0,))
            for i in B0:
                print("          %s" % gapvec(C["verts"][i]))
        print("  (%.1fs)" % (time.time() - t))
        del L_raw, L_sf

    print("\n### 5. classes  [%s]" % elapsed())
    RELS = [("raw", "unoriented", "class_raw_unoriented", "congruence (O(4), reflections allowed)"),
            ("raw", "oriented", "class_raw_oriented", "proper congruence (SO(4))"),
            ("sf", "unoriented", "class_scalefree_unoriented", "similarity"),
            ("sf", "oriented", "class_scalefree_oriented", "proper similarity")]
    classes = {}
    for key, flav, name, desc in RELS:
        reps = []      # list of (cf object, class id)
        ids = {}
        for C in cases:
            cf = C["cf"][key][flav]
            cid = None
            for (rcf, rid, rsha) in reps:
                if cf == rcf:
                    assert rsha == C["cf"][key]["sha_" + flav]
                    cid = rid
                    break
            if cid is None:
                cid = int(len(reps) + 1)
                reps.append((cf, cid, C["cf"][key]["sha_" + flav]))
            ids[C["case"]] = cid
        classes[name] = ids
        part = {}
        for C in cases:
            part.setdefault(ids[C["case"]], []).append(C["case"])
        print("  %-28s (%s): %d classes" % (name, desc, len(reps)))
        for cid in sorted(part):
            print("       class %2d: %s" % (cid, ", ".join(part[cid])))
    # consistency of the four relations (implications)
    for C in cases:
        pass
    def same(name, a, b):
        return classes[name][a] == classes[name][b]
    names = [r[2] for r in RELS]
    for i in range(len(cases)):
        for j in range(i + 1, len(cases)):
            a, b = cases[i]["case"], cases[j]["case"]
            if same("class_raw_oriented", a, b):
                assert same("class_raw_unoriented", a, b) and same("class_scalefree_oriented", a, b)
            if same("class_raw_unoriented", a, b):
                assert same("class_scalefree_unoriented", a, b)
            if same("class_scalefree_oriented", a, b):
                assert same("class_scalefree_unoriented", a, b)
    print("  [ok]   implications proper-congruent => congruent => similar, proper-congruent => proper-similar => similar hold")

    print("\n### 6. R1: exact coincidence of stored vertex sets / whole structures")
    r1_vertex = {}
    r1_struct = {}
    for i in range(len(cases)):
        for j in range(i + 1, len(cases)):
            Ca, Cb = cases[i], cases[j]
            sv = (Ca["Vset"] == Cb["Vset"])
            ss = sv and Ca["Eset"] == Cb["Eset"] and Ca["Fset"] == Cb["Fset"] and Ca["Cset"] == Cb["Cset"]
            r1_vertex[(Ca["case"], Cb["case"])] = sv
            r1_struct[(Ca["case"], Cb["case"])] = ss
            if sv:
                print("  vertex sets coincide exactly: %s and %s ; edges equal: %s ; faces equal: %s ; cells equal: %s ; whole structure equal: %s" %
                      (Ca["case"], Cb["case"], Ca["Eset"] == Cb["Eset"], Ca["Fset"] == Cb["Fset"], Ca["Cset"] == Cb["Cset"], ss))
    print("  pairs with identical vertex sets: %d ; pairs with identical whole structures: %d" %
          (sum(r1_vertex.values()), sum(r1_struct.values())))

    print("\n### 7. pairs and explicit similarity certificates  [%s]" % elapsed())
    pairs = []
    certs = []
    for i in range(len(cases)):
        for j in range(i + 1, len(cases)):
            Ca, Cb = cases[i], cases[j]
            if Ca["fvec"] != Cb["fvec"]:
                continue
            a, b = Ca["case"], Cb["case"]
            lam = Cb["ww"] / Ca["ww"]
            row = dict(case_a=a, case_b=b, T_a=Ca["T"], T_b=Cb["T"], fvector=Ca["fvec"],
                       eq_raw_unoriented=same("class_raw_unoriented", a, b),
                       eq_raw_oriented=same("class_raw_oriented", a, b),
                       eq_scalefree_unoriented=same("class_scalefree_unoriented", a, b),
                       eq_scalefree_oriented=same("class_scalefree_oriented", a, b),
                       lambda_gap=gapstr(lam), lambda_float=flt(lam),
                       same_vertex_set=r1_vertex[(a, b)], same_structure=r1_struct[(a, b)],
                       det_sign_M="", M_verified="")
            # exhaustive, canonical-form-independent search for all similarities a -> b with w_a -> w_b
            found, ngram = exhaustive_similarities(Ca, Cb)
            signs_found = sorted({sg for (U, sg) in found})
            row["n_sim_fixing_w"] = len(found)
            row["sim_det_signs"] = "".join("+" if sg > 0 else "-" for sg in signs_found) or "none"
            row["n_gram_compatible"] = ngram
            print("\n--- pair %s | %s : exhaustive search: %d Gram-compatible neighbour triples, %d verified similarities with w_a -> w_b, det signs %s"
                  % (a, b, ngram, len(found), signs_found))
            check((len(found) > 0) == row["eq_scalefree_unoriented"],
                  "exhaustive search agrees with SCALEFREE-UNORIENTED canonical forms (similar: %s)" % row["eq_scalefree_unoriented"])
            check(any(sg > 0 for (U, sg) in found) == row["eq_scalefree_oriented"],
                  "exhaustive search agrees with SCALEFREE-ORIENTED canonical forms (proper-similar: %s)" % row["eq_scalefree_oriented"])
            check((len(found) > 0 and lam == 1) == row["eq_raw_unoriented"],
                  "exhaustive search agrees with RAW-UNORIENTED canonical forms (congruent: %s)" % row["eq_raw_unoriented"])
            check((any(sg > 0 for (U, sg) in found) and lam == 1) == row["eq_raw_oriented"],
                  "exhaustive search agrees with RAW-ORIENTED canonical forms (proper-congruent: %s)" % row["eq_raw_oriented"])
            if row["eq_scalefree_unoriented"]:
                print("\n--- pair %s ~ %s  (T %s / %s): similar. lambda = %s ~ %.10f" % (a, b, Ca["T"], Cb["T"], gapstr(lam), flt(lam)))
                res = build_certificate(Ca, Cb, "sf")
                row["det_sign_M"] = "%+d" % res["det_sign"]
                row["M_verified"] = res["all_ok"]
                print("  basis a (indices %s):" % (res["basis_a"],))
                for k in res["basis_a"]:
                    print("     %s" % gapvec(Ca["verts"][k]))
                print("  basis b (indices %s):" % (res["basis_b"],))
                for k in res["basis_b"]:
                    print("     %s" % gapvec(Cb["verts"][k]))
                print("  M = B_a^-1 * B_b  (GAP notation, row convention x -> x*M):")
                print("  M := %s;" % gapmat(res["Mrows"]))
                print("  M ~ %s" % [[round(flt(x), 6) for x in r] for r in res["Mrows"]])
                check(res["MMt_eq_lambdaI"], "M*M^T = lambda*I exactly, lambda = %s" % gapstr(lam))
                check(res["det_eq_sign_lambda2"], "det M = %+d * lambda^2 exactly (det M = %s)" % (res["det_sign"], gapstr(res["det"])))
                check(res["vertices"], "M carries the vertex set of a onto the vertex set of b")
                check(res["edges"], "M carries the edge set of a onto the edge set of b")
                check(res["faces"], "M carries the 2-face set of a onto the 2-face set of b")
                check(res["cells"], "M carries the cell set of a onto the cell set of b")
                # consistency with the oriented forms
                if row["eq_scalefree_oriented"]:
                    if res["det_sign"] > 0:
                        print("  [ok]   equal SCALEFREE-ORIENTED forms and det M > 0: proper similarity exhibited")
                    else:
                        check(res["alt"] is not None and res["alt"]["all_ok"] and res["alt"]["det_sign"] > 0,
                              "equal oriented forms but M improper: proper certificate M*h exhibited")
                        if res["alt"] is not None:
                            print("  M' := %s;" % gapmat(res["alt"]["Mrows"]))
                else:
                    check(res["det_sign"] < 0, "different SCALEFREE-ORIENTED forms => the exhibited similarity must be improper (det M < 0)")
                    print("  (unoriented forms equal, oriented forms differ: a and b are mirror images, no proper similarity exists)")
                if row["eq_raw_unoriented"]:
                    check(lam == 1, "RAW-equal pair has lambda = 1")
                else:
                    check(lam != 1, "RAW-inequal similar pair has lambda != 1 (lambda = %s)" % gapstr(lam))
                cert = dict(case_a=a, case_b=b, T_a=Ca["T"], T_b=Cb["T"], fvector=list(Ca["fvec"]),
                            norm_w2_a=gapstr(Ca["ww"]), norm_w2_b=gapstr(Cb["ww"]),
                            lambda_gap=gapstr(lam), lambda_float=flt(lam),
                            basis_a_indices=list(res["basis_a"]), basis_b_indices=list(res["basis_b"]),
                            basis_a=[gapvec(Ca["verts"][k]) for k in res["basis_a"]],
                            basis_b=[gapvec(Cb["verts"][k]) for k in res["basis_b"]],
                            M_gap=[[gapstr(x) for x in r] for r in res["Mrows"]],
                            M_gap_matrix=gapmat(res["Mrows"]),
                            M_float=[[flt(x) for x in r] for r in res["Mrows"]],
                            det_M_gap=gapstr(res["det"]), det_sign=res["det_sign"],
                            checks=dict(MMt_eq_lambdaI=res["MMt_eq_lambdaI"], det_eq_sign_lambda2=res["det_eq_sign_lambda2"],
                                        vertices_mapped=res["vertices"], edges_mapped=res["edges"],
                                        faces_mapped=res["faces"], cells_mapped=res["cells"], all_ok=res["all_ok"]),
                            relations=dict(raw_unoriented=row["eq_raw_unoriented"], raw_oriented=row["eq_raw_oriented"],
                                           scalefree_unoriented=True, scalefree_oriented=row["eq_scalefree_oriented"]),
                            same_vertex_set=row["same_vertex_set"], same_structure=row["same_structure"],
                            exhaustive_n_similarities_fixing_w=row["n_sim_fixing_w"], exhaustive_det_signs=row["sim_det_signs"])
                if res["alt"] is not None:
                    cert["M_proper_alternative"] = dict(M_gap_matrix=gapmat(res["alt"]["Mrows"]), det_sign=res["alt"]["det_sign"],
                                                        all_ok=res["alt"]["all_ok"])
                certs.append(cert)
            pairs.append(row)

    print("\n### 8. writing outputs  [%s]" % elapsed())
    os.makedirs(LOGDIR, exist_ok=True)
    p_classes = os.path.join(LOGDIR, "method2-classes.tsv")
    with open(p_classes, "w") as fh:
        cols = ["case", "T", "alpha", "alpha_float", "fvector", "norm_w2", "norm_w2_float", "gamma_order", "gen_dets",
                "class_raw_unoriented", "class_raw_oriented", "class_scalefree_unoriented", "class_scalefree_oriented",
                "cf_raw_unoriented_sha256", "cf_raw_oriented_sha256", "cf_scalefree_unoriented_sha256", "cf_scalefree_oriented_sha256",
                "min_basis_sf", "n_min_bases_sf", "oriented_sign_sf"]
        fh.write("\t".join(cols) + "\n")
        for C in cases:
            r = C["rec"]
            af = "inf" if r["alpha"] is None else "%.12f" % flt(r["alpha"])
            fh.write("\t".join(str(x) for x in [
                C["case"], C["T"], r["alpha_gap"], af, "(%d,%d,%d,%d)" % C["fvec"], gapstr(C["ww"]), "%.12f" % flt(C["ww"]),
                C["order"], "".join("+" if d > 0 else "-" for d in C["dets"]),
                classes["class_raw_unoriented"][C["case"]], classes["class_raw_oriented"][C["case"]],
                classes["class_scalefree_unoriented"][C["case"]], classes["class_scalefree_oriented"][C["case"]],
                C["cf"]["raw"]["sha_unoriented"], C["cf"]["raw"]["sha_oriented"],
                C["cf"]["sf"]["sha_unoriented"], C["cf"]["sf"]["sha_oriented"],
                "(%d,%d,%d,%d)" % C["cf"]["sf"]["minimisers"][0][0], len(C["cf"]["sf"]["minimisers"]),
                "%+d" % C["cf"]["sf"]["sign"]]) + "\n")
    p_pairs = os.path.join(LOGDIR, "method2-pairs.tsv")
    with open(p_pairs, "w") as fh:
        cols = ["case_a", "case_b", "T_a", "T_b", "fvector", "eq_raw_unoriented", "eq_raw_oriented",
                "eq_scalefree_unoriented", "eq_scalefree_oriented", "lambda", "lambda_float", "det_sign_M", "M_verified",
                "same_vertex_set", "same_structure", "n_sim_fixing_w", "sim_det_signs", "n_gram_compatible"]
        fh.write("\t".join(cols) + "\n")
        for row in pairs:
            yn = lambda v: "yes" if v else "no"
            fh.write("\t".join(str(x) for x in [
                row["case_a"], row["case_b"], row["T_a"], row["T_b"], "(%d,%d,%d,%d)" % row["fvector"],
                yn(row["eq_raw_unoriented"]), yn(row["eq_raw_oriented"]), yn(row["eq_scalefree_unoriented"]), yn(row["eq_scalefree_oriented"]),
                row["lambda_gap"], "%.12f" % row["lambda_float"], row["det_sign_M"] or "-",
                (yn(row["M_verified"]) if row["M_verified"] != "" else "-"),
                yn(row["same_vertex_set"]), yn(row["same_structure"]),
                row["n_sim_fixing_w"], row["sim_det_signs"], row["n_gram_compatible"]]) + "\n")
    p_json = os.path.join(LOGDIR, "method2-certificates.json")
    with open(p_json, "w") as fh:
        json.dump(dict(script=SCRIPTNAME, data=DATA, data_sha256=hashlib.sha256(open(DATA, "rb").read()).hexdigest(),
                       convention="row vectors, x -> x*M; E(40)^k = exp(2*pi*i*k/40); M = B_a^-1 * B_b maps realisation a onto b",
                       n_classes={name: len(set(classes[name].values())) for name in names},
                       classes=classes,
                       certificates=certs), fh, indent=1)
    # GAP-readable copy of the certificates (for independent re-verification, see method2-verify-certificates.g)
    p_gap = os.path.join(LOGDIR, "method2-certificates.g")
    with open(p_gap, "w") as fh:
        fh.write("# machine-generated by %s: similarity certificates a -> b, row convention x -> x*M, M = B_a^-1*B_b\n" % SCRIPTNAME)
        fh.write("# lambda = (w_b.w_b)/(w_a.w_a); M*TransposedMat(M) = lambda*IdentityMat(4); DeterminantMat(M) = det_sign*lambda^2\n")
        fh.write("M2CERTS := [];\n")
        for c in certs:
            fh.write('Add(M2CERTS, rec(case_a := "%s", case_b := "%s", lambda := %s, det_sign := %d, '
                     'proper_similar := %s, raw_congruent := %s, M := %s));\n' %
                     (c["case_a"], c["case_b"], c["lambda_gap"], c["det_sign"],
                      "true" if c["relations"]["scalefree_oriented"] else "false",
                      "true" if c["relations"]["raw_unoriented"] else "false", c["M_gap_matrix"]))
    print("  wrote %s" % p_classes)
    print("  wrote %s" % p_pairs)
    print("  wrote %s" % p_json)
    print("  wrote %s" % p_gap)

    print("\n### 9. summary  [%s]" % elapsed())
    for key, flav, name, desc in RELS:
        print("  %-28s: %d classes   (%s)" % (name, len(set(classes[name].values())), desc))
    part = {}
    for C in cases:
        part.setdefault(classes["class_scalefree_unoriented"][C["case"]], []).append(C["case"])
    print("  partition of the %d realisations under SIMILARITY (scale-free, unoriented):" % len(cases))
    for cid in sorted(part):
        members = part[cid]
        Ts = sorted({c["T"] for c in cases if c["case"] in members})
        fv = [c["fvec"] for c in cases if c["case"] == members[0]][0]
        print("     class %2d  f=(%d,%d,%d,%d)  T=%s : %s" % ((cid,) + fv + (",".join(Ts), ", ".join(members))))
    eqpairs = [row for row in pairs if row["eq_scalefree_unoriented"]]
    print("  similar pairs (a ~ b): %d" % len(eqpairs))
    for row in eqpairs:
        print("     %s ~ %s : lambda = %s (~%.6f), det sign M = %s, raw-congruent=%s, proper-similar=%s, verified=%s, "
              "#similarities with w_a->w_b = %d (signs %s)" %
              (row["case_a"], row["case_b"], row["lambda_gap"], row["lambda_float"], row["det_sign_M"],
               row["eq_raw_unoriented"], row["eq_scalefree_oriented"], row["M_verified"], row["n_sim_fixing_w"], row["sim_det_signs"]))
    nonsim = [row for row in pairs if not row["eq_scalefree_unoriented"]]
    print("  non-similar pairs with equal f-vector: %d ; exhaustive search found 0 similarities for all of them: %s" %
          (len(nonsim), all(row["n_sim_fixing_w"] == 0 for row in nonsim)))

    if FAILURES:
        print("\nSELF-CHECK FAILURES (%d):" % len(FAILURES))
        for f in FAILURES:
            print("  - " + f)
    else:
        print("\nAll self-checks passed.")
    print("Done: %s" % SCRIPTNAME)
    sys.exit(int(1) if FAILURES else int(0))

main()
