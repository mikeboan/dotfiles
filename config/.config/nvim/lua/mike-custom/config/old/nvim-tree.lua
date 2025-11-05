return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- optional, but recommended
	},
	config = function()
		require("nvim-tree").setup({
			view = {
				width = 35,
				side = "left",
			},
			renderer = {
				highlight_git = true,
				highlight_opened_files = "all",
			},
			filters = {
				dotfiles = false,
				custom = { ".DS_Store", "node_modules" },
			},
			update_focused_file = {
				enable = true,
				update_root = true,
			},
			git = {
				enable = true,
				ignore = false,
			},
			actions = {
				open_file = {
					quit_on_open = false,
				},
			},
		})

		-- Toggle with <leader>e
		vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "[E]xplorer Toggle" })
	end,
}
