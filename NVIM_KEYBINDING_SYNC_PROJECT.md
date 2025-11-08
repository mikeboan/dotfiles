# Neovim/IdeaVim Keybinding Synchronization Project

**Date Started**: November 5, 2025
**Status**: Analysis Complete - Ready for Implementation
**Goal**: Create a seamless, consistent keybinding experience between IntelliJ IDEs (with IdeaVim) and Neovim/Tmux

---

## 📋 Project Objective

Synchronize keybindings across:
- **IntelliJ IDEs** with IdeaVim plugin (defined in `.ideavimrc`)
- **Neovim** configuration
- **Tmux** panel management

The goal is to make switching between IDE and terminal/nvim completely seamless, with muscle memory transferring perfectly between environments.

### Key Principle
**IdeaVim bindings should generally win in conflicts**, but user may want to change some ideavimrc patterns that don't feel right. This is a living decision that will be made during implementation.

---

## 🎯 User Context & Preferences

### Working Environment
- **Primary Shell**: zsh (with oh-my-zsh, starship prompt)
- **Terminal Emulators**: iTerm2 and WezTerm (learning WezTerm)
- **Terminal Multiplexer**: Tmux with vim-tmux-navigator plugin
- **Development Setup**: Uses tmux extensively to recreate IntelliJ's panel interface
- **Machine Count**: Primarily one machine, but portability is important for disaster recovery

### User Preferences Noted
1. Some aspects of ideavimrc may need revision - don't blindly copy everything
2. Wants time to think through the keybinding philosophy
3. Values muscle memory consistency across environments
4. Extensively uses tmux for panel management (mimicking IDE layout)

---

## 📁 File Locations

### Current Configuration Files
```
~/dotfiles/
├── vim/.ideavimrc                                    # IntelliJ IdeaVim config
├── config/.config/nvim/
│   ├── init.lua                                      # Nvim entry point
│   ├── lua/mike-custom/
│   │   ├── init.lua                                  # Loads all modules
│   │   ├── keybinds.lua                             # Main keybindings file
│   │   └── config/                                   # Plugin-specific configs
│   │       ├── completion.lua                        # nvim-cmp keybinds
│   │       ├── git.lua                               # Git plugin keybinds
│   │       ├── navigation.lua                        # Telescope, etc.
│   │       ├── terminal.lua                          # Terminal keybinds
│   │       ├── testing.lua                           # Test runner keybinds
│   │       └── [other config files...]
│   └── KEYBINDINGS_ANALYSIS.md                      # Generated analysis document
└── tmux/.tmux.conf                                   # Tmux configuration
```

### Analysis Documents Created
- `/Users/mike/dotfiles/config/.config/nvim/KEYBINDINGS_ANALYSIS.md` - Complete nvim keybinding inventory
- `/Users/mike/dotfiles/NVIM_KEYBINDING_SYNC_PROJECT.md` - This project report

---

## 🔍 Analysis Findings

### IdeaVim Configuration Analysis

**File**: `vim/.ideavimrc` (527 lines)

#### Organization Philosophy
IdeaVim uses a **hierarchical prefix system** with logical groupings:

| Prefix | Category | Purpose |
|--------|----------|---------|
| `<leader>f` | **F**ind | File/symbol/action finding |
| `<leader>G` | **G**it | Git operations (capital G) |
| `<leader>R` | **R**efactor | Refactoring operations (capital R) |
| `<leader>D` | **D**ocumentation | Docs, params, type info (capital D) |
| `<leader>t` | **t**est | Testing operations |
| `<leader>w` | **w**indow | Window sizing/management |
| `<leader>T` | **T**ab | Tab navigation (capital T) |
| `<leader>s` | **s**plit | Split management |
| `<leader>e` | **e**xplorer | File explorer/tool windows |
| `<leader>o` | **o**pen | Open terminal/run/debug windows |
| `<leader>r` | **r**un | Run configurations |
| `<leader>d` | **d**ebug | Debugger controls |
| `<leader>c` | **c**ode | Code actions |
| `<leader>b` | **b**ookmarks | Bookmark management |

#### Key Features in IdeaVim
1. **Which-Key Integration** - Shows keybinding hints
2. **Plugin Emulation**: surround, commentary, argtextobj, ReplaceWithRegister, exchange, highlightedyank, NERDTree
3. **Quick Escape**: `jj` and `jk` → Esc
4. **Popup Navigation**: `<C-j>/<C-k>` in insert mode for completion
5. **Multiple Cursors**: `<C-n>`, `<C-p>`, `<C-S-n>`
6. **Move Lines**: `<A-j>/<A-k>` to move lines up/down
7. **Quality of Life**: Center screen after jumps, Y yanks to EOL, x doesn't yank, visual paste doesn't yank
8. **Method Navigation**: `[[` and `]]` for method up/down
9. **Zen Mode**: `<leader>z` for distraction-free mode

#### Complete IdeaVim Keybinding Categories

**Insert Mode** (4 bindings)
- `jk`, `jj` → Esc (quick escape)
- `<C-j>`, `<C-k>` → Navigate popup menu

