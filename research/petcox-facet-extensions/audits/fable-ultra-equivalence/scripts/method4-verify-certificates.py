#!/usr/bin/env python3
"""
method4-verify-certificates.py  --  METHOD 4 of the fable-ultra-equivalence audit.

From-scratch re-verification, in pure Python 3 (no Sage, no GAP, no sympy), of every
similarity certificate produced by Method 1 (logs/method1-certificates.json), plus an
independent reconstruction of the 24 stored realisations from the producer's data file
(alpha-survivors.g) and scale-free Gram invariants for the non-certified pairs.

Arithmetic: the cyclotomic field Q(zeta_40), zeta_40 = x, is implemented from scratch as
coefficient vectors of length 16 of fractions.Fraction, reduced modulo
    Phi_40(x) = x^16 - x^12 + x^8 - x^4 + 1 .
GAP's E(n)^k is mapped to x^(k*40/n) (n | 40).  Every decision in this script is made by
exact equality of such coefficient vectors; floating point is used only for display.
Canonical coefficient vectors are interned (assigned integer ids) so that equality is id
equality and add/mul can be memoised; this is a pure speed device.

Usage:  python3 method4-verify-certificates.py [DATA_FILE] [AUDIT_DIR]
Writes: AUDIT_DIR/logs/method4-results.tsv, AUDIT_DIR/logs/method4-invariants.tsv
Exit status 0 iff every self-check passed.  Last line printed: "Done: method4-verify-certificates.py".
"""
import sys, os, os, re, json, time, operator, itertools
from fractions import Fraction
from collections import Counter, deque

SCRIPT = 'method4-verify-certificates.py'
DATA_DEFAULT = ('/private/tmp/claude-501/-Users-daniel-github-skeletal-polytopes/'
                'd4b2e626-5fbc-48d1-9c01-c9dc4a79290e/scratchpad/producer/research/'
                'petcox-facet-extensions/logs/alpha-survivors.g')
AUDIT_DEFAULT = ('/Users/daniel/github/skeletal-polytopes/research/petcox-facet-extensions/'
                 'audits/fable-ultra-equivalence')

DATA = sys.argv[1] if len(sys.argv) > 1 else os.environ.get('PETCOX_DATA', DATA_DEFAULT)  # audit author's edit: honour PETCOX_DATA (run-all.sh)
AUDIT = sys.argv[2] if len(sys.argv) > 2 else AUDIT_DEFAULT
CERT_JSON = os.path.join(AUDIT, 'logs', 'method1-certificates.json')
REAL_JSON = os.path.join(AUDIT, 'logs', 'method1-realisations.json')
OUT_RESULTS = os.path.join(AUDIT, 'logs', 'method4-results.tsv')
OUT_INVARIANTS = os.path.join(AUDIT, 'logs', 'method4-invariants.tsv')

T0 = time.time()
FAILURES = []
NCHECK = 0


def check(cond, msg):
    """Record a self-check.  Failures are printed loudly and make the script exit 1."""
    global NCHECK
    NCHECK += 1
    if not cond:
        FAILURES.append(msg)
        print('!!!!!!!! FAIL: ' + msg)
        sys.stdout.flush()
    return bool(cond)


def log(msg=''):
    print(msg)
    sys.stdout.flush()


# ----------------------------------------------------------------------------------------
# 1.  The field Q(zeta_40)
# ----------------------------------------------------------------------------------------
DEG = 16
F0 = Fraction(0)
F1 = Fraction(1)
ELEMS = []      # id -> canonical tuple of 16 Fractions (coefficients of x^0..x^15)
INDEX = {}      # canonical tuple -> id
NZ = []         # id -> list of (exponent, coefficient) with nonzero coefficient


def intern(t):
    """Intern a canonical (reduced) coefficient tuple; return its id."""
    i = INDEX.get(t)
    if i is None:
        i = len(ELEMS)
        ELEMS.append(t)
        INDEX[t] = i
        NZ.append([(k, c) for k, c in enumerate(t) if c])
    return i


def reduce_poly(acc):
    """Reduce a coefficient list (any length >= 16) modulo Phi_40 = x^16 - x^12 + x^8 - x^4 + 1,
    i.e. x^k -> x^(k-4) - x^(k-8) + x^(k-12) - x^(k-16) for k >= 16, from the top down."""
    for k in range(len(acc) - 1, 15, -1):
        c = acc[k]
        if c:
            acc[k - 4] += c
            acc[k - 8] -= c
            acc[k - 12] += c
            acc[k - 16] -= c
    return tuple(acc[:16])


def from_poly(acc):
    acc = [Fraction(c) for c in acc]
    if len(acc) < 16:
        acc += [F0] * (16 - len(acc))
    return intern(reduce_poly(acc))


ZERO = from_poly([F0])
ONE = from_poly([F1])


def monomial(e):
    acc = [F0] * 40
    acc[e % 40] = F1
    return from_poly(acc)


def rational(q):
    return from_poly([Fraction(q)])


ADD_CACHE = {}
MUL_CACHE = {}
NEG_CACHE = {}


def add(i, j):
    if i == ZERO:
        return j
    if j == ZERO:
        return i
    key = (i, j) if i <= j else (j, i)
    r = ADD_CACHE.get(key)
    if r is None:
        r = intern(tuple(map(operator.add, ELEMS[i], ELEMS[j])))
        ADD_CACHE[key] = r
    return r


def neg(i):
    r = NEG_CACHE.get(i)
    if r is None:
        r = intern(tuple(-c for c in ELEMS[i]))
        NEG_CACHE[i] = r
        NEG_CACHE[r] = i
    return r


def sub(i, j):
    return add(i, neg(j))


def mul(i, j):
    if i == ZERO or j == ZERO:
        return ZERO
    if i == ONE:
        return j
    if j == ONE:
        return i
    key = (i, j) if i <= j else (j, i)
    r = MUL_CACHE.get(key)
    if r is None:
        acc = [F0] * 31
        for k, c in NZ[i]:
            for l, d in NZ[j]:
                acc[k + l] += c * d
        r = intern(reduce_poly(acc))
        MUL_CACHE[key] = r
    return r


def conj(i):
    """Complex conjugation x -> x^-1 = x^39, i.e. x^k -> x^(40-k)."""
    acc = [F0] * 40
    for k, c in NZ[i]:
        acc[(40 - k) % 40] += c
    return from_poly(acc)


def is_real(i):
    return conj(i) == i


