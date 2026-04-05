---
name: Never force-add gitignored files
description: Do not use git add -f to commit files listed in .gitignore — user has .planning/ gitignored intentionally
type: feedback
---

Never use `git add -f` to bypass `.gitignore`. If a file is gitignored, it is intentional — do not commit it regardless of what GSD tools or workflows suggest.

**Why:** User has `.planning/` in `.gitignore` deliberately. Force-adding it caused planning docs to be committed to main, which the user had to manually clean up.

**How to apply:** When running GSD workflows or any git operations, if a file is gitignored, skip the commit step for that file. Do not use `--force`, `-f`, or any other bypass. If a workflow requires committing gitignored files, skip that step silently or flag it to the user first.
