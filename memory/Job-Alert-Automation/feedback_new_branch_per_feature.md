---
name: Always create a new branch for each feature
description: Never commit new work onto an existing/stale branch — always branch fresh from main
type: feedback
---

Every new feature or fix must start on a fresh branch from main. Never commit onto whatever branch happens to be checked out.

**Why:** Once a PR is merged, its branch is stale. Committing a new unrelated feature onto it pollutes the branch history, creates a PR that covers multiple unrelated changes, and requires painful cleanup (closing the PR, cherry-picking, deleting the branch).

**How to apply:** Before starting any new work — no matter what branch is currently checked out — always run:
```
git checkout main && git pull origin main && git checkout -b <new-branch>
```
This is required even if the task was handed off from a plan that was created while on a different branch.
