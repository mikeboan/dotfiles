# Removed plugins ledger

Kills from the 2026-07 minimalism overhaul. Every config is recoverable from
checkpoint commit `ed1d492`:

```
git show ed1d492:nvim/.config/nvim/lua/plugins/<file>
```

| Plugin | Was in | Why removed |
|---|---|---|
| nvim-dap, nvim-dap-ui, nvim-dap-virtual-text, mason-nvim-dap, nvim-dap-python | debugging.lua | Unused; most IDE-chasing stack in the config |
| neotest, neotest-python, nvim-nio | testing.lua | Tests run from a tmux pane |
| neogit | git.lua | Fugitive is the git UI; one tool per job |
| octo.nvim | github.lua | gh CLI covers PRs terminal-first |
| markdown-preview.nvim, live-preview.nvim, image.nvim, diagram.nvim | markdown.lua | render-markdown suffices; drops imagemagick/mermaid-cli deps |
| refactoring.nvim | refactoring.lua | Unused |
| neo-tree.nvim (+nui.nvim) | filetree.lua | oil.nvim (`-`) is the file UI; yazi for rich browsing |
| barbar.nvim | tabline.lua | No tabline — navigate by harpoon/picker |
| nvim-scrollbar, nvim-hlslens | scrollbar.lua | Visual chrome |
| persistence.nvim | session.lua | tmux/sesh is the session layer |
| lsp_lines.nvim | lsp.lua | Archived upstream; nvim 0.11 native virtual_lines (`<leader>tl`) |
| Comment.nvim | editor.lua | Native gc/gcc since nvim 0.10 |
| trouble.nvim | editor.lua | fzf-lua diagnostics + native quickfix |
| indent-blankline.nvim | editor.lua | Visual chrome |
| no-neck-pain.nvim | editor.lua | Unused |

LSP servers dropped from Mason: angularls (no Angular work), yamlls, marksman.

Non-nvim removals in the same overhaul (see commit history): tmuxinator,
aerospace, iterm2 cask, theme switcher machinery, oh-my-zsh, nvm.

## 2026-08 — LazyVim migration

The hand-rolled config was deleted wholesale and replaced with LazyVim.
Recoverable from commit `0e4c98a`:

```
git show 0e4c98a:nvim/.config/nvim/lua/plugins/<file>
```

Dropped because LazyVim (core or an extra) already does it:

| Plugin | Was in | Replaced by |
|---|---|---|
| conform.nvim (hand-configured) | formatting.lua | LazyVim core conform + `formatting.prettier` extra |
| mason.nvim, mason-lspconfig, nvim-lspconfig wiring | lsp.lua | LazyVim core LSP + `lang.*` extras |
| vim-fugitive, vim-rhubarb | git.lua | lazygit (`<leader>gg`), snacks.gitbrowse (`<leader>gY`), gitsigns |
| fzf-lua | picker.lua | snacks.picker (`<leader>f` find / `<leader>s` search) |
| oil.nvim | navigation.lua | mini.files (`<leader>e`), `use_as_default_explorer` |
| lualine.nvim (hand-themed) | statusline.lua | LazyVim's lualine config |
| which-key.nvim (hand-configured) | keybindings.lua | LazyVim's which-key config |
| nvim-treesitter(-textobjects) hand-wiring | treesitter.lua | LazyVim core treesitter + mini.ai textobjects |
| mini.pairs, mini.surround, mini.icons, todo-comments, flash, render-markdown, gitsigns, blink.cmp, treesitter-context, vim-illuminate, harpoon | various | Same plugins, LazyVim-managed |

Dropped outright:

| Plugin | Was in | Why removed |
|---|---|---|
| nvim-ufo, promise-async | folding.lua | nvim 0.11 native LSP/treesitter `foldexpr`, which LazyVim wires up |
| multicursor.nvim | multicursor.lua | LSP rename + `inc-rename` extra + `:s` cover it |
| fidget.nvim | feedback.lua | snacks.notifier reports LSP progress |
| onedark.nvim | colorscheme.lua | IntelliJ now runs IdeaVim, not a nested nvim |

Kept as custom specs on top of LazyVim (`lua/plugins/`): diffview (git's
mergetool, see `~/.gitconfig`), undotree, flatten.nvim, vim-sleuth,
vim-tmux-navigator.

Disabled in LazyVim: noice.nvim (native cmdline/messages), snacks.explorer
(mini.files instead).
