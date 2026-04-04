#!/usr/bin/env bash
# Run from repo root: bash sync.sh
# Copies current Claude config files into this repo for review/commit.
#
# On Mac: update CLAUDE_DIR to /Users/<your-mac-username>/.claude
# Run `whoami` to find your Mac username if unsure.
#
# On Windows (Git Bash): CLAUDE_DIR="/c/Users/Josh Berger/.claude"

set -e

CLAUDE_DIR="/c/Users/Josh Berger/.claude"
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

cp "$CLAUDE_DIR/CLAUDE.md"              "$REPO_DIR/CLAUDE.md"
cp "$CLAUDE_DIR/settings.json"          "$REPO_DIR/settings.json"
cp "$CLAUDE_DIR/package.json"           "$REPO_DIR/package.json"
cp "$CLAUDE_DIR/statusline-command.sh"  "$REPO_DIR/statusline-command.sh"
cp "$CLAUDE_DIR/hooks/gsd-check-update.js"    "$REPO_DIR/hooks/"
cp "$CLAUDE_DIR/hooks/gsd-context-monitor.js" "$REPO_DIR/hooks/"
cp "$CLAUDE_DIR/hooks/gsd-statusline.js"      "$REPO_DIR/hooks/"
cp "$CLAUDE_DIR/plugins/blocklist.json"          "$REPO_DIR/plugins/"
cp "$CLAUDE_DIR/plugins/known_marketplaces.json" "$REPO_DIR/plugins/"

# Project-specific CLAUDE.md files — add new projects here as needed
cp "$HOME/Documents/GitHub/Job-Alert-Automation/CLAUDE.md" \
   "$REPO_DIR/projects/Job-Alert-Automation/CLAUDE.md" 2>/dev/null || true

# Memory files — synced per-project
PROJECTS_DIR="$CLAUDE_DIR/projects"

# Windows project memory dirs (update path prefix on Mac)
JA_MEM="$PROJECTS_DIR/C--Users-Josh-Berger-Documents-GitHub-Job-Alert-Automation/memory"
GH_MEM="$PROJECTS_DIR/C--Users-Josh-Berger-Documents-GitHub-joshberger5-github-io/memory"
GLOBAL_MEM="$PROJECTS_DIR/C--Users-Josh-Berger/memory"

[ -d "$JA_MEM" ]     && cp -r "$JA_MEM/." "$REPO_DIR/memory/Job-Alert-Automation/"
[ -d "$GH_MEM" ]     && cp -r "$GH_MEM/." "$REPO_DIR/memory/joshberger5-github-io/"
[ -d "$GLOBAL_MEM" ] && cp -r "$GLOBAL_MEM/." "$REPO_DIR/memory/global/" 2>/dev/null || true

echo "Done. Review changes with: git diff"
echo "Then commit: git add -A && git commit -m 'chore: update Claude config snapshot'"
