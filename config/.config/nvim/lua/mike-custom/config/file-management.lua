-- File navigation and management (neo-tree, oil, etc.)
return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			-- LSP integration for file operations (rename updates imports, etc.)
			{
				"antosha417/nvim-lsp-file-operations",
				config = function()
					require("lsp-file-operations").setup()
				end,
			},
			-- Window picker for opening files in specific splits
			{
				"s1n7ax/nvim-window-picker",
				version = "2.*",
				config = function()
					require("window-picker").setup({
						filter_rules = {
							include_current_win = false,
							autoselect_one = true,
							bo = {
								filetype = { "neo-tree", "neo-tree-popup", "notify" },
								buftype = { "terminal", "quickfix" },
							},
						},
					})
				end,
			},
		},
		cmd = "Neotree",
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "[E]xplorer toggle" },
			{ "<leader>ef", "<cmd>Neotree reveal<cr>", desc = "[E]xplorer [F]ind file" },
			{ "<leader>eb", "<cmd>Neotree buffers<cr>", desc = "[E]xplorer [B]uffers" },
			{ "<leader>eg", "<cmd>Neotree git_status<cr>", desc = "[E]xplorer [G]it status" },
		},
		opts = {
			-- Close neo-tree when it's the last window
			close_if_last_window = true,

			-- Source selector at the top (tabs for filesystem/buffers/git)
			source_selector = {
				winbar = true,
				statusline = false,
				sources = {
					{ source = "filesystem", display_name = " 󰉓 Files " },
					{ source = "buffers", display_name = " 󰈚 Buffers " },
					{ source = "git_status", display_name = " 󰊢 Git " },
				},
			},

			-- Default component configs
			default_component_configs = {
				indent = {
					with_expanders = true,
					expander_collapsed = "",
					expander_expanded = "",
				},
				git_status = {
					symbols = {
						added = "✚",
						modified = "",
						deleted = "✖",
						renamed = "󰁕",
						untracked = "",
						ignored = "",
						unstaged = "󰄱",
						staged = "",
						conflict = "",
					},
				},
			},

			-- Window settings
			window = {
				position = "left",
				width = 35,
				mappings = {
					-- Use <space> to toggle node instead of default
					["<space>"] = false, -- disable so it doesn't conflict with leader
					["l"] = "open",
					["h"] = "close_node",
					["<cr>"] = "open",
					["<tab>"] = "toggle_node",
					["P"] = { "toggle_preview", config = { use_float = true } },
					["s"] = "open_split",
					["v"] = "open_vsplit",
					["w"] = "open_with_window_picker",
					["a"] = { "add", config = { show_path = "relative" } },
					["d"] = "delete",
					["r"] = "rename",
					["c"] = "copy",
					["m"] = "move",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["q"] = "close_window",
					["?"] = "show_help",
					["<"] = "prev_source",
					[">"] = "next_source",
				},
			},

			-- Filesystem source settings
			filesystem = {
				-- Don't hijack netrw (let oil handle `nvim .`)
				hijack_netrw_behavior = "disabled",

				-- Filtering
				filtered_items = {
					visible = false, -- toggle with H
					hide_dotfiles = true,
					hide_gitignored = true,
					hide_by_name = {
						".DS_Store",
						"thumbs.db",
						"node_modules",
					},
					never_show = {
						".DS_Store",
					},
				},

				-- Don't auto-follow, use <leader>ef to reveal manually
				follow_current_file = {
					enabled = false,
				},

				-- Use libuv file watcher for auto-refresh
				use_libuv_file_watcher = true,

				-- File nesting (group related files)
				nesting_rules = {
					["ts"] = { "ts.map", "d.ts", "d.ts.map" },
					["js"] = { "js.map", "d.ts", "d.ts.map" },
					["tsx"] = { "tsx.map" },
					["jsx"] = { "jsx.map" },
					["package.json"] = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml" },
					["go"] = { "go.sum" },
					[".env"] = { ".env.*" },
				},

				-- Group directories first
				group_empty_dirs = false,

				window = {
					mappings = {
						["H"] = "toggle_hidden",
						["/"] = "fuzzy_finder",
						["f"] = "filter_on_submit",
						["<C-x>"] = "clear_filter",
						["[g"] = "prev_git_modified",
						["]g"] = "next_git_modified",
					},
				},
			},

			-- Buffers source settings
			buffers = {
				follow_current_file = {
					enabled = true, -- highlight current buffer
				},
				group_empty_dirs = true,
				show_unloaded = true,
				window = {
					mappings = {
						["bd"] = "buffer_delete",
					},
				},
			},

			-- Git status source settings
			git_status = {
				window = {
					mappings = {
						["A"] = "git_add_all",
						["u"] = "git_unstage_file",
						["a"] = "git_add_file",
						["r"] = "git_revert_file",
						["c"] = "git_commit",
						["p"] = "git_push",
						["gg"] = "git_commit_and_push",
					},
				},
			},
		},
	},

	-- File explorer tree
	-- {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	version = "*",
	-- 	lazy = true,
	-- 	dependencies = {
	-- 		"nvim-tree/nvim-web-devicons", -- optional, but recommended
	-- 	},
	-- 	config = function()
	-- 		require("nvim-tree").setup({
	-- 			-- Prevent nvim-tree from automatically opening when you start Neovim
	-- 			open_on_setup = false,
	-- 			-- Prevent it from opening when you open a file
	-- 			open_on_setup_file = false,
	-- 			-- Prevent it from opening when you create new tabs
	-- 			open_on_tab = false,
	-- 			-- Let oil.nvim handle directory navigation instead of nvim-tree taking over
	-- 			hijack_netrw = false,
	-- 			-- Prevent nvim-tree from replacing empty buffers
	-- 			hijack_unnamed_buffer_when_opening = false,
	-- 			auto_reload_on_write = true,
	-- 			disable_netrw = false,
	-- 			hijack_cursor = false,
	-- 			view = {
	-- 				width = 35,
	-- 				side = "left",
	-- 			},
	-- 			renderer = {
	-- 				highlight_git = true,
	-- 				highlight_opened_files = "all",
	-- 			},
	-- 			filters = {
	-- 				dotfiles = false,
	-- 				custom = { ".DS_Store", "node_modules" },
	-- 			},
	-- 			update_focused_file = {
	-- 				enable = true,
	-- 				update_root = true,
	-- 			},
	-- 			git = {
	-- 				enable = true,
	-- 				ignore = false,
	-- 			},
	-- 			actions = {
	-- 				open_file = {
	-- 					quit_on_open = false,
	-- 				},
	-- 			},
	-- 		})
	--
	-- 		-- Toggle with <leader>e
	-- 		vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "[E]xplorer Toggle" })
	--
	-- 		-- Auto-quit when nvim-tree is the last buffer (so Neovim exits entirely)
	-- 		vim.api.nvim_create_autocmd("QuitPre", {
	-- 			callback = function()
	-- 				local tree_wins = {}
	-- 				local floating_wins = {}
	-- 				local wins = vim.api.nvim_list_wins()
	-- 				for _, w in ipairs(wins) do
	-- 					local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
	-- 					if bufname:match("NvimTree_") ~= nil then
	-- 						table.insert(tree_wins, w)
	-- 					end
	-- 					if vim.api.nvim_win_get_config(w).relative ~= "" then
	-- 						table.insert(floating_wins, w)
	-- 					end
	-- 				end
	-- 				if 1 == #wins - #floating_wins - #tree_wins then
	-- 					for _, w in ipairs(tree_wins) do
	-- 						vim.api.nvim_win_close(w, true)
	-- 					end
	-- 				end
	-- 			end,
	-- 		})
	-- 	end,
	-- },

	-- Oil.nvim for better file editing
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			default_file_explorer = true,
			view_options = {
				show_hidden = true,
			},
			keymaps = {
				-- Disable defaults that interfere with vim-tmux-navigator
				["<C-h>"] = false,
				["<C-l>"] = false,
				-- Replacements
				["<C-x>"] = { "actions.select", opts = { horizontal = true }, desc = "Open in horizontal split" },
				["<C-r>"] = "actions.refresh",
			},
		},
		keys = { { "-", "<cmd>Oil<CR>", desc = "Open parent directory" } },
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
	},
}
