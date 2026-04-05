# Global Claude Code Guidelines

## Suggestions
If asked to do something and there is a meaningfully better approach, stop and ask before proceeding.

## Shell & Environment
Shell is **zsh**. Python: use `python3`.

## CLAUDE.md Size
Keep CLAUDE.md files under 100 lines. Going over requires something genuinely important — prefer concise rules.

## Architecture
Prefer DDD (Domain-Driven Design) — three layers: `domain/` (core logic, no external deps), `application/` (orchestration), `infrastructure/` (all I/O).

## Branching
Never commit to `main`. Use feature branches. Always `git pull origin main` before branching.

## Commits
Commit after every meaningful unit of work. One logical change per commit. Human-readable messages. No batching unrelated changes.

## Docs
Update `README.md` and `CLAUDE.md` in the same commit as any change that affects their content.

## Context
When context exceeds **55%**: write `_context_checkpoint.md` (branch, done, remaining, blockers), clear context, resume from checkpoint.

## Development Practices
- **TDD** — write failing tests first, commit, then implement. Never after.
- **Model-driven development** — define domain objects first, build logic around them.
- **Clean code** — no silent failures, validate external calls before writing code that depends on them.
- **Read library source before writing code that calls it** — never assume behavior; verify it.
- **Tests must assert the full behavioral contract.** Every user-visible property needs a test. Ask "if someone introduced this exact bug, would my tests catch it?" Shallow tests that only check a function ran are worse than no tests — they create false confidence.
- **Self-review all code before committing.** Run linter, type-checker, full test suite; verify correctness, edge cases, security issues; confirm architecture adherence.

## Pull Requests
**Title:** Under 70 characters. Short imperative phrase in title case — capitalize every word except minor words (a, an, the, and, but, or, for, nor, so, yet, at, by, in, of, on, to, up, as). Always capitalize first and last word.

**Body:**
```
# {Title}

## Summary
- {What changed and why}
- {Key design decision or trade-off}

## Tests
- `{test_name}` — {what it verifies}

## Files changed
| File | Change |
|---|---|
| `{path}` | {one-line description} |
```

No `🤖 Generated with Claude Code` footer. Technical tone, explain *why* not just *what*.

## Writing Style
No em dashes — restructure the sentence or use a period or comma instead.
