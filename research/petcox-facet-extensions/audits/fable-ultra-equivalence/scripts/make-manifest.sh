#!/usr/bin/env bash
# make-manifest.sh -- SHA-256 manifest of every file in this audit directory
# (except the manifest itself), written to MANIFEST.sha256 in the audit root.
# Usage: scripts/make-manifest.sh    (from anywhere)
set -euo pipefail
AUDIT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$AUDIT"
out=MANIFEST.sha256
tmp="$(mktemp)"
find . -type f ! -name "$out" ! -path './build/*' -print0 | LC_ALL=C sort -z | \
  while IFS= read -r -d '' f; do shasum -a 256 "$f"; done > "$tmp"
mv "$tmp" "$out"
echo "wrote $AUDIT/$out ($(wc -l < "$out" | tr -d ' ') files)"
