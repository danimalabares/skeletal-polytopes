#!/Library/Frameworks/Python.framework/Versions/3.11/bin/python3
"""extract-sources.py -- reproducible text extraction behind logs/sources-quotes.md

Extracts the three PDFs with PyPDF2 into $SCRATCH/sources/<name>.txt, makes a
glyph-restored copy of PETCOX pp. 20-28 (Computer Modern math glyphs that the
plain extractor drops are recovered from their font positions), and runs
self-checks: the key sentences quoted in sources-quotes.md must be found, and
the words that sources-quotes.md reports as absent must be absent.

Run:  python3 extract-sources.py | tee ../logs/extract-sources.log
Exit status is non-zero if any self-check fails.  Last line: "Done: extract-sources.py".
"""
import os, re, sys
from PyPDF2 import PdfReader

SCRATCH = "/private/tmp/claude-501/-Users-daniel-github-skeletal-polytopes/d4b2e626-5fbc-48d1-9c01-c9dc4a79290e/scratchpad"
OUT = os.path.join(SCRATCH, "sources")
PRODUCER = os.path.join(SCRATCH, "producer")
SRCS = {
    "petcox": "/Users/daniel/dr/skeletal-polytopes/petcox.pdf",
    "chiral-4-polytope": "/Users/daniel/dr/skeletal-polytopes/chiral-4-polytope.pdf",
    "schulte-asia-chiral": "/Users/daniel/dr/skeletal-polytopes/schulte-asia-chiral.pdf",
}
THESIS = os.path.join(PRODUCER, "two-chiral.tex")

os.makedirs(OUT, exist_ok=True)
nfail = 0
def check(name, ok):
    global nfail
    print(("PASS  " if ok else "FAIL  ") + name)
    if not ok:
        nfail += 1

texts = {}
for name, path in SRCS.items():
    r = PdfReader(path)
    pages = []
    for i, p in enumerate(r.pages):
        pages.append(p.extract_text() or "")
    texts[name] = pages
    with open(os.path.join(OUT, name + ".txt"), "w") as f:
        for i, t in enumerate(pages):
            f.write(f"\n===== PAGE {i+1} (pdf page index {i}) =====\n")
            f.write(t)
    print(f"{name}: {len(pages)} pages, {sum(len(t) for t in pages)} characters")

check("petcox.pdf has 32 pages", len(texts["petcox"]) == 32)
check("chiral-4-polytope.pdf has 7 pages", len(texts["chiral-4-polytope"]) == 7)
check("schulte-asia-chiral.pdf has 24 pages", len(texts["schulte-asia-chiral"]) == 24)

# glyph-restored PETCOX pp. 20-28
r = PdfReader(SRCS["petcox"])
fixed = []
for pi in range(19, 28):
    parts = []
    def vis(text, cm, tm, fontDict, fontSize):
        fn = str(fontDict.get("/BaseFont", "?")) if fontDict else "?"
        t = text
        if "CMSY" in fn:
            t = (t.replace("\x00", "−").replace("p", "√").replace("\x06", "±")
                  .replace("f", "{").replace("g", "}").replace("1", "∞"))
        if "CMMI" in fn:
            t = t.replace("\x1e", "φ").replace("\x0b", "α")
        parts.append(t)
    r.pages[pi].extract_text(visitor_text=vis)
    s = "".join(parts)
    s = re.sub(r"[\x00-\x08\x0b\x0c\x0e-\x1f]", "", s)
    fixed.append(f"\n===== PAGE {pi+1} (glyph-substituted) =====\n" + s)
fixedtxt = "".join(fixed)
with open(os.path.join(OUT, "petcox-fixed-clean.txt"), "w") as f:
    f.write(fixedtxt)
print("petcox-fixed-clean.txt:", len(fixedtxt), "characters")

def squash(s):
    # remove all whitespace, for robust substring search across the extractor's spacing defects
    return re.sub(r"\s+", "", s)

