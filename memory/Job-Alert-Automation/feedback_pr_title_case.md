---
name: PR title case and format
description: PR titles use title case, no type prefix; PR body has no repeated # title header
type: feedback
---

PR titles must use title case — capitalize every word except: a, an, the, and, but, or, for, nor, so, yet, at, by, in, of, on, to, up, as. Always capitalize the first and last word regardless.

**No type prefix** — never prepend `Fix:`, `Docs:`, `Feat:`, `Chore:`, etc. to PR titles. Just the imperative phrase. The `# Title` rehash at the top of the PR body is fine.

**Exception:** `Auto:` prefix is allowed in `.github/workflows/improve_rules.yml` because those PRs are agent-generated without direct user supervision and need to be visually distinguishable.

**Why:** User explicitly corrected this — the type prefix is noise. The body title header is acceptable.

**How to apply:** Every time a PR is created or edited (`gh pr create`, `gh pr edit`).
