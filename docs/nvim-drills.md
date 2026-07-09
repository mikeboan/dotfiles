# Neovim Motion Drills

**Goal**: Overlearn a small trusted motion set until reflexive. Single-file editing under pressure.

## Config reference (verified)

| Plugin | Key | Action |
|--------|-----|--------|
| flash.nvim | `gs` | Jump anywhere on screen (2–3 keys) |
| flash.nvim | `gS` | Jump to any treesitter node |
| flash.nvim | `r` (op-pending) | Remote flash — operate on non-adjacent target |
| multicursor.nvim | `<C-n>` | Add cursor on next match |
| multicursor.nvim | `<C-p>` | Skip match, add cursor on next |
| multicursor.nvim | `<C-x>` | Remove cursor on current match |
| multicursor.nvim | `<C-S-n>` | Add cursors to ALL matches |
| multicursor.nvim | `<Esc>` | Clear all cursors |
| treesitter-textobjects | `af`/`if` | Around/inside function (seeks) |
| treesitter-textobjects | `ac`/`ic` | Around/inside class (seeks) |
| treesitter-textobjects | `aa`/`ia` | Around/inside argument (seeks) |
| treesitter-textobjects | `]f`/`[f` | Jump to next/prev function |
| treesitter-textobjects | `]c`/`[c` | Jump to next/prev class |

---

## Drill 1: Motion Economy

**Practice file**: `nvim/.config/nvim/lua/plugins/treesitter.lua`

**Constraint**: Arrow keys banned. `hjkl` limited to 3 consecutive same-direction presses — anything beyond that requires a better motion. Each violation, tally below.

### Reference card

| Motion | Use for |
|--------|---------|
| `gs` | Any target more than ~5 chars away |
| `gS` | Jump to a specific syntax node |
| `f{c}` / `F{c}` | Target on current line |
| `t{c}` / `T{c}` | Land before target char |
| `;` / `,` | Repeat / reverse f/t |
| `{` / `}` | Prev/next blank line |
| `%` | Bounce between bracket pair |
| `]f` / `[f` | Next/prev function |

### Reps (do 3× per session, ~10 min)

1. From line 1, navigate to `@parameter.inner` near the bottom. Use `gs` — type the first 1–2 chars of your target, pick the label. No `/` search.
2. From anywhere in the file, jump to the `select = { lookahead = true }` line using `gs`. Aim for 2 keystrokes after triggering.
3. Navigate between the two `map` blocks (around lines 47 and 52) using `]f` / `[f` only.
4. On any `map(...)` call, navigate to the string `"@function.outer"` using `f"` then `;` to step along the line.
5. Jump to the `autocmd` callback at line 24 (`callback = function()`). Use `gs` targeting `callback`.

**Checklist**:
- [ ] Used `gs` as primary long-range motion (not `/` or scrolling)
- [ ] Used `f` + `;` for within-line navigation at least twice
- [ ] Used `]f`/`[f` to move between functions
- [ ] Zero arrow key presses

**Tally**: banned-key touches: `___`

### Level 2

Constraint: cursor must reach its target in ≤3 keystrokes (after any initial mode or motion trigger). If you're on keystroke 4 and still positioning, stop and find a better entry angle.

---

## Drill 2: Nested Delimiters

**Practice file**: `nvim/.config/nvim/lua/plugins/treesitter.lua`

### The problem

```lua
vim.api.nvim_create_autocmd("User", {   -- outer {
  pattern = "LazyDone",
  callback = function()                 -- inner function
    require("nvim-treesitter").install(parsers)
  end,                                  -- inner end
})                                      -- outer }
```

With cursor before `callback`, `ci{` grabs the outer braces — because `i{` finds the pair whose braces **enclose** the cursor. At that position, you're inside the outer `{...}`, not yet inside the inner `function()...end`.

### The three fixes

**Fix 1 — `f{` then `ci{`**
`f{` jumps cursor onto the `{` you want. With cursor ON a `{`, `ci{` uses that pair (not its parent).

**Fix 2 — `%` to verify**
Press `%` from any brace to jump to its match. Watch where you land. If it's wrong, `%` again to return and rethink entry.

**Fix 3 — `cif` (treesitter)**
Doesn't care about cursor position. Seeks forward to the next function body and operates on it. Use this when bracket counting feels unreliable.

### Reps (do 3× per session, ~10 min)

**Part A — Bracket awareness with `%`**

1. Place cursor on the `{` at the end of line 8 (`config = function()`). Press `%`. Observe: cursor jumps to line 30 (`end`). You now know the full span of `config`'s body. Press `%` to return.
2. Place cursor on line 22 (the `vim.api.nvim_create_autocmd` `{`). Press `%`. Observe. Press `%` again.

**Part B — `f{` + `ci{` reflex**

