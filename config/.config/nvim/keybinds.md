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
| `<C-h>` | Normal | Move focus to the left window | keybinds.lua |
| `<C-l>` | Normal | Move focus to the right window | keybinds.lua |
| `<C-j>` | Normal | Move focus to the lower window | keybinds.lua |
| `<C-k>` | Normal | Move focus to the upper window | keybinds.lua |
| `<leader>wv` | Normal | Split vertical | keybinds.lua |
| `<leader>ws` | Normal | Split horizontal | keybinds.lua |
| `<leader>wo` | Normal | Close all splits except current | keybinds.lua |
| `<leader>wd` | Normal | Delete window | keybinds.lua |
| `<leader>wh` | Normal | Decrease window width | keybinds.lua |
| `<leader>wj` | Normal | Increase window height | keybinds.lua |
| `<leader>wk` | Normal | Decrease window height | keybinds.lua |
| `<leader>wl` | Normal | Increase window width | keybinds.lua |
| `<leader>w=` | Normal | Equalize window sizes | keybinds.lua |
| `<leader>-` | Normal | Split window below | keybinds.lua |
| `<leader>\|` | Normal | Split window right | keybinds.lua |

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

## Search (fzf-lua)

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>sf` | Normal | [S]earch [F]iles | navigation.lua |
| `<leader>sg` | Normal | [S]earch by [G]rep | navigation.lua |
| `<leader>sw` | Normal | [S]earch current [W]ord | navigation.lua |
| `<leader>s/` | Normal | [S]earch [/] in current buffer | navigation.lua |
| `<leader>/` | Normal | Fuzzily search in current buffer | navigation.lua |
| `<leader>s.` | Normal | [S]earch Recent Files | navigation.lua |
| `<leader>sh` | Normal | [S]earch [H]elp | navigation.lua |
| `<leader>sk` | Normal | [S]earch [K]eymaps | navigation.lua |
| `<leader>ss` | Normal | [S]earch [S]elect fzf-lua | navigation.lua |
| `<leader>sr` | Normal | [S]earch [R]esume | navigation.lua |
| `<leader>sn` | Normal | [S]earch [N]eovim files | navigation.lua |
| `<leader>sd` | Normal | [S]earch [D]efinitions (LSP) | navigation.lua |
| `<leader>sR` | Normal | [S]earch [R]eferences (LSP) | navigation.lua |
| `<leader>si` | Normal | [S]earch [I]mplementations (LSP) | navigation.lua |
| `<leader>st` | Normal | [S]earch [T]ype Definitions (LSP) | navigation.lua |
| `<leader>sD` | Normal | [S]earch [D]iagnostics in document | navigation.lua |
| `<leader>sW` | Normal | [S]earch diagnostics in [W]orkspace | navigation.lua |
| `<leader><leader>` | Normal | Find existing buffers | navigation.lua |

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

## GitHub & Pull Requests (Octo.nvim)

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>gpl` | Normal | List PRs | git.lua (octo) |
| `<leader>gpc` | Normal | Create PR | git.lua (octo) |
| `<leader>gpo` | Normal | Checkout PR | git.lua (octo) |
| `<leader>gpr` | Normal | Start PR review | git.lua (octo) |
| `<leader>gps` | Normal | PR checks (CI status) | git.lua (octo) |
| `<leader>gpm` | Normal | Merge PR | git.lua (octo) |
| `<leader>gil` | Normal | List issues | git.lua (octo) |
| `<leader>gic` | Normal | Create issue | git.lua (octo) |
| `<leader>gio` | Normal | Close issue | git.lua (octo) |
| `<leader>grs` | Normal | Review start | git.lua (octo) |
| `<leader>grc` | Normal | Review commit | git.lua (octo) |
| `<leader>gra` | Normal | Review approve | git.lua (octo) |
| `<leader>grr` | Normal | Review request changes | git.lua (octo) |
| `<leader>gss` | Normal | Search issues/PRs | git.lua (octo) |

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

## Rails Navigation (Ruby files only)

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>ra` | Normal | Rails alternate file (test/implementation) | ruby.lua |
| `<leader>rr` | Normal | Rails related file | ruby.lua |
| `<leader>rm` | Normal | Rails open model | ruby.lua |
| `<leader>rc` | Normal | Rails open controller | ruby.lua |
| `<leader>rv` | Normal | Rails open view | ruby.lua |
| `<leader>rd` | Normal | Rails open migration | ruby.lua |
| `<leader>rs` | Normal | Rails open schema | ruby.lua |

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

## Refactoring

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>Re` | Visual | Extract function | refactoring.lua |
| `<leader>Rf` | Visual | Extract function to file | refactoring.lua |
| `<leader>Rv` | Visual | Extract variable | refactoring.lua |
| `<leader>Rc` | Visual | Extract constant (refactor menu) | refactoring.lua |
| `<leader>Ri` | Normal/Visual | Inline variable | refactoring.lua |
| `<leader>RI` | Normal | Inline function | refactoring.lua |
| `<leader>Rb` | Normal | Extract block | refactoring.lua |
| `<leader>Rbf` | Normal | Extract block to file | refactoring.lua |
| `<leader>Rq` | Normal/Visual | Refactoring menu | refactoring.lua |

