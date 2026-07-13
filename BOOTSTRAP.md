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

Keymap lives on branch `mike` of `~/qmk_firmware` (based on ZSA's `firmware25`):
the `mike` keymap (force-added past QMK's keymap gitignore), the `zsa/defaults`
module enable in `reva/keyboard.json`, and `modules/getreuer` as a submodule.

Both branches are pushed to the fork: `github.com/mikeboan/qmk_firmware`.
bootstrap.sh clones it via `qmk setup mikeboan/qmk_firmware -b mike`.

- [ ] Verify the clone: `ls ~/qmk_firmware/keyboards/zsa/moonlander/keymaps/mike`
- [ ] `git checkout mike && git submodule update --init modules/getreuer`
- [ ] Build + flash: `qmk flash -kb zsa/moonlander/reva -km mike`

## macOS settings

- [ ] Key repeat: System Settings → Keyboard → fastest repeat, shortest delay
- [ ] Remap Caps Lock if not handled by Moonlander
- [ ] Grant kitty/terminal Full Disk Access if needed

## Sanity checks

- [ ] New terminal: starship prompt, `gst` works, `z <dir>` works
- [ ] `nvim`: `:checkhealth`, `:Lazy` (plugins auto-install on first run)
- [ ] tmux: `prefix+T` opens the sesh picker
