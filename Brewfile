# Brewfile - Homebrew package manifest
# Install all packages with: brew bundle install
# Update this file with: brew bundle dump --force

# Taps
tap "homebrew/services"
tap "osx-cross/arm"
tap "qmk/qmk"

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
# imagemagick-full + ffmpeg-full (Media processing),
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

# Language version managers
brew "asdf"           # Universal version manager
brew "uv"             # Python package/project & version manager (replaces pyenv/poetry)
brew "rbenv"          # Ruby version manager
brew "fnm"            # Node version manager (replaces nvm)

# Media processing (full variants also power Yazi's file previews)
# link: :overwrite == `brew link --overwrite`, so these supersede the plain
# imagemagick/ffmpeg binaries even if pulled in as deps of other formulae.
brew "imagemagick-full", link: :overwrite  # Image manipulation (superset of imagemagick)
brew "ffmpeg-full", link: :overwrite       # Video processing (superset of ffmpeg)

# Development tools
brew "watchman"       # File watching service
brew "cocoapods"      # iOS dependency manager
brew "clang-format"   # C/C++ formatter (QMK keymaps, general C dev)

# Additional utilities
brew "coreutils"      # GNU core utilities
brew "curl"           # HTTP client
brew "gnupg"          # GPG encryption
brew "bash"           # Bash shell
brew "gawk"           # GNU awk
brew "rust"           # Rust language (for cargo packages)
brew "python@3.14"    # System Python 3 (latest); use uv for project venvs
brew "pipx"           # Python app installer

# Keyboard firmware
brew "qmk/qmk/qmk"    # QMK firmware builder (Moonlander)
brew "arm-gcc-bin"        # ARM cross-compiler (Moonlander uses STM32)
brew "avr-gcc"            # AVR cross-compiler (other QMK boards)
brew "dos2unix"           # Line ending conversion (QMK dependency)
brew "make"               # GNU make (QMK build; installed as `gmake`, also `make` via gnubin)
# Flashing tools (qmk flash / per-bootloader). Not pulled in by the qmk formula,
# so list explicitly or `brew bundle` won't restore them.
brew "dfu-util"           # STM32/DFU flashing (Moonlander)
brew "dfu-programmer"     # AVR DFU flashing
brew "avrdude"            # AVR ISP flashing
brew "teensy_loader_cli"  # Teensy flashing
brew "bootloadhid"        # bootloadHID flashing (V-USB boards)

# Session/workspace management
brew "sesh"           # Tmux session manager (see tmux/.config/sesh/)

# Databases
brew "postgresql@18", restart_service: :changed  # PostgreSQL 18

# GUI Applications (Casks)

# Terminals
cask "kitty"          # Terminal

# Browsers
cask "chromium"       # Chromium browser
cask "firefox"        # Firefox browser

# Productivity
cask "hiddenbar"      # Menu bar manager

# Containers
cask "docker-desktop" # Docker Desktop

# Utilities
cask "keka"           # Archive manager
cask "vlc"            # Media player

# Fonts
cask "font-hack-nerd-font"           # Nerd font for terminal icons
cask "font-symbols-only-nerd-font"   # Icon-only glyphs (Yazi file icons)

# VS Code extensions (if using VS Code)
# vscode "ms-python.python"
# vscode "ms-python.vscode-pylance"
# vscode "ms-python.debugpy"