**Split Navigation** (4 bindings)
- `<C-h/j/k/l>` → Navigate between splits

**Split Management** (6 bindings)
- `<leader>sv` → Split vertical
- `<leader>sh` → Split horizontal
- `<leader>sc` → Close all splits
- `<leader>so` → Move to opposite group
- `<leader>w[hjkl]` → Stretch splits
- `<leader>wm` → Maximize editor
- `<leader>we` → Hide all windows

**Tab Navigation** (7 bindings)
- `<A-n>/<A-p>` → Next/Previous tab
- `<leader>Tn/Tp/Tc/To` → Tab operations

**File Finding** (11 bindings)
- `<leader>ff` → Find files (GotoFile)
- `<leader>fr` → Recent files
- `<leader>fc` → Recently changed files
- `<leader>fl` → Recent locations
- `<leader>fs` → Find symbols
- `<leader>fa` → Find actions
- `<leader>fg` → Grep in project
- `<leader>fu` → Find usages
- `<leader><leader>` → Quick access to recent files
- `<leader>q` → Close content

**Explorer** (5 bindings)
- `<leader>ee` → Toggle NERDTree
- `<leader>ef` → Find in NERDTree
- `<leader>ep` → Project tool window
- `<leader>es` → Structure tool window

**Code Navigation** (20+ bindings)
- `[[`, `]]` → Method up/down
- `[d`, `]d` → Previous/next diagnostic
- `[e`, `]e` → Previous/next error
- `[w`, `]w` → Previous/next warning
- `[c`, `]c` → Previous/next git change
- `[g`, `]g` → Previous/next git change (alternate)
- `]t` → Go to test
- `gd` → Go to declaration
- `gD` → Go to type declaration
- `gi` → Go to implementation
- `gr` → Show usages
- `gs` → Go to super method
- `gt` → Go to test
- `go` → Go to related
- `gb` → Back in history
- `gf` → Forward in history
- `<leader>gf/gF` → Back/forward in history

**Terminal** (6 bindings)
- `<leader>ot` → Open terminal
- `<leader>oT` → Open terminal here
- `<leader>tn/tp/tx` → Terminal tab navigation

**Run Window** (4 bindings)
- `<leader>or` → Open run window
- `<leader>rn/rl/rh/rx` → Run tab navigation

**Debug Window** (1 binding)
- `<leader>od` → Open debug window

**Testing** (8 bindings)
- `<leader>tt` → Run test class
- `<leader>tc` → Run test at cursor
- `<leader>tf` → Rerun failed tests
- `<leader>tl` → Rerun last test
- `<leader>td` → Debug test
- `<leader>tb` → Toggle breakpoint
- `<leader>ta` → Run all tests

**Run Configurations** (4 bindings)
- `<leader>rr` → Run
- `<leader>rd` → Debug
- `<leader>rc` → Choose configuration
- `<leader>rs` → Stop

**Debugger** (7 bindings)
- `<leader>dd` → Start debug
- `<leader>do` → Step over
- `<leader>di` → Step into
- `<leader>du` → Step out
- `<leader>dc` → Continue
- `<leader>dx` → Stop
- `<leader>db` → Toggle breakpoint

**Refactoring** (10 bindings)
- `<leader>Rr` → Rename
- `<leader>Rv` → Extract variable
- `<leader>Rc` → Extract constant
- `<leader>Rm` → Extract method
- `<leader>Ri` → Inline
- `<leader>Rs` → Change signature
- `<leader>Ro` → Optimize imports
- `<leader>Rf` → Format code
- `<leader>Rq` → Refactoring menu

**Code Actions** (9 bindings)
- `<leader>ca` → Code actions
- `<leader>cf` → Format
- `<leader>co` → Optimize imports
- `<leader>ci` → Implement methods
- `<leader>cg` → Generate
- `<leader>cs` → Surround with
- `<leader>cc` → Toggle comment

**Documentation** (9 bindings)
- `<leader>Dd` → Quick doc
- `<leader>Dp` → Parameter info
- `<leader>Dt` → Type info
- `<leader>De` → Error description
- `K` → Quick doc (standard vim mapping)
- `<leader>qd/qi/qp/qt/qe` → Quick info mappings

**Git/VCS** (10 bindings)
- `<leader>Gs` → Status
- `<leader>Gc` → Commit
- `<leader>Gp` → Push
- `<leader>Gu` → Update/Pull
- `<leader>Gb` → Branches
- `<leader>Gf` → Fetch
- `<leader>Gr` → Revert lines
- `<leader>Gh` → History
- `<leader>Ga` → Annotate/Blame
- `<leader>Gd` → Diff
- `<leader>Gt` → Git tool window

**Bookmarks** (4 bindings)
- `<leader>bt` → Toggle bookmark
- `<leader>bs` → Show bookmarks
- `<leader>bn/bp` → Next/previous bookmark

**Search & Replace** (5 bindings)
- `<leader>nh` → Clear highlighting
- `<leader>/` → Find
- `<leader>?` → Find in path
- `<leader>*` → Find word at caret
- `<leader>sr/sR` → Replace/Replace in path

