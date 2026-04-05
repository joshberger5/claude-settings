---
name: PR description template
description: Template and rules for writing GitHub PR descriptions in this repo, derived from PRs #1–#6
type: reference
---

## Format

```markdown
# {Verb phrase — imperative, title-case, describes the change}

## Summary

- {What changed and why — include motivation, not just what}
- {Key design decision or trade-off worth calling out}
- {Any notable constraints or behaviours (fail-open, non-mutating, etc.)}

## {Optional context section — e.g. "Usage", "Behavior", "What a failure means"}

{Free-form content — use tables, code blocks, or bullet lists as appropriate.
Include this section only when the PR introduces a new workflow or non-obvious runtime behaviour.}

## Tests

- `{test_name}` — {one-line description of what it verifies}
- `{test_name}` — {one-line description}

{N} unit tests passing, mypy clean ({M} source files).

## Files changed

| File | Change |
|---|---|
| `{path}` | {one-line description of the change} |
| `{path}` | {one-line description of the change} |
```

## Rules

- **Title is Markdown H1** (`# ...`), not a plain string — it renders as the PR heading on GitHub.
- **No `🤖 Generated with Claude Code` footer** — existing PRs don't have it; omit it.
- **Summary bullets explain *why*, not just *what*** — motivate each change briefly.
- **Tests section lists individual test names** with a short description of what each verifies, followed by the total count and mypy status.
- **Files changed table** is always last. One row per file; keep descriptions short (< 10 words).
- **Optional sections** (Usage, Behavior, etc.) go between Summary and Tests, only when genuinely needed to explain non-obvious runtime behaviour.
- **Tone**: plain, technical, no marketing language.
