-- IDE-aligned keybindings (synced with ideavimrc)
-- This file contains all keybindings for a seamless nvim/IntelliJ experience

-- [[ Basic Keymaps ]]

-- ========================================
-- Insert Mode Mappings
-- ========================================

-- Quick escape (matches ideavimrc)
vim.keymap.set("i", "jj", "<Esc>", { desc = "Quick escape" })
vim.keymap.set("i", "jk", "<Esc>", { desc = "Quick escape" })

-- ========================================
-- Quality of Life Improvements
-- ========================================

-- Y yanks to end of line (like D and C)
vim.keymap.set("n", "Y", "y$", { desc = "Yank to end of line" })

-- x deletes without yanking (to black hole register)
vim.keymap.set({ "n", "v" }, "x", '"_x', { desc = "Delete without yanking" })

-- Visual mode paste doesn't yank
vim.keymap.set("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Center screen after navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "*", "*zz", { desc = "Search word forward (centered)" })
vim.keymap.set("n", "#", "#zz", { desc = "Search word backward (centered)" })
vim.keymap.set("n", "g*", "g*zz", { desc = "Search word forward (no boundaries, centered)" })
vim.keymap.set("n", "g#", "g#zz", { desc = "Search word backward (no boundaries, centered)" })

-- ========================================
-- Save/Quit
-- ========================================

vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>x", ":x<CR>", { desc = "Save and quit" })

-- ========================================
-- Config
-- ========================================

vim.keymap.set("n", "<leader>cr", "<cmd>source $MYVIMRC<CR>", { desc = "Reload config" })

-- ========================================
-- Search & Highlight
-- ========================================

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<leader><Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- ========================================
-- Window/Split Navigation (Ctrl+hjkl)
-- ========================================
-- These work with vim-tmux-navigator for seamless tmux/nvim navigation

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- ========================================
-- Window/Split Management
-- ========================================

-- Split creation (matches ideavimrc pattern)
vim.keymap.set("n", "<leader>sv", "<C-W>v", { desc = "Split vertical" })
vim.keymap.set("n", "<leader>sh", "<C-W>s", { desc = "Split horizontal" })
vim.keymap.set("n", "<leader>sc", "<C-W>o", { desc = "Close all splits except current" })

-- Alternative split bindings (keep for flexibility)
vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })

-- ========================================
-- Window Resizing (leader+w+hjkl)
-- ========================================

vim.keymap.set("n", "<leader>wh", ":vertical resize -5<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<leader>wj", ":resize +5<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<leader>wk", ":resize -5<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<leader>wl", ":vertical resize +5<CR>", { desc = "Increase window width" })
vim.keymap.set("n", "<leader>w=", "<C-W>=", { desc = "Equalize window sizes" })

-- ========================================
-- Buffer/Tab Navigation
-- ========================================

-- Alt+n/p for buffer navigation (matches ideavimrc tab nav, but adapted for buffers)
vim.keymap.set("n", "<A-n>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<A-p>", ":bprevious<CR>", { desc = "Previous buffer" })

-- Keep Tab/Shift-Tab as well for convenience
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })

-- Buffer management
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bo", ":%bdelete|edit #|bdelete #<CR>", { desc = "Delete other buffers" })

-- ========================================
-- Move Lines Up/Down
-- ========================================

-- Move lines with Alt+j/k (matches ideavimrc)
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- ========================================
-- Visual Mode Enhancements
-- ========================================

-- Keep selection when indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- ========================================
-- Terminal
-- ========================================

-- Exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Toggle terminal (assuming toggleterm is configured)
-- Note: toggleterm itself sets up <C-\> by default
vim.keymap.set("n", "<leader>ot", "<cmd>ToggleTerm<CR>", { desc = "Open terminal" })

-- ========================================
-- Diagnostics & Quickfix
-- ========================================

-- Diagnostics
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic Location list" })
vim.keymap.set("n", "<leader>Q", vim.diagnostic.setqflist, { desc = "Open diagnostic Quickfix list" })

-- Diagnostic navigation
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })

local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- Quickfix list
vim.keymap.set("n", "<leader>xq", function()
	local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
	if not success and err then
		vim.notify(err, vim.log.levels.ERROR)
	end
end, { desc = "Quickfix List" })

vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- Location list
vim.keymap.set("n", "<leader>xl", function()
	local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
	if not success and err then
		vim.notify(err, vim.log.levels.ERROR)
	end
end, { desc = "Location List" })

-- ========================================
-- File Operations
-- ========================================

-- New file
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- File explorer (nvim-tree is configured elsewhere with <leader>e)

-- ========================================
-- Commenting
-- ========================================

-- Add comment line above/below
vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- ========================================
-- Code Formatting
-- ========================================

-- Formatting (using conform or LSP)
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
	-- Try conform first, fall back to LSP
	local conform_available, conform = pcall(require, "conform")
	if conform_available then
		conform.format({ async = true, lsp_fallback = true })
	else
		vim.lsp.buf.format()
	end
end, { desc = "Format" })

-- ========================================
-- Testing (Simple pattern to match ideavimrc)
-- ========================================

-- These will be picked up by vim-test or neotest
vim.keymap.set("n", "<leader>t", ":TestNearest<CR>", { desc = "Test nearest" })
vim.keymap.set("n", "<leader>T", ":TestFile<CR>", { desc = "Test file" })
vim.keymap.set("n", "<leader>ta", ":TestSuite<CR>", { desc = "Test all/suite" })
vim.keymap.set("n", "<leader>l", ":TestLast<CR>", { desc = "Test last" })
vim.keymap.set("n", "<leader>tv", ":TestVisit<CR>", { desc = "Visit test file" })

-- Note: <leader>a namespace is reserved for AI operations (see config/ai.lua)

-- ========================================
-- Inspection & UI
-- ========================================

vim.keymap.set("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
vim.keymap.set("n", "<leader>uI", function()
	vim.treesitter.inspect_tree()
	vim.api.nvim_input("I")
end, { desc = "Inspect Tree" })

-- ========================================
-- Additional Keybindings
-- ========================================

-- Markdown (configured elsewhere, just documenting)
-- <leader>mr - Toggle markdown rendering
-- <leader>me - Enable markdown rendering
-- <leader>md - Disable markdown rendering

-- Note: LSP, Git, Telescope, and other plugin-specific keybindings
-- are configured in their respective config files:
-- - lua/mike-custom/config/language-support.lua (LSP)
-- - lua/mike-custom/config/git.lua (Git/gitsigns)
-- - lua/mike-custom/config/navigation.lua (Telescope)
-- - lua/mike-custom/config/testing.lua (Testing)
-- - lua/mike-custom/config/editor.lua (Multiple cursors, zen-mode, etc.)
