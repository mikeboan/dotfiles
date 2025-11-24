# Brewfile - Homebrew package manifest
# Install all packages with: brew bundle install
# Update this file with: brew bundle dump --force

# Taps
tap "heroku/brew"
tap "homebrew/services"
tap "ngrok/ngrok"
tap "stripe/stripe-cli"

# Core utilities
brew "stow"           # Dotfiles symlink manager
brew "git"            # Version control
brew "neovim"         # Text editor
brew "tmux"           # Terminal multiplexer
brew "starship"       # Shell prompt
brew "fzf"            # Fuzzy finder
brew "fd"             # Better find
brew "ripgrep"        # Better grep
brew "zoxide"         # Better cd
brew "lazygit"        # Git TUI
brew "gh"             # GitHub CLI
brew "just"           # Command runner

# Modern CLI replacements
brew "bat"            # Better cat with syntax highlighting
brew "eza"            # Modern ls replacement
brew "btop"           # Better process viewer
brew "duf"            # Better df (disk usage)
brew "dust"           # Better du (directory size)
brew "procs"          # Better ps (process viewer)

# Git tools
brew "git-delta"      # Better git diff with syntax highlighting

# Development utilities
brew "jq"             # JSON processor
brew "yq"             # YAML processor
brew "httpie"         # Better curl for APIs
brew "tldr"           # Simplified man pages
brew "glow"           # Markdown renderer
brew "slides"         # Terminal presentations

# Language version managers
brew "asdf"           # Universal version manager
brew "pyenv"          # Python version manager
brew "rbenv"          # Ruby version manager
# Note: nvm installed via oh-my-zsh plugin

# Environment management
brew "autoenv"        # Auto-load environment based on directory

# Media processing
brew "imagemagick"    # Image manipulation
brew "ffmpeg"         # Video processing

# Development tools
brew "watchman"       # File watching service
brew "cocoapods"      # iOS dependency manager
brew "oauth2l"        # OAuth2 CLI tool

# Additional utilities
brew "coreutils"      # GNU core utilities
brew "curl"           # HTTP client
brew "gnupg"          # GPG encryption
brew "bash"           # Bash shell
brew "gawk"           # GNU awk
brew "rust"           # Rust language (for cargo packages)
brew "pipx"           # Python app installer

# Databases
brew "postgresql@14"  # PostgreSQL 14
brew "postgresql@15", restart_service: :changed  # PostgreSQL 15
brew "redis", restart_service: :changed          # Redis database

# Work-specific tools
brew "heroku/brew/heroku"           # Heroku CLI
brew "stripe/stripe-cli/stripe"     # Stripe CLI

# GUI Applications (Casks)

# Terminals
cask "wezterm"        # Primary terminal
cask "iterm2"         # Backup terminal

# Browsers
cask "chromium"       # Chromium browser
cask "firefox"        # Firefox browser

# Productivity
cask "hiddenbar"      # Menu bar manager

# Utilities
cask "keka"           # Archive manager
cask "vlc"            # Media player
cask "postman"        # API testing
cask "ngrok"          # Tunneling service

# Fonts
cask "font-hack-nerd-font"  # Nerd font for terminal icons

# VS Code extensions (if using VS Code)
# vscode "ms-python.python"
# vscode "ms-python.vscode-pylance"
# vscode "ms-python.debugpy"
