-- Moving around code and files (marks, etc.)
return {
	-- Fast fuzzy finder using fzf (much faster than Telescope for large projects)
	{
		"ibhagwan/fzf-lua",
		event = "VimEnter",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			-- fzf-lua is significantly faster than Telescope, especially on large codebases
			-- It uses native fzf under the hood while providing a clean Lua API
			local fzf = require("fzf-lua")

			fzf.setup({
				"telescope",
				"hide",
				winopts = {
					height = 0.85,
					width = 0.85,
					row = 0.35,
					col = 0.50,
					border = "rounded",
					preview = {
						layout = "horizontal",
						horizontal = "right:50%",
						-- scrollbar = "border",
					},
				},
				keymap = {
					fzf = {
						["ctrl-q"] = "select-all+accept",
					},
				},
				files = {
					-- Use fd for faster file finding
					find_opts = [[-type f -not -path '*/\.git/*' -not -path '*/node_modules/*' -not -path '*/.angular/*' -not -path '*/dist/*']],
					fd_opts = "--color=never --type f --hidden --follow --exclude .git --exclude node_modules --exclude .angular --exclude dist",
					git_icons = true,
					file_icons = true,
				},
				grep = {
					-- Use ripgrep for fast grepping (--hidden to include dotfiles like .config)
					rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --hidden -g '!{.git,node_modules,.angular,dist}/*'",
				},
				lsp = {
					symbols = {
						symbol_icons = {
							File = "",
							Module = "",
							Namespace = "",
							Package = "",
							Class = "",
							Method = "",
							Property = "",
							Field = "",
							Constructor = "",
							Enum = "",
							Interface = "",
							Function = "",
							Variable = "",
							Constant = "",
							String = "",
							Number = "",
							Boolean = "",
							Array = "",
							Object = "",
							Key = "",
							Null = "",
						},
					},
				},
			})

			-- File and content searching
			vim.keymap.set("n", "<leader>sf", fzf.files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>sg", fzf.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sw", fzf.grep_cword, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>s/", fzf.lgrep_curbuf, { desc = "[S]earch [/] in current buffer" })
			vim.keymap.set("n", "<leader>/", fzf.blines, { desc = "[/] Fuzzily search in current buffer" })

			-- Buffer and file history
			vim.keymap.set("n", "<leader><leader>", fzf.buffers, { desc = "[ ] Find existing buffers" })
			vim.keymap.set("n", "<leader>s.", fzf.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })

			-- Vim/Neovim helpers
			vim.keymap.set("n", "<leader>sh", fzf.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", fzf.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>ss", fzf.builtin, { desc = "[S]earch [S]elect fzf-lua" })
			vim.keymap.set("n", "<leader>sr", fzf.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>sn", function()
				fzf.files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })

			-- LSP integrated searching
			vim.keymap.set("n", "<leader>sd", fzf.lsp_definitions, { desc = "[S]earch [D]efinitions (LSP)" })
			vim.keymap.set("n", "<leader>sR", fzf.lsp_references, { desc = "[S]earch [R]eferences (LSP)" })
			vim.keymap.set("n", "<leader>si", fzf.lsp_implementations, { desc = "[S]earch [I]mplementations (LSP)" })
			vim.keymap.set("n", "<leader>st", fzf.lsp_typedefs, { desc = "[S]earch [T]ype Definitions (LSP)" })

			-- Diagnostics
			vim.keymap.set("n", "<leader>sD", fzf.diagnostics_document, { desc = "[S]earch [D]iagnostics in document" })
			vim.keymap.set(
				"n",
				"<leader>sW",
				fzf.diagnostics_workspace,
				{ desc = "[S]earch diagnostics in [W]orkspace" }
			)
		end,
	},

	-- UI select replacement for fzf-lua (replaces telescope-ui-select)
	{
		"ibhagwan/fzf-lua",
		opts = function(_, opts)
			local config = require("fzf-lua.config")
			local actions = require("fzf-lua.actions")

			-- Use fzf-lua for vim.ui.select
			config.defaults.actions.files["ctrl-t"] = actions.file_tabedit
			config.defaults.actions.files["ctrl-v"] = actions.file_vsplit
			config.defaults.actions.files["ctrl-x"] = actions.file_split

			-- Register as vim.ui.select handler
			require("fzf-lua").register_ui_select()

			return opts
		end,
	},

	-- Show pending keybinds
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		opts = {
			delay = 200,
			icons = {
				mappings = vim.g.have_nerd_font,
				keys = vim.g.have_nerd_font and {} or {
					Up = "<Up> ",
					Down = "<Down> ",
					Left = "<Left> ",
					Right = "<Right> ",
					C = "<C-…> ",
					M = "<M-…> ",
					D = "<D-…> ",
					S = "<S-…> ",
					CR = "<CR> ",
					Esc = "<Esc> ",
					ScrollWheelDown = "<ScrollWheelDown> ",
					ScrollWheelUp = "<ScrollWheelUp> ",
					NL = "<NL> ",
					BS = "<BS> ",
					Space = "<Space> ",
					Tab = "<Tab> ",
					F1 = "<F1>",
					F2 = "<F2>",
					F3 = "<F3>",
					F4 = "<F4>",
					F5 = "<F5>",
					F6 = "<F6>",
					F7 = "<F7>",
					F8 = "<F8>",
					F9 = "<F9>",
					F10 = "<F10>",
					F11 = "<F11>",
					F12 = "<F12>",
				},
			},

			spec = {
				{ "<leader>s", group = "[S]earch", mode = { "n", "x" } },
				{ "<leader>g", group = "[g]it", mode = { "n", "x" } },
				{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
				{ "<leader>R", group = "[R]efactor" },
				{ "<leader>D", group = "[D]ocumentation" },
				{ "<leader>w", group = "[W]indow/Split" },
				{ "<leader>e", group = "[E]xplorer" },
				{ "<leader>t", group = "[t]est" },
				{ "<leader>a", group = "[a]i" },
				{ "<leader>b", group = "[b]ookmarks" },
				{ "<leader>o", group = "[o]pen" },
				{ "<leader>h", group = "[h]unk (git)" },
				{ "<leader>d", group = "[d]ebug" },
				{ "<leader>r", group = "[r]eplace" },
				{ "<leader>x", group = "[x] diagnostics" },
				{ "<leader>u", group = "[u]i" },
			},
		},
	},

	-- Tmux/vim navigation integration
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},

	-- Enhanced marks visualization and management
	{
		"chentoast/marks.nvim",
		event = "BufReadPost",
		keys = {
			{ "<leader>bt", "<cmd>MarksToggleSigns<cr>", desc = "Toggle bookmark signs" },
			{ "<leader>bs", "<cmd>MarksListBuf<cr>", desc = "Show bookmarks in buffer" },
			{ "<leader>bn", "<cmd>MarksQFListBuf<cr>", desc = "Next bookmark" },
			{ "<leader>bp", "<cmd>MarksQFListAll<cr>", desc = "Previous bookmark" },
		},
		opts = {
			default_mappings = true,
			cyclic = true,
			force_write_shada = false,
			refresh_interval = 250,
			sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
			excluded_filetypes = {
				"qf",
				"NvimTree",
				"toggleterm",
				"alpha",
				"netrw",
			},
			bookmark_0 = {
				sign = "⚑",
				virt_text = "bookmark",
				annotate = false,
			},
			mappings = {
				set_next = "m,",
				next = "]m",
				prev = "[m",
				preview = "m:",
				set_bookmark0 = "m0",
				delete_bookmark = "dm-",
				delete_bookmark0 = "dm=",
			},
		},
	},
}
