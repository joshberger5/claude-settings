# claude-settings

Living version-control for my Claude Code configuration. Every meaningful change to CLAUDE.md rules, hooks, or statusline gets committed here — so I can see how my setup evolves over time and restore it on a new machine.

## What's tracked

| File/Dir | Description |
|---|---|
| `CLAUDE.md` | Global Claude rules (architecture, git, TDD, PR format, etc.) |
| `settings.json` | Permissions, hooks, statusline config |
| `package.json` | Claude config dir type |
| `hooks/` | Context monitor and statusline renderer |
| `memory/*/` | Project memory files (rules, feedback, references) |
| `sync.sh` | Script to snapshot current config into this repo and commit |

## What's NOT tracked

- `.credentials.json` — OAuth tokens (never commit)
- `history.jsonl`, `sessions/`, `debug/` — ephemeral runtime data

## Keeping it up to date

`sync.sh` auto-commits and pushes when there are changes:

```bash
bash ~/.claude/../path-to-this-repo/sync.sh
```

Or run it from this repo root:

```bash
bash sync.sh
```

## Restoring on a new machine

1. Clone this repo
2. Copy files to `~/.claude/`:
   ```bash
   cp CLAUDE.md settings.json package.json ~/.claude/
   cp hooks/* ~/.claude/hooks/
   ```
3. Update absolute paths in `settings.json` to match the new machine's username
4. Copy memory files to `~/.claude/projects/<project-path>/memory/`

## Current platform

macOS (Josh Berger's MacBook), April 2026. Hook paths in `settings.json` use `/Users/joshuaberger/`.
