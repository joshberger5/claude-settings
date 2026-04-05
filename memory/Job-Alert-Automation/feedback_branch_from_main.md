---
name: Always sync main before branching
description: Pull origin/main and ensure local main is up to date before creating any new branch
type: feedback
---

Before creating a new branch, always run:

```bash
git checkout main && git pull origin main
```

**Why:** Avoids branching off a stale local main, which causes unnecessary merge conflicts and drift from the canonical state.

**How to apply:** Any time a new feature/fix branch is being created — do this first, before `git checkout -b`.
