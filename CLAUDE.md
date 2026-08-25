# Dotfiles — Development Guidelines

## What Is This?

GNU Stow-based dotfiles for macOS (Apple Silicon). Manages dev environment config: neovim, zsh, tmux, kitty, git, and supporting tools.

## Directory Layout

Each top-level directory is a **tool-named stow package**. A package owns *all* config for its tool — both `~/` dotfiles and `~/.config/` files — so there's one obvious place to look for any tool's config.

```
dotfiles/
  nvim/           → ~/.config/nvim/                       # Neovim (LazyVim)
  tmux/           → ~/.tmux.conf, ~/.config/sesh/          # Tmux + sesh sessions
  zsh/            → ~/.zshrc, ~/.config/zsh/               # Shell (frameworkless)
  starship/       → ~/.config/starship.toml               # Prompt
  kitty/          → ~/.config/kitty/                      # Terminal
  yazi/           → ~/.config/yazi/                       # File manager
  git/            → ~/.gitconfig, ~/.config/git/ignore     # Git
  ideavim/        → ~/.ideavimrc                          # IntelliJ IdeaVim
  gh/             → ~/.config/gh/                         # GitHub CLI
  just/           → ~/.justfile                           # Command runner
  markdown/       → ~/.markdownlintrc                     # Markdown linting
  pi/             → ~/.pi/agent/                          # Pi coding agent
  claude/         → ~/.claude/                            # Claude Code global config
```

### Other Files (Not Stow Packages)

- `install.sh` — stow all packages, backs up existing files
- `bootstrap.sh` — fresh macOS setup: Homebrew, `brew bundle` from Brewfile, QMK, Pi
- `BOOTSTRAP.md` — manual checklist for the unscriptable rest of a new machine
- `Brewfile` — Homebrew packages shared by every machine
- `Brewfile.personal` — personal-machine-only Homebrew packages
- `scripts/dotfiles-profile.sh` — resolves the personal/work profile for this machine
- `docs/removed-plugins.md` — ledger of everything killed in the 2026-07 minimalism overhaul
- `claude/README.md` — what the `claude` package ships and why `settings.json` isn't stowed

## Conventions

### Stow Package Structure

- **One package per tool** — the package is named after the tool it configures
- A package owns everything for that tool: `~/` dotfiles, `~/.config/` dirs, all of it
- Files in a package mirror their target location relative to `$HOME`
- Closely related tools can share a package (e.g., tmux + sesh)
- Adding a new tool? Create a new top-level package and add it to `install.sh`

### Machine-Specific Overrides

- Use `.local` suffix files for machine/work-specific config (gitignored)
- Example: `.zshrc` sources `.zshrc.local` if it exists
- `.zshrc.local.example` and `git/.gitconfig.local.example` show the expected format

### Personal vs. Work Profile

Some tools/packages aren't installed or permitted on corporate machines (e.g.
`pi`, QMK firmware, certain language version managers). This is a first-class
split, not a `.local` override:

- `~/.dotfiles-profile` holds `personal` or `work`, set by a one-time prompt in
  `install.sh`/`bootstrap.sh` (see `scripts/dotfiles-profile.sh`); override with
  `DOTFILES_PROFILE=personal ./bootstrap.sh`
- `Brewfile` is shared; `Brewfile.personal` holds personal-only packages,
  installed only when the profile is `personal`

### Config File Conventions

- **Lua configs** (neovim): stock LazyVim. `lazyvim.json` is the extras list;
  `lua/config/*.lua` holds only deltas from LazyVim defaults; `lua/plugins/*.lua`
  holds one file per override or custom plugin. Check LazyVim's own source at
  `~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/` before adding anything — it
  probably already ships it as core or an extra
- **Shell configs** (zsh): single `.zshrc`, sections clearly commented
- **Declarative configs** (tmux, git): single file per tool
- **Agent configs** (claude): only hand-authored files are tracked — instructions,
  rules, statusline. Anything Claude Code rewrites itself (`settings.json`,
  caches, session state) stays untracked; ship a `.example.json` template instead

### Idempotency

All scripts must be safe to run repeatedly:
- Check before installing (e.g., `command -v brew &> /dev/null`)
- Back up before overwriting
- Use `stow --restow` to refresh symlinks

## Commands

```bash
cd ~/dotfiles && ./install.sh       # Set up all stow symlinks
cd ~/dotfiles && ./bootstrap.sh     # Fresh machine setup (Homebrew + packages + config)
stow <package>                      # Symlink a single package (e.g., stow zsh)
stow -D <package>                   # Unsymlink a package
stow -R <package>                   # Restow (refresh) a package
brew bundle dump --force             # Update Brewfile from current installs
```

## What to Avoid

- Never commit secrets, API keys, or tokens — use `.local` files (gitignored)
- Never break idempotency — scripts must be re-runnable without side effects
- Don't hardcode paths — use `$HOME`, `$XDG_CONFIG_HOME`, etc.
- Don't add tool-specific config to the wrong stow package

## Research

Research notes live in `.claude/research/`. Check existing notes before starting new research — the answer may already be there.
