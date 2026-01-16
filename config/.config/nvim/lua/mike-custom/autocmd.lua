-- Autocmds mostly copied from kickstart.nvim
--
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Persist cursor position in buffer when reopening file.
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local last_pos = vim.fn.line("'\"")
		if last_pos > 1 and last_pos <= vim.fn.line("$") then
			vim.cmd('silent! normal! g`"')
		end
	end,
})

-- Don't continue comments on 'o', but still continue comments on <Enter>
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions:remove("o")
	end,
})

-- Close :help buffers on 'q'
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function()
		vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = true, silent = true })
	end,
})

-- Auto-change working directory to git root when opening nvim inside
-- git repository.
-- The commented out version has a hiccup with submodules, where the root
-- will be set to the submodule rather than the real project root.
-- vim.api.nvim_create_autocmd("BufEnter", {
-- callback = function()
--   local git_dir = vim.fn.finddir(".git", ".;")
--    if git_dir ~= "" then
--      vim.cmd("lcd " .. vim.fn.fnamemodify(git_dir, ":h"))
--    end
--  end,
-- })
-- This version sets the project root to the root git module
-- even if neovim is opened inside a submodule.
-- last_cwd is a cache so that we don't need to run a git command
-- on every BufEnter event.
local last_cwd = ""
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local cwd = vim.fn.getcwd() -- Get current working directory

		-- Only update if we changed directories
		if cwd ~= last_cwd then
			last_cwd = cwd
			-- Ask git for the root, which will be the outer repo if submodule(s) exist(s).
			local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]

			if vim.v.shell_error == 0 and git_root and vim.fn.isdirectory(git_root) == 1 then
				vim.cmd("lcd " .. git_root)
			end
		end
	end,
})

-- NOTE: Format on save is handled by conform.nvim in language-support.lua
-- Do NOT add vim.lsp.buf.format() here as it would duplicate formatting

-- Set conceallevel for markdown files (required for obsidian.nvim UI features)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.conceallevel = 2
	end,
})
