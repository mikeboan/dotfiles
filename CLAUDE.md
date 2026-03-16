# Dotfiles — Development Guidelines

## What Is This?

GNU Stow-based dotfiles for macOS (Apple Silicon). Manages dev environment config: neovim, zsh, tmux, wezterm, git, and supporting tools.

## Directory Layout

Each top-level directory is a **tool-named stow package**. A package owns *all* config for its tool — both `~/` dotfiles and `~/.config/` files — so there's one obvious place to look for any tool's config.

```
dotfiles/
  nvim/           → ~/.config/nvim/                       # Neovim
  tmux/           → ~/.tmux.conf, ~/.config/tmuxinator/,  # Tmux + session managers
                    ~/.config/sesh/
  zsh/            → ~/.zshrc                              # Shell
  starship/       → ~/.config/starship.toml               # Prompt
  wezterm/        → ~/.wezterm.lua                        # Terminal
  git/            → ~/.gitconfig, ~/.config/git/ignore     # Git
  ideavim/        → ~/.ideavimrc                          # IntelliJ IdeaVim
  gh/             → ~/.config/gh/                         # GitHub CLI
  iterm2/         → ~/.config/iterm2/                     # iTerm2
  just/           → ~/.justfile                           # Command runner
  markdown/       → ~/.markdownlintrc                     # Markdown linting
  bin/            → ~/bin/theme, ~/.config/dotfiles/       # Custom scripts
```

### Other Files (Not Stow Packages)

- `install.sh` — stow all packages, backs up existing files
- `bootstrap.sh` — fresh macOS setup: Homebrew, `brew bundle` from Brewfile, oh-my-zsh
- `Brewfile` — single source of truth for all Homebrew packages and casks

## Conventions

### Stow Package Structure

- **One package per tool** — the package is named after the tool it configures
- A package owns everything for that tool: `~/` dotfiles, `~/.config/` dirs, all of it
- Files in a package mirror their target location relative to `$HOME`
- Closely related tools can share a package (e.g., tmux + tmuxinator + sesh)
- Adding a new tool? Create a new top-level package and add it to `install.sh`

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