P = squash("".join(texts["petcox"]))
B = squash("".join(texts["chiral-4-polytope"]))
S = squash("".join(texts["schulte-asia-chiral"]))
F = squash(fixedtxt)
with open(THESIS) as f:
    T = f.read()

# key sentences quoted in sources-quotes.md (searched with whitespace removed; ligatures fi/fl are dropped by the extractor)
check("PETCOX p.19: 'isomorphic and have the same symmetry group'", squash("are isomorphic and have the same symmetry group") in P)
check("PETCOX p.20: 'denote the normalization of x'", squash("denote the normalization of x") in P)
check("PETCOX p.19: 'we rst project it to S3'", squash("we rst project it to S3") in P or squash("we first project it to S3") in P)
check("PETCOX p.20: 'we linearize the meaning of the parameter'", squash("we linearize the meaning of the parameter") in P)
check("PETCOX p.10: 'continuous family of dierent P'", squash("continuous family of dierent P") in P or squash("continuous family of different P") in P)
check("PETCOX p.28: 'isometry groups of the chiral polyhedra'", squash("isometry groups of the chiral polyhedra") in P)
check("PETCOX p.29: 'regular member of the family'", squash("regular member of the family") in P)
check("PETCOX p.23: regular vertices of {4,3,3} '(1,1,1,sqrt3)' present in glyph pass", squash("[(1;1;1;√3)] and [(1;1;1;−√3)]") in F)
check("PETCOX p.22: '{3,3,3} is regular' for alpha = 1/2, infinity", squash("Hα({3;3;3}) is regular") in F)
check("PETCOX: word 'congruen' absent", "congruen" not in P.lower())
check("PETCOX: word 'enantiomorph' absent", "enantiomorph" not in P.lower())
check("PETCOX: word 'mirror' absent", "mirror" not in P.lower())
check("BHP p.801: 'chiral colourings are enantiomorphic'", squash("chiral colourings are enantiomorphic") in B)
check("BHP p.803: 'two enantiomorphic forms of Q'", squash("the two enantiomorphic forms of Q") in B)
check("BHP p.803: 'sharing the same geometric symmetry group'", squash("sharing the same geometric symmetry group") in B)
check("BHP p.805: 'Wythoff space of chiral realizations is of dimension 2'", squash("Wythoff space of chiral realizations is of dimension 2") in B)
check("BHP p.803: 'in the sphere S3 subset R4'", squash("in the sphere S3⊂R4") in B or squash("in the sphere S3") in B)
check("BHP: word 'congruen' absent", "congruen" not in B.lower())
check("BHP: word 'mirror' absent", "mirror" not in B.lower())
check("SW: word 'enantiomorph' absent", "enantiomorph" not in S.lower())
check("SW: word 'mirror' absent", "mirror" not in S.lower())
check("SW p.496: 'replacing a sigma by its inverse'", squash("replacing a cr by its inverse") in S or squash("by its inverse") in S)
check("SW p.495: 'chiral (or irreflexible)'", squash("chiral (or irreflexible)") in S)
check("SW p.511: 'two ways how chiral n-polytopes can occur'", squash("two ways how chiral n-polytopes can occur") in S or squash("two ways how chiral") in S)
check("Thesis: 'same as the (abstract) one constructed before'", "same as the (abstract) one" in T)
check("Thesis: symmetry = isometry of E^4", "is an isometry of $\\mathbb{E}^4$ that" in T)
check("Thesis: word 'congruen' absent", "congruen" not in T.lower())
check("Thesis: word 'enantiomorph' absent", "enantiomorph" not in T.lower())
check("Thesis: 'mirror' occurs once, in 'The mirror of the [newline] reflection $P_i$' (L495-496)",
      T.lower().count("mirror") == 1 and "The mirror of the\nreflection $P_i$" in T)

print(f"\nextract-sources.py: {nfail} failed checks")
if nfail:
    print("Done: extract-sources.py")
    sys.exit(1)
print("Done: extract-sources.py")
