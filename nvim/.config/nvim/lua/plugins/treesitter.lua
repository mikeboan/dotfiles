return {
	-- Treesitter: syntax highlighting and code understanding
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			-- Setup with install directory

			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})

			-- Parsers to auto-install
			local parsers = {
				"bash", "css", "html", "javascript", "json", "lua",
				"markdown", "markdown_inline", "python", "ruby", "scss",
				"tsx", "typescript", "vim", "vimdoc", "yaml",
			}

			-- Install parsers after lazy.nvim is done
			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyDone",
				once = true,
				callback = function()
					require("nvim-treesitter").install(parsers)
				end,
			})
		end,
	},

	-- Textobjects: select/move/swap by syntax
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			-- Required setup call
			require("nvim-treesitter-textobjects").setup({
				select = { lookahead = true },
				move = { set_jumps = true },
			})

			local map = vim.keymap.set
			-- Selection (note: second arg 'textobjects' is required)
			map({ "x", "o" }, "af", function() require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects") end, { desc = "Around function" })
			map({ "x", "o" }, "if", function() require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects") end, { desc = "Inner function" })
			map({ "x", "o" }, "ac", function() require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects") end, { desc = "Around class" })
			map({ "x", "o" }, "ic", function() require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects") end, { desc = "Inner class" })
			map({ "x", "o" }, "aa", function() require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects") end, { desc = "Around argument" })
			map({ "x", "o" }, "ia", function() require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects") end, { desc = "Inner argument" })
			-- Movement
			map({ "n", "x", "o" }, "]f", function() require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects") end, { desc = "Next function" })
			map({ "n", "x", "o" }, "[f", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects") end, { desc = "Prev function" })
			map({ "n", "x", "o" }, "]c", function() require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects") end, { desc = "Next class" })
			map({ "n", "x", "o" }, "[c", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects") end, { desc = "Prev class" })
			-- Swap
			map("n", "<leader>a", function() require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner") end, { desc = "Swap param next" })
			map("n", "<leader>A", function() require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner") end, { desc = "Swap param prev" })
		end,
	},

	-- Sticky context: shows function/class header at top of screen when scrolled
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			enable = true,
			max_lines = 3,
			trim_scope = "outer",
		},
	},
}