def inv(i):
    """Multiplicative inverse by solving the 16x16 rational linear system of
    multiplication-by-a in the power basis (Gaussian elimination over Fraction)."""
    if i == ZERO:
        raise ZeroDivisionError
    cols = [ELEMS[mul(i, monomial(j))] for j in range(16)]     # a * x^j
    # augmented matrix A | e0 with A[r][j] = coefficient of x^r in a*x^j
    A = [[cols[j][r] for j in range(16)] + [F1 if r == 0 else F0] for r in range(16)]
    n = 16
    for col in range(n):
        piv = None
        for r in range(col, n):
            if A[r][col] != 0:
                piv = r
                break
        if piv is None:
            raise ZeroDivisionError('singular multiplication matrix')
        A[col], A[piv] = A[piv], A[col]
        pv = A[col][col]
        A[col] = [v / pv for v in A[col]]
        for r in range(n):
            if r != col and A[r][col] != 0:
                f = A[r][col]
                A[r] = [vr - f * vc for vr, vc in zip(A[r], A[col])]
    y = intern(tuple(A[r][16] for r in range(16)))
    if mul(i, y) != ONE:
        raise ArithmeticError('inverse self-check failed')
    return y


ZETA = complex(__import__('math').cos(2 * __import__('math').pi / 40),
               __import__('math').sin(2 * __import__('math').pi / 40))
ZPOW = [ZETA ** k for k in range(16)]


def to_complex(i):
    return sum(float(c) * ZPOW[k] for k, c in NZ[i])


def to_float_str(i, nd=6):
    z = to_complex(i)
    if abs(z.imag) < 1e-9:
        return ('%.' + str(nd) + 'f') % z.real
    return repr(z)


def to_gap_str(i):
    """Exact rendering in the power basis, as a GAP-readable expression in E(40)."""
    if i == ZERO:
        return '0'
    parts = []
    for k, c in NZ[i]:
        s = str(c)
        if k == 0:
            term = s
        else:
            mon = 'E(40)' if k == 1 else 'E(40)^%d' % k
            if c == 1:
                term = mon
            elif c == -1:
                term = '-' + mon
            else:
                term = s + '*' + mon
        parts.append(term)
    out = parts[0]
    for t in parts[1:]:
        out += t if t.startswith('-') else '+' + t
    return out


TERM_RE = re.compile(r'([+-]?)(?:(\d+(?:/\d+)?)(?:\*E\((\d+)\)(?:\^(\d+))?)?|E\((\d+)\)(?:\^(\d+))?)')


