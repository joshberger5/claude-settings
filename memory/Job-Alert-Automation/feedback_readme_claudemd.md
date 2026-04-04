---
name: Update README and CLAUDE.md on every change
description: After every code change, update README.md and CLAUDE.md (if they exist) in the same commit
type: feedback
---

After every change — not just feature additions — update `README.md` and `CLAUDE.md` if they exist.

**Why:** User explicitly requested this broader scope. CLAUDE.md already had a narrower rule (only for config/fetcher/workflow changes), but the user wants it applied universally.

**How to apply:** Any time a file is modified and committed, check whether `README.md` or `CLAUDE.md` need updating to reflect the change. If so, include those updates in the **same commit** — not a follow-up commit. Do not treat README updates as a separate step at the end of a session. The rule has been violated multiple times by committing code first and updating README later; this must not happen.

**Concrete check before every commit:** After staging code changes, ask "does README.md accurately describe what I just changed?" If no, update it before running `git commit`.

**This rule has been violated repeatedly.** README updates must be in the same commit as the change -- not a follow-up. No exceptions.
