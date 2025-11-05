# Neovim Keybinds Reference

## Basic Navigation & Editor

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader><Esc>` | Normal | Clear highlights on search | keybinds.lua:4 |
| `<Esc><Esc>` | Terminal | Exit terminal mode | keybinds.lua:7 |
| `<Tab>` | Normal | Next buffer | keybinds.lua:10 |
| `<S-Tab>` | Normal | Previous buffer | keybinds.lua:11 |
| `q` | Normal | Close help buffers | autocmd.lua:6 |

## Window Management

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<C-h>` | Normal | Move focus to the left window | keybinds.lua:14 |
| `<C-l>` | Normal | Move focus to the right window | keybinds.lua:15 |
| `<C-j>` | Normal | Move focus to the lower window | keybinds.lua:16 |
| `<C-k>` | Normal | Move focus to the upper window | keybinds.lua:17 |
| `<C-Up>` | Normal | Increase window height | keybinds.lua:19 |
| `<C-Down>` | Normal | Decrease window height | keybinds.lua:20 |
| `<C-Left>` | Normal | Decrease window width | keybinds.lua:21 |
| `<C-Right>` | Normal | Increase window width | keybinds.lua:22 |
| `<leader>-` | Normal | Split Window Below | keybinds.lua:25 |
| `<leader>\|` | Normal | Split Window Right | keybinds.lua:26 |
| `<leader>wd` | Normal | Delete Window | keybinds.lua:27 |

## Visual Mode

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<` | Visual | Restore visual selection after indenting left | keybinds.lua:30 |
| `>` | Visual | Restore visual selection after indenting right | keybinds.lua:31 |

## Comments & File Operations

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `gco` | Normal | Add comment line below | keybinds.lua:34 |
| `gcO` | Normal | Add comment line above | keybinds.lua:35 |
| `<leader>fn` | Normal | New File | keybinds.lua:38 |

## Diagnostics

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>q` | Normal | Open diagnostic Location list | keybinds.lua:11 / lsp.lua:91 |
| `<leader>Q` | Normal | Open diagnostic Quickfix list | keybinds.lua:12 / lsp.lua:92 |
| `[d` | Normal | Previous Diagnostic | keybinds.lua:13 / lsp.lua:93 |
| `]d` | Normal | Next Diagnostic | keybinds.lua:14 / lsp.lua:94 |
| `<leader>cd` | Normal | Line Diagnostics | lsp.lua:95 |
| `]e` | Normal | Next Error | keybinds.lua:46 |
| `[e` | Normal | Previous Error | keybinds.lua:47 |
| `]w` | Normal | Next Warning | keybinds.lua:48 |
| `[w` | Normal | Previous Warning | keybinds.lua:49 |

## Lists & Navigation

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>xl` | Normal | Toggle Location List | keybinds.lua:52 |
| `<leader>xq` | Normal | Toggle Quickfix List | keybinds.lua:53 |
| `[q` | Normal | Previous Quickfix | keybinds.lua:54 |
| `]q` | Normal | Next Quickfix | keybinds.lua:55 |

## Formatting

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>cf` | Normal/Visual | Force format | keybinds.lua:58 |
| `<leader>f` | Normal/Visual | Format buffer | formatting.lua:25 |

## Telescope Search

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>sh` | Normal | [S]earch [H]elp | telescope.lua:15 |
| `<leader>sk` | Normal | [S]earch [K]eymaps | telescope.lua:16 |
| `<leader>sf` | Normal | [S]earch [F]iles | telescope.lua:17 |
| `<leader>ss` | Normal | [S]earch [S]elect Telescope | telescope.lua:18 |
| `<leader>sw` | Normal | [S]earch current [W]ord | telescope.lua:19 |
| `<leader>sg` | Normal | [S]earch by [G]rep | telescope.lua:20 |
| `<leader>sD` | Normal | [S]earch [D]iagnostics | telescope.lua:21 |
| `<leader>sr` | Normal | [S]earch [R]esume | telescope.lua:22 |
| `<leader>s.` | Normal | [S]earch Recent Files | telescope.lua:23 |
| `<leader><leader>` | Normal | Find existing buffers | telescope.lua:24 |
| `<leader>/` | Normal | Fuzzily search in current buffer | telescope.lua:31 |
| `<leader>s/` | Normal | [S]earch [/] in Open Files | telescope.lua:37 |
| `<leader>sn` | Normal | [S]earch [N]eovim files | telescope.lua:49 |

## LSP Navigation

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `gd` | Normal | [G]oto [D]efinition | lsp.lua:35 |
| `gr` | Normal | [G]oto [R]eferences | lsp.lua:36 |
| `gI` | Normal | [G]oto [I]mplementation | lsp.lua:37 |
| `gD` | Normal | [G]oto [D]eclaration | lsp.lua:38 |
| `<leader>D` | Normal | Type [D]efinition | lsp.lua:39 |
| `<leader>ds` | Normal | [D]ocument [S]ymbols | lsp.lua:40 |
| `<leader>ws` | Normal | [W]orkspace [S]ymbols | lsp.lua:41 |

## LSP Documentation & Help

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `K` | Normal | Hover Documentation | lsp.lua:79 |
| `gK` | Normal | Signature Help | lsp.lua:80 |

## LSP Code Actions

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>rn` | Normal | [R]e[n]ame | lsp.lua:84 |
| `<leader>ca` | Normal/Visual | [C]ode [A]ction | lsp.lua:83 |
| `<leader>th` | Normal | Toggle Inlay [H]ints | lsp.lua:113 |

