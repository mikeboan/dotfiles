return {
	-- Jump anywhere on screen in 2-3 keystrokes
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			-- Don't override f/t/F/T — keep them as normal vim motions
			-- flash.nvim's power is in `s` (search-based jump), not enhanced f/t
			modes = {
				char = { enabled = false },
			},
			highlight = {
				groups = {
					label = "FlashLabel",
				},
			},
		},
		config = function(_, opts)
			require("flash").setup(opts)
			-- tokyonight orange labels with bold text
			vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#1a1b26", bg = "#ff9e64", bold = true })
		end,
		keys = {
			{ "gs", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
			{ "gS", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
			{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote flash" },
			{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle flash search" },
		},
	},

	-- Pin files and jump to them instantly
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>ma", function() require("harpoon"):list():add() end, desc = "Harpoon add file" },
			{ "<leader>mm", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon menu" },
			{ "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon file 1" },
			{ "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon file 2" },
			{ "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon file 3" },
			{ "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon file 4" },
		},
		config = function()
			require("harpoon"):setup()
		end,
	},
}