**Folding** (7 bindings)
- `zc/zo/za/zC/zO/zR/zM` → Standard fold operations
- `<leader>zc/zo` → Collapse/expand all

**Multiple Cursors** (3 bindings)
- `<C-n>` → Select next occurrence
- `<C-p>` → Unselect previous
- `<C-S-n>` → Select all occurrences

**Productivity** (4 bindings)
- `<leader>z` → Zen mode
- `<leader>mm` → Show popup menu
- `<leader>mp` → Manage recent projects
- `<leader>w/:w` → Quick save
- `<leader>x/:x` → Quick save and quit

**Visual Enhancements** (6 bindings)
- `<` / `>` → Keep selection when indenting
- `<A-j>/<A-k>` → Move lines up/down

**Quality of Life** (12 bindings)
- `x` → Don't yank on delete
- `p` (visual) → Don't yank on paste
- `<C-d>/<C-u>/n/N/*/#/g*/g#` → Center screen after navigation
- `Y` → Yank to end of line

**Miscellaneous** (2 bindings)
- `<leader>sw` → Toggle soft wraps
- `<leader>?` → Show all mappings

**Total IdeaVim Keybindings**: ~175 bindings

---

### Neovim Configuration Analysis

**Primary Files**:
- `lua/mike-custom/keybinds.lua` - Main keybindings
- `lua/mike-custom/config/*.lua` - Plugin-specific keybindings

#### Organization Philosophy
Nvim uses a **mixed system** with some conventions from LazyVim/modern nvim configs:

| Prefix | Category | Purpose |
|--------|----------|---------|
| `<leader>s` | **S**earch | Telescope searches (conflicts with ideavim split!) |
| `<leader>g` | **g**it | Git operations (lowercase, conflicts with ideavim!) |
| `<leader>c` | **c**ode | Code actions (matches ideavim) |
| `<leader>d` | **d**ebug | Debug operations (matches ideavim) |
| `<leader>w` | **w**indow | Window operations |
| `<leader>x` | **x** | Quickfix/location lists |
| `<leader>t` | **t**est/toggle | Testing + toggle operations |
| `<leader>h` | **h**unk | Git hunks (gitsigns) |
| `<leader>r` | **r**eplace/rename | Spectre find/replace + LSP rename |

#### Current Nvim Keybindings by Category

**Window/Split Navigation** (4 bindings)
- `<C-h/j/k/l>` → Move focus between windows
- Works with vim-tmux-navigator!

**Window Resizing** (4 bindings)
- `<C-Up/Down/Left/Right>` → Resize windows
- DIFFERENT from ideavim's `<leader>w[hjkl]`

**Window Management** (3 bindings)
- `<leader>-` → Split horizontal
- `<leader>|` → Split vertical
- `<leader>wd` → Delete window
- DIFFERENT from ideavim's `<leader>s[vh]`

**Buffer Navigation** (2 bindings)
- `<Tab>` → Next buffer
- `<S-Tab>` → Previous buffer
- CONFLICTS with ideavim's tab navigation

**Diagnostics** (9 bindings)
- `[d`, `]d` → Prev/next diagnostic ✅ Matches ideavim
- `[e`, `]e` → Prev/next error ✅ Matches ideavim
- `[w`, `]w` → Prev/next warning ✅ Matches ideavim
- `<leader>cd` → Line diagnostics
- `<leader>q` → Diagnostic location list
- `<leader>Q` → Diagnostic quickfix list

**Telescope Search** (17+ bindings)
- Uses `<leader>s` prefix - CONFLICTS with ideavim split!
- `<leader>sf` → Find files (ideavim uses `<leader>ff`)
- `<leader>sg` → Live grep (ideavim uses `<leader>fg`)
- `<leader>sh/sk/sw/sD/sr/s.` → Various searches
- `<leader><leader>` → Buffers ✅ Matches ideavim

**LSP** (15+ bindings)
- `gd` → Go to definition ✅ Matches ideavim
- `gr` → Go to references ✅ Matches ideavim
- `gI` → Go to implementation (ideavim uses `gi`)
- `gD` → Go to declaration ✅ Matches ideavim
- `K` → Hover ✅ Matches ideavim
- `<leader>ca` → Code action ✅ Matches ideavim
- `<leader>rn` → Rename (ideavim uses `<leader>Rr`)
- `<leader>cf` → Format ✅ Matches ideavim

**Git** (20+ bindings)
- Uses `<leader>g` (lowercase) - ideavim uses `<leader>G` (capital)
- `]c`, `[c` → Next/prev git change ✅ Matches ideavim
- Git hunks use `<leader>h` prefix (gitsigns)
- `<leader>gg` → Lazygit
- Conflict resolution: `]x`, `[x`, `<leader>co/ct/cb/c0`

**Testing** (5 bindings)
- `<leader>t/T/a/l/g` → Test operations
- DIFFERENT from ideavim's more extensive `<leader>t[tcflda]`

**Debugging** (13 bindings)
- Function keys: `F5/F1/F2/F3/F7` ✅ Good!
- `<leader>d[cioUtbB]` → Debug operations
- Similar to ideavim but not identical

