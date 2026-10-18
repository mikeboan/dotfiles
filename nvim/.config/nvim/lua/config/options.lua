-- Loaded before lazy.nvim starts. These are DELTAS from LazyVim's defaults:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

-- Keep vim registers separate from the macOS clipboard.
-- LazyVim sets clipboard=unnamedplus; that makes dd/x/c clobber the system
-- clipboard, which is more annoying than typing "+y. Mirrored in ~/.ideavimrc.
opt.clipboard = ""

-- Line wrapping (LazyVim disables wrap)
opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.breakindentopt = "shift:2"
opt.showbreak = "↪ "

-- Diff mode. LazyVim fills missing lines with "╱", which is visual noise;
-- blank filler lets the background tint carry the meaning.
opt.fillchars:append({ diff = " " })
-- histogram: better alignment for code than myers (the default).
-- linematch: pair up similar lines inside a hunk so changes show as changes,
-- not delete+add (60 = max lines per hunk to run it on; default 40).
opt.diffopt:append({ "algorithm:histogram" })
opt.diffopt:remove("linematch:40")
opt.diffopt:append({ "linematch:60" })

-- Whitespace visualization
opt.list = true
opt.listchars = { tab = "⇥ ", trail = "·", nbsp = "␣" }

-- Live substitution preview in a split (LazyVim uses "nosplit")
opt.inccommand = "split"

-- More breathing room than LazyVim's 4
opt.scrolloff = 10

-- Fast CursorHold so the disk-reload autocmds in autocmds.lua feel instant
opt.updatetime = 50
opt.timeoutlen = 300
opt.ttimeoutlen = 0

-- Undofile is enough history; skip swap noise
opt.swapfile = false

-- Blinking cursor (works through tmux + kitty)
opt.guicursor = table.concat({
  "n-v-c:block-blinkwait300-blinkon200-blinkoff150",
  "i-ci-ve:ver25-blinkwait300-blinkon200-blinkoff150",
  "r-cr-o:hor20-blinkwait300-blinkon200-blinkoff150",
}, ",")

-- LazyVim's python extra defaults to pyright; basedpyright is stricter and
-- infers more without annotations.
vim.g.lazyvim_python_lsp = "basedpyright"

-- Per-project .nvim.lua / .nvimrc
opt.exrc = true

-- Named server so external tools can open files in this instance (e.g. Pi's /nvim).
-- Skipped when nested inside another nvim ($NVIM is set).
if not vim.env.NVIM then
  local pipe = vim.fn.expand("~/.local/share/nvim/server.pipe")
  vim.fn.delete(pipe)
  vim.fn.serverstart(pipe)
end
