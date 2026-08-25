#!/bin/bash

# Dotfiles Installation Script
# This script sets up the dotfiles using GNU Stow

set -e  # Exit on any error

echo "🏠 Setting up dotfiles..."

# Check if we're in the dotfiles directory
if [ ! -f "install.sh" ]; then
    echo "❌ Please run this script from the dotfiles directory"
    exit 1
fi

# Resolve personal/work profile (prompts once, then remembers)
source "$(dirname "$0")/scripts/dotfiles-profile.sh"
profile="$(dotfiles_profile)"
echo "🧭 Profile: $profile"

# Install Stow if not present
if ! command -v stow &> /dev/null; then
    echo "📦 Installing GNU Stow..."
    if command -v brew &> /dev/null; then
        brew install stow
    elif command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y stow
    elif command -v pacman &> /dev/null; then
        sudo pacman -S stow
    else
        echo "❌ Cannot install Stow automatically. Please install it manually."
        exit 1
    fi
else
    echo "✅ GNU Stow is already installed"
fi

# Backup existing dotfiles (optional)
echo "💾 Backing up existing dotfiles (if any)..."
backup_dir="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$backup_dir"

# Paths (relative to $HOME) that Stow will manage and may already exist as
# real files/dirs. Nested paths keep their structure inside the backup dir.
files_to_backup=(
    ".zshrc"
    ".tmux.conf"
    ".ideavimrc"
    ".gitconfig"
    ".justfile"
    ".markdownlintrc"
    ".claude/CLAUDE.md"
    ".claude/code-philosophy.md"
    ".claude/statusline-command.sh"
)

for file in "${files_to_backup[@]}"; do
    if [ -e "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
        echo "  Backing up $file"
        mkdir -p "$backup_dir/$(dirname "$file")"
        mv "$HOME/$file" "$backup_dir/$file"
    fi
done

# Create symlinks with Stow
echo "🔗 Creating symlinks..."
packages="zsh tmux ideavim git kitty starship nvim gh just markdown yazi claude"
if [ "$profile" = "personal" ]; then
    packages="$packages pi"
fi
stow $packages

echo "✨ Dotfiles installation complete!"
echo ""
echo "📁 Your original files have been backed up to: $backup_dir"
echo ""
echo "🔧 Next steps:"
echo "   - Restart your shell or run: source ~/.zshrc"
echo "   - Create ~/.zshrc.local for work/machine-specific settings (see zsh/.zshrc.local.example)"
echo "   - Create ~/.gitconfig.local for git secrets/tokens if needed"
echo "   - Claude Code: cp ~/.claude/settings.example.json ~/.claude/settings.json (see claude/README.md)"
echo ""
echo "🎉 Happy coding!"