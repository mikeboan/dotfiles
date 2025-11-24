# Dotfiles Audit Summary

**Date:** 2025-11-19

## Overview

This audit compared installed tools on the system against what's documented in the dotfiles repository to ensure the repo represents a fully restorable system state.

## Changes Made

### 1. Created Brewfile

Generated a comprehensive `Brewfile` that tracks all Homebrew packages, casks, and taps. This provides:
- Single-command installation: `brew bundle install`
- Easy maintenance: `brew bundle dump --force`
- Version tracking in git
- Faster alternative to running individual brew install commands

The bootstrap.sh script now detects the Brewfile and offers to use it for faster installation.

### 2. Updated bootstrap.sh

Added the following missing tools:

**Modern CLI Replacements:**
- bat (better cat)
- eza (better ls)
- btop (better top)
- duf (better df)
- dust (better du)
- procs (better ps)

**Git Tools:**
- git-delta (better git diff)

**Development Utilities:**
- jq, yq (JSON/YAML processors)
- httpie (better curl)
- tldr (simplified man pages)
- glow (markdown renderer)
- slides (terminal presentations)

**Version Managers:**
- asdf (universal version manager)

**Environment & Build Tools:**
- autoenv (auto-load environments)
- watchman (file watching)
- cocoapods (iOS dependencies)
- stripe (Stripe CLI)
- oauth2l (OAuth2 CLI)

**Media Processing:**
- imagemagick
- ffmpeg

**Databases:**
- postgresql@14 (in addition to @15)
- redis

**GUI Applications (Casks):**
- wezterm, iterm2 (terminals)
- chromium, firefox (browsers)
- font-hack-nerd-font
- hiddenbar (menu bar manager)
- keka (archive manager)
- vlc (media player)
- postman (API testing)
- ngrok (tunneling)

### 2. Updated zsh/.zshrc

Added aliases for modern CLI tools:
- `cat` → `bat`
- `ls` → `eza`
- `ll` → `eza -lah`
- `lt` → `eza --tree`
- `df` → `duf`
- `du` → `dust`
- `ps` → `procs`
- `top` → `btop`

Added git-delta configuration:
- `GIT_PAGER='delta'`

### 3. Updated git/.gitconfig

Added git-delta configuration for beautiful diffs:
- Core pager set to delta
- Interactive diff filter
- Side-by-side view enabled
- Line numbers enabled
- Navigation shortcuts (n/N)
- Improved merge conflict style
- Color moved code detection

### 4. Added Missing Files to Repository

- `config/.config/dotfiles/theme.sh` - Central theme configuration (now tracked)
- `bin/theme` - Theme switcher script (already tracked)

### 5. Updated install.sh

Added `bin` to the stow command to ensure custom scripts are symlinked.

### 6. Updated README.md

Completely reorganized and expanded the tool documentation with proper categorization:
- Essential Tools
- Modern CLI Replacements
- Development Utilities
- Version Managers
- Development Tools
- Databases
- GUI Applications

## Tools to Remove

See `CLEANUP.md` for a list of tools that can be safely removed:
- skhd, yabai (window management - not using)
- fnm (duplicate of nvm)
- alt-tab, amethyst, raycast (not using)
- syncthing, yt-dlp (not using)
- eza via cargo (now using brew version)

## System State

Your dotfiles repo now accurately represents your system configuration. A fresh macOS installation can be fully restored by:

1. Running `./bootstrap.sh` to install all tools
2. Running `./install.sh` to symlink all configurations
3. Creating `~/.zshrc.local` for machine-specific settings
4. Creating `~/.gitconfig.local` for git secrets

## Next Steps

1. Review `CLEANUP.md` and remove unused tools when convenient
2. Test the installation on a fresh system (or in a VM) to verify completeness
3. Consider adding any project-specific tools to a separate documentation file
4. Set up asdf with your preferred language versions

## Notes

- All version managers (asdf, pyenv, rbenv, nvm) are now documented
- Both PostgreSQL 14 and 15 are kept (as requested)
- Redis is included in bootstrap
- JetBrains IDE shortcuts in ~/bin are kept separate (auto-generated)
- All GUI apps are now tracked via Homebrew casks