## Completion (Insert Mode)

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<C-b>` | Insert | Scroll docs backward | completion.lua:68 |
| `<C-f>` | Insert | Scroll docs forward | completion.lua:69 |
| `<CR>` | Insert | Confirm completion | completion.lua:70 |
| `<Tab>` | Insert | Select next item | completion.lua:71 |
| `<S-Tab>` | Insert | Select previous item | completion.lua:72 |
| `<C-Space>` | Insert | Manually trigger completion | completion.lua:81 |
| `<C-l>` | Insert/Select | Expand or jump forward in snippet | completion.lua:88 |
| `<C-h>` | Insert/Select | Jump backward in snippet | completion.lua:89 |

## Terminal

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<c-\>` | Normal | Toggle terminal | terminal.lua:31 |
| `<leader>td` | Normal | [T]oggle [D]jango dev server | terminal.lua:42 |
| `<leader>ta` | Normal | [T]oggle [A]ngular dev server | terminal.lua:48 |

## Git (GitSigns)

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `]c` | Normal | Jump to next git [c]hange | gitsigns.lua:23 |
| `[c` | Normal | Jump to previous git [c]hange | gitsigns.lua:24 |
| `<leader>hs` | Normal/Visual | git [s]tage hunk | gitsigns.lua:27 |
| `<leader>hr` | Normal/Visual | git [r]eset hunk | gitsigns.lua:28 |
| `<leader>hS` | Normal | git [S]tage buffer | gitsigns.lua:29 |
| `<leader>hu` | Normal | git [u]ndo stage hunk | gitsigns.lua:30 |
| `<leader>hR` | Normal | git [R]eset buffer | gitsigns.lua:31 |
| `<leader>hp` | Normal | git [p]review hunk | gitsigns.lua:32 |
| `<leader>hb` | Normal | git [b]lame line | gitsigns.lua:33 |
| `<leader>hd` | Normal | git [d]iff against index | gitsigns.lua:34 |
| `<leader>hD` | Normal | git [D]iff against last commit | gitsigns.lua:35 |
| `<leader>tb` | Normal | [T]oggle git show [b]lame line | gitsigns.lua:36 |
| `<leader>tD` | Normal | [T]oggle git show [D]eleted | gitsigns.lua:37 |