3. Position cursor anywhere on line 21 (`vim.api.nvim_create_autocmd("User", {`), BEFORE the inner `{` at the end.
   - Wrong: press `ci{` directly — observe it grabs outer (the `config` function body).
   - Undo. Right: press `f{` to land on the line's `{`, then `ci{`. Observe it grabs only the autocmd's block.
   - Repeat until the `f{` → `ci{` sequence fires without thought.

4. Navigate to line 15 (`local parsers = {`). Practice:
   - `f{` to land on `{`
   - `vi{` to select inside (confirm with visual highlight before committing)
   - `ci{` to replace the list

**Part C — treesitter escape hatch**

5. Place cursor somewhere OUTSIDE any function (e.g., line 1). Press `cif`. Confirm: it seeks to the next function body (`config = function()`), enters insert mode inside it. Undo.
6. With cursor inside the outer `config` function body but BEFORE the `callback`, press `cif`. Confirm: it grabs the `callback` function's body (seeks to next inner function), not the outer one.

**Checklist**:
- [ ] Used `f{` + `ci{` combo at least 3× correctly
- [ ] Used `%` to verify a bracket span before operating
- [ ] Used `cif` and confirmed it seeks past your cursor position
- [ ] Zero accidental outer-bracket edits

**Tally**: wrong-pair edits: `___`

---

## Drill 3: Multi-cursor Reflex

**Practice file**: `nvim/.config/nvim/lua/plugins/treesitter.lua`

Two flows. Know when to use each.

### Flow A — `*` → `cgn` → `.` / `n`

Use when: stepping through matches with per-match confirmation. Closest to "find + manual replace" in an IDE.

| Key | Action |
|-----|--------|
| `*` | Search word under cursor; jump to next match |
| `cgn` | Change current search match; drop into insert |
| `.` | Repeat: jump to next match AND apply same change |
| `n` | Skip this match; move to next without changing |

**Reps**:

1. Place cursor on `"textobjects"` (as a string argument, any line around 47–52). Press `*` — watch vim-illuminate's dim highlights become bright search matches, and nvim-hlslens shows `[1/N]` in the scrollbar.
2. Press `cgn`. Type `"ts_objects"`. Press `<Esc>`.
3. Press `.` to replace the next match. Press `n` to skip one. Press `.` to replace the one after.
4. `:noh` + `u` to undo. Repeat the sequence until the `*` → `cgn` → `.`/`n` rhythm is automatic.

### Flow B — `<C-n>` multicursor (Cmd-D equivalent)

Use when: you want all cursors active before typing, or you're making a structural edit (not just text replacement).

**The flow**:

1. Place cursor on the word to target (or make a visual selection).
2. `<C-n>` — selects word under cursor, adds first cursor.
3. `<C-n>` — adds cursor on next match. Repeat.
4. `<C-p>` — skip current match, add cursor on the next one instead.
5. `<C-x>` — remove cursor on current match entirely.
6. `<C-S-n>` — shortcut: add cursors to ALL matches at once.
7. Operate: `c` to change, `d` to delete, `I` insert at line start, `A` insert at end, `ciw` to change word, etc.
8. `<Esc>` — clear all cursors, return to normal.

**Reps**:

1. **Cmd-D flow**: Place cursor on `textobjects`. Press `<C-n>` twice to select the first two occurrences. Type `c` to change. Type `treesitter_obj`. `<Esc>`. Undo.
2. **Skip flow**: Same setup, but after selecting 2 occurrences, press `<C-p>` to skip one and add cursor on the next. Confirms that `<C-p>` is "skip, not remove".
3. **Select-all flow**: Place cursor on `textobjects`. Press `<C-S-n>`. All occurrences selected at once. Press `c`, type replacement. `<Esc>`. Undo.
4. **Remove-one flow**: Select 3 occurrences with `<C-n>` × 3. Use `<C-x>` to remove the cursor on the one you don't want changed. Operate on the remaining two.

**Checklist**:
- [ ] Completed a rename using `*` + `cgn` + `.` without `:s`
- [ ] Used `n` to skip at least one match
- [ ] Completed same rename using `<C-n>` flow
- [ ] Used `<C-p>` to skip (not remove) an occurrence
- [ ] Used `<C-S-n>` for select-all
- [ ] Used `<C-x>` to remove one cursor from the set
- [ ] `<Esc>` cleanly cleared all cursors

**Decision rule**: `cgn`+`.` = step-by-step with per-match decisions. `<C-n>` = select set first, then operate (mirrors Cmd-D muscle memory better).

---

## Drill 4: Search & Replace Syntax

**Goal**: `:s`, `:g`, and `:%!` as reflex — stop thinking, start typing. nvim-hlslens is active: when you search with `/`, match counts display inline and in the scrollbar.

### Syntax reference

