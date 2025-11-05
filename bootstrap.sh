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

# Language version managers
brew install pyenv         # Python version manager
brew install rbenv         # Ruby version manager
brew install nvm           # Node version manager (will need additional setup)

# Other tools
brew install tmuxinator    # Tmux session manager
brew install postgresql@15 # Database (if needed)

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
