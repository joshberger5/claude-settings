---
name: Always push branch after committing
description: Always run git push -u origin <branch> after committing on a feature branch
type: feedback
---

Always run `git push -u origin <branch>` immediately after committing on a feature branch — do not wait for the user to ask.

**Why:** User was repeatedly having to come back and ask for the branch to be pushed before they could open a PR.

**How to apply:** Any time a commit is made on a non-main branch, push it to remote in the same step.
