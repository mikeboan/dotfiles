# Neovim/IdeaVim Keybinding Sync - Implementation Summary

**Date**: November 6, 2025
**Status**: ✅ Implementation Complete - Ready for Testing

---

## 🎉 What We Accomplished

Successfully synchronized keybindings between IntelliJ's IdeaVim and Neovim to create a seamless muscle memory experience across both environments.

---

## 📋 Decisions Made

### 1. **Git Prefix**: Lowercase `<leader>g`
- Changed ideavimrc from capital `G` to lowercase `g`
- More ergonomic and matches nvim conventions
- `<leader>gg` for commit/lazygit

### 2. **File Explorer**: Simple `<leader>e`
- Changed ideavimrc from `<leader>ee` to `<leader>e`
- Faster, single-keypress toggle

### 3. **Buffer/Tab Navigation**: Buffers with `<A-n/p>`
- `<A-n>/<A-p>` now navigates buffers (not tabs)
- Keep `<Tab>/<S-Tab>` as alternates
- Nvim buffers = IntelliJ "tabs" conceptually

### 4. **Terminal**: Toggleterm with `<leader>ot`
- Keep toggleterm floating terminal
- Bound to `<leader>ot` to match ideavimrc

### 5. **Testing**: Simplified pattern (nvim-style)
- `<leader>t` - Run nearest test
- `<leader>T` - Run test file
- `<leader>a` - Run all tests
- `<leader>l` - Rerun last
- `<leader>tv` - Visit test file
- Changed ideavimrc to match this simpler pattern

### 6. **Window Resizing**: Use `<leader>w[hjkl]`
- Replaced arrow keys with vim-style hjkl under `<leader>w`
- More consistent with IDE approach

### 7. **Plugins Selected**:
- **Multiple cursors**: vim-visual-multi (enabled) + nvim-multi-cursor (disabled backup)
- **Zen mode**: zen-mode.nvim
- **Bookmarks**: marks.nvim

### 8. **Quality of Life**: All enabled
- `Y` yanks to end of line
- `x` deletes without yanking
- Visual `p` doesn't yank
- Auto-center after jumps (`<C-d>`, `<C-u>`, `n`, `N`, `*`, `#`)

---

## 🔧 Changes Made to Ideavimrc

**File**: `vim/.ideavimrc`

### Git Section (Capital G → lowercase g)
```vim
" Changed from <leader>G* to <leader>g*
<leader>gg → Commit (was <leader>Gc)
<leader>gs → Status (was <leader>Gs)
<leader>gp → Push (was <leader>Gp)
<leader>gu → Update (was <leader>Gu)
<leader>gb → Branches (was <leader>Gb)
<leader>gf → Fetch (was <leader>Gf)
<leader>gr → Revert (was <leader>Gr)
<leader>gh → History (was <leader>Gh)
<leader>ga → Annotate (was <leader>Ga)
<leader>gd → Diff (was <leader>Gd)
<leader>gt → Git tool window (was <leader>Gt)
```

### File Explorer
```vim
" Changed from <leader>ee to <leader>e
<leader>e → Toggle explorer (was <leader>ee)
```

### Testing (Simplified)
```vim
" Matched nvim's simpler pattern
<leader>t  → Run nearest test (was <leader>tc)
<leader>T  → Run test file (was <leader>tt)
<leader>a  → Run all tests (was <leader>ta)
<leader>l  → Rerun last (was <leader>tl)
<leader>tv → Visit test file (new)
<leader>tb → Toggle breakpoint (kept)
```

### Removed
- `<leader>gf/gF` for back/forward (redundant with `gb`/`gf`)
- Old `<leader>tc/tt/tf/td` test bindings

---

## 🔧 Changes Made to Nvim Config

### 1. **Added Plugins**

