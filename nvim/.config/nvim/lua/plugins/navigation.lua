return {
	-- Seamless navigation between tmux panes and vim splits
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},

	-- Oil.nvim - edit filesystem like a buffer
	{
		"stevearc/oil.nvim",
		lazy = false, -- recommended by oil docs
		dependencies = { "echasnovski/mini.icons" },
		keys = {
			{ "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
		},
		opts = {
			default_file_explorer = true,
			view_options = {
				show_hidden = true,
			},
			keymaps = {
				-- Disable defaults that conflict with vim-tmux-navigator
				["<C-h>"] = false,
				["<C-l>"] = false,
				-- Replacements for the disabled keys
				["<C-x>"] = { "actions.select", opts = { horizontal = true }, desc = "Open in horizontal split" },
				["<C-r>"] = "actions.refresh",
			},
		},
	},
}