**Terminal** (4 bindings)
- `<Esc><Esc>` → Exit terminal mode
- `<C-\>` → Toggle terminal
- DIFFERENT from ideavim's `<leader>ot`

**File Management** (3 bindings)
- `<leader>fn` → New file
- `<leader>e` → Toggle nvim-tree ✅ Matches ideavim pattern
- `-` → Open oil.nvim

**Markdown** (3 bindings)
- `<leader>mr/me/md` → Markdown rendering

**Editor Enhancements**
- `<` / `>` → Keep selection ✅ Matches ideavim
- `gco/gcO` → Add comment above/below
- Text objects with treesitter
- Folding with UFO plugin

**Total Nvim Keybindings**: ~150+ bindings

---

### Tmux Configuration Analysis

**File**: `tmux/.tmux.conf`

#### Key Features
- **Prefix**: `C-a` (Caps Lock mapped to Ctrl via system preferences)
- **Pane Navigation**: `prefix + h/j/k/l` (vim-style)
- **Pane Resizing**: `prefix + H/J/K/L` (repeatable with `-r`)
- **Pane Splitting**:
  - `prefix + |` → Split horizontal (opens at current path)
  - `prefix + -` → Split vertical (opens at current path)
- **Copy Mode**: Vim-style (`v` to select, `y` to yank)
- **Plugins**:
  - `tmux-plugins/tpm` (plugin manager)
  - `christoomey/vim-tmux-navigator` ✅ Critical for seamless nvim/tmux navigation!
  - `vaaleyard/tmux-dotbar` (UI theme)
- **Quality of Life**:
  - Mouse enabled
  - Base index 1 (windows and panes)
  - Renumber windows on close
  - Escape time 0 (for smooth nvim usage)
  - 100k line history

#### Tmux-Vim-Navigator Integration
This plugin allows `<C-h/j/k/l>` to navigate seamlessly between:
- Vim/Nvim splits
- Tmux panes
- Works in **both** directions!

**Current Status**: ✅ Already working! The nvim config has the plugin configured.

---

## ⚠️ Key Conflicts & Issues

### Critical Conflicts (Breaks Muscle Memory)

| Area | IdeaVim | Nvim | Impact |
|------|---------|------|--------|
| **Split Management** | `<leader>s[vhco]` | Used for **Search**! | 🔴 HIGH - Can't create splits with muscle memory |
| **File Finding** | `<leader>f[frgsa]` | Uses `<leader>s[fg]` | 🔴 HIGH - Different prefix for core action |
| **Git** | `<leader>G` (capital) | `<leader>g` (lowercase) | 🟡 MEDIUM - Case sensitivity issue |
| **Tab Navigation** | `<A-n/p>`, `<leader>T` | `<Tab>/<S-Tab>` | 🔴 HIGH - Completely different keys |
| **Window Resize** | `<leader>w[hjkl]` | `<C-Up/Down/Left/Right>` | 🟡 MEDIUM - Different but both work |
| **Terminal** | `<leader>ot` | `<C-\>` | 🟡 MEDIUM - Different prefix |
| **Refactoring** | `<leader>R` namespace | Scattered | 🔴 HIGH - No unified refactor prefix |
| **Documentation** | `<leader>D` namespace | Missing | 🔴 HIGH - No quick doc access |
| **Rename** | `<leader>Rr` | `<leader>rn` | 🟡 MEDIUM - Different location |

### Missing Features in Nvim

| Feature | IdeaVim | Nvim | Plugin Needed |
|---------|---------|------|---------------|
| **Quick Escape** | `jj`/`jk` | ❌ | No plugin, just add mapping |
| **Multiple Cursors** | `<C-n/p>`, `<C-S-n>` | ❌ | vim-visual-multi or similar |
| **Move Lines** | `<A-j/k>` | ❌ | No plugin, just add mapping |
| **Zen Mode** | `<leader>z` | ❌ | zen-mode.nvim |
| **Bookmarks** | `<leader>b` prefix | ❌ | bookmarks.nvim or harpoon |
| **Method Navigation** | `[[`, `]]` | Partial | Already have treesitter, just remap |
| **Quality of Life** | Center after jumps, Y to EOL, etc. | Partial | Just add mappings |
| **Window Maximize** | `<leader>wm` | ❌ | Could use zen-mode or custom |
| **NERDTree-style** | IdeaVim emulates | nvim-tree (different keys) | Already have it, just remap |

### Plugin Mismatches

| Category | IdeaVim Emulation | Nvim Plugin | Status |
|----------|-------------------|-------------|--------|
| Surround | ✅ Built-in | ✅ nvim-surround (likely) | Check |
| Commentary | ✅ Built-in | ✅ Comment.nvim (likely) | Check |
| File Explorer | ✅ NERDTree emulation | ✅ nvim-tree | Different bindings |
| Git | ✅ Built-in VCS | ✅ gitsigns, neogit, lazygit | Good coverage |
| Which-Key | ✅ Built-in | ❓ Check if installed | Should add |
| Highlighted Yank | ✅ Built-in | ❓ Check if installed | Easy to add |

