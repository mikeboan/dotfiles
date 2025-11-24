# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Features

- **Shell**: zsh with oh-my-zsh, starship prompt, fzf, zoxide
- **Editor**: neovim configuration
- **Terminal**: tmux, wezterm, iterm2 configs
- **Version Control**: git with sensible defaults and useful aliases
- **Work/Personal Separation**: Local config files for work-specific settings

## Quick Start

### Fresh macOS Installation

If you're setting up a brand new Mac, run the bootstrap script first:

```bash
# Clone this repo
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles

# Run bootstrap to install all prerequisites
cd ~/dotfiles
./bootstrap.sh

# Then run the installer
./install.sh
```

### Alternative: Using Brewfile

For faster installation with exact package versions:

```bash
cd ~/dotfiles

# Install Homebrew first if needed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install all packages from Brewfile
brew bundle install

# Then run the rest of bootstrap (oh-my-zsh, plugins, etc)
./bootstrap.sh

# Finally, symlink dotfiles
./install.sh
```

### Existing System

If you already have the required tools installed:

```bash
cd ~/dotfiles
./install.sh
```

## Directory Structure

```
dotfiles/
├── bootstrap.sh           # Fresh machine setup script
├── install.sh             # Symlinks dotfiles using Stow
├── README.md              # This file
│
├── zsh/                   # Zsh configuration
│   ├── .zshrc             # Main zsh config
│   └── .zshrc.local.example  # Template for work/local config
│
├── git/                   # Git configuration
│   ├── .gitconfig         # Main git config
│   └── .gitignore-global  # Global gitignore
│
├── vim/                   # Vim/IDE configuration
│   └── .ideavimrc         # IntelliJ vim plugin config
│
├── tmux/                  # Tmux configuration
│   └── .tmux.conf         # Tmux config
│
├── wezterm/               # Wezterm terminal configuration
│   └── .wezterm.lua       # Wezterm config
│
├── config/                # XDG config directory
│   └── .config/
│       ├── nvim/          # Neovim configuration
│       ├── starship.toml  # Starship prompt config
│       ├── iterm2/        # iTerm2 settings
│       └── tmuxinator/    # Tmux session configs
│
├── bin/                   # Custom scripts (added to PATH)
│   └── theme              # Theme switcher script
│
└── legacy/                # Archived configs for reference
    └── README.md          # Documentation for legacy configs
```

## Managing Packages

### Brewfile

This repo includes a `Brewfile` that tracks all Homebrew packages, casks, and taps. This makes it easy to:

- Install all packages at once: `brew bundle install`
- Update the manifest: `brew bundle dump --force`
- Check what's installed: `brew bundle list`
- Cleanup unused packages: `brew bundle cleanup`

When you install new packages via Homebrew, remember to update the Brewfile:

```bash
cd ~/dotfiles
brew bundle dump --force
git add Brewfile
git commit -m "Update Brewfile with new packages"
```

## Prerequisites

The `bootstrap.sh` script will install these automatically. If installing manually:

