return {
		"romgrk/barbar.nvim",
		event = "VimEnter",
		dependencies = { "echasnovski/mini.icons" },
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			animation = false, -- disable if you find it distracting
			auto_hide = 1, -- hide when only 1 buffer open
			tabpages = true, -- show vim tab indicator
			clickable = true,
			icons = {
				buffer_index = false,
				buffer_number = false,
				button = "×",
				diagnostics = {
					[vim.diagnostic.severity.ERROR] = { enabled = true, icon = " " },
					[vim.diagnostic.severity.WARN] = { enabled = false },
					[vim.diagnostic.severity.INFO] = { enabled = false },
					[vim.diagnostic.severity.HINT] = { enabled = false },
				},
				filetype = { enabled = true },
				separator = { left = "▎", right = "" },
				modified = { button = "●" },
				pinned = { button = "📌", filename = true },
			},
		},
		keys = {
			-- Navigate buffers
			{ "<S-h>", "<cmd>BufferPrevious<cr>", desc = "Previous buffer" },
			{ "<S-l>", "<cmd>BufferNext<cr>", desc = "Next buffer" },
			-- Reorder buffers
			{ "<A-h>", "<cmd>BufferMovePrevious<cr>", desc = "Move buffer left" },
			{ "<A-l>", "<cmd>BufferMoveNext<cr>", desc = "Move buffer right" },
			-- Jump to buffer (THE KILLER FEATURE)
			{ "<leader>b", "<cmd>BufferPick<cr>", desc = "Pick buffer (jump mode)" },
			{ "<leader>B", "<cmd>BufferPickDelete<cr>", desc = "Pick buffer to close" },
			-- Close buffers
			{ "<leader>x", "<cmd>BufferClose<cr>", desc = "Close buffer" },
			{ "<leader>X", "<cmd>BufferCloseAllButCurrentOrPinned<cr>", desc = "Close other buffers" },
			-- Pin buffer
			{ "<leader>p", "<cmd>BufferPin<cr>", desc = "Pin buffer" },
		},
}
