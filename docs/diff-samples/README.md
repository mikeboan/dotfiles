# Diff styling samples

Fixtures for eyeballing nvim diff highlighting.

```sh
nvim -d before.ts after.ts   # plain diff mode
./diffview-repo.sh           # same change in Diffview (+ a new-file case)
```

Each `Case N` comment marks what it exercises. Knobs to try live:

```vim
:set diffopt+=inline:word        " word-level instead of char-level inline hl
:set diffopt-=linematch:60       " see what linematch buys you in Case 3
:set diffopt+=iwhite             " hide Case 4
:set diffopt+=context:3          " fold more aggressively (default 6)
:set diffopt+=algorithm:patience " compare against histogram
```
