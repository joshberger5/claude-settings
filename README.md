# claude-settings

Living version-control for my Claude Code configuration. Every meaningful change to CLAUDE.md rules, GSD settings, hooks, or statusline gets committed here — so I can see how my setup evolves over time and restore it on a new machine.

## What's tracked

| File/Dir | Description |
|---|---|
| `CLAUDE.md` | Global Claude rules (architecture, git, TDD, PR format, etc.) |
| `settings.json` | Permissions, hooks, statusline config |
| `statusline-command.sh` | Custom statusline: tokens, cost, context bar |
| `package.json` | Claude config dir type |
| `hooks/` | GSD update checker, context monitor, statusline renderer |
| `plugins/` | Plugin blocklist and marketplace config |
| `projects/*/CLAUDE.md` | Project-specific Claude instructions |
| `memory/*/` | Project memory files (rules, feedback, references) |
| `GSD_SETUP.md` | GSD config reference + Mac/Windows restore guide |
| `sync.sh` | Script to snapshot current config into this repo |

## What's NOT tracked

- `.credentials.json` — OAuth tokens (never commit)
- `history.jsonl`, `sessions/`, `debug/` — ephemeral runtime data
- `get-shit-done/` framework files — reinstalled via `/gsd:update`

## Keeping it up to date

After making changes to your Claude config, run from this repo:

```bash
bash sync.sh
git add -A
git commit -m "Update Claude config — <what changed>"
git push
```

## Restoring on a new machine

See [GSD_SETUP.md](GSD_SETUP.md) for full step-by-step instructions, including:
- Mac vs Windows path differences
- How to update the `py` → `python3` Python alias
- How to reinstall GSD
- How to restore memory files

## Current platform

This snapshot was taken on **Windows 11** (Josh Berger's PC), April 2026.
Hook paths in `settings.json` reflect Windows absolute paths — see `GSD_SETUP.md` for Mac equivalents.
