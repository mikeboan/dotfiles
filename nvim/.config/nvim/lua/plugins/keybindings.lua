return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix", -- clean modern look
			delay = 300, -- ms before popup shows
			icons = {
				mappings = false, -- disable icons for cleaner look
			},
			spec = {
				-- Group labels for leader key prefixes
				{ "<leader>f", group = "find" },
				{ "<leader>g", group = "git" },
				{ "<leader>h", group = "hunk" },
				{ "<leader>c", group = "code" },
				{ "<leader>t", group = "toggle" },
				{ "<leader>T", group = "test" },
				{ "<leader>q", group = "session" },
				{ "<leader>x", group = "diagnostics" },
				{ "<leader>m", group = "marks" },
				{ "<leader>r", group = "refactor" },
				{ "<leader>d", group = "debug" },
				{ "<leader>o", group = "octo" },
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer keymaps",
			},
		},
	},
}
