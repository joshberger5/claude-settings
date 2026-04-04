---
name: Redact FEEDBACK_PAT before committing files
description: Any file written to disk that may contain the FEEDBACK_PAT must redact it before being committed to git
type: feedback
---

Never write the `FEEDBACK_PAT` value into any file that ends up committed to git.

**Why:** Vote links embed the PAT in the URL fragment. When `archive_email()` saved the full email HTML to `docs/emails/`, GitHub push protection detected the token and blocked the push entirely (PR #20 incident).

**How to apply:** Use `archive_email(html, run_at, redact_tokens=[pat])` — this replaces the token with `[REDACTED]` before writing. Any future feature that persists HTML or other text containing the PAT must apply the same redaction before saving to disk.
