-- File navigation and management (oil, etc.)
return {
	-- File explorer tree
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = true,
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		config = function()
			require("nvim-tree").setup({
				-- Prevent nvim-tree from automatically opening when you start Neovim
				open_on_setup = false,
				-- Prevent it from opening when you open a file
				open_on_setup_file = false,
				-- Prevent it from opening when you create new tabs
				open_on_tab = false,
				-- Let oil.nvim handle directory navigation instead of nvim-tree taking over
				hijack_netrw = false,
				-- Prevent nvim-tree from replacing empty buffers
				hijack_unnamed_buffer_when_opening = false,
				auto_reload_on_write = true,
				disable_netrw = false,
				hijack_cursor = false,
				view = {
					width = 35,
					side = "left",
				},
				renderer = {
					highlight_git = true,
					highlight_opened_files = "all",
				},
				filters = {
					dotfiles = false,
					custom = { ".DS_Store", "node_modules" },
				},
				update_focused_file = {
					enable = true,
					update_root = true,
				},
				git = {
					enable = true,
					ignore = false,
				},
				actions = {
					open_file = {
						quit_on_open = false,
					},
				},
			})

			-- Toggle with <leader>e
			vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "[E]xplorer Toggle" })

			-- Auto-quit when nvim-tree is the last buffer (so Neovim exits entirely)
			vim.api.nvim_create_autocmd("QuitPre", {
				callback = function()
					local tree_wins = {}
					local floating_wins = {}
					local wins = vim.api.nvim_list_wins()
					for _, w in ipairs(wins) do
						local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
						if bufname:match("NvimTree_") ~= nil then
							table.insert(tree_wins, w)
						end
						if vim.api.nvim_win_get_config(w).relative ~= "" then
							table.insert(floating_wins, w)
						end
					end
					if 1 == #wins - #floating_wins - #tree_wins then
						for _, w in ipairs(tree_wins) do
							vim.api.nvim_win_close(w, true)
						end
					end
				end,
			})
		end,
	},

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
				-- Interferes with vim-tmux navigation. Was horizontal selection
				["<C-h>"] = false,
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
