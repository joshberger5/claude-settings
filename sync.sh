#!/usr/bin/env bash
# Copies current Claude config files into this repo and commits.
# Run from repo root: bash sync.sh

set -e

CLAUDE_DIR="$HOME/.claude"
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

cp "$CLAUDE_DIR/CLAUDE.md"    "$REPO_DIR/CLAUDE.md"
cp "$CLAUDE_DIR/settings.json" "$REPO_DIR/settings.json"
cp "$CLAUDE_DIR/package.json"  "$REPO_DIR/package.json"
cp "$CLAUDE_DIR/hooks/gsd-statusline.js"      "$REPO_DIR/hooks/"
cp "$CLAUDE_DIR/hooks/gsd-context-monitor.js" "$REPO_DIR/hooks/"

# Memory — synced per-project (add new projects here as needed)
LI_MEM="$CLAUDE_DIR/projects/-Users-joshuaberger-Documents-linkedin-downloaded-data-enricher/memory"
[ -d "$LI_MEM" ] && cp -r "$LI_MEM/." "$REPO_DIR/memory/linkedin-enricher/"

# Auto-commit if there are changes
cd "$REPO_DIR"
if ! git diff --quiet || ! git diff --cached --quiet; then
  git add -A
  git commit -m "chore: update Claude config snapshot"
  git push
  echo "Committed and pushed."
else
  echo "No changes to commit."
fi
