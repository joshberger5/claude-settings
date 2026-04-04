# GSD (Get Shit Done) Setup Guide

Version tracked: **1.22.4**

This document captures the full GSD configuration and explains how to reinstall it on a new machine.

---

## Install GSD

In any Claude Code session, run:

```
/gsd:update
```

If GSD is not yet installed, install Claude Code first, then run `/gsd:update` in a session — it will detect and install the framework.

---

## Current Config (`~/.claude/get-shit-done/templates/config.json`)

```json
{
  "mode": "interactive",
  "granularity": "standard",
  "workflow": {
    "research": true,
    "plan_check": true,
    "verifier": true,
    "auto_advance": false,
    "nyquist_validation": true
  },
  "planning": {
    "commit_docs": true,
    "search_gitignored": false
  },
  "parallelization": {
    "enabled": true,
    "plan_level": true,
    "task_level": false,
    "skip_checkpoints": true,
    "max_concurrent_agents": 3,
    "min_plans_for_parallel": 2
  },
  "gates": {
    "confirm_project": true,
    "confirm_phases": true,
    "confirm_roadmap": true,
    "confirm_breakdown": true,
    "confirm_plan": true,
    "execute_next_plan": true,
    "issues_review": true,
    "confirm_transition": true
  },
  "safety": {
    "always_confirm_destructive": true,
    "always_confirm_external_services": true
  }
}
```

### Config Explained

| Setting | Value | Meaning |
|---|---|---|
| `mode` | `interactive` | Pauses for human confirmation at gates |
| `granularity` | `standard` | Standard task breakdown depth |
| `workflow.research` | `true` | Research agents run before planning |
| `workflow.plan_check` | `true` | Plans are verified before execution |
| `workflow.verifier` | `true` | Output is verified after execution |
| `workflow.auto_advance` | `false` | Does NOT automatically move to next phase |
| `workflow.nyquist_validation` | `true` | Test coverage validated during phases |
| `planning.commit_docs` | `true` | Docs committed alongside code changes |
| `planning.search_gitignored` | `false` | Skips gitignored files during research |
| `parallelization.enabled` | `true` | Agents can run in parallel |
| `parallelization.plan_level` | `true` | Parallel at plan level (multiple plans at once) |
| `parallelization.task_level` | `false` | Not parallel at individual task level |
| `parallelization.max_concurrent_agents` | `3` | Max 3 agents running simultaneously |
| `gates.*` | all `true` | Confirms at every major decision point |
| `safety.always_confirm_destructive` | `true` | Always asks before destructive operations |
| `safety.always_confirm_external_services` | `true` | Always asks before external API calls |

---

## Hooks Configured in `settings.json`

```json
"hooks": {
  "SessionStart": [
    { "type": "command", "command": "node \"<claude-dir>/hooks/gsd-check-update.js\"" }
  ],
  "PostToolUse": [
    { "type": "command", "command": "node \"<claude-dir>/hooks/gsd-context-monitor.js\"" }
  ]
}
```

- **SessionStart / `gsd-check-update.js`** — checks for GSD updates in the background at the start of every session
- **PostToolUse / `gsd-context-monitor.js`** — monitors context window usage after each tool call

---

## Statusline

```json
"statusLine": {
  "type": "command",
  "command": "bash ~/.claude/statusline-command.sh"
}
```

The custom `statusline-command.sh` displays: `<project> | <tokens> | <cost> | <context bar>`

- Context bar is color-coded: green → yellow → orange → red (blinking at >80%)
- Uses `py` (Python) to parse JSON — **change to `python3` on Mac**
- Cost estimate: Sonnet 4.x pricing ($3/M input, $15/M output)

---

## Permissions

```json
"permissions": {
  "allow": ["Bash(git:*)"]
}
```

Git commands are pre-approved. All other Bash commands prompt for approval.

---

## Mac Restore Steps

1. **Find your username**: `whoami`
2. **Install Homebrew** (if not installed): `https://brew.sh`
3. **Install Node.js**: `brew install node`
4. **Install Claude Code CLI**: `npm install -g @anthropic-ai/claude-code`
5. **Log in**: `claude` → follow auth prompts
6. **Clone this repo**: `git clone https://github.com/joshberger5/claude-settings.git`
7. **Copy config files**:
   ```bash
   cp claude-settings/CLAUDE.md ~/.claude/CLAUDE.md
   cp claude-settings/settings.json ~/.claude/settings.json
   cp claude-settings/package.json ~/.claude/package.json
   cp claude-settings/statusline-command.sh ~/.claude/statusline-command.sh
   cp claude-settings/hooks/* ~/.claude/hooks/
   mkdir -p ~/.claude/plugins
   cp claude-settings/plugins/* ~/.claude/plugins/
   ```
8. **Update hook paths in `~/.claude/settings.json`** — replace `C:/Users/Josh Berger` with `/Users/<your-mac-username>`:
   ```bash
   USERNAME=$(whoami)
   sed -i '' "s|C:/Users/Josh Berger|/Users/$USERNAME|g" ~/.claude/settings.json
   ```
9. **Update `py` → `python3` in `~/.claude/statusline-command.sh`**:
   ```bash
   sed -i '' 's/ py -c/ python3 -c/g' ~/.claude/statusline-command.sh
   ```
10. **Update `py` → `python3` in `~/.claude/CLAUDE.md`** (the Python alias line)
11. **Install GSD**: start a Claude session and run `/gsd:update`
12. **Restore memory files**:
    ```bash
    mkdir -p "~/.claude/projects/C--Users-<mac-username>-Documents-GitHub-Job-Alert-Automation/memory"
    cp claude-settings/memory/Job-Alert-Automation/* \
       "~/.claude/projects/C--Users-<mac-username>-Documents-GitHub-Job-Alert-Automation/memory/"
    ```

---

## Platform Differences

| | Windows (this PC) | Mac |
|---|---|---|
| Python alias | `py` | `python3` |
| Claude config dir | `C:/Users/Josh Berger/.claude/` | `/Users/<username>/.claude/` |
| Hook paths | `C:/Users/Josh Berger/.claude/hooks/...` | `/Users/<username>/.claude/hooks/...` |
| Shell | Git Bash | zsh/bash |
| Project memory prefix | `C--Users-Josh-Berger-Documents-GitHub-...` | `C--Users-<mac-username>-Documents-GitHub-...` (uses `-` not `/`) |
