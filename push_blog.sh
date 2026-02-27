#!/usr/bin/env bash
set -euo pipefail

# Change these if needed
REPO_DIR="${REPO_DIR:-$HOME/blog}"
REMOTE="${REMOTE:-origin}"
BRANCH="${BRANCH:-main}"

cd "$REPO_DIR"

# Safety: ensure we're inside a git repo
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || {
  echo "Error: $REPO_DIR is not a git repository."
  exit 1
}

# Stage everything (respects .gitignore)
git add Morteza-Mahdavi-Blog/content/en/posts Morteza-Mahdavi-Blog/hugo.toml

# Commit only if there is something staged
if git diff --cached --quiet; then
  echo "Nothing to commit."
else
  MSG="New blog post added $(date '+%Y-%m-%d %H:%M')"
  git commit -m "$MSG"
fi

# Sync and push
git pull --rebase "$REMOTE" "$BRANCH"
git push "$REMOTE" "$BRANCH"
