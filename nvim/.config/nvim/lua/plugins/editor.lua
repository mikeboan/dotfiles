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
			mappings = {
				-- Don't autopair backticks when previous char is already a backtick.
				-- This lets you type ``` naturally for code fences instead of
				-- always getting an even number of backticks.
				['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\`].', register = { cr = false } },
			},
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

	-- Undo history tree viewer
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>tu", "<cmd>UndotreeToggle<cr>", desc = "Toggle undotree" },
		},
	},
}
