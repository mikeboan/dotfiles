return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		event = "InsertEnter",
		dependencies = {
			"rafamadriz/friendly-snippets", -- community snippets
		},
		opts = function(_, opts)
			return vim.tbl_deep_extend("force", opts, {
			keymap = {
				preset = "none",
				-- Vim-native style keybindings
				["<C-n>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-y>"] = { "accept", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<C-e>"] = { "hide", "fallback" },
				["<Tab>"] = { "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
			},
			completion = {
				list = {
					selection = {
						preselect = true,
						auto_insert = false,
					},
				},
				menu = {
					border = "rounded",
					draw = {
						columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = {
						border = "rounded",
					},
				},
				ghost_text = { enabled = true },
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				per_filetype = {
					markdown = { "path" },
					text = { "path" },
					gitcommit = { "path" },
				},
			},
			signature = {
				enabled = true,
				window = {
					border = "rounded",
				},
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
		})
		end,
	},
}
