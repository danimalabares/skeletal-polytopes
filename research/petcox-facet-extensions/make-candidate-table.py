#!/usr/bin/env python3
"""Assemble candidate-table.tsv from the machine-generated rows.

Inputs (all written by the GAP scripts in gap/):
  logs/canonical-rows.tsv       one row per canonical extension (20 endpoint records)
  logs/parent-rows.tsv          one row per candidate third generator that passed the
                                relations, the fixed-line condition and the
                                intersection condition in a parent-group search
  logs/alpha-complete-rows.tsv  one row per base vertex of the complete Level 3
                                analysis (all isometries of E^4)
  logs/compare.log              deduplication (abstract classes, congruence classes)

Output: candidate-table.tsv, one row per tested case with its final
classification, from the vocabulary
  PROVED-CONSTRUCTION, KNOWN-CONSTRUCTION, PROVED-OBSTRUCTION-CANONICAL,
  PROVED-OBSTRUCTION-IN-PARENT, DUPLICATE, COMPUTATIONAL-EVIDENCE-ONLY,
  UNRESOLVED.
"""
import csv, os, re, sys
from collections import Counter, OrderedDict

here = os.path.dirname(os.path.abspath(__file__))
logs = os.path.join(here, "logs")

def read_tsv(name):
    """Read a GAP-written TSV, undoing GAP's backslash line wrapping."""
    path = os.path.join(logs, name)
    if not os.path.exists(path):
        return None, []
    text = open(path).read()
    text = text.replace("\\\n", "")          # GAP wraps long lines with a backslash
    rows = [ln.split("\t") for ln in text.splitlines() if ln.strip()]
    return rows[0], rows[1:]

can_hdr, can_rows = read_tsv("canonical-rows.tsv")
par_hdr, par_rows = read_tsv("parent-rows.tsv")
l3_hdr, l3_rows = read_tsv("alpha-complete-rows.tsv")

# --- deduplication information from compare.log ------------------------------
compare_path = os.path.join(logs, "compare.log")
compare = open(compare_path).read().replace("\\\n", "") if os.path.exists(compare_path) else ""
rel = {}
for m in re.finditer(r"^(\S+) vs (\S+): abstractly isomorphic \(same orientation (\w+), mirror (\w+)\), dual (\w+); geometry: (.*)$",
                     compare, re.M):
    a, b, same, mirror, dual, geom = m.groups()
    rel.setdefault(a, []).append(dict(other=b, same=same == "true", mirror=mirror == "true",
                                      dual=dual == "true", geom=geom.strip()))
classes = {}
for m in re.finditer(r"^class (\d+): \[ (.*?) \]", compare, re.M):
    k, members = m.groups()
    for mem in re.findall(r'"([^"]+)"', members):
        classes[mem] = int(k)

known = {
    "C-{4,3,3}": "KNOWN: Roli's cube, Bracho-Hubard-Pellicer 2014",
    "C-{5,3,5/2}": "KNOWN: thesis polytope {12/(1,5),3,5/2}",
    "C-{5/2,3,5}": "KNOWN: thesis polytope {12/(1,5),3,5}",
}
# the same three, as they appear in the Level 3 and parent-search listings
known_alias = {
    ("{4,3,3}", "0"): "Roli's cube",
    ("{5,3,5/2}", "0"): "thesis {12/(1,5),3,5/2}",
    ("{5,3,5/2}", "1"): "thesis {12/(1,5),3,5} (the dual endpoint H_1({5,3,5/2}) = H_0({5/2,3,5}))",
    ("{5/2,3,5}", "0"): "thesis {12/(1,5),3,5}",
    ("{3,3,4}", "1"): "Roli's cube (dual endpoint)",
}

out = []
hdr = ["case_id", "level", "T", "parent", "alpha", "facet", "S3_or_X", "orders", "relations",
       "intersection_condition", "ip_defect", "fvector", "directly_regular", "faithful",
       "skeletal_polytope", "geometrically_chiral", "combinatorially_chiral", "abstract_class",
       "same_polytope_as", "classification", "note"]

