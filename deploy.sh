#!/usr/bin/env bash
set -euo pipefail

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PUBLIC_DIR="$ROOT_DIR/public"

if [ ! -d "$PUBLIC_DIR/.git" ]; then
  echo "Error: public/ is expected to be a Git repository." >&2
  exit 1
fi

cd "$ROOT_DIR"

hugo -t coder

cd "$PUBLIC_DIR"
git add .

msg="rebuilding site $(date)"
if [ $# -gt 0 ]; then
  msg="$*"
fi

if git diff --cached --quiet; then
  echo "No generated changes to publish."
  exit 0
fi

git commit -m "$msg"
git push origin master
