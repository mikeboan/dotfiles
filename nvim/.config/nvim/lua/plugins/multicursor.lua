return {
	{
		"jake-stewart/multicursor.nvim",
		event = "VeryLazy",
		config = function()
			local mc = require("multicursor-nvim")
			mc.setup()

			local map = vim.keymap.set

			-- Add/skip/remove cursors on matches
			map({ "n", "x" }, "<C-n>", function() mc.matchAddCursor(1) end, { desc = "Add cursor on next match" })
			map({ "n", "x" }, "<C-p>", function() mc.matchSkipCursor(1) end, { desc = "Skip match, move to next" })
			map({ "n", "x" }, "<C-x>", function() mc.matchDeleteCursor() end, { desc = "Remove cursor on current match" })

			-- Add cursors above/below
			map({ "n", "x" }, "<C-Up>", function() mc.lineAddCursor(-1) end, { desc = "Add cursor above" })
			map({ "n", "x" }, "<C-Down>", function() mc.lineAddCursor(1) end, { desc = "Add cursor below" })

			-- Add cursors to all matches
			map({ "n", "x" }, "<C-S-n>", function() mc.matchAllAddCursors() end, { desc = "Add cursors to all matches" })

			-- Escape to clear cursors
			map("n", "<Esc>", function()
				if mc.hasCursors() then
					mc.clearCursors()
				else
					vim.cmd("nohlsearch")
				end
			end)
		end,
	},
}
