-- Ruby and Rails-specific tools
return {
	-- Rails navigation and framework integration
	{
		"tpope/vim-rails",
		ft = { "ruby", "eruby" },
		dependencies = {
			"tpope/vim-bundler", -- Bundler integration
			"tpope/vim-rake",    -- Rake integration
		},
		config = function()
			-- Rails commands are available via :R, :A, :Emodel, etc.
			-- No additional keybindings needed - vim-rails provides its own

			-- Optional: Add custom Rails-specific keybindings
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "ruby", "eruby" },
				callback = function()
					-- Navigate to alternate file (test/implementation)
					vim.keymap.set("n", "<leader>ra", ":A<CR>", { buffer = true, desc = "[R]ails [A]lternate file" })

					-- Navigate to related file
					vim.keymap.set("n", "<leader>rr", ":R<CR>", { buffer = true, desc = "[R]ails [R]elated file" })

					-- Open model
					vim.keymap.set("n", "<leader>rm", ":Emodel ", { buffer = true, desc = "[R]ails [M]odel" })

					-- Open controller
					vim.keymap.set("n", "<leader>rc", ":Econtroller ", { buffer = true, desc = "[R]ails [C]ontroller" })

					-- Open view
					vim.keymap.set("n", "<leader>rv", ":Eview ", { buffer = true, desc = "[R]ails [V]iew" })

					-- Open migration
					vim.keymap.set("n", "<leader>rd", ":Emigration ", { buffer = true, desc = "[R]ails Migration" })

					-- Open schema
					vim.keymap.set("n", "<leader>rs", ":Eschema<CR>", { buffer = true, desc = "[R]ails [S]chema" })
				end,
			})
		end,
	},

	-- ERB and Haml template support
	{
		"vim-ruby/vim-ruby",
		ft = { "ruby", "eruby", "haml" },
	},
}
