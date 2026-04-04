---
name: Do not commit DESIGN.md
description: DESIGN.md is a local-only file — never commit or push it
type: feedback
---

Never commit DESIGN.md to git. It is a local design document, not a tracked project file.

**Why:** User explicitly did not ask for it to be committed. It is untracked intentionally.

**How to apply:** If DESIGN.md needs to be updated as part of a task, update it locally but do not stage or commit it. Only commit files the user has asked to change or that are clearly part of the feature (code, tests, README, CLAUDE.md, candidate_profile.yaml, etc.).
