return {
	-- Database connection and query execution
	{
		"tpope/vim-dadbod",
		dependencies = {
			"kristijanhusak/vim-dadbod-ui",
			"kristijanhusak/vim-dadbod-completion",
		},
		config = function()
			-- DBUI Configuration
			vim.g.db_ui_save_location = vim.fn.stdpath("config") .. "/db_ui"
			vim.g.db_ui_show_database_icon = true
			vim.g.db_ui_tmp_query_location = vim.fn.stdpath("cache") .. "/db_ui"
			vim.g.db_ui_use_nerd_fonts = true
			vim.g.db_ui_execute_on_save = false

			-- Auto-complete setup for SQL files
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "sql", "mysql", "plsql" },
				callback = function()
					require("cmp").setup.buffer({
						sources = {
							{ name = "vim-dadbod-completion" },
							{ name = "buffer" },
						},
					})
				end,
			})

			-- Key mappings for DBUI
			vim.keymap.set("n", "<leader>db", "<cmd>DBUI<cr>", { desc = "Open Database UI" })
			vim.keymap.set("n", "<leader>dt", "<cmd>DBUIToggle<cr>", { desc = "Toggle Database UI" })
			vim.keymap.set("n", "<leader>df", "<cmd>DBUIFindBuffer<cr>", { desc = "Find Database Buffer" })
			vim.keymap.set("n", "<leader>dr", "<cmd>DBUIRenameBuffer<cr>", { desc = "Rename Database Buffer" })
			vim.keymap.set("n", "<leader>dq", "<cmd>DBUILastQueryInfo<cr>", { desc = "Last Query Info" })

			-- Visual mode mapping for executing selected SQL
			vim.keymap.set("v", "<leader>de", "<cmd>DBUIExecute<cr>", { desc = "Execute Selected SQL" })
		end,
	},
}
