return {
	-- LSP progress indicator (bottom-right spinner)
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		opts = {},
	},

	-- Highlight other occurrences of word under cursor
	-- Uses LSP references when available, falls back to treesitter then regex
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			delay = 200,
			providers = { "lsp", "treesitter", "regex" },
			filetypes_denylist = { "neo-tree", "oil", "Trouble" },
		},
		config = function(_, opts)
			require("illuminate").configure(opts)
		end,
	},
}
