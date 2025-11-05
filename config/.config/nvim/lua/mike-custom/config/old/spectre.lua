-- spectre.lua
-- Search and replace across multiple files with a powerful UI
-- https://github.com/nvim-pack/nvim-spectre

return {
	"nvim-pack/nvim-spectre",
	cmd = "Spectre",
	keys = {
		{
			"<leader>rr",
			function()
				require("spectre").toggle()
			end,
			desc = "[R]eplace: Toggle Spectre UI",
		},
		{
			"<leader>rw",
			function()
				require("spectre").open_visual({ select_word = true })
			end,
			desc = "[R]eplace: Word in project",
			mode = { "n" },
		},
		{
			"<leader>rp",
			function()
				require("spectre").open_file_search({ select_word = true })
			end,
			desc = "[R]eplace: Current [P]ath/file",
		},
	},
	opts = {
		open_cmd = "noswapfile vnew", -- opens in vertical split
		live_update = true, -- auto update as you type
		result_padding = " │ ",
		highlight = {
			ui = "String",
			search = "DiffChange",
			replace = "DiffDelete",
		},
	},
}
