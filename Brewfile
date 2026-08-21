# Brewfile — Homebrew package manifest (shared across all machines)
# Install all packages with: brew bundle install
# Update this file with: brew bundle dump --force
# Personal-machine-only packages live in Brewfile.personal (see bootstrap.sh)

# Core utilities
brew "stow"           # Dotfiles symlink manager
brew "git"            # Version control
brew "neovim"         # Text editor
brew "tree-sitter-cli" # Treesitter grammar compiler (nvim-treesitter)
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

# File manager
brew "yazi"           # Terminal file manager
brew "sevenzip"       # Archive extraction/preview (Yazi)
brew "poppler"        # PDF preview (Yazi)
brew "resvg"          # SVG preview (Yazi)
# Yazi also relies on: fd, ripgrep, fzf, zoxide, jq (Core utilities),
# imagemagick-full + ffmpeg-full (Media processing, Brewfile.personal),
# font-symbols-only-nerd-font (Fonts).

# Git tools
brew "git-delta"      # Better git diff with syntax highlighting

# Development utilities
brew "jq"             # JSON processor
brew "yq"             # YAML processor
brew "httpie"         # Better curl for APIs
brew "tldr"           # Simplified man pages
brew "glow"           # Markdown renderer
brew "slides"         # Terminal presentations

# Shell plugins (sourced directly in .zshrc — no framework)
brew "zsh-autosuggestions"
brew "zsh-syntax-highlighting"
brew "zsh-completions"

# Session/workspace management
brew "sesh"           # Tmux session manager (see tmux/.config/sesh/)

# GUI Applications (Casks)

# Terminals
cask "kitty"          # Terminal

# Fonts
cask "font-hack-nerd-font"           # Nerd font for terminal icons
cask "font-symbols-only-nerd-font"   # Icon-only glyphs (Yazi file icons)

# VS Code extensions (if using VS Code)
# vscode "ms-python.python"
# vscode "ms-python.vscode-pylance"
# vscode "ms-python.debugpy"
