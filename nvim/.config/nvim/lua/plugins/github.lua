return {
	-- GitHub PRs and issues inside Neovim
	{
		"pwntester/octo.nvim",
		cmd = "Octo",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"ibhagwan/fzf-lua",
			"echasnovski/mini.icons",
		},
		keys = {
			{ "<leader>oi", "<cmd>Octo issue list<cr>", desc = "List issues" },
			{ "<leader>oo", "<cmd>Octo issue create<cr>", desc = "Create issue" },
			{ "<leader>op", "<cmd>Octo pr list<cr>", desc = "List PRs" },
			{ "<leader>oP", "<cmd>Octo pr create<cr>", desc = "Create PR" },
			{ "<leader>or", "<cmd>Octo review start<cr>", desc = "Start review" },
			{ "<leader>os", "<cmd>Octo search<cr>", desc = "Search (issues/PRs)" },
		},
		opts = {
			picker = "fzf-lua",
			suppress_missing_scope = {
				projects_v2 = true,
			},
		},
	},
}
