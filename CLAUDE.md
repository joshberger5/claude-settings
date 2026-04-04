# Global Claude Rules

## Environment
- Shell is **bash** — use Unix-style syntax (`/dev/null`, forward slashes)
- Python alias: `py` only — `python` and `python3` are not aliased on this machine

## File Deletion
Only delete files that are **untracked by git**. Move them to the Windows Recycle Bin instead of permanently deleting. Tracked files should be removed normally via git.

## CLAUDE.md Size
Keep CLAUDE.md files under 100 lines. Going over requires something genuinely important — prefer concise rules.

## Architecture
Prefer DDD (Domain-Driven Design) — three layers: `domain/` (core logic, no external deps), `application/` (orchestration), `infrastructure/` (all I/O).

## Branching
Never commit to `main`. Use feature branches. Always `git pull origin main` before branching.

## Commits
Commit after every meaningful unit of work. Human-readable messages. No batching unrelated changes.

## Docs
Update `README.md` and `CLAUDE.md` in the same commit as any change that affects their content.

## Context
When context exceeds **55%**: write `_context_checkpoint.md` (branch, done, remaining, blockers), clear context, resume from checkpoint.

## Development Process
- TDD — write failing tests first, commit, then implement
- Always push branch immediately after committing (`git push -u origin <branch>`)
- Never force-add gitignored files
- **Tests must assert the full behavioral contract.** Every user-visible property needs a test: colors, element types, link structure, realistic negative inputs. Ask "if someone introduced this exact bug, would my tests catch it?" If no, the tests are incomplete. Shallow tests that only check a function ran are worse than no tests — they create false confidence.
- **Self-review all code before committing.** After writing any code, perform a thorough code review: run linter, type-checker, and full test suite; verify correctness of logic and edge cases; check for security issues (injection, leaks, unvalidated input); confirm adherence to project architecture and naming conventions; read `BUSINESS_RULES.md` (if present) and verify no rule is violated or left unaddressed. Do not commit until everything passes.

## Pull Requests
**Title:** Keep under 70 characters. Use a short imperative phrase in title case — capitalize every word except minor words (a, an, the, and, but, or, for, nor, so, yet, at, by, in, of, on, to, up, as). Always capitalize the first and last word regardless.

**Body format:**
```
# {Imperative verb phrase, title-case}

## Summary
- {What changed and why}
- {Key design decision or trade-off}

## Tests
- `{test_name}` — {what it verifies}
{N} unit tests passing, mypy clean.

## Files changed
| File | Change |
|---|---|
| `{path}` | {one-line description} |
```

**Rules:**
- Title is Markdown H1 (`# ...`), not a plain string
- No `🤖 Generated with Claude Code` footer
- Summary bullets explain *why*, not just *what*
- Optional context section (Usage, Behavior, etc.) goes between Summary and Tests, only when needed
- Plain, technical tone — no marketing language