### Required
- [Homebrew](https://brew.sh/) - macOS package manager
- [GNU Stow](https://www.gnu.org/software/stow/) - Symlink manager
- [oh-my-zsh](https://ohmyz.sh/) - Zsh framework
- [Starship](https://starship.rs/) - Shell prompt

### oh-my-zsh Plugins
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [zsh-completions](https://github.com/zsh-users/zsh-completions)

### Essential Tools
- [neovim](https://neovim.io/) - Text editor
- [tmux](https://github.com/tmux/tmux) - Terminal multiplexer
- [fzf](https://github.com/junegunn/fzf) - Fuzzy finder
- [fd](https://github.com/sharkdp/fd) - Better find
- [ripgrep](https://github.com/BurntSushi/ripgrep) - Better grep
- [zoxide](https://github.com/ajeetdsouza/zoxide) - Better cd
- [lazygit](https://github.com/jesseduffield/lazygit) - Git TUI
- [tmuxinator](https://github.com/tmuxinator/tmuxinator) - Tmux session manager

### Modern CLI Replacements
- [bat](https://github.com/sharkdp/bat) - Better cat with syntax highlighting
- [eza](https://github.com/eza-community/eza) - Modern ls replacement
- [btop](https://github.com/aristocratos/btop) - Better process viewer
- [duf](https://github.com/muesli/duf) - Better df (disk usage)
- [dust](https://github.com/bootandy/dust) - Better du (directory size)
- [procs](https://github.com/dalance/procs) - Better ps (process viewer)
- [git-delta](https://github.com/dandavison/delta) - Better git diff
- [httpie](https://github.com/httpie/httpie) - Better curl for APIs

### Development Utilities
- [jq](https://github.com/stedolan/jq) - JSON processor
- [yq](https://github.com/mikefarah/yq) - YAML processor
- [tldr](https://github.com/tldr-pages/tldr) - Simplified man pages
- [glow](https://github.com/charmbracelet/glow) - Markdown renderer
- [slides](https://github.com/maaslalani/slides) - Terminal presentations

### Version Managers
- [asdf](https://asdf-vm.com/) - Universal version manager
- [pyenv](https://github.com/pyenv/pyenv) - Python version manager
- [rbenv](https://github.com/rbenv/rbenv) - Ruby version manager
- nvm (via oh-my-zsh) - Node version manager

### Development Tools
- [autoenv](https://github.com/hyperupcall/autoenv) - Auto-load environment
- [watchman](https://github.com/facebook/watchman) - File watching service
- [cocoapods](https://cocoapods.org/) - iOS dependency manager
- [stripe](https://stripe.com/docs/cli) - Stripe CLI
- [oauth2l](https://github.com/google/oauth2l) - OAuth2 CLI tool
- [imagemagick](https://imagemagick.org/) - Image manipulation
- [ffmpeg](https://ffmpeg.org/) - Video processing

### Databases
- [postgresql@14](https://www.postgresql.org/) - PostgreSQL 14
- [postgresql@15](https://www.postgresql.org/) - PostgreSQL 15
- [redis](https://redis.io/) - Redis database

### GUI Applications
- [WezTerm](https://wezfurlong.org/wezterm/) - Primary terminal
- [iTerm2](https://iterm2.com/) - Backup terminal
- [Chromium](https://www.chromium.org/) - Web browser
- [Firefox](https://www.mozilla.org/firefox/) - Web browser
- [HiddenBar](https://github.com/dwarvesf/hidden) - Menu bar manager
- [Keka](https://www.keka.io/) - Archive manager
- [VLC](https://www.videolan.org/vlc/) - Media player
- [Postman](https://www.postman.com/) - API testing
- [ngrok](https://ngrok.com/) - Tunneling service
- [Hack Nerd Font](https://www.nerdfonts.com/) - Terminal icons

## Local Configuration

### Work/Machine-Specific Settings

Create `~/.zshrc.local` for settings that shouldn't be in version control:

```bash
cp ~/dotfiles/zsh/.zshrc.local.example ~/.zshrc.local
# Edit ~/.zshrc.local with your work-specific settings
```

This is perfect for:
- Work-specific environment variables
- API keys and tokens
- Company-specific aliases
- Machine-specific paths

### Git Secrets

Create `~/.gitconfig.local` for git settings with secrets:

```gitconfig
[user]
    signingkey = YOUR_GPG_KEY

[credential]
    helper = osxkeychain

[github]
    user = YOUR_GITHUB_USERNAME
    token = YOUR_GITHUB_TOKEN
```

## How Stow Works

GNU Stow creates symlinks from this dotfiles directory to your home directory.

For example:
- `dotfiles/zsh/.zshrc` → `~/.zshrc`
- `dotfiles/git/.gitconfig` → `~/.gitconfig`
- `dotfiles/config/.config/nvim/` → `~/.config/nvim/`

When you edit `~/.zshrc`, you're actually editing `~/dotfiles/zsh/.zshrc`, which makes it easy to commit changes.

## Customization

### Adding New Dotfiles

1. Create a new directory for the tool (e.g., `alacritty/`)
2. Add the dotfile with the correct path structure (e.g., `alacritty/.alacritty.yml`)
3. Update `install.sh` to include the new directory in the `stow` command
4. Update the backup list in `install.sh` if needed

Example:
```bash
mkdir -p ~/dotfiles/alacritty
cp ~/.alacritty.yml ~/dotfiles/alacritty/.alacritty.yml

# Edit install.sh and add 'alacritty' to the stow command
```

### Archiving Old Configs

When you move away from a tool but want to keep its config for reference:

1. Move the config to the `legacy/` directory
2. Remove it from the `stow` command in `install.sh`
3. Document what it was used for in `legacy/README.md`

## Useful Commands

### Git Aliases (from .gitconfig)

- `git st` - status
- `git co` - checkout
- `git br` - branch
- `git ci` - commit
- `git unstage` - unstage files
- `git last` - show last commit
- `git visual` - pretty graph log

### Custom Git/GitHub Aliases (from .zshrc)

- `gbase` - Show base branch of current PR
- `gcurrent` - Show current branch name
- `gnext` - Show next branch in PR chain
- `gcb` - Checkout base branch
- `gcn` - Checkout next branch
- `gcm` - Checkout main
- `gcs` - Checkout staging
- `gmb` - Merge base branch
- `gpush` - Push current branch
- `gpull` - Pull current branch
- `gchain` - Checkout next, merge base, and push

### Other Aliases

- `vim`/`vi` → `nvim` (uses Neovim)
- `tx` → `tmuxinator`
- `lg` → `lazygit`

## Backup & Recovery

### Before Installing

The `install.sh` script automatically backs up existing dotfiles to:
```
~/dotfiles_backup_YYYYMMDD_HHMMSS/
```

### Manual Backup

```bash
# Backup current dotfiles
tar -czf ~/dotfiles_backup_$(date +%Y%m%d).tar.gz \
  ~/.zshrc ~/.gitconfig ~/.tmux.conf ~/.config
```

### Disaster Recovery

Since these dotfiles are in git:

1. Clone this repo on a new machine
2. Run `./bootstrap.sh` to install prerequisites
3. Run `./install.sh` to symlink configs
4. Restore any `~/.zshrc.local` or `~/.gitconfig.local` from secure backup

## Troubleshooting

### Stow Conflicts

If stow fails with conflicts:

```bash
# Remove existing file/symlink
rm ~/.zshrc

# Re-run stow
cd ~/dotfiles
stow zsh
```

### Plugin Not Found Errors

If you get errors about missing oh-my-zsh plugins:

```bash
# Reinstall plugins
cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions
```

### Broken Symlinks

To find and remove broken symlinks:

```bash
# Find broken symlinks in home directory
find ~ -maxdepth 1 -type l ! -exec test -e {} \; -print

# Remove a specific broken symlink
rm ~/.broken-symlink
```

## Contributing

This is a personal dotfiles repo, but feel free to fork and adapt for your own use!

## License

MIT