#### `editor.lua`
```lua
-- vim-visual-multi (multiple cursors)
<C-n>   → Select next occurrence
<C-p>   → Unselect previous occurrence
<C-S-n> → Select all occurrences

-- nvim-multi-cursor (alternative, disabled)
- Same keybindings, can enable to test
```

#### `ui.lua`
```lua
-- zen-mode.nvim (distraction-free coding)
<leader>z → Toggle zen mode
```

#### `navigation.lua`
```lua
-- marks.nvim (bookmark management)
<leader>bt → Toggle bookmark signs
<leader>bs → Show bookmarks
<leader>bn → Next bookmark
<leader>bp → Previous bookmark
]m/[m      → Next/prev mark
m,         → Set next available mark
m0         → Set bookmark
```

### 2. **Complete Keybindings Rewrite**

**File**: `lua/mike-custom/keybinds.lua` (backed up to `keybinds.lua.backup`)

#### New Keybindings Added

**Insert Mode**:
- `jj`, `jk` → Quick escape

**Quality of Life**:
- `Y` → Yank to end of line
- `x` → Delete without yanking
- Visual `p` → Paste without yanking
- `<C-d/u>`, `n`, `N`, `*`, `#`, `g*`, `g#` → Auto-center after jump

**Save/Quit**:
- `<leader>w` → Save file
- `<leader>x` → Save and quit

**Split Management** (IDE-style):
- `<leader>sv` → Split vertical
- `<leader>sh` → Split horizontal
- `<leader>sc` → Close all splits except current

**Window Resizing**:
- `<leader>wh/j/k/l` → Resize windows (vim-style)
- `<leader>w=` → Equalize window sizes

**Buffer Navigation**:
- `<A-n>/<A-p>` → Next/previous buffer
- `<leader>bd` → Delete buffer
- `<leader>bo` → Delete other buffers

**Move Lines**:
- `<A-j>/<A-k>` → Move lines/selection up/down

**Terminal**:
- `<leader>ot` → Open terminal (toggleterm)

**Testing**:
- `<leader>t` → Test nearest
- `<leader>T` → Test file
- `<leader>a` → Test suite
- `<leader>l` → Test last
- `<leader>tv` → Visit test file

### 3. **Updated Telescope Keybindings**

**File**: `lua/mike-custom/config/navigation.lua`

Changed prefix from `<leader>s` (Search) to `<leader>f` (Find):
```lua
<leader>ff → Find files (was <leader>sf)
<leader>fg → Find by grep (was <leader>sg)
<leader>fh → Find help (was <leader>sh)
<leader>fk → Find keymaps (was <leader>sk)
<leader>fw → Find word (was <leader>sw)
<leader>fd → Find diagnostics (was <leader>sD)
<leader>fr → Find resume (was <leader>sr)
<leader>f. → Find recent files (was <leader>s.)
<leader>f/ → Find in open files (was <leader>s/)
<leader>fn → Find in nvim config (was <leader>sn)

" LSP searches (telescope alternatives)
<leader>fd → Find definitions (was <leader>sd)
<leader>fR → Find references (was <leader>sr)
<leader>fi → Find implementations (was <leader>si)
<leader>ft → Find type definitions (was <leader>st)
```

### 4. **Updated Which-Key Groups**

**File**: `lua/mike-custom/config/navigation.lua`

Updated prefix groups to match IDE structure:
```lua
<leader>f → [F]ind
<leader>g → [g]it
<leader>c → [C]ode
<leader>R → [R]efactor
<leader>D → [D]ocumentation
<leader>w → [W]indow
<leader>s → [S]plit
<leader>e → [E]xplorer
<leader>t → [t]est
<leader>b → [b]ookmarks
<leader>o → [o]pen
<leader>h → [h]unk (git)
<leader>d → [d]ebug
<leader>r → [r]eplace
<leader>x → [x] diagnostics
<leader>u → [u]i
```

---

## 📁 Files Modified

