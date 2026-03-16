return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			signs_staged_enable = true,
			current_line_blame = false, -- toggle with <leader>gb
			current_line_blame_opts = {
				delay = 300,
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gs.nav_hunk("next")
					end
				end, { desc = "Next hunk" })

				map("n", "[h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end, { desc = "Previous hunk" })

				-- Actions
				map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
				map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
				map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage hunk" })
				map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset hunk" })
				map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
				map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
				map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
				map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
				map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Blame line (full)" })
				map("n", "<leader>hd", gs.diffthis, { desc = "Diff against index" })
				map("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "Diff against last commit" })

				-- Toggles
				map("n", "<leader>gb", gs.toggle_current_line_blame, { desc = "Toggle line blame" })

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
			end,
		},
	},

	-- Neogit - magit-style interactive git UI
	{
		"NeogitOrg/neogit",
		cmd = "Neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim", -- better diff UI
		},
		keys = {
			{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit status" },
			{ "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Neogit commit" },
			{ "<leader>gl", "<cmd>Neogit log<cr>", desc = "Neogit log" },
		},
		opts = {
			integrations = {
				diffview = true,
			},
		},
	},

	-- Fugitive - git commands (:Git blame, :GBrowse, etc.)
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "Gread", "Gwrite", "GBrowse", "Gdiffsplit" },
		keys = {
			{ "<leader>gB", "<cmd>Git blame<cr>", desc = "Git blame (full file)" },
		},
	},

	-- GBrowse support for GitHub
	{
		"tpope/vim-rhubarb",
		dependencies = { "tpope/vim-fugitive" },
		cmd = { "GBrowse" },
	},
}
