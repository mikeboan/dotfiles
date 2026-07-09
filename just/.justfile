# Dotfiles management with just
# Run 'just' or 'just --list' to see available commands

# Default recipe - shows available commands
default:
    @just --list

# Install dotfiles using stow
install:
    @echo "🔗 Installing dotfiles..."
    ./install.sh

# Bootstrap a fresh system
bootstrap:
    @echo "🚀 Bootstrapping system..."
    ./bootstrap.sh

# Update all package managers and tools
update:
    @echo "🔄 Updating Homebrew..."
    brew update && brew upgrade
    @echo "🔄 Updating oh-my-zsh..."
    cd ~/.oh-my-zsh && git pull
    @echo "✅ Update complete!"

# Clean up old/broken symlinks
clean:
    @echo "🧹 Cleaning up broken symlinks..."
    find ~ -maxdepth 1 -type l ! -exec test -e {} \; -print -delete

# Uninstall dotfiles (remove symlinks)
uninstall:
    @echo "🔗 Uninstalling dotfiles..."
    cd {{justfile_directory()}} && stow -D zsh tmux ideavim git kitty starship nvim gh just bin markdown aerospace pi yazi

# Reinstall dotfiles (uninstall then install)
reinstall: uninstall install

# Backup current dotfiles
backup:
    @echo "💾 Creating backup..."
    tar -czf ~/dotfiles-backup-$(date +%Y%m%d-%H%M%S).tar.gz -C ~ .zshrc .tmux.conf .config 2>/dev/null || true
    @echo "✅ Backup complete!"

# Show status of symlinks
status:
    @echo "📊 Dotfiles status:"
    @echo "\nSymlinks in home directory:"
    @ls -la ~ | grep -E '\.zshrc|\.tmux\.conf|\.ideavimrc' || echo "No dotfiles symlinks found"
    @echo "\nConfig directory:"
    @ls -la ~/.config | head -20
