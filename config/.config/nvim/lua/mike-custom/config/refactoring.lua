-- Advanced code refactoring capabilities
return {
	-- Refactoring plugin with language-aware operations
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			-- Extract function (visual mode)
			{
				"<leader>Re",
				":Refactor extract ",
				mode = "x",
				desc = "Extract function",
			},
			-- Extract function to file (visual mode)
			{
				"<leader>Rf",
				":Refactor extract_to_file ",
				mode = "x",
				desc = "Extract function to file",
			},
			-- Extract variable (visual mode)
			{
				"<leader>Rv",
				":Refactor extract_var ",
				mode = "x",
				desc = "Extract variable",
			},
			-- Extract constant (visual mode)
			{
				"<leader>Rc",
				function()
					require("refactoring").select_refactor()
				end,
				mode = "x",
				desc = "Extract constant (refactor menu)",
			},
			-- Inline variable (normal and visual mode)
			{
				"<leader>Ri",
				":Refactor inline_var",
				mode = { "n", "x" },
				desc = "Inline variable",
			},
			-- Inline function (normal mode)
			{
				"<leader>RI",
				":Refactor inline_func",
				mode = "n",
				desc = "Inline function",
			},
			-- Extract block (normal mode)
			{
				"<leader>Rb",
				":Refactor extract_block",
				mode = "n",
				desc = "Extract block",
			},
			-- Extract block to file (normal mode)
			{
				"<leader>Rbf",
				":Refactor extract_block_to_file",
				mode = "n",
				desc = "Extract block to file",
			},
			-- Refactoring menu (show all available refactorings)
			{
				"<leader>Rq",
				function()
					require("refactoring").select_refactor()
				end,
				mode = { "n", "x" },
				desc = "Refactoring menu",
			},
		},
		opts = {
			-- Automatically prompt for function/variable name
			prompt_func_return_type = {
				go = false,
				java = false,
				cpp = true,
				c = true,
				h = true,
				hpp = true,
				cxx = true,
			},
			prompt_func_param_type = {
				go = false,
				java = false,
				cpp = true,
				c = true,
				h = true,
				hpp = true,
				cxx = true,
			},
			-- Print debug statements
			printf_statements = {},
			print_var_statements = {},
		},
		config = function(_, opts)
			require("refactoring").setup(opts)

			-- Load refactoring Telescope extension (if available)
			local has_telescope, telescope = pcall(require, "telescope")
			if has_telescope then
				telescope.load_extension("refactoring")
			end
		end,
	},
}