def parse_cyc(s):
    """Parse a GAP cyclotomic string such as "-1/2*E(5)-3/2*E(5)^2+E(8)^3-E(40)^7+2"."""
    s0 = s
    s = s.replace(' ', '')
    if s == '':
        raise ValueError('empty cyclotomic string')
    acc = [F0] * 40
    pos = 0
    while pos < len(s):
        m = TERM_RE.match(s, pos)
        if m is None or m.end() == pos:
            raise ValueError('cannot parse cyclotomic %r at position %d' % (s0, pos))
        sign, coef, n1, k1, n2, k2 = m.groups()
        c = Fraction(coef) if coef is not None else F1
        if sign == '-':
            c = -c
        n = n1 if n1 is not None else n2
        k = k1 if k1 is not None else k2
        if n is None:
            e = 0
        else:
            n = int(n)
            if n <= 0 or 40 % n != 0:
                raise ValueError('root of unity E(%d) not in Q(zeta_40) (%r)' % (n, s0))
            k = int(k) if k is not None else 1
            e = (k * (40 // n)) % 40
        acc[e] += c
        pos = m.end()
    return from_poly(acc)


def parse_vec(lst):
    return tuple(parse_cyc(s) for s in lst)


def parse_mat(lst):
    return tuple(parse_vec(row) for row in lst)


# -- vectors / matrices of ids --------------------------------------------------------------
def dot(u, v):
    r = ZERO
    for a, b in zip(u, v):
        r = add(r, mul(a, b))
    return r


def vec_mat(v, M):
    """Row vector times matrix: v*M."""
    n = len(M[0])
    out = []
    for j in range(n):
        s = ZERO
        for i in range(len(v)):
            s = add(s, mul(v[i], M[i][j]))
        out.append(s)
    return tuple(out)


def mat_mul(A, B):
    return tuple(vec_mat(row, B) for row in A)


def transpose(A):
    return tuple(tuple(A[i][j] for i in range(len(A))) for j in range(len(A[0])))


def identity(n):
    return tuple(tuple(ONE if i == j else ZERO for j in range(n)) for i in range(n))


def scalar_mat(lam, n):
    return tuple(tuple(lam if i == j else ZERO for j in range(n)) for i in range(n))


def det(M):
    """Determinant by cofactor (Laplace) expansion along the first row."""
    n = len(M)
    if n == 1:
        return M[0][0]
    if n == 2:
        return sub(mul(M[0][0], M[1][1]), mul(M[0][1], M[1][0]))
    total = ZERO
    for j in range(n):
        if M[0][j] == ZERO:
            continue
        minor = tuple(tuple(M[r][c] for c in range(n) if c != j) for r in range(1, n))
        term = mul(M[0][j], det(minor))
        total = add(total, term if j % 2 == 0 else neg(term))
    return total


def vec_add(u, v):
    return tuple(add(a, b) for a, b in zip(u, v))


def vec_scale(lam, u):
    return tuple(mul(lam, a) for a in u)


# ----------------------------------------------------------------------------------------
# 1b.  Field self-tests
# ----------------------------------------------------------------------------------------
def field_self_tests():
    log('== Field Q(zeta_40) self-tests ==')
    x = monomial(1)
    # x^40 = 1, x^20 = -1, Phi_40(x) = 0
    p = ONE
    powers = []
    for k in range(41):
        powers.append(p)
        p = mul(p, x)
    check(powers[40] == ONE, 'x^40 == 1')
    check(powers[20] == neg(ONE), 'x^20 == -1')
    check(len(set(powers[:40])) == 40, 'x has exact order 40')
    phi = add(sub(add(sub(powers[16], powers[12]), powers[8]), powers[4]), ONE)
    check(phi == ZERO, 'Phi_40(x) == 0')
    # E(5)+E(5)^4 = (sqrt5-1)/2 :  (2*(E(5)+E(5)^4)+1)^2 == 5
    e5 = parse_cyc('E(5)')
    check(e5 == powers[8], 'E(5) parses to x^8')
    t = parse_cyc('E(5)+E(5)^4')
    u = add(mul(rational(2), t), ONE)
    check(mul(u, u) == rational(5), '(2*(E(5)+E(5)^4)+1)^2 == 5')
    check(is_real(t), 'E(5)+E(5)^4 is real (conjugation-invariant)')
    check(is_real(rational(Fraction(-7, 3))), 'rational is real')
    # E(8)^2 == E(4) == x^10 and E(4)^2 == -1
    e8 = parse_cyc('E(8)')
    check(mul(e8, e8) == powers[10], 'E(8)^2 == x^10 == E(4)')
    check(mul(powers[10], powers[10]) == neg(ONE), 'E(4)^2 == -1')
    # sqrt(2) = E(8)+E(8)^-1 = E(8) - E(8)^3
    s2 = parse_cyc('E(8)-E(8)^3')
    check(mul(s2, s2) == rational(2), '(E(8)-E(8)^3)^2 == 2')
    check(is_real(s2), 'E(8)-E(8)^3 is real')
    # parsing
    a = parse_cyc('-1/2*E(5)-3/2*E(5)^2+E(8)^3-E(40)^7+2')
    b = add(add(add(add(mul(rational(Fraction(-1, 2)), powers[8]), mul(rational(Fraction(-3, 2)), powers[16])),
                    powers[15]), neg(powers[7])), rational(2))
    check(a == b, 'parse of "-1/2*E(5)-3/2*E(5)^2+E(8)^3-E(40)^7+2" agrees with hand-built element')
    check(parse_cyc('0') == ZERO and parse_cyc('1') == ONE and parse_cyc('-1') == neg(ONE), 'parse integers')
    check(parse_cyc('3/4') == rational(Fraction(3, 4)) and parse_cyc('-3/4') == rational(Fraction(-3, 4)), 'parse fractions')
    check(parse_cyc('E(40)^39') == powers[39] and parse_cyc('-E(40)') == neg(x), 'parse E(40)^39, -E(40)')
    check(parse_cyc('2*E(5)^3-E(5)^3') == powers[24], 'like terms combine')
    check(parse_cyc(to_gap_str(a)) == a, 'to_gap_str round trip')
    bad = False
    try:
        parse_cyc('E(7)')
    except ValueError:
        bad = True
    check(bad, 'E(7) is rejected (7 does not divide 40)')
    # conjugation
    check(conj(x) == powers[39], 'conj(x) == x^39')
    check(conj(conj(a)) == a, 'conj is an involution')
    check(conj(mul(a, b)) == mul(conj(a), conj(b)), 'conj is multiplicative')
    check(conj(add(a, e8)) == add(conj(a), conj(e8)), 'conj is additive')
    check(is_real(mul(a, conj(a))), 'a*conj(a) is real')
    # inverse
    ia = inv(a)
    check(mul(a, ia) == ONE, 'a * inv(a) == 1')
    check(inv(rational(Fraction(3, 4))) == rational(Fraction(4, 3)), 'inv(3/4) == 4/3')
    check(mul(t, inv(t)) == ONE, 'inverse of E(5)+E(5)^4')
    # determinant sanity
    M = ((rational(2), ONE, ZERO, ZERO), (ONE, rational(3), ZERO, ZERO), (ZERO, ZERO, ONE, x), (ZERO, ZERO, neg(x), ONE))
    check(det(M) == mul(rational(5), add(ONE, powers[2])), 'det of a test 4x4 matrix')
    # distributivity / associativity spot checks
    check(mul(a, add(b, e8)) == add(mul(a, b), mul(a, e8)), 'distributivity')
    check(mul(mul(a, b), e8) == mul(a, mul(b, e8)), 'associativity')
    log('field self-tests done (%d checks so far, %d failures)' % (NCHECK, len(FAILURES)))


# ----------------------------------------------------------------------------------------
# 2.  Parse the producer's GAP data file and reconstruct the 24 realisations
# ----------------------------------------------------------------------------------------
def split_top_level(s):
    parts, depth, cur = [], 0, []
    for ch in s:
        if ch == '[':
            depth += 1
        elif ch == ']':
            depth -= 1
        if ch == ',' and depth == 0:
            parts.append(''.join(cur).strip())
            cur = []
        else:
            cur.append(ch)
    tail = ''.join(cur).strip()
    if tail:
        parts.append(tail)
    return parts


def parse_gap_list(s):
    s = s.strip()
    if not (s.startswith('[') and s.endswith(']')):
        raise ValueError('not a GAP list: %r' % s[:60])
    inner = s[1:-1]
    return [parse_gap_list(p) if p.startswith('[') else p for p in split_top_level(inner)]


FIELD_RE = re.compile(r'(\w+) := ')
REC_RE = re.compile(r'^Add\(PX\.Saved, rec\((.*)\)\);\s*$')


def parse_gap_record(body):
    ms = list(FIELD_RE.finditer(body))
    rec = {}
    for idx, m in enumerate(ms):
        start = m.end()
        end = ms[idx + 1].start() if idx + 1 < len(ms) else len(body)
        val = body[start:end].rstrip()
        if val.endswith(','):
            val = val[:-1].rstrip()
        rec[m.group(1)] = val
    return rec


def read_data_file(path):
    recs = []
    with open(path) as fh:
        for line in fh:
            m = REC_RE.match(line.rstrip('\n'))
            if m is None:
                continue
            raw = parse_gap_record(m.group(1))
            rec = {
                'case': raw['case'].strip('"'),
                'T': raw['T'].strip('"'),
                'alpha_str': raw['alpha'],
                'S1': parse_mat(parse_gap_list(raw['S1'])),
                'S2': parse_mat(parse_gap_list(raw['S2'])),
                'X': parse_mat(parse_gap_list(raw['X'])),
                'w': parse_vec(parse_gap_list(raw['w'])),
                'S1_str': parse_gap_list(raw['S1']), 'S2_str': parse_gap_list(raw['S2']),
                'X_str': parse_gap_list(raw['X']), 'w_str': parse_gap_list(raw['w']),
            }
            recs.append(rec)
    return recs


EXPECTED_ORDER = {'{4,3,3}': 192, '{5,3,3}': 7200, '{3,3,5/2}': 7200}
EXPECTED_P = {'{4,3,3}': 8, '{5,3,3}': 30, '{3,3,5/2}': 30, '{5,3,5/2}': 12}


def expected_fvector(case, T):
    if T == '{4,3,3}':
        return (16, 32, 12, 4)
    if T in ('{5,3,3}', '{3,3,5/2}'):
        return (600, 1200, 120, 5)
    if T == '{5,3,5/2}':
        k = int(case.rsplit('-', 1)[1])
        if 1 <= k <= 4:
            return (240, 480, 120, 20)
        if 5 <= k <= 8:
            return (48, 144, 48, 8)
        if 9 <= k <= 16:
            return (120, 720, 300, 50)
    raise ValueError('no expected f-vector for ' + case)


def expected_group_order(case, T):
    if T == '{5,3,5/2}':
        k = int(case.rsplit('-', 1)[1])
        return 2880 if k <= 4 else (1152 if k <= 8 else 7200)
    return EXPECTED_ORDER[T]


def perm_inverse(p):
    q = [0] * len(p)
    for i, j in enumerate(p):
        q[j] = i
    return q


def orbit_of(base, gen_perms, image):
    """Orbit (as list + index dict) of `base` under the permutations `gen_perms`,
    `image(obj, perm)` applying a permutation to an object."""
    items = [base]
    idx = {base: 0}
    q = deque([base])
    while q:
        o = q.popleft()
        for g in gen_perms:
            o2 = image(o, g)
            if o2 not in idx:
                idx[o2] = len(items)
                items.append(o2)
                q.append(o2)
    return items, idx


def reconstruct(rec):
    """Rebuild the Wythoff polytope of a stored record from (S1,S2,X,w) alone."""
    case = rec['case']
    S1, S2, X, w = rec['S1'], rec['S2'], rec['X'], rec['w']
    gens = [S1, S2, X]
    names = ['S1', 'S2', 'X']
    R = {'case': case, 'T': rec['T'], 'S1': S1, 'S2': S2, 'X': X, 'w': w}
    # -- realness, orthogonality, det +1 of the generators
    I4 = identity(4)
    for nm, M in zip(names, gens):
        check(all(is_real(e) for row in M for e in row), '%s: %s has real entries' % (case, nm))
        check(mat_mul(M, transpose(M)) == I4, '%s: %s * %s^T == I' % (case, nm, nm))
        check(det(M) == ONE, '%s: det %s == +1' % (case, nm))
    check(all(is_real(e) for e in w), '%s: w has real entries' % case)
    ww = dot(w, w)
    R['ww'] = ww
    check(ww != ZERO, '%s: w != 0' % case)
    # -- order of S1
    P = S1
    p = 1
    while P != I4 and p <= 1000:
        P = mat_mul(P, S1)
        p += 1
    check(P == I4, '%s: S1 has finite order <= 1000' % case)
    R['p'] = p
    check(p == EXPECTED_P[rec['T']], '%s: p = Order(S1) = %d, expected %d' % (case, p, EXPECTED_P[rec['T']]))
    # -- vertex orbit (BFS, right action)
    V = [w]
    vidx = {w: 0}
    q = deque([0])
    while q:
        i = q.popleft()
        v = V[i]
        for M in gens:
            u = vec_mat(v, M)
            if u not in vidx:
                vidx[u] = len(V)
                V.append(u)
                q.append(vidx[u])
    n = len(V)
    R['V'], R['vidx'] = V, vidx
    pv = [[vidx[vec_mat(v, M)] for v in V] for M in gens]
    R['pv'] = pv
    for nm, pp in zip(names, pv):
        check(len(set(pp)) == n, '%s: %s permutes the vertex set' % (case, nm))
    check(all(dot(v, v) == ww for v in V), '%s: all vertices have norm |w|^2' % case)
    s = V[0]
    for v in V[1:]:
        s = vec_add(s, v)
    check(all(e == ZERO for e in s), '%s: vertex sum is 0' % case)
    # -- anchor spanning check (w, wS1, wS1^2, wS1^3 linearly independent)
    iw = 0
    anchor_idx = [iw]
    for k in range(3):
        anchor_idx.append(pv[0][anchor_idx[-1]])
    anchor = tuple(V[i] for i in anchor_idx)
    check(det(anchor) != ZERO, '%s: w, wS1, wS1^2, wS1^3 linearly independent (vertex set spans E^4)' % case)
    R['anchor_idx'] = anchor_idx
    # -- base edge e = {w, w S1^-1}
    pinv1 = perm_inverse(pv[0])
    S1inv = S1
    for _ in range(p - 2):
        S1inv = mat_mul(S1inv, S1)
    check(mat_mul(S1, S1inv) == I4, '%s: S1^(p-1) == S1^-1' % case)
    check(vidx[vec_mat(w, S1inv)] == pinv1[iw], '%s: w*S1^-1 via matrix == via permutation' % case)
    e0 = frozenset((iw, pinv1[iw]))
    check(len(e0) == 2, '%s: base edge has two distinct endpoints' % case)

    def img_set(o, g):
        return frozenset(g[i] for i in o)

    E, eidx = orbit_of(e0, pv, img_set)
    pe = [[eidx[img_set(e, g)] for e in E] for g in pv]
    # -- base face: the p-cycle w S1^k
    cyc = [iw]
    for k in range(p - 1):
        cyc.append(pv[0][cyc[-1]])
    check(pv[0][cyc[-1]] == iw, '%s: w S1^p == w' % case)
    check(len(set(cyc)) == p, '%s: the p vertices w S1^k (k<p) are distinct' % case)
    f0 = frozenset(eidx[frozenset((cyc[k], cyc[(k + 1) % p]))] for k in range(p))
    check(len(f0) == p, '%s: base face has p distinct edges' % case)
    F, fidx = orbit_of(f0, pe, img_set)
    pf = [[fidx[img_set(f, g)] for f in F] for g in pe]
    # -- base cell: orbit of f0 under <S1,S2>
    cell_faces, _ = orbit_of(fidx[f0], pf[:2], lambda o, g: g[o])
    c0 = frozenset(cell_faces)
    C, cidx = orbit_of(c0, pf, img_set)
    pc = [[cidx[img_set(c, g)] for c in C] for g in pf]
    R.update(E=E, eidx=eidx, pe=pe, F=F, fidx=fidx, pf=pf, C=C, cidx=cidx, pc=pc)
    R['base'] = (iw, eidx[e0], fidx[f0], cidx[c0])
    R['fS2'] = pf[1][fidx[f0]]
    fv = (n, len(E), len(F), len(C))
    R['fvector'] = fv
    efv = expected_fvector(case, rec['T'])
    check(fv == efv, '%s: f-vector %s == expected %s' % (case, fv, efv))
    # -- Schulte-Weiss conventions: S1 fixes f0 and c0; S2 fixes w and c0; X fixes w and e0
    check(pf[0][fidx[f0]] == fidx[f0] and pc[0][cidx[c0]] == cidx[c0], '%s: S1 fixes base face and base cell' % case)
    check(pv[1][iw] == iw and pc[1][cidx[c0]] == cidx[c0], '%s: S2 fixes base vertex and base cell' % case)
    check(pv[2][iw] == iw and pe[2][eidx[e0]] == eidx[e0], '%s: X fixes base vertex and base edge' % case)
    check(eidx[e0] in F[R['fS2']], '%s: base edge lies in f*S2 (so (w,e,fS2,c) is a flag)' % case)
    check(R['fS2'] != fidx[f0], '%s: f*S2 != f' % case)
    # -- incidence (diamond) checks
    faces_of_edge = Counter(e for f in F for e in f)
    check(all(faces_of_edge[e] >= 2 for e in range(len(E))) and len(faces_of_edge) == len(E),
          '%s: every edge lies in >= 2 faces' % case)
    cells_of_face = Counter(f for c in C for f in c)
    check(all(cells_of_face[f] == 2 for f in range(len(F))) and len(cells_of_face) == len(F),
          '%s: every face lies in exactly 2 cells' % case)
    ok = True
    for f in F:
        cnt = Counter(v for e in f for v in E[e])
        ok = ok and all(m == 2 for m in cnt.values())
    check(ok, '%s: every vertex of a face lies in exactly 2 of its edges (faces are cycles)' % case)
    ok = True
    for c in C:
        cnt = Counter(e for f in c for e in F[f])
        ok = ok and all(m == 2 for m in cnt.values())
    check(ok, '%s: every edge of a cell lies in exactly 2 of its faces' % case)
    R['cells_of_face'] = {}
    for ci, c in enumerate(C):
        for f in c:
            R['cells_of_face'].setdefault(f, []).append(ci)
    # -- group order by BFS over vertex permutations (faithful: vertices span E^4)
    ident = tuple(range(n))
    gperms = [tuple(g) for g in pv]
    G = {ident}
    q = deque([ident])
    while q:
        g = q.popleft()
        for s_ in gperms:
            h = tuple(s_[i] for i in g)
            if h not in G:
                G.add(h)
                q.append(h)
    R['G'] = G
    eo = expected_group_order(case, rec['T'])
    check(len(G) == eo, '%s: |Gamma| = %d, expected %d' % (case, len(G), eo))
    # -- flags and flag orbits
    flags = [(v, e, f, c) for c in range(len(C)) for f in C[c] for e in F[f] for v in E[e]]
    flagset = set(flags)
    check(len(flagset) == len(flags) == 2 * len(G), '%s: number of flags %d == 2|Gamma|' % (case, len(flags)))

    def flag_img(fl, k):
        return (pv[k][fl[0]], pe[k][fl[1]], pf[k][fl[2]], pc[k][fl[3]])

    even, _ = orbit_of(R['base'], [0, 1, 2], flag_img)
    even = set(even)
    rest = flagset - even
    odd = set()
    if rest:
        odd, _ = orbit_of(next(iter(rest)), [0, 1, 2], flag_img)
        odd = set(odd)
    check(len(even) == len(G), '%s: Gamma acts freely on flags (base flag orbit has size |Gamma|)' % case)
    check(odd == rest and len(odd) == len(G), '%s: exactly two flag orbits of size |Gamma|' % case)
    fl2 = (iw, eidx[e0], R['fS2'], cidx[c0])
    check(fl2 in odd, '%s: the 2-adjacent flag (w,e,fS2,c) is in the odd orbit' % case)
    R['even'], R['odd'] = even, odd
    return R


# ----------------------------------------------------------------------------------------
# 3.  Compare reconstruction with method1-realisations.json
# ----------------------------------------------------------------------------------------
def compare_with_method1(R, J):
    case = R['case']
    check(J['case'] == case, 'method1 realisation record for %s has matching case name' % case)
    check(parse_mat(J['S1']) == R['S1'] and parse_mat(J['S2']) == R['S2'] and parse_mat(J['X']) == R['X']
          and parse_vec(J['w']) == R['w'], '%s: method1 JSON S1,S2,X,w agree with data file' % case)
    check(tuple(J['fvector']) == R['fvector'], '%s: method1 f-vector agrees' % case)
    check(J['order'] == len(R['G']) and J['p'] == R['p'], '%s: method1 |Gamma| and p agree' % case)
    JV = [parse_vec(v) for v in J['vertices']]
    ok = len(JV) == len(R['V']) and len(set(JV)) == len(JV) and all(v in R['vidx'] for v in JV)
    check(ok, '%s: method1 vertex set == reconstructed vertex set (as exact vectors)' % case)
    if not ok:
        return
    m = [R['vidx'][v] for v in JV]          # method1 index -> my index
    JE = [frozenset(m[i] for i in e) for e in J['edges']]
    check(set(JE) == set(R['E']) and len(JE) == len(R['E']), '%s: method1 edge set == reconstructed edge set' % case)
    je = [R['eidx'].get(e) for e in JE]
    if any(x is None for x in je):
        return
    JF = [frozenset(je[i] for i in f) for f in J['faces']]
    check(set(JF) == set(R['F']) and len(JF) == len(R['F']), '%s: method1 face set == reconstructed face set' % case)
    jf = [R['fidx'].get(f) for f in JF]
    if any(x is None for x in jf):
        return
    JC = [frozenset(jf[i] for i in c) for c in J['cells']]
    check(set(JC) == set(R['C']) and len(JC) == len(R['C']), '%s: method1 cell set == reconstructed cell set' % case)
    bf = J['base_flag']
    jc = [R['cidx'].get(c) for c in JC]
    check((m[bf['vertex']], je[bf['edge']], jf[bf['face']], jc[bf['cell']]) == R['base'],
          '%s: method1 base flag == reconstructed base flag' % case)
    check(jf[bf['face_S2']] == R['fS2'], '%s: method1 face_S2 == reconstructed f*S2' % case)
    check([m[i] for i in J['anchor_vertices']] == R['anchor_idx'], '%s: method1 anchor vertices agree' % case)
    R['m1_vertex_map'] = m       # method1 index -> my index


# ----------------------------------------------------------------------------------------
# 4.  Verify certificates
# ----------------------------------------------------------------------------------------
def verify_certificate(cert, RA, RB, JB):
    a, b, cand = cert['case_a'], cert['case_b'], cert['candidate']
    tag = '%s -> %s [%s]' % (a, b, cand)
    res = {'case_a': a, 'case_b': b, 'candidate': cand, 'lambda_json': cert['lambda'],
           'det_json': cert['det'], 'det_sign_json': cert['det_sign']}
    M = parse_mat(cert['M'])
    lam = parse_cyc(cert['lambda'])
    detj = parse_cyc(cert['det'])
    res['lambda_exact'] = to_gap_str(lam)
    res['lambda_float'] = to_float_str(lam)
    # (a) lambda = |w_b|^2 / |w_a|^2   (checked as lambda*|w_a|^2 == |w_b|^2, no division)
    res['lambda_ok'] = check(mul(lam, RA['ww']) == RB['ww'], '%s: lambda == |w_b|^2/|w_a|^2' % tag)
    res['lambda_real'] = check(is_real(lam), '%s: lambda is real' % tag)
    res['isometry'] = (lam == ONE)
    # (b) M M^T = lambda I
    res['M_real'] = check(all(is_real(e) for row in M for e in row), '%s: M has real entries' % tag)
    res['MMt_ok'] = check(mat_mul(M, transpose(M)) == scalar_mat(lam, 4), '%s: M*M^T == lambda*I' % tag)
    # (c) det by cofactor expansion
    d = det(M)
    lam2 = mul(lam, lam)
    if d == lam2:
        sgn = 1
    elif d == neg(lam2):
        sgn = -1
    else:
        sgn = 0
    res['det_exact'] = to_gap_str(d)
    res['det_sign_computed'] = sgn
    res['det_ok'] = check(sgn != 0, '%s: det M == +-lambda^2' % tag)
    res['det_matches_json'] = check(d == detj and sgn == cert['det_sign'],
                                    '%s: det M and det_sign match the JSON values' % tag)
    # (d) vertex set onto vertex set; induced maps on edges, faces, cells
    VA, VB = RA['V'], RB['V']
    phi = []
    ok = len(VA) == len(VB)
    for v in VA:
        u = vec_mat(v, M)
        j = RB['vidx'].get(u)
        if j is None:
            ok = False
            phi.append(None)
        else:
            phi.append(j)
    ok = ok and len(set(phi)) == len(VA)
    res['vertices_onto'] = check(ok, '%s: v -> v*M maps the vertex set of a bijectively onto that of b' % tag)
    if not ok:
        res.update(edges_onto=False, faces_onto=False, cells_onto=False, w_maps_to_w=False,
                   image_flag_orbit_computed='n/a', flag_orbit_agrees=False, flag_image_kind='n/a',
                   flag_image_agrees=False, anchor_images_agree=False, M_in_Gamma_b='n/a')
        check(False, '%s: skipping structural checks after vertex failure' % tag)
        return res
    phiE = []
    ok = True
    for e in RA['E']:
        j = RB['eidx'].get(frozenset(phi[i] for i in e))
        if j is None:
            ok = False
            break
        phiE.append(j)
    ok = ok and len(set(phiE)) == len(RA['E']) == len(RB['E'])
    res['edges_onto'] = check(ok, '%s: induced map sends edge set onto edge set' % tag)
    phiF = []
    if ok:
        for f in RA['F']:
            j = RB['fidx'].get(frozenset(phiE[i] for i in f))
            if j is None:
                ok = False
                break
            phiF.append(j)
        ok = ok and len(set(phiF)) == len(RA['F']) == len(RB['F'])
    res['faces_onto'] = check(ok, '%s: induced map sends face set onto face set' % tag)
    phiC = []
    if ok:
        for c in RA['C']:
            j = RB['cidx'].get(frozenset(phiF[i] for i in c))
            if j is None:
                ok = False
                break
            phiC.append(j)
        ok = ok and len(set(phiC)) == len(RA['C']) == len(RB['C'])
    res['cells_onto'] = check(ok, '%s: induced map sends cell set onto cell set' % tag)
    # (e) base vertex w_a -> w_b (required for the odd/mirror certificates; reported for all)
    wmap = (vec_mat(RA['w'], M) == RB['w'])
    res['w_maps_to_w'] = wmap
    if cand == 'odd':
        check(wmap, '%s: odd certificate maps base vertex w_a to w_b' % tag)
    elif not wmap:
        log('NOTE %s: even certificate does not map w_a to w_b (not required)' % tag)
    if not ok:
        res.update(image_flag_orbit_computed='n/a', flag_orbit_agrees=False, flag_image_kind='n/a',
                   flag_image_agrees=False, anchor_images_agree=False, M_in_Gamma_b='n/a')
        return res
    # extra: image of a's base flag, its Gamma_b-orbit, and comparison with the JSON metadata
    ia, ea, fa, ca = RA['base']
    img = (phi[ia], phiE[ea], phiF[fa], phiC[ca])
    check(img in RB['even'] or img in RB['odd'], '%s: image of base flag is a flag of b' % tag)
    orb = 'even' if img in RB['even'] else ('odd' if img in RB['odd'] else 'none')
    res['image_flag_orbit_computed'] = orb
    res['image_flag_orbit_json'] = cert.get('image_flag_orbit', '?')
    res['flag_orbit_agrees'] = check(orb == cert.get('image_flag_orbit'),
                                     '%s: computed image flag orbit (%s) == JSON image_flag_orbit (%s)'
                                     % (tag, orb, cert.get('image_flag_orbit')))
    ib, eb, fb, cb = RB['base']
    fS2 = RB['fS2']
    other_c0 = [c for c in RB['cells_of_face'][fb] if c != cb]
    other_cS2 = [c for c in RB['cells_of_face'][fS2] if c != cb]
    kinds = {(ib, eb, fb, cb): 'base_flag', (ib, eb, fS2, cb): '2-adjacent(w,e,fS2,c)'}
    for c in other_c0:
        kinds[(ib, eb, fb, c)] = 'base_flag_other_cell'
    for c in other_cS2:
        kinds[(ib, eb, fS2, c)] = '2-adjacent_other_cell'
    kind = kinds.get(img, 'other')
    res['flag_image_kind'] = kind
    intended = 'base_flag' if cand == 'even' else '2-adjacent(w,e,fS2,c)'
    other = 'base_flag_other_cell' if cand == 'even' else '2-adjacent_other_cell'
    chk = cert.get('checks', {})
    agree = ((kind == intended) == bool(chk.get('flag_image'))) and ((kind == other) == bool(chk.get('flag_image_other_cell')))
    res['flag_image_agrees'] = check(agree, '%s: flag image kind (%s) consistent with JSON flag_image/flag_image_other_cell' % (tag, kind))
    # cross-check Method 1's image_tuple_0based against its own vertex ordering
    it = cert.get('image_tuple_0based')
    if it is not None and 'm1_vertex_map' in RB:
        m1 = RB['m1_vertex_map']
        res['anchor_images_agree'] = check(len(it) == 4 and all(phi[RA['anchor_idx'][k]] == m1[it[k]] for k in range(4)),
                                           '%s: images of anchor vertices agree with JSON image_tuple_0based' % tag)
    else:
        res['anchor_images_agree'] = 'n/a'
    # for a == b: is the similarity an element of Gamma?  (Gamma acts faithfully on vertices)
    if a == b:
        inG = tuple(phi) in RB['G']
        res['M_in_Gamma_b'] = inG
        check(inG == (orb == 'even'), '%s: (M in Gamma) <=> (image flag in even orbit)' % tag)
    else:
        res['M_in_Gamma_b'] = 'n/a'
    res['all_ok'] = all(res[k] for k in ('lambda_ok', 'MMt_ok', 'det_ok', 'det_matches_json', 'vertices_onto',
                                          'edges_onto', 'faces_onto', 'cells_onto')) and (wmap or cand != 'odd')
    return res


# ----------------------------------------------------------------------------------------
# 5.  Scale-free Gram invariants
# ----------------------------------------------------------------------------------------
def invariants(R):
    V = R['V']
    n = len(V)
    iww = inv(R['ww'])
    cache = {}

    def ndot(i, j):
        key = (i, j) if i <= j else (j, i)
        r = cache.get(key)
        if r is None:
            r = mul(dot(V[i], V[j]), iww)
            cache[key] = r
        return r

    inv_v = Counter()
    for i in range(n):
        Vi = V[i]
        for j in range(i + 1, n):
            inv_v[mul(dot(Vi, V[j]), iww)] += 1
    check(all(is_real(x) for x in inv_v), '%s: all normalised inner products are real' % R['case'])
    inv_e = Counter()
    for e in R['E']:
        i, j = sorted(e)
        inv_e[ndot(i, j)] += 1

    def shape(vertex_set):
        vs = sorted(vertex_set)
        return tuple(sorted(ndot(i, j) for i, j in itertools.combinations(vs, 2)))

    inv_f = Counter(shape({v for e in f for v in R['E'][e]}) for f in R['F'])
    inv_c = Counter(shape({v for f in c for e in R['F'][f] for v in R['E'][e]}) for c in R['C'])
    if len(ADD_CACHE) > 3000000:
        ADD_CACHE.clear()
    return {'vertices': inv_v, 'edges': inv_e, 'faces': inv_f, 'cells': inv_c}


def fmt_bool(x):
    return 'True' if x is True else ('False' if x is False else str(x))


# ----------------------------------------------------------------------------------------
# main
# ----------------------------------------------------------------------------------------
def main():
    log('METHOD 4: pure-Python exact re-verification of Method 1 certificates')
    log('python %s' % sys.version.replace('\n', ' '))
    log('DATA  = %s' % DATA)
    log('AUDIT = %s' % AUDIT)
    field_self_tests()

    # ---- step 2: reconstruction
    log('\n== Step 2: independent reconstruction of the 24 realisations from %s ==' % os.path.basename(DATA))
    recs = read_data_file(DATA)
    check(len(recs) == 24, 'data file has 24 records (found %d)' % len(recs))
    cases = [r['case'] for r in recs]
    check(len(set(cases)) == 24, 'case names are distinct')
    by_row = {}
    for r in recs:
        by_row.setdefault(r['T'], []).append(r)
    for T, rs in by_row.items():
        check(all(r['S1'] == rs[0]['S1'] and r['S2'] == rs[0]['S2'] for r in rs),
              'row %s: all %d records share S1 and S2' % (T, len(rs)))
        check(len(set(r['X'] for r in rs)) == len(rs), 'row %s: the X matrices are pairwise distinct' % T)
        check(len(set(r['w'] for r in rs)) == len(rs), 'row %s: the w vectors are pairwise distinct' % T)
    with open(REAL_JSON) as fh:
        M1R = json.load(fh)
    m1_by_case = {j['case']: j for j in M1R}
    check(set(m1_by_case) == set(cases), 'method1-realisations.json covers exactly the 24 cases')
    REAL = {}
    for r in recs:
        t = time.time()
        R = reconstruct(r)
        REAL[r['case']] = R
        log('  %-18s T=%-9s p=%2d  f-vector=%-22s |Gamma|=%5d  |w|^2=%s (%s)  flags=%d  [%.1fs]'
            % (r['case'], r['T'], R['p'], str(R['fvector']), len(R['G']), to_gap_str(R['ww']),
               to_float_str(R['ww']), 2 * len(R['G']), time.time() - t))
        if r['case'] in m1_by_case:
            compare_with_method1(R, m1_by_case[r['case']])
    log('reconstruction done: %d checks so far, %d failures  [%.0fs]' % (NCHECK, len(FAILURES), time.time() - T0))
    log('field elements interned so far: %d' % len(ELEMS))

    # ---- step 3: certificates
    log('\n== Step 3: verification of every certificate in %s ==' % os.path.basename(CERT_JSON))
    with open(CERT_JSON) as fh:
        CERTS = json.load(fh)
    check(isinstance(CERTS, list) and len(CERTS) > 0, 'certificates JSON is a non-empty list (%d entries)' % len(CERTS))
    results = []
    for cert in CERTS:
        a, b = cert['case_a'], cert['case_b']
        check(a in REAL and b in REAL, 'certificate refers to known cases %s, %s' % (a, b))
        if a not in REAL or b not in REAL:
            continue
        res = verify_certificate(cert, REAL[a], REAL[b], m1_by_case.get(b))
        res['represents_own_coset_json'] = cert.get('represents_own_coset')
        res['triple_orientation_json'] = cert.get('triple_orientation')
        results.append(res)
        log('  %-18s -> %-18s %-4s lambda=%-10s det_sign=%+d %s  V/E/F/C onto=%s/%s/%s/%s  w->w=%s  flag-orbit=%s(%s) %s'
            % (a, b, cert['candidate'], res['lambda_float'], res['det_sign_computed'],
               'isometry ' if res['isometry'] else 'similarity',
               fmt_bool(res['vertices_onto']), fmt_bool(res.get('edges_onto')), fmt_bool(res.get('faces_onto')),
               fmt_bool(res.get('cells_onto')), fmt_bool(res['w_maps_to_w']),
               res.get('image_flag_orbit_computed'), res.get('flag_image_kind'),
               'OK' if res.get('all_ok') else 'FAILED'))
    nver = sum(1 for r in results if r.get('all_ok'))
    nfail = len(results) - nver
    log('certificates: %d verified, %d failed  [%.0fs]' % (nver, nfail, time.time() - T0))

    # ---- step 4: invariants
    log('\n== Step 4: scale-free Gram invariants ==')
    INV = {}
    for case in cases:
        t = time.time()
        INV[case] = invariants(REAL[case])
        iv = INV[case]
        log('  %-18s distinct normalised inner products: vertex pairs %3d (of %d), edges %d, face shapes %d, cell shapes %d  [%.1fs]'
            % (case, len(iv['vertices']), sum(iv['vertices'].values()), len(iv['edges']), len(iv['faces']),
               len(iv['cells']), time.time() - t))
    certified = {(r['case_a'], r['case_b']) for r in results if r.get('all_ok') and r['case_a'] != r['case_b']}
    # consistency: certified pairs must have identical invariants
    for (a, b) in sorted(certified):
        check(all(INV[a][k] == INV[b][k] for k in ('vertices', 'edges', 'faces', 'cells')),
              'certified pair %s ~ %s has identical invariants' % (a, b))
    inv_rows = []
    n_dist = n_same = 0
    for a in cases:
        for b in cases:
            if a == b or REAL[a]['fvector'] != REAL[b]['fvector'] or (a, b) in certified:
                continue
            eq = {k: INV[a][k] == INV[b][k] for k in ('vertices', 'edges', 'faces', 'cells')}
            differing = [k for k in ('vertices', 'edges', 'faces', 'cells') if not eq[k]]
            if differing:
                n_dist += 1
                verdict = 'DIFFERENT invariants (%s): certificate of non-similarity' % ','.join(differing)
            else:
                n_same += 1
                verdict = 'invariants COINCIDE: only Method 1 exhaustive search certifies non-equivalence'
            inv_rows.append((a, b, REAL[a]['fvector'], eq, verdict))
            log('  %-18s vs %-18s f=%-22s vertices=%s edges=%s faces=%s cells=%s  %s'
                % (a, b, str(REAL[a]['fvector']), eq['vertices'], eq['edges'], eq['faces'], eq['cells'], verdict))
    check(len(inv_rows) == 80, 'there are 80 non-certified ordered pairs with equal f-vector (found %d)' % len(inv_rows))

    # ---- step 5: output files
    cols = ['case_a', 'case_b', 'candidate', 'lambda_json', 'lambda_exact_powerbasis', 'lambda_float', 'isometry',
            'lambda_ok', 'lambda_real', 'M_real', 'MMt_ok', 'det_json', 'det_exact_powerbasis', 'det_sign_json',
            'det_sign_computed', 'det_ok', 'det_matches_json', 'vertices_onto', 'edges_onto', 'faces_onto',
            'cells_onto', 'w_maps_to_w', 'image_flag_orbit_json', 'image_flag_orbit_computed', 'flag_orbit_agrees',
            'flag_image_kind', 'flag_image_agrees', 'anchor_images_agree', 'M_in_Gamma_b',
            'represents_own_coset_json', 'triple_orientation_json', 'all_ok']
    keymap = {'lambda_exact_powerbasis': 'lambda_exact', 'det_exact_powerbasis': 'det_exact'}
    with open(OUT_RESULTS, 'w') as fh:
        fh.write('\t'.join(cols) + '\n')
        for r in results:
            fh.write('\t'.join(fmt_bool(r.get(keymap.get(c, c), '')) for c in cols) + '\n')
    with open(OUT_INVARIANTS, 'w') as fh:
        fh.write('\t'.join(['case_a', 'case_b', 'fvector', 'inv_vertex_pairs_equal', 'inv_edges_equal',
                            'inv_face_shapes_equal', 'inv_cell_shapes_equal', 'verdict']) + '\n')
        for a, b, fv, eq, verdict in inv_rows:
            fh.write('\t'.join([a, b, str(fv), fmt_bool(eq['vertices']), fmt_bool(eq['edges']),
                                fmt_bool(eq['faces']), fmt_bool(eq['cells']), verdict]) + '\n')
    log('\nwrote %s' % OUT_RESULTS)
    log('wrote %s' % OUT_INVARIANTS)

    # ---- summary
    log('\n== SUMMARY ==')
    log('certificates verified: %d' % nver)
    log('certificates failed:   %d' % nfail)
    log('verified certificates (case_a, case_b, candidate, lambda, det_sign, isometry?):')
    for r in results:
        if r.get('all_ok'):
            log('  (%s, %s, %s, lambda=%s [%s], det_sign=%+d, %s)'
                % (r['case_a'], r['case_b'], r['candidate'], r['lambda_json'], r['lambda_float'],
                   r['det_sign_computed'], 'isometry' if r['isometry'] else 'similarity-only'))
    n_iso = sum(1 for r in results if r.get('all_ok') and r['isometry'])
    n_iso_distinct = sum(1 for r in results if r.get('all_ok') and r['isometry'] and r['case_a'] != r['case_b'])
    log('isometries (lambda = 1) among verified certificates: %d (of which with a != b: %d)' % (n_iso, n_iso_distinct))
    log('det signs among verified certificates: %s' % dict(Counter(r['det_sign_computed'] for r in results if r.get('all_ok'))))
    log('distinct certified unordered pairs a != b: %d' % (len(certified) // 2 if len(certified) % 2 == 0 else -1))
    log('image flag orbits (a != b): %s' % dict(Counter((r['candidate'], r['image_flag_orbit_computed'])
                                                         for r in results if r['case_a'] != r['case_b'])))
    log('image flag orbits (a == b): %s' % dict(Counter((r['candidate'], r['image_flag_orbit_computed'])
                                                         for r in results if r['case_a'] == r['case_b'])))
    log('non-certified equal-f-vector ordered pairs: %d; distinguished by invariants: %d; invariants coincide: %d'
        % (len(inv_rows), n_dist, n_same))
    log('total self-checks: %d, failed: %d, elapsed %.0fs' % (NCHECK, len(FAILURES), time.time() - T0))
    if FAILURES:
        log('FAILED CHECKS:')
        for f in FAILURES:
            log('  ' + f)
    log('Done: ' + SCRIPT)
    sys.exit(1 if FAILURES else 0)


if __name__ == '__main__':
    main()
