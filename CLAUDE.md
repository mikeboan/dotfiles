# Dotfiles — Development Guidelines

## What Is This?

GNU Stow-based dotfiles for macOS (Apple Silicon). Manages dev environment config: neovim, zsh, tmux, wezterm, git, and supporting tools.

## Directory Layout

Each top-level directory is a **stow package** — its contents get symlinked into `$HOME`:

```
dotfiles/
  git/            → .gitconfig, .gitignore-global        → ~/
  zsh/            → .zshrc, .zshrc.local.example          → ~/
  tmux/           → .tmux.conf                            → ~/
  vim/            → .ideavimrc                            → ~/
  wezterm/        → .wezterm.lua                          → ~/
  just/           → .justfile                             → ~/
  markdown/       → .markdownlintrc                       → ~/
  bin/            → theme                                 → ~/bin/
```

### Other Files (Not Stow Packages)

- `install.sh` — sets up stow symlinks, backs up existing files
- `bootstrap.sh` — fresh macOS setup (Homebrew, packages, config)
- `Brewfile` — declarative Homebrew dependencies

## Conventions

### Stow Package Structure

- One concern per package — don't mix unrelated configs
- Files in a package mirror their target location relative to `$HOME`
- New top-level tool config → new stow package (unless it lives under `.config/`, then use `config/`)

### Machine-Specific Overrides

- Use `.local` suffix files for machine/work-specific config (gitignored)
- Example: `.zshrc` sources `.zshrc.local` if it exists
- `.zshrc.local.example` shows the expected format

### Config File Conventions

- **Lua configs** (neovim, wezterm): one file per concern, imported by a central init
- **Shell configs** (zsh): single `.zshrc`, sections clearly commented
- **Declarative configs** (tmux, git): single file per tool

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
