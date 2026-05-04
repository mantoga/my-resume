#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PUBLIC_DIR="$ROOT_DIR/public"
SITE_URL="https://mantoga.github.io"
msg="rebuilding site $(date)"

if ! git -C "$PUBLIC_DIR" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Error: public/ is expected to be a Git repository." >&2
  exit 1
fi

if [ $# -gt 0 ]; then
  msg="$*"
fi

echo -e "\033[0;32mBuilding production site...\033[0m"
cd "$ROOT_DIR"
hugo --gc --minify

if grep -R "localhost:1313" "$PUBLIC_DIR" >/dev/null 2>&1; then
  echo "Error: generated site still contains localhost:1313 references." >&2
  exit 1
fi

if ! grep -q "$SITE_URL/css/" "$PUBLIC_DIR/index.html"; then
  echo "Error: homepage does not reference production CSS under $SITE_URL/css/." >&2
  exit 1
fi

echo -e "\033[0;32mPublishing public/ to GitHub Pages...\033[0m"
cd "$PUBLIC_DIR"
git add .

if git diff --cached --quiet; then
  echo "No generated changes to publish."
  exit 0
fi

git commit -m "$msg"
git push origin master

echo -e "\033[0;32mPublished $SITE_URL\033[0m"