---

## 🎯 Proposed Solution Strategy

### Phase 1: Critical Conflict Resolution

1. **Reorganize Telescope Prefix**
   - Move from `<leader>s` → `<leader>f` (Find)
   - Free up `<leader>s` for splits

2. **Add Split Management**
   - Add `<leader>s[vhco]` bindings
   - Keep `<leader>-/|` as alternates if desired

3. **Fix Tab Navigation**
   - Add `<A-n/p>` for next/prev tab
   - Add `<leader>T` namespace
   - Decide: Keep `<Tab>/<S-Tab>` for buffers or reassign?

4. **Unify Git Prefix**
   - Change `<leader>g` → `<leader>G` (capital)
   - Keep lazygit at `<leader>gg` (double-tap, doesn't conflict)

5. **Add Refactoring Namespace**
   - Create `<leader>R` prefix
   - Map rename, extract, inline, etc.

6. **Add Documentation Namespace**
   - Create `<leader>D` prefix
   - Map quick doc, params, type info, error desc

### Phase 2: Add Missing Features

7. **Quick Escape** - `jj`/`jk` → `<Esc>`

8. **Move Lines** - `<A-j/k>` mappings

9. **Quality of Life**
   - Center after jumps (`<C-d>`, `<C-u>`, `n`, `N`, `*`, `#`)
   - `Y` yanks to EOL
   - `x` doesn't yank (delete to black hole)
   - Visual `p` doesn't yank

10. **Window Operations**
    - Add `<leader>w[hjkl]` for resizing
    - Add `<leader>wm` for maximize (zen-mode?)
    - Add `<leader>we` for hide all (if possible)

11. **Terminal Bindings**
    - Add `<leader>ot` for toggle terminal
    - Add `<leader>oT` for terminal here (current file's directory)

12. **Method Navigation**
    - Ensure `[[` and `]]` work for methods (treesitter text objects)

### Phase 3: Enhanced Plugins

13. **Multiple Cursors**
    - Research: vim-visual-multi vs other options
    - Add `<C-n>`, `<C-p>`, `<C-S-n>` bindings

14. **Bookmarks**
    - Research: bookmarks.nvim vs harpoon vs marks.nvim
    - Add `<leader>b` namespace

15. **Zen Mode**
    - Install zen-mode.nvim or similar
    - Add `<leader>z` binding

16. **Which-Key**
    - Verify installation
    - Configure groups to match ideavim prefixes

17. **Highlighted Yank**
    - Verify/add vim.highlight.on_yank

### Phase 4: Tmux Integration Enhancement

18. **Tmux-aware splits**
    - Consider making nvim create tmux panes instead of nvim splits
    - Or add separate bindings for tmux pane creation

19. **Tmux Session Management**
    - Add bindings to control tmuxinator from nvim
    - Consider FZF-based session switcher

20. **Terminal Strategy**
    - Decide: Nvim terminal buffers vs tmux panes?
    - Current: Uses toggleterm.nvim
    - Alternative: Use tmux panes for terminals

---

## 📊 Keybinding Mapping Table

### Priority 1: Must Fix for Muscle Memory

| Action | IdeaVim | Current Nvim | Proposed Nvim | Notes |
|--------|---------|--------------|---------------|-------|
| Find files | `<leader>ff` | `<leader>sf` | `<leader>ff` | Move from search prefix |
| Recent files | `<leader>fr` | `<leader>s.` | `<leader>fr` | Match ideavim |
| Grep/live grep | `<leader>fg` | `<leader>sg` | `<leader>fg` | Match ideavim |
| Find symbols | `<leader>fs` | ? | `<leader>fs` | Add |
| Find actions | `<leader>fa` | ? | `<leader>fa` | Telescope command palette? |
| Split vertical | `<leader>sv` | `<leader>\|` | `<leader>sv` | Primary binding |
| Split horizontal | `<leader>sh` | `<leader>-` | `<leader>sh` | Primary binding |
| Close all splits | `<leader>sc` | ? | `<leader>sc` | Add |
| Next tab | `<A-n>` | - | `<A-n>` | Add Alt binding |
| Prev tab | `<A-p>` | - | `<A-p>` | Add Alt binding |
| Tab namespace | `<leader>T*` | - | `<leader>T*` | Add namespace |
| Git status | `<leader>Gs` | `<leader>gs` | `<leader>Gs` | Capitalize |
| Git commit | `<leader>Gc` | ? | `<leader>Gc` | Add/remap |
| Git push | `<leader>Gp` | ? | `<leader>Gp` | Add/remap |
| Git branches | `<leader>Gb` | ? | `<leader>Gb` | Add/remap |
| Refactor rename | `<leader>Rr` | `<leader>rn` | `<leader>Rr` | New namespace |
| Extract variable | `<leader>Rv` | - | `<leader>Rv` | Add |
| Extract method | `<leader>Rm` | - | `<leader>Rm` | Add |
| Format code | `<leader>Rf` | `<leader>cf` | Both | Keep both |
| Quick doc | `<leader>Dd` | - | `<leader>Dd` | Add namespace |
| Parameter info | `<leader>Dp` | - | `<leader>Dp` | Add |
| Type info | `<leader>Dt` | - | `<leader>Dt` | Add |
| Open terminal | `<leader>ot` | `<C-\>` | `<leader>ot` | Remap primary |
| Window resize left | `<leader>wh` | `<C-Left>` | `<leader>wh` | Add, keep alternate |
| Window resize down | `<leader>wj` | `<C-Down>` | `<leader>wj` | Add, keep alternate |
| Window resize up | `<leader>wk` | `<C-Up>` | `<leader>wk` | Add, keep alternate |
| Window resize right | `<leader>wl` | `<C-Right>` | `<leader>wl` | Add, keep alternate |

### Priority 2: Nice to Have

| Action | IdeaVim | Current Nvim | Proposed Nvim | Notes |
|--------|---------|--------------|---------------|-------|
| Quick escape | `jj`, `jk` | - | `jj`, `jk` | Add both |
| Move line down | `<A-j>` | - | `<A-j>` | Add |
| Move line up | `<A-k>` | - | `<A-k>` | Add |
| Multiple cursors next | `<C-n>` | - | `<C-n>` | Need plugin |
| Multiple cursors prev | `<C-p>` | - | `<C-p>` | Need plugin |
| Select all occurrences | `<C-S-n>` | - | `<C-S-n>` | Need plugin |
| Zen mode | `<leader>z` | - | `<leader>z` | Need plugin |
| Bookmark toggle | `<leader>bt` | - | `<leader>bt` | Need plugin |
| Bookmark show | `<leader>bs` | - | `<leader>bs` | Need plugin |
| Bookmark next | `<leader>bn` | - | `<leader>bn` | Need plugin |
| Bookmark prev | `<leader>bp` | - | `<leader>bp` | Need plugin |
| Save | `<leader>w` | - | `<leader>w` | Add |
| Save & quit | `<leader>x` | - | `<leader>x` | Add |
| Method up | `[[` | Partial | `[[` | Verify treesitter |
| Method down | `]]` | Partial | `]]` | Verify treesitter |
| Maximize window | `<leader>wm` | - | `<leader>wm` | Zen-mode? |
| Center after C-d | `<C-d>` | - | `<C-d>zz` | Add |
| Center after C-u | `<C-u>` | - | `<C-u>zz` | Add |
| Center after n | `n` | - | `nzzzv` | Add |
| Center after N | `N` | - | `Nzzzv` | Add |
| Y to EOL | `Y` | - | `y$` | Add |
| x no yank | `x` | - | `"_x` | Add |
| Visual p no yank | `p` (visual) | - | `"_dP` | Add |

### Keep As-Is (Working Well)

| Action | IdeaVim | Nvim | Status |
|--------|---------|------|--------|
| Split navigation | `<C-h/j/k/l>` | `<C-h/j/k/l>` | ✅ Perfect with tmux-navigator |
| Go to definition | `gd` | `gd` | ✅ Match |
| Go to declaration | `gD` | `gD` | ✅ Match |
| Go to references | `gr` | `gr` | ✅ Match |
| Hover docs | `K` | `K` | ✅ Match |
| Code action | `<leader>ca` | `<leader>ca` | ✅ Match |
| Format | `<leader>cf` | `<leader>cf` | ✅ Match |
| Next diagnostic | `]d` | `]d` | ✅ Match |
| Prev diagnostic | `[d` | `[d` | ✅ Match |
| Next error | `]e` | `]e` | ✅ Match |
| Prev error | `[e` | `[e` | ✅ Match |
| Next warning | `]w` | `]w` | ✅ Match |
| Prev warning | `[w` | `[w` | ✅ Match |
| Next git change | `]c` | `]c` | ✅ Match |
| Prev git change | `[c` | `[c` | ✅ Match |
| Visual indent keep | `<` / `>` | `<` / `>` | ✅ Match |
| Debug continue | `<leader>dc` | `<leader>dc` | ✅ Match |
| Debug step over | `<leader>do` | `<leader>do` | ✅ Match |
| Debug step into | `<leader>di` | `<leader>di` | ✅ Match |
| Debug step out | `<leader>du` | `<leader>du` | ✅ Match |
| Debug breakpoint | `<leader>db` | `<leader>db` | ✅ Match |
| F5 Continue | `n/a` | `<F5>` | ✅ IDE-like |
| F1 Step into | `n/a` | `<F1>` | ✅ IDE-like |
| F2 Step over | `n/a` | `<F2>` | ✅ IDE-like |
| F3 Step out | `n/a` | `<F3>` | ✅ IDE-like |

---

## 🔌 Plugin Recommendations

### Critical (Need to Add)

1. **vim-visual-multi** or **nvim-multi-cursor**
   - For: Multiple cursor support (`<C-n>`, `<C-p>`, `<C-S-n>`)
   - Research both, choose one

2. **zen-mode.nvim** + **twilight.nvim**
   - For: Distraction-free coding (`<leader>z`)
   - Well-maintained, popular in nvim community

3. **which-key.nvim**
   - For: Showing keybinding hints (like IdeaVim)
   - Likely already installed? Verify

4. **bookmarks.nvim** OR **harpoon** OR **marks.nvim**
   - For: Bookmark management (`<leader>b` namespace)
   - Research which fits workflow best
   - Harpoon is more "project-local" quick-jump
   - bookmarks.nvim is more traditional
   - marks.nvim enhances vim's built-in marks

### Nice to Have

5. **vim-illuminate**
   - Automatically highlight word under cursor
   - Similar to IdeaVim's highlighting

6. **todo-comments.nvim**
   - Highlight TODO, FIXME, etc.
   - Adds telescope search for todos

### Already Have (Verify Config)

7. **nvim-treesitter** with textobjects
   - For: `[[`, `]]`, `af`, `if`, etc.
   - Already installed, verify text object config

8. **nvim-cmp**
   - For: Completion popup
   - Need to verify `<C-j>`/`<C-k>` navigation

9. **Comment.nvim** or similar
   - For: `gcc`, `gc` motions
   - Verify what's installed

10. **nvim-surround** or **mini.surround**
    - For: `cs'"`  operations
    - Verify what's installed

11. **vim-tmux-navigator**
    - ✅ Already working!
    - Critical for seamless nvim/tmux navigation

---

## 🤔 Questions for User (Decision Points)

### High Priority Decisions

1. **Tab vs Buffer Navigation**
   - IdeaVim uses `<A-n/p>` and `<leader>T` for tabs
   - Nvim uses `<Tab>/<S-Tab>` for buffers
   - In nvim, tabs are rarely used (buffers are preferred)
   - **Decision**: Should we:
     - A) Map `<A-n/p>` to buffer navigation (not tab navigation)?
     - B) Actually use nvim tabs and match ideavim exactly?
     - C) Keep both - `<Tab>` for buffers, `<A-n/p>` for tabs?

