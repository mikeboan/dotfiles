return {
	-- Primary colorscheme: tokyonight
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "storm",
			})

			-- Use tokyonight unless we're in IntelliJ
			if not vim.env.INTELLIJ then
				vim.cmd.colorscheme("tokyonight-storm")
			end
		end,
	},

	-- Secondary colorscheme: onedark (for IntelliJ terminal)
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			-- Only load onedark when running inside IntelliJ terminal
			if vim.env.INTELLIJ then
				require("onedark").load()
			end
		end,
	},
}
