return {
	-- Auto-detect indent settings from file/project
	{ "tpope/vim-sleuth" },

	-- Auto-close brackets, quotes, etc.
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		opts = {
			-- skip autopair when next character is a closing bracket
			skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
			-- skip autopair when inside these treesitter nodes
			skip_ts = { "string" },
			-- skip autopair when next character is closing and there are more closing than opening
			skip_unbalanced = true,
		},
	},

	-- Add/change/delete surroundings (brackets, quotes, tags, etc.)
	{
		"echasnovski/mini.surround",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			-- Default mappings:
			-- sa = add surrounding (e.g., saiw" adds quotes around word)
			-- sd = delete surrounding (e.g., sd" deletes quotes)
			-- sr = replace surrounding (e.g., sr"' replaces " with ')
			-- sf = find surrounding (move to right)
			-- sF = find surrounding (move to left)
			-- sh = highlight surrounding
			-- sn = update n_lines (how far to search)
			mappings = {
				add = "sa",
				delete = "sd",
				replace = "sr",
				find = "sf",
				find_left = "sF",
				highlight = "sh",
				update_n_lines = "sn",
			},
		},
	},

	-- Comments: Neovim 0.10+ has built-in gc, but this gives more control
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			-- gc{motion} - toggle comment
			-- gcc - toggle current line
			-- gbc - toggle block comment current line
			-- gcO/gco/gcA - add comment above/below/end of line
		},
	},

	-- Highlight and search TODO/FIXME/HACK/etc.
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		keys = {
			{ "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
			{ "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
			{ "<leader>ft", "<cmd>TodoFzfLua<cr>", desc = "Find todos" },
		},
	},

	-- Indent guides
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			indent = {
				char = "│",
			},
			scope = {
				enabled = true,
				show_start = false,
				show_end = false,
			},
		},
	},

	-- Better diagnostics/quickfix list
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		dependencies = { "echasnovski/mini.icons" },
		opts = {},
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics (Trouble)" },
			{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list (Trouble)" },
			{ "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location list (Trouble)" },
		},
	},
}