## Testing (Neotest & Coverage)

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>t` | Normal | Run nearest test | testing.lua |
| `<leader>T` | Normal | Run file tests | testing.lua |
| `<leader>ta` | Normal | Run all tests / test suite | keybinds.lua, testing.lua |
| `<leader>l` | Normal | Run last test | testing.lua |
| `<leader>tv` | Normal | Visit next failed test | testing.lua |
| `<leader>ts` | Normal | Toggle test summary | testing.lua |
| `<leader>to` | Normal | Show test output | testing.lua |
| `<leader>tO` | Normal | Toggle test output panel | testing.lua |
| `<leader>td` | Normal | Debug nearest test | testing.lua |
| `<leader>tx` | Normal | Stop test | testing.lua |
| `<leader>tw` | Normal | Toggle watch mode | testing.lua |
| `<leader>tc` | Normal | Show test coverage | testing.lua |
| `<leader>tC` | Normal | Toggle coverage display | testing.lua |
| `<leader>tcc` | Normal | Clear coverage | testing.lua |

## AI Code Assistance (codecompanion.nvim)

### Core Operations

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>aa` | Normal/Visual | Toggle AI chat | ai.lua |
| `<leader>ac` | Normal/Visual | New AI chat | ai.lua |
| `<leader>ai` | Normal/Visual | Inline AI actions | ai.lua |
| `<leader>at` | Normal/Visual | AI actions menu | ai.lua |

### Context Management

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>ab` | Normal | Add buffer to AI context | ai.lua |
| `<leader>ad` | Normal | Add diagnostics to AI context | ai.lua |

### Git Workflow

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>agg` | Normal | Generate git commit message | ai.lua |
| `<leader>agp` | Normal | Generate PR description | ai.lua |

### Testing Workflow

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>att` | Normal/Visual | Generate tests for code | ai.lua |
| `<leader>ate` | Normal | Explain test failure | ai.lua |

### Code Review & Documentation

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>arc` | Normal/Visual | AI code review suggestions | ai.lua |
| `<leader>ard` | Normal/Visual | Generate documentation | ai.lua |
| `<leader>are` | Normal/Visual | Explain code | ai.lua |

### Refactoring

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>ars` | Normal/Visual | Suggest refactoring improvements | ai.lua |

**Note**: AI namespace uses `<leader>a` (test all moved to `<leader>ta`)

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

## Markdown & Obsidian

### Markdown Rendering

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>mr` | Normal | Toggle Markdown Rendering | keybinds.lua:157 |
| `<leader>me` | Normal | Enable Markdown Rendering | keybinds.lua:158 |
| `<leader>md` | Normal | Disable Markdown Rendering | keybinds.lua:159 |

### Obsidian Vault

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>on` | Normal | [O]bsidian [N]otes - Quick switch | writing.lua:82 |
| `<leader>os` | Normal | [O]bsidian [S]earch notes | writing.lua:84 |
| `<leader>oc` | Normal | [O]bsidian [C]reate note | writing.lua:86 |
| `<leader>od` | Normal | [O]bsidian [D]aily note | writing.lua:88 |
| `<leader>oo` | Normal | [O]bsidian [O]pen in app | writing.lua:90 |
| `gf` | Normal (markdown) | Follow Obsidian link | writing.lua:92 |
| `<leader>ob` | Normal | [O]bsidian [B]acklinks | writing.lua:94 |
| `<leader>ol` | Visual | [O]bsidian [L]ink from selection | writing.lua:96 |
| `<leader>oL` | Visual | [O]bsidian [L]ink new note | writing.lua:98 |
| `<leader>ot` | Normal | [O]bsidian [T]emplate | writing.lua:100 |

## Inspection & Debugging

| Keybind | Mode | Description | File |
|---------|------|-------------|------|
| `<leader>ui` | Normal | Inspect Position | keybinds.lua:143 |
| `<leader>uI` | Normal | Inspect Tree | keybinds.lua:144 |

## Which-Key Groups

The following leader key groups are defined for organization:

- `<leader>s` → `[S]earch` group (fzf-lua fuzzy finding)
- `<leader>g` → `[g]it` group
- `<leader>c` → `[C]ode` group
- `<leader>R` → `[R]efactor` group
- `<leader>D` → `[D]ocumentation` group
- `<leader>w` → `[W]indow/Split` group
- `<leader>e` → `[E]xplorer` group
- `<leader>t` → `[t]est` group
- `<leader>a` → `[a]i` group
- `<leader>b` → `[b]ookmarks` group
- `<leader>o` → `[o]pen` group
- `<leader>h` → `[h]unk (git)` group
- `<leader>d` → `[d]ebug` group
- `<leader>r` → `[r]eplace` group
- `<leader>x` → `[x] diagnostics` group
- `<leader>u` → `[u]i` group

---

*Generated from Neovim configuration analysis*
