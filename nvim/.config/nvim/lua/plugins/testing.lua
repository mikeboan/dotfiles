return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			-- Adapters
			"nvim-neotest/neotest-python",
		},
		keys = {
			{ "<leader>Tr", function() require("neotest").run.run() end, desc = "Run nearest test" },
			{ "<leader>Tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file tests" },
			{ "<leader>Td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test" },
			{ "<leader>Ts", function() require("neotest").run.stop() end, desc = "Stop test" },
			{ "<leader>To", function() require("neotest").output.open({ enter = true }) end, desc = "Show test output" },
			{ "<leader>TO", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
			{ "<leader>Tp", function() require("neotest").summary.toggle() end, desc = "Toggle summary panel" },
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-python")({
						dap = { justMyCode = false },
						-- Use Django test runner
						runner = "django",
						-- Or use pytest if you switch later:
						-- runner = "pytest",
					}),
				},
				status = {
					virtual_text = true,
				},
				output = {
					open_on_run = false,
				},
			})
		end,
	},
}
