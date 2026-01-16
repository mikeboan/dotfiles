-- Sets lots of vim.opt settings. Copied from kickstart.nvim
--
--
-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Enable 24-bit RGB color in the TUI (required for modern colorschemes like TokyoNight)
vim.opt.termguicolors = true

-- Blinking cursor configuration (works with WezTerm + tmux)
-- See :help 'guicursor' for full documentation
--
-- Format: "mode-list:shape-blinkwait-blinkon-blinkoff"
--   Modes: n=normal, v=visual, c=command, i=insert, ci=command-insert,
--          ve=visual-exclusive, r=replace, cr=command-replace, o=operator-pending
--   Shapes: block, ver25 (vertical bar 25% width), hor20 (horizontal bar 20% height)
--   Timing: blinkwait=delay before first blink, blinkon=visible time, blinkoff=hidden time (ms)
vim.opt.guicursor = "n-v-c:block-blinkwait300-blinkon200-blinkoff150,i-ci-ve:ver25-blinkwait300-blinkon200-blinkoff150,r-cr-o:hor20-blinkwait300-blinkon200-blinkoff150"

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Prefer spaces over tabs, make tabs look like 2 spaces.
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Set softwrap options
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.showbreak = "↪ "

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Wrap lines that are too long for window
vim.opt.wrap = true
-- Break wrapped lines at chars defined in 'breakat'
vim.opt.linebreak = true
-- Indent wrapped lines
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 50
-- Instant key repeat
vim.opt.ttimeoutlen = 0

-- Decrease mapped sequence wait time
-- Consider increasing if leader key sequences feel rushed
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Improve performance in large files by limiting the number of redraws
vim.opt.lazyredraw = true

-- Folds
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Per-project configuration
-- Allows .nvim.lua files in project roots to customize LSP, options, etc.
-- Example: create ~/Src/myproject/.nvim.lua to disable specific LSPs or set project-specific options
vim.o.exrc = true
