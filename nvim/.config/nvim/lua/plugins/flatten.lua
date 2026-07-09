return {
	-- Prevent nested neovim instances
	-- When running `nvim file` inside a neovim terminal or tmux, opens
	-- the file in the parent neovim instance instead of nesting.
	-- Also makes `git commit` from terminal use the parent editor.
	{
		"willothy/flatten.nvim",
		lazy = false,
		priority = 1001, -- load before anything else
		opts = {
			window = {
				open = "alternate", -- open files in the alternate window
			},
		},
	},
}
