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
