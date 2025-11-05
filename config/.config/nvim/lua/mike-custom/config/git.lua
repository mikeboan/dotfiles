-- Git tools and integrations
return {
	-- Git signs and hunk management
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			on_attach = function(bufnr)
				local gitsigns = require 'gitsigns'

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map('n', ']c', function()
					if vim.wo.diff then
						vim.cmd.normal { ']c', bang = true }
					else
						gitsigns.nav_hunk 'next'
					end
				end, { desc = 'Jump to next git [c]hange' })

				map('n', '[c', function()
					if vim.wo.diff then
						vim.cmd.normal { '[c', bang = true }
					else
						gitsigns.nav_hunk 'prev'
					end
				end, { desc = 'Jump to previous git [c]hange' })

				-- Actions
				-- visual mode
				map('v', '<leader>hs', function()
					gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
				end, { desc = 'git [s]tage hunk' })
				map('v', '<leader>hr', function()
					gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
				end, { desc = 'git [r]eset hunk' })
				-- normal mode
				map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
				map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
				map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
				map('n', '<leader>hu', gitsigns.stage_hunk, { desc = 'git [u]ndo stage hunk' })
				map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
				map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
				map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
				map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
				map('n', '<leader>hD', function()
					gitsigns.diffthis '@'
				end, { desc = 'git [D]iff against last commit' })
				-- Toggles
				map('n', '<leader>tb', gitsigns.toggle_current_line_blame,
					{ desc = '[T]oggle git show [b]lame line' })
				map('n', '<leader>tD', gitsigns.preview_hunk_inline,
					{ desc = '[T]oggle git show [D]eleted' })
			end,
		},
	},
	
	-- Git UI powered by libgit2, inspired by Magit for Emacs
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for async Git ops
			"sindrets/diffview.nvim", -- Optional, for nicer diffs
		},
		cmd = "Neogit",
		keys = {
			{
				"<leader>gg",
				function()
					require("neogit").open()
				end,
				desc = "[G]it: Open Neo[G]it",
			},
			{
				"<leader>gc",
				function()
					require("neogit").open({ kind = "split" })
				end,
				desc = "[G]it: Open Neo[g]it in split",
			},
		},
		config = function()
			require("neogit").setup({
				integrations = {
					diffview = true, -- Use diffview.nvim for diffs if available
				},
				disable_commit_confirmation = false,
				signs = {
					section = { "", "" }, -- collapsed, opened
					item = { "", "" },
				},
				use_magit_keybindings = true,
				commit_popup = {
					kind = "vsplit", -- or "split" | "tab"
				},
				-- You can further tweak things here like:
				-- disable_hint = false,
				-- console_timeout = 2000,
			})
		end,
	},
	
	-- Git conflict resolution
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = true,
		keys = {
			{ "]x", "<Plug>(git-conflict-next-conflict)", desc = "Next Git conflict" },
			{ "[x", "<Plug>(git-conflict-prev-conflict)", desc = "Previous Git conflict" },
			{ "<leader>co", "<Plug>(git-conflict-ours)", desc = "Choose ours" },
			{ "<leader>ct", "<Plug>(git-conflict-theirs)", desc = "Choose theirs" },
			{ "<leader>cb", "<Plug>(git-conflict-both)", desc = "Choose both" },
			{ "<leader>c0", "<Plug>(git-conflict-none)", desc = "Choose none" },
		},
	},
	
	-- Enhanced diff view
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		config = true,
	},
}
