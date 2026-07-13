# New Machine Checklist

`./bootstrap.sh` handles everything scriptable (Homebrew, Brewfile, fzf, Pi,
QMK clone). `./install.sh` stows the configs. This is the unscriptable rest,
in order:

## Auth & identity

- [ ] Sign into iCloud / App Store
- [ ] Generate SSH key, add to GitHub: `ssh-keygen -t ed25519 -C "mikeboan@gmail.com"`
- [ ] `gh auth login`
- [ ] GPG key if signing commits (import from old machine or generate)

## Machine-local config

- [ ] `cp ~/dotfiles/zsh/.zshrc.local.example ~/.zshrc.local` and customize
- [ ] `~/.gitconfig.local` for any machine-specific git identity/tokens

## Language runtimes

- [ ] `fnm install --lts && fnm default lts-latest` (or per-project via .nvmrc)
- [ ] Python per-project via `uv` (no global install needed)

## Keyboard (Moonlander)

- [ ] bootstrap cloned `zsa/qmk_firmware` on branch `firmware25` — verify the
      personal keymap exists: `ls ~/qmk_firmware/keyboards/zsa/moonlander/keymaps/mike`
      (if the branch only lived on the old machine, restore it from the fork/backup)
- [ ] Build + flash: `qmk flash -kb zsa/moonlander -km mike`

## macOS settings

- [ ] Key repeat: System Settings → Keyboard → fastest repeat, shortest delay
- [ ] Remap Caps Lock if not handled by Moonlander
- [ ] Grant kitty/terminal Full Disk Access if needed

## Sanity checks

- [ ] New terminal: starship prompt, `gst` works, `z <dir>` works
- [ ] `nvim`: `:checkhealth`, `:Lazy` (plugins auto-install on first run)
- [ ] tmux: `prefix+T` opens the sesh picker
