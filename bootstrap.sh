#!/bin/bash

# Bootstrap Script for Fresh macOS Installation
# This script sets up a new machine with all necessary tools and configurations

set -e  # Exit on any error

echo "🚀 Starting fresh macOS setup..."
echo ""

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "❌ This script is designed for macOS only"
    exit 1
fi

# Install Homebrew if not present
if ! command -v brew &> /dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == 'arm64' ]]; then
        echo "🔧 Configuring Homebrew for Apple Silicon..."
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "✅ Homebrew is already installed"
fi

# Update Homebrew
echo "🔄 Updating Homebrew..."
brew update

# Check if Brewfile exists and offer to use it
if [ -f "Brewfile" ]; then
    echo ""
    echo "📋 Found Brewfile. Would you like to use it to install packages?"
    echo "   Using Brewfile is faster and ensures exact package versions."
    read -p "   Use Brewfile? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "📦 Installing packages from Brewfile..."
        brew bundle install
        echo "✅ Brewfile packages installed"
        # Skip individual package installation
        SKIP_INDIVIDUAL_INSTALL=true
    fi
fi

if [ "$SKIP_INDIVIDUAL_INSTALL" != "true" ]; then
    # Install essential tools via Homebrew
    echo "📦 Installing essential tools..."

# Core utilities
brew install stow          # Dotfiles symlink manager
brew install git           # Version control
brew install neovim        # Text editor
brew install tmux          # Terminal multiplexer
brew install starship      # Shell prompt
brew install fzf           # Fuzzy finder
brew install fd            # Better find
brew install ripgrep       # Better grep
brew install zoxide        # Better cd
brew install lazygit       # Git TUI
brew install gh            # GitHub CLI
brew install just          # Command runner

# Modern CLI replacements
brew install bat           # Better cat with syntax highlighting
brew install eza           # Modern ls replacement
brew install btop          # Better process viewer
brew install duf           # Better df (disk usage)
brew install dust          # Better du (directory size)
brew install procs         # Better ps (process viewer)

# Git tools
brew install git-delta     # Better git diff with syntax highlighting

# Development utilities
brew install jq            # JSON processor
brew install yq            # YAML processor
brew install httpie        # Better curl for APIs
brew install tldr          # Simplified man pages
brew install glow          # Markdown renderer
brew install slides        # Terminal presentations

# Language version managers
brew install asdf          # Universal version manager
brew install pyenv         # Python version manager
brew install rbenv         # Ruby version manager
# Note: nvm will be installed via oh-my-zsh plugin

# Environment management
brew install autoenv       # Auto-load environment based on directory

# Media processing
brew install imagemagick   # Image manipulation
brew install ffmpeg        # Video processing

# Development tools
brew install watchman      # File watching service
brew install cocoapods     # iOS dependency manager
brew install stripe        # Stripe CLI
brew install oauth2l       # OAuth2 CLI tool

# Databases
brew install postgresql@14 # PostgreSQL 14
brew install postgresql@15 # PostgreSQL 15
brew install redis         # Redis database

# Other tools
brew install tmuxinator    # Tmux session manager

fi  # End of individual package installation

echo ""
echo "📦 Installing oh-my-zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "✅ oh-my-zsh is already installed"
fi

# Install oh-my-zsh plugins
echo "📦 Installing oh-my-zsh plugins..."

# zsh-autosuggestions
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
    echo "✅ zsh-autosuggestions already installed"
fi

# zsh-syntax-highlighting
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
    echo "✅ zsh-syntax-highlighting already installed"
fi

# zsh-completions
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-completions" ]; then
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
else
    echo "✅ zsh-completions already installed"
fi

# Clone fzf-git.sh if not present
echo "📦 Installing fzf-git.sh..."
if [ ! -d "$HOME/fzf-git.sh" ]; then
    git clone https://github.com/junegunn/fzf-git.sh.git ~/fzf-git.sh
else
    echo "✅ fzf-git.sh already installed"
fi

# Setup fzf key bindings
echo "🔧 Setting up fzf..."
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc

# Install GUI applications via Homebrew Casks
echo ""
echo "🖥️  Installing GUI applications..."

# Terminals
brew install --cask wezterm      # Primary terminal
brew install --cask iterm2       # Backup terminal

# Browsers
brew install --cask chromium     # Chromium browser
brew install --cask firefox      # Firefox browser

# Productivity
brew install --cask hiddenbar    # Menu bar manager

# Utilities
brew install --cask keka         # Archive manager
brew install --cask vlc          # Media player
brew install --cask postman      # API testing
brew install --cask ngrok        # Tunneling service

# Fonts
brew install --cask font-hack-nerd-font  # Nerd font for terminal icons

# Install WezTerm terminfo for proper color support
echo ""
echo "🎨 Installing WezTerm terminfo..."
if [ ! -d "$HOME/.terminfo/w/wezterm" ]; then
    echo "   Downloading WezTerm terminfo..."
    TEMPFILE=$(mktemp)
    if curl -fsSL -o "$TEMPFILE" https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo; then
        echo "   Installing terminfo to ~/.terminfo..."
        tic -x -o "$HOME/.terminfo" "$TEMPFILE"
        rm "$TEMPFILE"
        echo "✅ WezTerm terminfo installed successfully"
    else
        echo "⚠️  Failed to download WezTerm terminfo (non-fatal)"
        rm -f "$TEMPFILE"
    fi
else
    echo "✅ WezTerm terminfo already installed"
fi

echo ""
echo "✨ Bootstrap complete!"
echo ""
echo "📋 Next steps:"
echo "   1. Clone your dotfiles repo:"
echo "      git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles"
echo ""
echo "   2. Run the dotfiles installer:"
echo "      cd ~/dotfiles && ./install.sh"
echo ""
echo "   3. Install Rust (for cargo tools):"
echo "      curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
echo ""
echo "   4. Setup any language versions you need:"
echo "      pyenv install 3.11.0  # or your preferred Python version"
echo "      rbenv install 3.2.0   # or your preferred Ruby version"
echo ""
echo "   5. Consider installing GUI apps via Homebrew casks:"
echo "      brew install --cask wezterm iterm2 visual-studio-code"
echo ""
echo "🎉 Your system is ready for dotfiles installation!"
