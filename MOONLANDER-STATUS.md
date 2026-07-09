# Moonlander QMK Migration — Status

## What we've done

1. **Research notes** are in `~/notes/_global/keyboard-research/`
   - 8 research docs (symbol layers, HRM timing, QMK features, vim integration, etc.)
   - Oryx export unzipped in `oryx-export/`
   - `moonlander-template.md` — blank ASCII diagram template for the Moonlander
   - `layout-current.md` — all 7 layers documented in diagram form (canonical reference)

2. **QMK build environment** set up and working
   - Added `qmk`, `arm-gcc-bin`, `avr-gcc`, `dos2unix` to Brewfile
   - Added `qmk setup` to bootstrap.sh
   - ZSA firmware repo cloned to `~/qmk_firmware` (branch: `firmware25`)
   - Note: had to add `"zsa/defaults"` to `modules` in `keyboards/zsa/moonlander/reva/keyboard.json` to fix build

3. **Baseline keymap compiles clean**
   - Keymap at `~/qmk_firmware/keyboards/zsa/moonlander/keymaps/mike/`
   - Stripped Oryx-specific code (RGB training, `rawhid_state`, `MOON_LED_LEVEL`)
   - Fixed `KC_PC_UNDO` → `KC_UNDO`
   - Binary: `~/qmk_firmware/zsa_moonlander_reva_mike.bin` (57KB)
   - Compile: `cd ~/qmk_firmware && qmk compile -kb zsa/moonlander/reva -km mike`
   - Flash: `qmk flash -kb zsa/moonlander/reva -km mike` (then press reset button)

4. **Baseline keymap flashed and verified on hardware**
   - Initial flash failed at 89% erase — recovered via `dfu-util` direct flash
   - Factory default firmware restored first, then custom keymap flashed successfully

5. **Per-layer RGB lighting working**
   - Tokyonight-storm palette at 40% brightness (original colors dimmed evenly)
   - LT() keys always show their target layer's color
   - Layer-aware shine-through: transparent keys show the color of the layer that defines them
   - `KC_NO` keys are dark
   - TODO: color tuning — tokyonight pastels lack enough hue spread for 7 distinct LED colors. Blue/cyan especially hard to tell apart. May need to swap 1-2 hues for more contrast while keeping the tokyonight feel.

6. **Achordion + streak detection working**
   - Installed as QMK module from `getreuer/qmk-modules` (cloned to `modules/getreuer/`)
   - Opposite-hand mod activation + `ACHORDION_STREAK` for require-prior-idle
   - `PERMISSIVE_HOLD` enabled
   - Tapping term tuned from 185ms → 150ms — fast typing feels good, `?` (Shift+/) still works
   - `achordion_timeout` returns 0 for LT keys (bypasses Achordion for layer-taps — instant layer switch)
   - Also fixed: hold+key combos like `f`+`/` → `?` that were previously failing

7. **Caps Word — not working, low priority**
   - `BOTH_SHIFTS_TURNS_ON_CAPS_WORD` added but couldn't get it to trigger reliably
   - Low value — vim handles capitalization, rare use case
   - Config left in place but not actively using

8. **Symbol + number layers redesigned**
   - Num: 1-2-3 on home row, + * on pinky, added `,` for number formatting, `/` for division
   - Sym: brackets paired by row ([] top, () home, {} bottom), `!` `=` on home for `!=` inward roll
   - Added `-` to sym layer row 4 so Cmd+`=`/`-` (zoom) works on one layer
   - Swapped `` ` `` to top row pinky (Cmd+`` ` `` shortcut), `~` to thumb (rare)
   - Blocked shine-through: row 0 and outer columns are KC_NO on all non-base layers
   - Printable cheatsheet at `keymaps/mike/cheatsheet.html`

9. **Repeat Key + Alt Repeat**
   - `QK_REP` on left bridge (next to G), `QK_AREP` on right bridge (next to H)
   - Solves: Bksp can't hold-to-repeat (it's LT), vim jjjj/dd/>>, etc.
   - If Alt Repeat proves useless, swap to second Repeat key

10. **Left-hand command layer (Layer 7)**
    - Activated by left thumb3 (bottom thumb key, `MO(7)`)
    - Single-key macOS shortcuts: copy/paste/cut/undo, tab mgmt
    - Cmd+Tab on G, Cmd+` on B (reachable while holding thumb3)
    - Prev/next tab (Cmd+Shift+[/]) on D and F
    - Cmd+Shift+T (reopen tab) on E
    - Right hand stays on mouse throughout

11. **Paired delimiter combos**
    - Vertical combos (top + home row, same finger): W+S → `()`, E+D → `{}`, R+F → `[]`
    - Cursor positioned between the pair automatically
    - Works from any layer

## Key inventory notes

- Left thumb3 now used for command layer (MO(7))
- Right thumb3 still unused — awkward reach but available for one-off stuff
- Bridge columns on rows 0-1 still unused (only row 2 has Repeat/AltRepeat)

## What's next

- Code digraph combos (`=>`, `!=`, `<=`, etc. as single chords)
- RGB color tuning (tokyonight pastels lack hue spread for 7 distinct LED colors)
- Num Word (auto-deactivating number mode for multi-digit entry without holding)
- Explore more QMK features as needs arise

## Key decisions

- Keeping redundant bottom-row modifiers on Layer 0 for now (safety net)
- Hardware is Rev A (bought 2022), compile target is `zsa/moonlander/reva`