### Ideavimrc
- `vim/.ideavimrc` - Updated git, explorer, and test bindings

### Nvim Config Files
- `lua/mike-custom/keybinds.lua` - Complete rewrite (backup saved)
- `lua/mike-custom/config/editor.lua` - Added multiple cursor plugins
- `lua/mike-custom/config/ui.lua` - Added zen-mode
- `lua/mike-custom/config/navigation.lua` - Added marks.nvim, updated telescope, updated which-key

### Backups Created
- `lua/mike-custom/keybinds.lua.backup` - Original keybindings file

---

## 🔑 Key Keybinding Reference

### Quick Escape
| Mode | Key | Action |
|------|-----|--------|
| Insert | `jj` or `jk` | Escape to normal mode |

### Window/Split Navigation (Seamless with Tmux)
| Mode | Key | Action |
|------|-----|--------|
| Normal | `<C-h/j/k/l>` | Navigate splits/tmux panes |

### Split Management
| Mode | Key | Action |
|------|-----|--------|
| Normal | `<leader>sv` | Split vertical |
| Normal | `<leader>sh` | Split horizontal |
| Normal | `<leader>sc` | Close all splits except current |
| Normal | `<leader>-` | Split horizontal (alternate) |
| Normal | `<leader>\|` | Split vertical (alternate) |

### Window Resizing
| Mode | Key | Action |
|------|-----|--------|
| Normal | `<leader>wh` | Decrease width |
| Normal | `<leader>wj` | Increase height |
| Normal | `<leader>wk` | Decrease height |
| Normal | `<leader>wl` | Increase width |
| Normal | `<leader>w=` | Equalize sizes |

### Buffer Navigation
| Mode | Key | Action |
|------|-----|--------|
| Normal | `<A-n>` | Next buffer |
| Normal | `<A-p>` | Previous buffer |
| Normal | `<Tab>` | Next buffer (alternate) |
| Normal | `<S-Tab>` | Previous buffer (alternate) |
| Normal | `<leader>bd` | Delete buffer |
| Normal | `<leader>bo` | Delete other buffers |

### File Finding (Telescope)
| Mode | Key | Action |
|------|-----|--------|
| Normal | `<leader>ff` | Find files |
| Normal | `<leader>fg` | Find by grep |
| Normal | `<leader>fr` | Find recent files |
| Normal | `<leader>f.` | Find recent files (alternate) |
| Normal | `<leader>fw` | Find word under cursor |
| Normal | `<leader>fh` | Find in help |
| Normal | `<leader>fk` | Find keymaps |
| Normal | `<leader><leader>` | Find buffers (quick access) |

### Git Operations
| Mode | Key | Action |
|------|-----|--------|
| Normal | `<leader>gg` | Commit / Lazygit |
| Normal | `<leader>gs` | Git status |
| Normal | `<leader>gp` | Git push |
| Normal | `<leader>gu` | Git pull/update |
| Normal | `<leader>gb` | Git branches |
| Normal | `<leader>gf` | Git fetch |
| Normal | `<leader>gh` | Git history |
| Normal | `<leader>ga` | Git annotate/blame |
| Normal | `<leader>gd` | Git diff |
| Normal | `]c` / `[c` | Next/prev git change |

### Code Actions & LSP
| Mode | Key | Action |
|------|-----|--------|
| Normal | `gd` | Go to definition |
| Normal | `gr` | Go to references |
| Normal | `gi` | Go to implementation |
| Normal | `gD` | Go to declaration |
| Normal | `K` | Hover documentation |
| Normal | `<leader>ca` | Code action |
| Normal | `<leader>cf` | Format code |
| Normal | `<leader>rn` | Rename symbol |

### Diagnostics
| Mode | Key | Action |
|------|-----|--------|
| Normal | `[d` / `]d` | Prev/next diagnostic |
| Normal | `[e` / `]e` | Prev/next error |
| Normal | `[w` / `]w` | Prev/next warning |
| Normal | `<leader>cd` | Show line diagnostics |

