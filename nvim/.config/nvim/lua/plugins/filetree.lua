return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"echasnovski/mini.icons",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file tree" },
			{ "<leader>E", "<cmd>Neotree reveal<cr>", desc = "Reveal current file in tree" },
		},
		opts = {
			close_if_last_window = true,
			filesystem = {
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true, -- auto-refresh on file changes
				filtered_items = {
					visible = true, -- show hidden files dimmed
					hide_dotfiles = false,
					hide_gitignored = false,
					never_show = {
						".DS_Store",
						"__pycache__",
						".git",
					},
				},
			},
			window = {
				position = "left",
				width = 35,
				mappings = {
					["<space>"] = "none", -- don't conflict with leader
					["h"] = "close_node",
					["l"] = "open",
					["s"] = "open_split",
					["v"] = "open_vsplit",
					["Y"] = function(state)
						-- copy path to clipboard
						local node = state.tree:get_node()
						vim.fn.setreg("+", node.path)
						vim.notify("Copied: " .. node.path)
					end,
				},
			},
			default_component_configs = {
				git_status = {
					symbols = {
						added = "",
						modified = "",
						deleted = "",
						renamed = "",
						untracked = "",
						ignored = "",
						unstaged = "",
						staged = "",
						conflict = "",
					},
				},
			},
		},
	},
}
