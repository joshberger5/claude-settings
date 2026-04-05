---
name: Never use the Anthropic Python SDK or Claude API directly
description: This project must stay free — always use Claude Code CLI or claude-code-action, never the anthropic Python package
type: feedback
---

Never use `import anthropic`, the Anthropic Python SDK, or direct HTTP calls to generativelanguage/anthropic APIs in this project.

**Why:** The user wants the entire project to be free. Claude Code CLI and `anthropics/claude-code-action` are covered by their existing subscription. The Python SDK incurs per-token API charges.

**How to apply:** Any automation that needs AI reasoning must use:
- `anthropics/claude-code-action@beta` in GitHub Actions workflows
- `claude` CLI run non-interactively (e.g., `claude --print "..."`)

Never suggest adding `anthropic` to requirements.txt or calling the REST API directly. This rule has been stated many times — do not forget it.