### Testing
| Mode | Key | Action |
|------|-----|--------|
| Normal | `<leader>t` | Run nearest test |
| Normal | `<leader>T` | Run test file |
| Normal | `<leader>a` | Run all tests |
| Normal | `<leader>l` | Rerun last test |
| Normal | `<leader>tv` | Visit test file |

### Multiple Cursors
| Mode | Key | Action |
|------|-----|--------|
| Normal/Visual | `<C-n>` | Select next occurrence |
| Normal/Visual | `<C-p>` | Unselect previous |
| Normal/Visual | `<C-S-n>` | Select all occurrences |

### Bookmarks (Marks)
| Mode | Key | Action |
|------|-----|--------|
| Normal | `<leader>bt` | Toggle bookmark signs |
| Normal | `<leader>bs` | Show bookmarks |
| Normal | `<leader>bn` | Next bookmark |
| Normal | `<leader>bp` | Previous bookmark |
| Normal | `m,` | Set next available mark |
| Normal | `m0` | Set bookmark |
| Normal | `]m` / `[m` | Next/prev mark |

### Terminal
| Mode | Key | Action |
|------|-----|--------|
| Normal | `<leader>ot` | Toggle terminal |
| Terminal | `<Esc><Esc>` | Exit terminal mode |

### Zen Mode
| Mode | Key | Action |
|------|-----|--------|
| Normal | `<leader>z` | Toggle zen mode |

### Quality of Life
| Mode | Key | Action |
|------|-----|--------|
| Normal | `Y` | Yank to end of line |
| Normal/Visual | `x` | Delete without yanking |
| Visual | `p` | Paste without yanking |
| Normal | `<C-d>` | Half page down (centered) |
| Normal | `<C-u>` | Half page up (centered) |
| Normal | `n` / `N` | Next/prev search (centered) |
| Normal | `*` / `#` | Search word (centered) |
| Normal | `<leader>w` | Save file |
| Normal | `<leader>x` | Save and quit |
| Normal | `<A-j>` / `<A-k>` | Move line down/up |
| Visual | `<A-j>` / `<A-k>` | Move selection down/up |

---

## ✅ What's Already Working

These features were already aligned between ideavimrc and nvim:

1. **Split Navigation**: `<C-h/j/k/l>` with vim-tmux-navigator ✅
2. **LSP Navigation**: `gd`, `gr`, `gD`, `K` ✅
3. **Code Actions**: `<leader>ca` ✅
4. **Diagnostics**: `[d`, `]d`, `[e`, `]e`, `[w`, `]w` ✅
5. **Git Changes**: `[c`, `]c` ✅
6. **Visual Indent**: `<` / `>` keeping selection ✅
7. **Debug Bindings**: `<leader>d*` ✅
8. **Commenting**: `gcc`, `gc` ✅

---

## 🧪 Testing Checklist

Before considering this complete, test the following:

### Critical Path (Must Work)
- [ ] `jj` / `jk` escapes from insert mode
- [ ] `<C-h/j/k/l>` navigates between nvim splits AND tmux panes
- [ ] `<leader>ff` finds files (telescope)
- [ ] `<leader>fg` greps through project
- [ ] `<leader>gg` opens lazygit
- [ ] `<leader>e` toggles file explorer
- [ ] `<A-n>` / `<A-p>` switches buffers
- [ ] `<leader>sv` / `<leader>sh` creates splits
- [ ] `<leader>wh/j/k/l` resizes windows
- [ ] `gd`, `gr`, `K` work for LSP
- [ ] `<leader>ca` shows code actions
- [ ] `[d` / `]d` navigates diagnostics