```vim
:s/old/new/          " first match, current line
:s/old/new/g         " all matches, current line
:%s/old/new/g        " all matches, whole file
:%s/old/new/gc       " all matches, confirm each (y/n/a/q/l)
:5,20s/old/new/g     " lines 5–20 only
:'<,'>s/old/new/g    " visual selection only (auto-inserted after V + :)

" \v = very magic: () {} | need no backslash
:%s/\v(word)_(suffix)/\1-\2/g

:g/pattern/d         " delete all matching lines
:g/pattern/          " list all matching lines
:g!/pattern/d        " delete all NON-matching lines (keep matches)
:v/pattern/d         " same as :g!/pattern/d

:%!jq .              " pipe whole file through shell command
:'<,'>!sort          " pipe visual selection through sort
```

### Exercise A — `:s` reps

**Practice file**: `nvim/.config/nvim/lua/plugins/treesitter.lua`

1. **Confirm-mode**: Run `:%s/textobjects/ts_obj/gc`. Step through with `y`/`n`. Press `q` when done. Undo with `u`. Read the `[y/n/a/q/l/^E/^Y]?` prompt — know what `a` (all remaining) and `l` (last, then quit) do.

2. **Very-magic capture groups**: The file has strings like `"@function.outer"` and `"@class.inner"`. Swap the category part using a capture:
   ```vim
   :%s/\v"@(function|class)\.(outer|inner)"/"\@\1.\2_v2"/gc
   ```
   Read it aloud before typing: "very-magic, literal `@`, capture `function-or-class`, literal dot, capture `outer-or-inner`". Undo after.

3. **Range**: Lines 47–52 are the `af`/`if`/`ac`/`ic` map calls. Restrict to that range:
   ```vim
   :47,52s/select_textobject/pick_node/g
   ```
   Undo. Confirm only lines 47–52 were touched.

4. **Visual range**: Visually select lines 47–52 with `V`. Press `:` — observe `:'<,'>` is auto-inserted. Complete:
   ```vim
   :'<,'>s/select_textobject/pick_node/g
   ```
   Same result. Undo.

### Exercise B — `:g` reps

**Practice file**: `zsh/.zshrc`

1. **List matches** (non-destructive): `:g/export/` — lists all lines with `export` in the command window. Read the output.

2. **Delete blank lines**: `:g/^\s*$/d` — removes all empty/whitespace-only lines. Undo immediately.

3. **Keep only matches**: `:g!/alias/d` — deletes every line that does NOT contain `alias`. Watch the file shrink to only alias lines. Undo.

4. **Compound**: Delete all comment lines (lines starting with `#`):
   ```vim
   :g/^\s*#/d
   ```
   Undo.

### Exercise C — `:%!` shell filter

1. Open `tmux/.config/sesh/sesh.toml`. Type `:%!cat -n` — observe line numbers prepended by shell. This is the motion you'll use with `jq`, `sort`, `uniq -c | sort -rn`, etc. Undo.

2. If you have a JSON buffer open: `:%!jq .` to pretty-print. Undo.

3. Visually select a few lines. `:'<,'>!sort` to sort them. Undo.

**Checklist**:
- [ ] Typed `:%s/\v.../gc` from scratch, including a capture group + `\1`
- [ ] Used the `c` flag and stepped through `y`/`n`/`a`/`q`
- [ ] Used `:g/pat/d` and `:g!/pat/d`
- [ ] Used a line range `n,ms///`
- [ ] Used visual range `'<,'>s///` via `V` + `:`
- [ ] Used `:%!cmd` to pipe through a shell command

---

## Daily schedule

| Days | Focus | Time |
|------|-------|------|
| 1–3 | Drill 1 only | 10 min |
| 4–6 | Drill 2 only | 10 min |
| 7–9 | Drills 1 + 2 | 10 min |
| 10–12 | Drill 3 only | 15 min |
| 13–15 | Drill 4 only | 15 min |
| 16+ | Full rotation, one rep each | 15 min |

---

## Suggested config change: rebind flash to `s`

Your flash jump is `gs`. Under pairing pressure, a two-key leader sequence is slower than `s`. The conventional trade: bind flash to `s`, which replaces Vim's built-in substitute-char (`s` = `cl` anyway).

In `nvim/.config/nvim/lua/plugins/motion.lua`, replace the `keys` block:

```lua
keys = {
  { "s",  mode = { "n", "x", "o" }, function() require("flash").jump() end,        desc = "Flash" },
  { "S",  mode = { "n", "x", "o" }, function() require("flash").treesitter() end,  desc = "Flash treesitter" },
  { "r",  mode = "o",               function() require("flash").remote() end,       desc = "Remote flash" },
  { "<c-s>", mode = { "c" },        function() require("flash").toggle() end,       desc = "Toggle flash search" },
},
```

`S` (substitute-line) is redundant with `cc` — same trade. This is the standard flash.nvim setup; `gs`/`gS` is a conservative choice that costs you speed. Drill 1 is written for `gs` as-is; if you make this change, just mentally substitute `s` for `gs` throughout.
