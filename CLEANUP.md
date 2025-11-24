# Cleanup Tasks

This document lists tools that are currently installed but not being used. You can remove them to clean up your system.

## Tools to Uninstall

### Window Management (Not Using)
```bash
brew uninstall skhd
brew uninstall yabai
```

### Productivity Apps (Not Using)
```bash
brew uninstall --cask alt-tab
brew uninstall --cask amethyst
brew uninstall --cask raycast  # If installed and not using
```

### Version Managers (Duplicates)
```bash
# You're using nvm via oh-my-zsh, so fnm is redundant
brew uninstall fnm
```

### Utilities (Not Using)
```bash
brew uninstall syncthing
brew uninstall yt-dlp
```

### Cargo Packages (Migrated to Brew)
Since eza is now installed via Homebrew, you can optionally remove the cargo version:
```bash
cargo uninstall eza
```

## After Cleanup

Once you've removed the tools you don't need, you can verify your installed packages:

```bash
# Check what's installed via Homebrew
brew list --formula
brew list --cask

# Check cargo packages
cargo install --list
```

## Notes

- Keep postgresql@14 and postgresql@15 (you indicated you need both versions)
- Keep redis (in active use)
- All other currently installed tools have been added to bootstrap.sh