2. **Testing Keybindings**
   - IdeaVim: `<leader>tt/tc/tf/tl/td/ta`
   - Nvim: `<leader>t/T/a/l` (shorter, but different)
   - **Decision**: Which pattern do you prefer?

3. **Terminal Strategy**
   - Nvim currently uses toggleterm.nvim (floating terminal)
   - Could use tmux panes instead for "true IDE" experience
   - **Decision**:
     - A) Keep toggleterm with `<leader>ot` binding?
     - B) Make `<leader>ot` create a tmux pane instead?
     - C) Have both - `<leader>ot` for toggleterm, different binding for tmux?

4. **Window/Split Philosophy**
   - IdeaVim distinguishes "splits" vs "windows" (IDE concept)
   - Nvim just has "windows"
   - Tmux has "panes"
   - **Decision**: How should we think about the hierarchy?
     - Tmux panes for major layout (like IDE tool windows)
     - Nvim splits for editor splits only?

5. **File Explorer**
   - IdeaVim uses `<leader>ee` for NERDTree toggle
   - Nvim has nvim-tree on `<leader>e`
   - Also has oil.nvim on `-`
   - **Decision**:
     - A) Change to `<leader>ee` to match ideavim?
     - B) Keep `<leader>e` (simpler)?
     - C) Add both?

