---
name: Small incremental commits
description: User wants one logical change per commit, not batched changes
type: feedback
---

Make small, incremental commits as work progresses — one logical change per commit. Do not batch unrelated changes together.

**Why:** User explicitly requested this style for the LinkedIn enricher project.

**How to apply:** After each discrete step (new file, refactor, feature addition), commit before moving to the next step.
