return {
	-- Treesitter-based refactoring (extract, inline)
	--
	-- Supported: extract variable, extract function (+ to file), extract block,
	--            inline variable, inline function
	-- Languages: Python, TypeScript, JavaScript, Lua, Go, Ruby, Java, C/C++, PHP, C#
	--
	-- NOT supported (IntelliJ gaps):
	--   - Move (class/function to another file)
	--   - Change signature (reorder/add/remove params)
	--   - Safe delete (checks references before removing)
	--   - Pull up / push down members
	--   - Introduce parameter
	--
	-- Uses treesitter (syntax), not LSP (semantics) — works offline but
	-- lacks type awareness. Less sophisticated than IntelliJ, more reliable
	-- than text manipulation.
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{ "<leader>re", mode = "x", function() require("refactoring").refactor("Extract Function") end, desc = "Extract function" },
			{ "<leader>rv", mode = "x", function() require("refactoring").refactor("Extract Variable") end, desc = "Extract variable" },
			{ "<leader>ri", mode = { "n", "x" }, function() require("refactoring").refactor("Inline Variable") end, desc = "Inline variable" },
			{ "<leader>rI", function() require("refactoring").refactor("Inline Function") end, desc = "Inline function" },
			{ "<leader>rb", function() require("refactoring").refactor("Extract Block") end, desc = "Extract block" },
			{ "<leader>rB", function() require("refactoring").refactor("Extract Block To File") end, desc = "Extract block to file" },
		},
		opts = {},
	},
}
