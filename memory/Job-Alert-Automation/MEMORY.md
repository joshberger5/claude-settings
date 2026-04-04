# Project Memory

## Hard Rules
- **Never use Anthropic Python SDK / Claude API** — use `claude` CLI or `anthropics/claude-code-action` instead; project must stay free; see `feedback_no_claude_api.md`

## Secrets / Security
- **Never commit FEEDBACK_PAT** — redact it before writing any file to disk; see `feedback_redact_pat_in_committed_files.md`

## Git Rules
- **Never force-add gitignored files** — `.planning/` is gitignored intentionally; see `feedback_gitignore.md`
- **Never commit or push CLAUDE.md** — gitignored intentionally, local-only; see `feedback_dont_push_claudemd.md`
- **Never commit DESIGN.md** — local-only design document, untracked intentionally; see `feedback_dont_commit_design_md.md`
- **Always sync main before branching** — `git checkout main && git pull origin main` before any `git checkout -b`; see `feedback_branch_from_main.md`
- **One branch per feature, always fresh** — never commit new work onto an existing/stale branch regardless of what's checked out; see `feedback_new_branch_per_feature.md`
- **Always push branch after committing** — run `git push -u origin <branch>` immediately after every commit on a feature branch; see `feedback_push_branch.md`

## Development Process
- **TDD — always write tests first**: write failing tests, commit, then implement; see `feedback_tdd.md`
- **Tests must assert the full behavioral contract**: every user-visible property must have a test — color, element type, structure, realistic inputs. "Code runs without error" is not a test; see `feedback_test_quality.md`
- **Update README + CLAUDE.md on every change**: after any code change, update both files if they exist (same commit); see `feedback_readme_claudemd.md`

## Code Style — Non-Negotiable
- **Always use explicit type annotations**: every function parameter, return type, and local variable must be explicitly typed. No implicit `Any`, no bare `dict`/`list` without type args, no unannotated variables. This is a hard requirement — do not skip it.

## Environment
- Python alias: **`py`** only — `python` and `python3` do not exist on this machine

## Project Overview
- Job Alert Automation using DDD (Domain-Driven Design)
- Entry point: `main.py` (`py main.py`)
- Requires `resume.pdf` in project root (gitignored)

## Architecture
- `domain/` — core business logic, no external deps
- `application/` — orchestration services
- `infrastructure/` — concrete implementations (fetchers, parsers, in-memory repos)

## Testing
- Framework: `pytest` + `mypy` (both in `requirements.txt`)
- Run: `py -m pytest tests/ -v`
- 80 tests across 11 test files, all passing
- Domain layer fully covered: test_scoring_policy, test_filtering_policy, test_experience_requirement, test_keyword_title_filter
- HTTP mocked with `unittest.mock.patch("requests.get", ...)` — no network calls in tests
- `conftest.py` at project root (empty) ensures rootdir is recognized and imports work
- `ExperienceRequirement`: context-window tokens NOT stripped of punctuation, so "experience." at end-of-sentence won't match. Use "X years experience required." in tests, not "Requires X years experience."

## PR Descriptions
- Follow the repo template derived from PRs #1–#6; see `reference_pr_template.md`
- **Title case on PR titles, no type prefix** — capitalize all words except minor ones; never prepend `Fix:` / `Docs:` / `Feat:` / `Chore:` etc.; `# Title` in the body is fine; see `feedback_pr_title_case.md`

## Writing Style
- **No em dashes** — restructure the sentence or use a period/comma instead; see `feedback_no_em_dashes.md`

## Screenshots
- **Never use Playwright to screenshot email HTML** — output looks nothing like real email; user must open in Edge + snipping tool; see `feedback_no_playwright_screenshots.md`

## Key Files
- `domain/candidate_profile.py` — `CandidateProfile` frozen dataclass; fields: `preferred_locations`, `remote_allowed`, `ideal_max_experience_years`, `core_skills`, `secondary_skills`, `tertiary_skills`, `open_to_contract`, `minimum_salary` (default 0), `feedback_thumbs_down_reasons` (default []), `feedback_thumbs_up_reasons` (default [])
- `domain/scoring_policy.py` — `ScoringPolicy.MINIMUM_SCORE = 7`; `evaluate()` returns `tuple[int, dict[str, int]]`; uses word-boundary regex for skill matching
- `application/job_record.py` — `JobRecord` TypedDict (total=False); all `list[dict]` replaced with `list[JobRecord]` throughout
- `application/job_processing_service.py` — `process()` returns `list[JobRecord]`
- `application/title_filter_service.py` — `TitleFilterService` orchestrates keyword + optional LLM filter pipeline
- `infrastructure/job_fetchers/_utils.py` — `infer_remote(location)` shared utility used by all fetchers
- `infrastructure/job_fetchers/workday_fetcher.py` — has `fetch_descriptions: bool` param; fetches ld+json from job pages
- `infrastructure/job_fetchers/phenom_fetcher.py` — page-1 diagnostic prints present (temporary, remove once key confirmed)
