return {
	{
		"petertriho/nvim-scrollbar",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"kevinhwang91/nvim-hlslens",
		},
		opts = {
			show_in_active_only = true,
			hide_if_all_visible = true, -- hide when file fits in window
			handle = {
				blend = 0, -- opaque handle
			},
			marks = {
				Search = { color = "#ff9e64" },
				Error = { color = "#db4b4b" },
				Warn = { color = "#e0af68" },
				Info = { color = "#0db9d7" },
				Hint = { color = "#1abc9c" },
				Misc = { color = "#9d7cd8" },
				GitAdd = { color = "#449dab" },
				GitChange = { color = "#6183bb" },
				GitDelete = { color = "#914c54" },
			},
			handlers = {
				diagnostic = true,
				gitsigns = true,
				search = true, -- requires hlslens, will just skip if not installed
			},
		},
		config = function(_, opts)
			require("scrollbar").setup(opts)
			require("scrollbar.handlers.gitsigns").setup()
			require("scrollbar.handlers.search").setup()
		end,
	},
}
