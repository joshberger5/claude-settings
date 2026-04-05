---
name: Never push CLAUDE.md
description: CLAUDE.md is gitignored and must never be committed or pushed to the remote
type: feedback
---

Never commit or push CLAUDE.md to the remote repository. It is listed in .gitignore intentionally.

**Why:** User explicitly flagged this — CLAUDE.md is a local-only file and should stay that way.

**How to apply:** Do not use `git add -f CLAUDE.md` or otherwise force-stage it. If it accidentally gets staged, run `git rm --cached CLAUDE.md` before committing.