### Feature Testing
- [ ] Multiple cursors: `<C-n>` on a word, `<C-n>` again, type to edit all
- [ ] Bookmarks: `m0` to set, `<leader>bs` to show, `]m` to go to next
- [ ] Zen mode: `<leader>z` toggles distraction-free mode
- [ ] Move lines: `<A-j>` / `<A-k>` in normal and visual mode
- [ ] Testing: `<leader>t` runs nearest test
- [ ] Quality of Life: `Y` yanks to EOL, `x` doesn't pollute registers
- [ ] Center after jumps: `<C-d>` / `<C-u>` / `n` / `N` center screen

### IDE Comparison
- [ ] Open same file in IntelliJ and nvim
- [ ] Try the same keybindings in both
- [ ] Muscle memory should transfer seamlessly

---

## 📝 Notes & Known Issues

### Potential Issues to Watch For

1. **Plugin Installation**: New plugins need to be installed by lazy.nvim
   - On first launch, lazy.nvim will auto-install
   - May need to restart nvim after installation

2. **Multiple Cursor Behavior**: vim-visual-multi has its own mode
   - Press `<Esc>` to exit multi-cursor mode
   - If it feels wrong, can enable nvim-multi-cursor instead (set `enabled = true` in editor.lua)

3. **Telescope Prefix Change**: Muscle memory from `<leader>s` to `<leader>f`
   - Might take a day or two to adjust
   - `<leader>s` is now available for splits

4. **Git Prefix Lowercase**: Changed from `<leader>G` to `<leader>g`
   - More ergonomic but requires relearning
   - Both ideavimrc and nvim now use lowercase

5. **Test Bindings**: Simplified from ideavimrc's extensive set
   - If you find you need more test operations, can add them back

### Files to Keep Synchronized

When making changes to keybindings in the future:

1. Update **both** `vim/.ideavimrc` AND `lua/mike-custom/keybinds.lua`
2. Update which-key groups in `lua/mike-custom/config/navigation.lua`
3. Test in both IntelliJ and nvim

### Backup & Recovery

If something breaks:
```bash
# Restore original keybindings
cd ~/dotfiles/config/.config/nvim/lua/mike-custom/
cp keybinds.lua.backup keybinds.lua

# Restart nvim
```

---

## 🚀 Next Steps

### Immediate
1. **Test all keybindings** - Go through the testing checklist
2. **Install plugins** - Open nvim, let lazy.nvim install new plugins
3. **Restart nvim** - After plugins install
4. **Try real coding** - Use for a few hours, note any friction

### Short Term (This Week)
1. **Adjust as needed** - Fix any bindings that don't feel right
2. **Learn new bindings** - Especially `<leader>f` for find
3. **Test multi-cursor** - Try vim-visual-multi, switch to nvim-multi-cursor if preferred
4. **Verify tmux integration** - Make sure `<C-h/j/k/l>` seamlessly navigates

### Long Term
1. **Add refactoring namespace** (`<leader>R*`) if LSP supports it
2. **Add documentation namespace** (`<leader>D*`) for hover, params, type info
3. **Consider tmux-aware terminal** - Maybe `<leader>ot` could create tmux pane instead

---

## 📚 Resources

- **Project Report**: `/Users/mike/dotfiles/NVIM_KEYBINDING_SYNC_PROJECT.md`
- **Keybinding Analysis**: `/Users/mike/dotfiles/config/.config/nvim/KEYBINDINGS_ANALYSIS.md`
- **This Summary**: `/Users/mike/dotfiles/KEYBINDING_SYNC_IMPLEMENTATION_SUMMARY.md`

---

## 🎯 Success Metrics

The implementation is successful if:
- ✅ All critical path bindings work in both environments
- ✅ Muscle memory transfers without thinking
- ✅ No keybinding conflicts cause confusion
- ✅ Tmux/nvim navigation feels seamless
- ✅ Can work for a full day without reaching for the mouse

---

**Implementation Date**: November 6, 2025
**Implementer**: Claude Code
**Status**: Ready for User Testing 🚀
