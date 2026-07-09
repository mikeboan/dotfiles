-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs & indentation (defaults; vim-sleuth will override per-project)
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Line wrapping
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.breakindentopt = "shift:2"
vim.opt.showbreak = "↪ "

-- Mouse
vim.opt.mouse = "a"

-- Clipboard
-- Disabled: syncs with system clipboard, but dd/x/etc overwrite it which is annoying.
-- Uncomment to experiment. Use "+ register for explicit system clipboard access.
-- vim.schedule(function()
--   vim.opt.clipboard = "unnamedplus"
-- end)

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- UI
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.laststatus = 3 -- global statusline (one bar, not one per split)

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Undo (persists across sessions; swap files are off since we have this + git)
vim.opt.undofile = true
vim.opt.swapfile = false

-- Whitespace visualization
vim.opt.list = true
vim.opt.listchars = { tab = "⇥ ", trail = "·", nbsp = "␣" }

-- Live substitution preview
vim.opt.inccommand = "split"

-- Scroll margin
vim.opt.scrolloff = 10

-- Timing
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 0

-- Cursor (blinking, works with tmux + kitty)
vim.opt.guicursor = "n-v-c:block-blinkwait300-blinkon200-blinkoff150,i-ci-ve:ver25-blinkwait300-blinkon200-blinkoff150,r-cr-o:hor20-blinkwait300-blinkon200-blinkoff150"

-- Per-project config
vim.opt.exrc = true

-- Start a named server so external tools can open files here (e.g. Pi /nvim)
-- Skipped if we're nested inside another nvim instance ($NVIM is set).
if not vim.env.NVIM then
  local pipe = vim.fn.expand("~/.local/share/nvim/server.pipe")
  vim.fn.delete(pipe)
  vim.fn.serverstart(pipe)
end

-- Folding (nvim-ufo)
vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- Auto-reload files changed outside Neovim
-- When a file changes on disk (code agent, git checkout, another editor, etc.) and the
-- buffer has no unsaved changes, Neovim will silently reload it. If the buffer IS modified,
-- Neovim warns instead of clobbering your work.
vim.opt.autoread = true

-- Trigger reload checks on common events:
--   FocusGained  — alt-tab back to terminal (requires tmux `focus-events on`)
--   BufEnter     — switching between buffers
--   CursorHold/I — after `updatetime` ms of inactivity (50ms with our config)
-- Note: CursorHold only fires once until you move the cursor again, so this alone
-- doesn't cover the "staring at a buffer while a code agent works" case.
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	group = vim.api.nvim_create_augroup("auto_reload", { clear = true }),
	callback = function()
		-- Guard: checktime errors if called from the command-line window (q:)
		if vim.fn.getcmdwintype() == "" then
			vim.cmd("checktime")
		end
	end,
})

-- Poll for changes every second to cover the idle case.
-- This is what makes buffers update in real-time when you're watching a code agent
-- edit files in a split tmux pane without touching Neovim. checktime just does stat()
-- calls on loaded buffers — negligible cost even with 100+ buffers open.
-- (We use a timer instead of per-buffer libuv file watchers because macOS kqueue breaks
-- when files are deleted + recreated, which is how most tools write files.)
local reload_timer = vim.uv.new_timer()
reload_timer:start(1000, 1000, vim.schedule_wrap(function()
	if vim.fn.getcmdwintype() == "" then
		vim.cmd("checktime")
	end
end))

-- Notify when a buffer gets reloaded from disk so you know it happened.
-- Fires after the reload is complete (FileChangedShellPost), not before.
vim.api.nvim_create_autocmd("FileChangedShellPost", {
	group = vim.api.nvim_create_augroup("auto_reload_notify", { clear = true }),
	callback = function()
		vim.notify("File reloaded from disk", vim.log.levels.INFO)
	end,
})

-- Autosave: write buffers on FocusLost and InsertLeave.
-- We intentionally DON'T use BufLeave here — that fires when switching between splits,
-- which triggers format-on-save and causes code to jump around while you're looking at it.
-- InsertLeave only fires when you exit insert mode, so navigating splits in normal mode
-- won't trigger unexpected saves/formats.
-- If this gets annoying (e.g., saving too often in a scratch buffer), options:
--   - Remove InsertLeave and keep only FocusLost (saves only when you leave Neovim)
--   - Add a buffer-local vim.b.no_autosave flag to skip specific buffers
--   - Use BufLeave instead of InsertLeave if you don't use format-on-save
vim.api.nvim_create_autocmd({ "FocusLost", "InsertLeave" }, {
	group = vim.api.nvim_create_augroup("auto_save", { clear = true }),
	callback = function(event)
		local buf = event.buf
		if
			vim.bo[buf].modified
			and vim.bo[buf].buftype == "" -- only normal file buffers (skip terminal, help, etc.)
			and vim.api.nvim_buf_get_name(buf) ~= "" -- must have a filename (skip scratch buffers)
		then
			vim.api.nvim_buf_call(buf, function()
				vim.cmd("silent! write")
			end)
		end
	end,
})

-- Open neo-tree when nvim starts with no file arguments
-- Shows file tree on the left with an empty buffer on the right.
vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("open_neotree_on_start", { clear = true }),
	callback = function()
		if vim.fn.argc() == 0 then
			vim.cmd("Neotree show")
		end
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 150 })
	end,
})

-- Dim background when tmux pane loses focus (match tmux inactive pane color)
-- Requires `set -g focus-events on` in tmux.conf to receive FocusLost/FocusGained.
-- Note: only dims the Normal bg. Other groups with explicit backgrounds (NormalFloat,
-- SignColumn, etc.) won't change. Expand if needed.
vim.api.nvim_create_autocmd("FocusLost", {
	callback = function()
		vim.g._saved_normal_bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Normal")), "bg#")
		vim.api.nvim_set_hl(0, "Normal", { bg = "#292e42" })
	end,
})

vim.api.nvim_create_autocmd("FocusGained", {
	callback = function()
		if vim.g._saved_normal_bg and vim.g._saved_normal_bg ~= "" then
			vim.api.nvim_set_hl(0, "Normal", { bg = vim.g._saved_normal_bg })
		else
			-- Fallback: re-apply colorscheme to restore all highlight groups
			vim.cmd.colorscheme(vim.g.colors_name)
		end
	end,
})
