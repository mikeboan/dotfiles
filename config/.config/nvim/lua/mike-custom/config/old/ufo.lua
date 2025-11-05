return {
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async", -- required for ufo
		},
		event = "BufReadPost", -- Lazy load after file read
		opts = {
			provider_selector = function(_, filetype, _)
				-- Prefer Treesitter, fallback to indent
				return { "treesitter", "indent" }
			end,
		},
		config = function(_, opts)
			vim.o.foldcolumn = "1" -- Show fold column (or 'auto', '2', '0', etc).
			vim.o.foldlevel = 99 -- Start with all folds open
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
			vim.o.fillchars = "eob: ,fold:▏,foldopen:,foldsep: ,foldclose:"

			require("ufo").setup(opts)

			-- Optional keymaps
			vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
			vim.keymap.set("n", "zp", function()
				require("ufo").peekFoldedLinesUnderCursor()
			end, { desc = "Peek fold under cursor" })
		end,
	},
}