## Git (Neogit & LazyGit)

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>gg` | Normal | Lazygit (Root Dir) | keybinds.lua:125 |
| `<leader>gG` | Normal | Lazygit (cwd) | keybinds.lua:129 |
| `<leader>gc` | Normal | Open Neo[g]it in split | neogit.lua:10 |

## Git Conflicts

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `]x` | Normal | Next Git conflict | git-conflict.lua:8 |
| `[x` | Normal | Previous Git conflict | git-conflict.lua:9 |
| `<leader>co` | Normal | Choose ours | git-conflict.lua:10 |
| `<leader>ct` | Normal | Choose theirs | git-conflict.lua:11 |
| `<leader>cb` | Normal | Choose both | git-conflict.lua:12 |
| `<leader>c0` | Normal | Choose none | git-conflict.lua:13 |

## File Management

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>e` | Normal | [E]xplorer Toggle | nvim-tree.lua:12 |
| `-` | Normal | Open parent directory | oil.lua:7 |

## Session Management

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>sl` | Normal | [S]ession [L]oad | project.lua:66 |
| `<leader>ss` | Normal | [S]ession [S]ave | project.lua:67 |
| `<leader>sd` | Normal | [S]ession [D]elete | project.lua:68 |

## TreeSitter Text Objects

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `af` | Visual | @function.outer | treesitter.lua:67 |
| `if` | Visual | @function.inner | treesitter.lua:68 |
| `ac` | Visual | @class.outer | treesitter.lua:69 |
| `ic` | Visual | @class.inner | treesitter.lua:70 |
| `ab` | Visual | @block.outer | treesitter.lua:71 |
| `ib` | Visual | @block.inner | treesitter.lua:72 |
| `aa` | Visual | @parameter.outer | treesitter.lua:73 |
| `ia` | Visual | @parameter.inner | treesitter.lua:74 |

## TreeSitter Movement

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `]m` | Normal | Next function start | treesitter.lua:78 |
| `[m` | Normal | Previous function start | treesitter.lua:79 |
| `]c` | Normal | Next class start | treesitter.lua:80 |
| `[c` | Normal | Previous class start | treesitter.lua:81 |

## TreeSitter Swapping

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `]a` | Normal | Swap next parameter | treesitter.lua:85 |
| `[a` | Normal | Swap previous parameter | treesitter.lua:86 |

## Code Folding

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `zR` | Normal | Open all folds | ufo.lua:12 |
| `zM` | Normal | Close all folds | ufo.lua:13 |
| `zp` | Normal | Peek fold under cursor | ufo.lua:14 |

## Testing

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>t` | Normal | Run nearest test | vim-test.lua:20 |
| `<leader>T` | Normal | Run file tests | vim-test.lua:21 |
| `<leader>a` | Normal | Run all tests | vim-test.lua:22 |
| `<leader>l` | Normal | Run last test | vim-test.lua:23 |
| `<leader>g` | Normal | Visit test file | vim-test.lua:24 |

## Database

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>db` | Normal | Open Database UI | dadbod.lua:13 |
| `<leader>dt` | Normal | Toggle Database UI | dadbod.lua:14 |
| `<leader>df` | Normal | Find Database Buffer | dadbod.lua:15 |
| `<leader>dr` | Normal | Rename Database Buffer | dadbod.lua:16 |
| `<leader>dq` | Normal | Last Query Info | dadbod.lua:17 |
| `<leader>de` | Visual | Execute Selected SQL | dadbod.lua:18 |

## Search & Replace

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>rr` | Normal | [R]eplace: Toggle Spectre UI | spectre.lua:9 |
| `<leader>rw` | Normal | [R]eplace: Word in project | spectre.lua:10 |
| `<leader>rp` | Normal | [R]eplace: Current [P]ath/file | spectre.lua:11 |

## TMUX Integration

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<c-h>` | Normal | TmuxNavigateLeft | vim-tmux-navigator.lua:10 |
| `<c-j>` | Normal | TmuxNavigateDown | vim-tmux-navigator.lua:11 |
| `<c-k>` | Normal | TmuxNavigateUp | vim-tmux-navigator.lua:12 |
| `<c-l>` | Normal | TmuxNavigateRight | vim-tmux-navigator.lua:13 |
| `<c-\>` | Normal | TmuxNavigatePrevious | vim-tmux-navigator.lua:14 |

## Trouble Diagnostics

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>xx` | Normal | Diagnostics (Trouble) | trouble.lua:12 |
| `<leader>xX` | Normal | Buffer Diagnostics (Trouble) | trouble.lua:13 |
| `<leader>cs` | Normal | Symbols (Trouble) | trouble.lua:14 |
| `<leader>cl` | Normal | LSP Definitions/references (Trouble) | trouble.lua:15 |
| `<leader>xL` | Normal | Location List (Trouble) | trouble.lua:16 |
| `<leader>xQ` | Normal | Quickfix List (Trouble) | trouble.lua:17 |

## Task Management

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>oo` | Normal | [O]verseer [O]pen task list | overseer.lua:13 |
| `<leader>or` | Normal | [O]verseer [R]un task | overseer.lua:14 |

## Debugging

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<F5>` | Normal | Debug: Start/Continue | debug.lua:83 |
| `<F1>` | Normal | Debug: Step Into | debug.lua:84 |
| `<F2>` | Normal | Debug: Step Over | debug.lua:85 |
| `<F3>` | Normal | Debug: Step Out | debug.lua:86 |
| `<F7>` | Normal | Debug: Toggle UI | debug.lua:87 |
| `<leader>b` | Normal | Debug: Toggle Breakpoint | debug.lua:90 |
| `<leader>B` | Normal | Debug: Set Breakpoint | debug.lua:95 |

## Markdown

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>mr` | Normal | Toggle Markdown Rendering | keybinds.lua:157 |
| `<leader>me` | Normal | Enable Markdown Rendering | keybinds.lua:158 |
| `<leader>md` | Normal | Disable Markdown Rendering | keybinds.lua:159 |

## Inspection & Debugging

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>ui` | Normal | Inspect Position | keybinds.lua:143 |
| `<leader>uI` | Normal | Inspect Tree | keybinds.lua:144 |

## Which-Key Groups

The following leader key groups are defined for organization:

- `<leader>c` → `[C]ode` group (Normal/Visual)
- `<leader>d` → `[D]ocument` group  
- `<leader>r` → `[R]ename` group
- `<leader>s` → `[S]earch` group
- `<leader>w` → `[W]orkspace` group

---

*Generated from Neovim configuration analysis*
