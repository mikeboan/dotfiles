return { -- Highlight, edit, and navigate code
	{
		-- Tresitter core
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs", -- Sets main module to use for opts
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
		opts = {
			ensure_installed = {
				-- "angular", install manually, this seems to break it
				"bash",
				"diff",
				"go",
				"gomod",
				"gowork",
				"gosum",
				"html",
				"javascript",
				"json",
				"lua",
				"luadoc",
				"rust",
				"css",
				"vue",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },

			-- Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["ab"] = "@block.outer",
						["ib"] = "@block.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]m"] = "@function.outer",
						["]c"] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[c"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["]a"] = "@parameter.inner",
					},
					swap_previous = {
						["[a"] = "@parameter.inner",
					},
				},
			},
		},
	},
	-- Textobjects module
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter/nvim-treesitter",
		event = "VeryLazy", -- Load after TS to avoid issues
	},

	--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			max_lines = 5,
			trim_scope = "outer",
			multiline_threshold = 20,
			mode = "cursor", -- topline is another good option
		},
	},

	--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
}
