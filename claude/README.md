# claude — Claude Code global config

Stowed into `~/.claude/`. Stow ignores this README (top-level `^/README.*` is in
its default ignore list), so it never lands in `$HOME`.

## What's here

| File | Purpose |
|---|---|
| `.claude/CLAUDE.md` | Global instructions loaded into every Claude Code session |
| `.claude/code-philosophy.md` | Long-form rationale behind the principles in `CLAUDE.md` |
| `.claude/statusline-command.sh` | Status line mirroring the Starship prompt (Tokyo Night Storm) |
| `.claude/settings.example.json` | Template for `~/.claude/settings.json` — **not** symlinked |

## Why `settings.json` isn't stowed

Claude Code rewrites `~/.claude/settings.json` itself (theme toggles, plugin
enable/disable, survey state). An atomic write would replace the symlink and
orphan the repo copy. Copy the template once per machine instead:

```bash
cp ~/.claude/settings.example.json ~/.claude/settings.json   # then edit
```

Machine-specific permission allowlists belong in `~/.claude/settings.local.json`
(gitignored by Claude Code itself, never tracked here).

## No `rules/` directory — on purpose

Claude Code auto-loads `~/.claude/rules/**` into every session. Files with no
frontmatter apply *always*; a `paths:` list makes them conditional. That makes
the directory a standing context tax on every project, so nothing lives there.
Global guidance goes in `CLAUDE.md`; anything project- or language-specific
belongs in that project's own `CLAUDE.md`.

## Dependencies

- `jq` — required by `statusline-command.sh` (in the shared `Brewfile`)
- `git` — the status line shows branch/worktree
