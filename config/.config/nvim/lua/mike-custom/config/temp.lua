-- Landing zone for new plugins I'm trying out before I adopt them.
return {
	-- Highlights convenient letters for f/t/F/T motions.
	-- Would live in editor.lua if adopted
	{ "unblevable/quick-scope" },

	-- Substitute operator (see keymaps in config fn)
	-- Would live in editor.lua if adopted
	{
		"gbprod/substitute.nvim",
		config = function()
			vim.keymap.set("n", "<leader>s", require("substitute").operator, { noremap = true })
			vim.keymap.set("n", "<leader>ss", require("substitute").line, { noremap = true })
			vim.keymap.set("n", "<leader>S", require("substitute").eol, { noremap = true })
			vim.keymap.set("x", "<leader>s", require("substitute").visual, { noremap = true })
		end,
	},
}
