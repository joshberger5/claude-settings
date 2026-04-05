# CLAUDE.md

## Environment

- Use `python` (not `py`) in GitHub Actions YAML — Linux runner
- Requires `.env` (`ADZUNA_APP_ID`, `ADZUNA_APP_KEY`) in project root
- `resume.tex` and `jobs_debug.json` are committed to the repo and updated by CI on every run

## Commands

```bash
py main.py                                      # run the app
py -m pytest tests/ -v --ignore=tests/e2e/     # unit tests
py -m mypy .                                    # type-check
py -m pytest tests/e2e/ -v                     # E2E health checks (real HTTP, needs .env)
py -m mutmut run && py -m mutmut html           # mutation testing (local only, never CI)
```

**Run tests and mypy after every change.**

## Code Style

Explicit type annotations on every function parameter, return type, and local variable. No implicit `Any`, no bare `dict`/`list` without type args.

## Architecture

DDD layers for this project:

```
domain/         Core logic — no external deps
application/    Orchestration and services
infrastructure/ All I/O: fetchers, parsers, repository, email
main.py         Wiring only — no logic
```

See `DESIGN.md` for full design decisions.

### Adding a Fetcher

1. Create `infrastructure/job_fetchers/your_fetcher.py` — implement `fetch() -> list[Job]`, expose `company_name: str`
2. `job.remote = True` (confirmed remote) / `None` (unknown) / `False` (confirmed on-site)
3. Populate `job.required_skills` only when source provides structured tags
4. Register in `infrastructure/fetcher_registry.py`

### Key Non-Obvious Rules

- All salary parsing goes through `SalaryParser` (`infrastructure/salary_parser.py`) — never inline it in fetchers
- Fanatics posts on both Lever and Greenhouse; same job appears with different IDs — standard dedup won't catch it
- Oracle ICE endpoint: `jpmc.fa.oraclecloud.com` returns 401 in live runs; CSX and Florida Blue have had SSL errors
- `PhenomFetcher` exists but is not wired in (client-side rendering returns empty results)
- Detail-page fetches use `ThreadPoolExecutor(max_workers=10)`, 12s per request, 120s batch cap
- `feedback.json` is capped at 50 records; trimming logic lives in **two places**: `infrastructure/feedback_trimmer.py` (unit-tested, used by tests) and an inline Python step in `feedback.yml` (runs in CI) — keep them in sync if the schema changes
- `docs/feedback.html` contains literal `__THUMBS_UP_REASONS__` and `__THUMBS_DOWN_REASONS__` placeholders; `feedback.yml` replaces them with JSON arrays from `candidate_profile.yaml` on every vote commit — never hardcode reasons in the HTML
- Vote links put the PAT in the URL **fragment** (`#token`), not the query string — intentional, keeps it out of server/proxy logs; don't move it to `?token=`
- `FEEDBACK_PAT` must **never be committed to git** — `archive_email()` accepts `redact_tokens` to strip it before writing `docs/emails/*.html`; any new feature that writes a file containing the PAT must redact it the same way

## GitHub Actions

Runs 6 AM / 12 PM / 5 PM ET daily + `workflow_dispatch`. Force-commits `seen_jobs.json` after each run.

**DST — only one cron entry active at a time:**
- Current (EDT, Mar–Nov 2026): `0 10,16,21 * * *`
- Next adjustment Nov 1, 2026 (EST): `0 11,17,22 * * *`

Update the workflow comment whenever you touch the cron.

Required secrets: `ADZUNA_APP_ID`, `ADZUNA_APP_KEY`, `SMTP_HOST`, `SMTP_PORT`, `SMTP_USER`, `SMTP_PASS`, `EMAIL_TO`, `FEEDBACK_PAT`
Optional: `GEMINI_API_KEY`, `JSEARCH_API_KEY`

## Pull Requests

Before opening any PR, read `BUSINESS_RULES.md` and add a **Business Rules**
section to the PR body listing every rule that the change touches and confirming
it still holds (or explaining why it changed).

## .gitignore Entries Required

```
_context_checkpoint.md
jobs_debug.json
infrastructure/tertiary_cache.json
.mutmut-cache
html/
```