def dedup_note(cid, cls, note):
    """Turn PROVED-CONSTRUCTION into DUPLICATE when compare.log says the
    realisation is identical to, or the mirror image of, an earlier one."""
    same = ""
    if cls != "PROVED-CONSTRUCTION":
        return cls, same, note
    rels = rel.get(cid, [])
    ident = [x for x in rels if x["geom"].startswith("IDENTICAL")]
    mirror = [x for x in rels if x["geom"].startswith("MIRROR IMAGE")]
    iso = [x for x in rels if x["same"] or x["mirror"]]
    if ident:
        x = ident[0]
        return "DUPLICATE", x["other"], "identical geometric polytope to " + x["other"] + "; " + note
    if mirror:
        x = mirror[0]
        return "DUPLICATE", x["other"], "mirror image (enantiomorph) of " + x["other"] + "; " + note
    if iso:
        x = iso[0]
        same = x["other"] + " (abstractly)"
        note = ("abstractly isomorphic to " + x["other"] + ", geometrically: " + x["geom"] + "; " + note)
    return cls, same, note

for r in can_rows or []:
    d = dict(zip(can_hdr, r))
    cid = "C-" + d["T"]
    cls, same, note = d["classification"], "", d["note"]
    if cid in known:
        cls, note = "KNOWN-CONSTRUCTION", known[cid]
    out.append([d["case_id"], "1 canonical", d["T"], "W(T)", d["alpha"], d["facet"], d["S3"], d["orders"],
                d["string_relations"], d["intersection_condition"], d["ip_defect"], d["fvector"],
                d["directly_regular"], d["faithful"], d["skeletal_polytope"], d["geometrically_chiral"],
                d["combinatorially_chiral"], str(classes.get(cid, "")), same, cls, note])

for r in par_rows or []:
    d = dict(zip(par_hdr, r))
    cid = d["case_id"]
    cls, same, note = dedup_note(cid, d["classification"], d["note"])
    out.append([cid, "2 parent search", d["T"], d["parent"], d["alpha"], d["facet"], d["X_description"],
                d["orders"], d["string_relations"], d["intersection_condition"], d["ip_defect"], d["fvector"],
                d["directly_regular"], d["faithful"], d["skeletal_polytope"], d["geometrically_chiral"],
                d["combinatorially_chiral"], str(classes.get(cid, "")), same, cls, note])

for r in l3_rows or []:
    d = dict(zip(l3_hdr, r))
    cid = d["case_id"]
    cls, same, note = dedup_note(cid, d["classification"], d["note"])
    key = (d["T"], d["alpha"])
    if cls in ("PROVED-CONSTRUCTION",) and key in known_alias:
        cls, note = "KNOWN-CONSTRUCTION", known_alias[key] + "; " + note
    comb = "-" if d["directly_regular"] in ("-", "") else ("false" if d["directly_regular"] == "true" else "true")
    out.append([cid, "3 all isometries", d["T"], "O(4)", d["alpha"], "H_alpha(" + d["T"] + ")",
                "X_alpha (unique, Prop. E1)", d["X_order"], d["relations"], d["intersection_condition"],
                d["ip_defect"], d["fvector"], d["directly_regular"], d["faithful"], d["skeletal_polytope"],
                d["geometrically_chiral"], comb, str(classes.get(cid, "")), same, cls, note])

with open(os.path.join(here, "candidate-table.tsv"), "w", newline="") as f:
    w = csv.writer(f, delimiter="\t", lineterminator="\n")
    w.writerow(hdr)
    w.writerows(out)

print(f"candidate-table.tsv: {len(out)} rows")
cnt = Counter(row[-2] for row in out)
for k in sorted(cnt):
    print(f"  {k}: {cnt[k]}")
lv = Counter(row[1] for row in out)
print("  by level: " + ", ".join(f"{k}: {v}" for k, v in sorted(lv.items())))