6. **Git Prefix Case**
   - IdeaVim uses `<leader>G` (capital) for git operations
   - Nvim uses `<leader>g` (lowercase)
   - Changing this affects muscle memory significantly
   - **Decision**:
     - A) Change to capital `G` to match ideavim?
     - B) Keep lowercase `g` (common in nvim)?
     - C) What about `<leader>gg` for lazygit (requires lowercase)?

7. **Multiple Cursor Plugin**
   - vim-visual-multi (most popular, most features, some complexity)
   - nvim-multi-cursor (newer, simpler, less features)
   - mini.surround's builtin (minimal)
   - **Decision**: Which to use?

8. **Bookmark Plugin**
   - harpoon - Quick project-local file jumping (4-5 files)
   - bookmarks.nvim - Traditional bookmarks with annotations
   - marks.nvim - Enhanced vim marks with UI
   - **Decision**: Which workflow fits best?

### Medium Priority Decisions

9. **Search/Replace Tool**
   - Currently using Spectre on `<leader>rr/rw/rp`
   - IdeaVim has simple find/replace on `<leader>sr/sR`
   - **Decision**: Keep Spectre bindings or change?

10. **Quickfix/Location List**
    - Nvim has `<leader>xq/xl` for toggling
    - IdeaVim has `<leader>q` for close content
    - **Decision**: Keep nvim pattern or simplify?

11. **Comment Keybindings**
    - IdeaVim: `<leader>cc` for toggle comment
    - Nvim: Typically `gcc` (from vim-commentary)
    - Also have `gco`/`gcO` for adding comment lines
    - **Decision**: Add `<leader>cc` as alias? Or keep `gcc`?

12. **Refactoring Actions**
    - IdeaVim has full `<leader>R` namespace
    - Nvim LSP has these but scattered
    - Need to map: Rename, Extract Variable, Extract Method, Inline, etc.
    - Some may not be available in all LSPs
    - **Decision**: Map all and let them fail gracefully? Or only map guaranteed ones?

