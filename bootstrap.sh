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

# Trust third-party taps (newer Homebrew refuses untrusted-tap formulas)
if brew trust --help &> /dev/null; then
    brew trust qmk/qmk || true
    brew trust osx-cross/arm || true
fi

# Install packages from Brewfile
echo ""
echo "📦 Installing packages from Brewfile..."
brew bundle install --file="$(cd "$(dirname "$0")" && pwd)/Brewfile"
echo "✅ Brewfile packages installed"

# Clone fzf-git.sh if not present
echo ""
echo "📦 Installing fzf-git.sh..."
if [ ! -d "$HOME/fzf-git.sh" ]; then
    git clone https://github.com/junegunn/fzf-git.sh.git ~/fzf-git.sh
else
    echo "✅ fzf-git.sh already installed"
fi

# Setup fzf key bindings
echo "🔧 Setting up fzf..."
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc

# Pi coding agent — uses the official installer which bundles its own Node binary,
# so it stays working when you switch nvm versions.
echo ""
echo "🤖 Installing Pi coding agent..."
if ! command -v pi &> /dev/null; then
    curl -fsSL https://pi.dev/install.sh | sh
    echo "✅ Pi installed"
else
    echo "✅ Pi already installed"
fi

# QMK firmware setup (ZSA Moonlander)
echo ""
echo "⌨️  Setting up QMK firmware..."
if command -v qmk &> /dev/null; then
    if [ ! -d "$HOME/qmk_firmware" ]; then
        # TODO: once the personal fork remote exists, clone it instead and
        # check out branch `mike` (keymap + getreuer submodule live there)
        qmk setup mikeboan/qmk_firmware -b mike -y
        echo "✅ QMK firmware initialized"
    else
        echo "✅ QMK firmware already set up"
    fi
else
    echo "⚠️  qmk not found (skipping firmware setup)"
fi

echo ""
echo "✨ Bootstrap complete!"
echo ""
echo "📋 Next steps:"
echo "   1. Clone your dotfiles repo:"
echo "      git clone https://github.com/mikeboan/dotfiles.git ~/dotfiles"
echo ""
echo "   2. Run the dotfiles installer:"
echo "      cd ~/dotfiles && ./install.sh"
echo ""
echo "   3. Work through the manual checklist:"
echo "      ~/dotfiles/BOOTSTRAP.md"
echo ""
echo "🎉 Your system is ready for dotfiles installation!"