---

## 📝 Implementation Checklist

### Phase 1: Analysis ✅ COMPLETE
- [x] Read and analyze ideavimrc keybindings
- [x] Explore nvim config structure and keybindings
- [x] Read and analyze tmux config
- [x] Compare ideavimrc vs nvim keybindings
- [x] Identify conflicts and missing features
- [x] Create comprehensive analysis documents
- [x] Identify required plugins

### Phase 2: User Decisions (NEXT)
- [ ] Review all decision points
- [ ] Choose tab/buffer navigation strategy
- [ ] Choose testing keybinding pattern
- [ ] Choose terminal strategy (toggleterm vs tmux)
- [ ] Choose window/split/pane philosophy
- [ ] Decide on Git prefix case (G vs g)
- [ ] Select multiple cursor plugin
- [ ] Select bookmark plugin
- [ ] Review and approve keybinding migration plan

### Phase 3: Implementation (FUTURE)
- [ ] Create backup of current nvim config
- [ ] Install required plugins
- [ ] Create new `keybinds-ide.lua` with migrated bindings
- [ ] Update existing config files as needed
- [ ] Configure which-key groups
- [ ] Test all bindings
- [ ] Document any ideavimrc changes needed
- [ ] Create cheat sheet for quick reference

### Phase 4: Refinement (FUTURE)
- [ ] Use for 1-2 weeks, note any issues
- [ ] Adjust based on real usage
- [ ] Fine-tune any conflicts
- [ ] Update documentation

---

## 📚 Reference Documents

1. **This Report**: `/Users/mike/dotfiles/NVIM_KEYBINDING_SYNC_PROJECT.md`
   - Complete project overview and analysis

2. **Nvim Keybinding Analysis**: `/Users/mike/dotfiles/config/.config/nvim/KEYBINDINGS_ANALYSIS.md`
   - Complete inventory of current nvim keybindings
   - Organized by category with tables

3. **Configuration Files**:
   - IdeaVim: `/Users/mike/dotfiles/vim/.ideavimrc`
   - Nvim Main: `/Users/mike/dotfiles/config/.config/nvim/lua/mike-custom/keybinds.lua`
   - Nvim Configs: `/Users/mike/dotfiles/config/.config/nvim/lua/mike-custom/config/*.lua`
   - Tmux: `/Users/mike/dotfiles/tmux/.tmux.conf`

---

## 🎯 Success Criteria

The project will be considered successful when:

1. ✅ **Muscle Memory Transfer**: Can switch between IntelliJ and Nvim without thinking about different bindings
2. ✅ **Core Actions Match**: All common actions (find, navigate, refactor, git, debug) use same keys
3. ✅ **No Conflicts**: No keybinding collisions that cause confusion
4. ✅ **Tmux Integration**: Seamless navigation between nvim splits and tmux panes
5. ✅ **IDE-like Experience**: Nvim+Tmux feels as cohesive as IntelliJ
6. ✅ **Documented**: Clear documentation of all bindings with which-key hints
7. ✅ **Quality of Life**: All the nice touches from ideavimrc work in nvim
8. ✅ **Terminal Workflow**: Terminal access is as smooth as IDE's terminal window

---

## 💭 Important Notes

### User Preferences & Philosophy
- User noted that some ideavimrc bindings may not be ideal and wants flexibility to revise
- Don't blindly copy everything - think through each decision
- User values muscle memory consistency but also ergonomics
- Extensive tmux usage for panel management (recreating IDE layout)

### Tmux-Vim-Navigator is Critical
- Already working and configured
- This is the foundation for seamless split/pane navigation
- Any changes must preserve `<C-h/j/k/l>` navigation

### Buffer vs Tab Paradigm
- IntelliJ uses "tabs" heavily (each file is a tab)
- Nvim community prefers "buffers" (tabs are for separate workspaces)
- This philosophical difference needs to be addressed
- Possible solution: Map both - `<Tab>` for buffers, `<A-n/p>` for buffers too

### Testing Workflow
- IdeaVim has extensive test bindings
- Nvim currently uses vim-test with simpler bindings
- May want to expand nvim test bindings to match

### Git Workflow
- Both configs have strong git integration
- IdeaVim uses capital `G`, nvim uses lowercase `g`
- Also have gitsigns for hunk operations (`<leader>h`)
- Need to unify the approach

---

## 🚀 Next Session Goals

When resuming tomorrow:

1. **Review this document** - Make sure everything is clear
2. **Make decisions** - Go through all decision points
3. **Prioritize** - Decide what to implement first
4. **Choose plugins** - Select which plugins to add
5. **Begin implementation** - Start creating the new keybinding config

Estimated time: 2-4 hours for implementation once decisions are made

---

## 📞 Contact & Collaboration

This is a personal project for Mike's dotfiles.

**Repository**: ~/dotfiles (not yet on GitHub)
**Current Date**: November 5, 2025
**Next Session**: November 6, 2025 (morning)

---

*End of Report*
