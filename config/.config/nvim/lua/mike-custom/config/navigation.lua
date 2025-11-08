-- Moving around code and files (marks, etc.)
return {
	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			-- Telescope is a fuzzy finder that comes with a lot of different things that
			-- it can fuzzy find! It's more than just a "file finder", it can search
			-- many different aspects of Neovim, your workspace, LSP, and more!
			--
			-- The easiest way to use Telescope, is to start by doing something like:
			--  :Telescope help_tags
			--
			-- After running this command, a window will open up and you're able to
			-- type in the prompt window. You'll see a list of `help_tags` options and
			-- a corresponding preview of the help.
			--
			-- Two important keymaps to use while in Telescope are:
			--  - Insert mode: <c-/>
			--  - Normal mode: ?
			--
			-- This opens a window that shows you all of the keymaps for the current
			-- Telescope picker. This is really useful to discover what Telescope can
			-- do as well as how to actually do it!

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			require("telescope").setup({
				-- You can put your default mappings / updates / etc. in here
				--  All the info you're looking for is in `:help telescope.setup()`
				--
				defaults = {
					layout_strategy = "horizontal",
					path_display = { "smart" },
					--   mappings = {
					--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
					--   },
				},
				-- pickers = {}
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
			vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "[F]ind [S]elect Telescope" })
			vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind current [W]ord" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
			vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume" })
			vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>f/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[F]ind [/] in Open Files" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>fn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[F]ind [N]eovim files" })

			-- LSP integrated searching (using Find prefix for consistency)
			-- Note: gd, gr, gi are the primary LSP bindings, these are alternatives via telescope
			vim.keymap.set("n", "<leader>fd", builtin.lsp_definitions, { desc = "[F]ind [D]efinitions (LSP)" })
			vim.keymap.set("n", "<leader>fR", builtin.lsp_references, { desc = "[F]ind [R]eferences (LSP)" })
			vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations, { desc = "[F]ind [I]mplementations (LSP)" })
			vim.keymap.set("n", "<leader>ft", builtin.lsp_type_definitions, { desc = "[F]ind [T]ype Definitions (LSP)" })
		end,
	},
	
	-- Show pending keybinds
	{
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		opts = {
			-- delay between pressing a key and opening which-key (milliseconds)
			-- this setting is independent of vim.opt.timeoutlen
			delay = 200,
			icons = {
				-- set icon mappings to true if you have a Nerd Font
				mappings = vim.g.have_nerd_font,
				-- If you are using a Nerd Font: set icons.keys to an empty table which will use the
				-- default which-key.nvim defined Nerd Font icons, otherwise define a string table
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

			-- Document existing key chains (IDE-aligned)
			spec = {
				{ "<leader>f", group = "[F]ind", mode = { "n", "x" } },
				{ "<leader>g", group = "[g]it", mode = { "n", "x" } },
				{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
				{ "<leader>R", group = "[R]efactor" },
				{ "<leader>D", group = "[D]ocumentation" },
				{ "<leader>w", group = "[W]indow" },
				{ "<leader>s", group = "[S]plit" },
				{ "<leader>e", group = "[E]xplorer" },
				{ "<leader>t", group = "[t]est" },
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
			default_mappings = true, -- Enable default mark mappings (mx, dmx, etc.)
			cyclic = true, -- Whether mark moves wrap around buffer ends
			force_write_shada = false, -- Save marks to shada file
			refresh_interval = 250, -- Refresh interval for signs (ms)
			sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
			excluded_filetypes = {
				"qf",
				"NvimTree",
				"toggleterm",
				"TelescopePrompt",
				"alpha",
				"netrw",
			},
			-- Mark groups for bookmarks (using letters a-z for bookmarks)
			bookmark_0 = {
				sign = "⚑",
				virt_text = "bookmark",
				annotate = false,
			},
			mappings = {
				-- Built-in mark operations still work: m{a-zA-Z}, '{a-zA-Z}, `{a-zA-Z}
				-- Additional convenience mappings
				set_next = "m,", -- Set next available mark
				next = "]m", -- Go to next mark
				prev = "[m", -- Go to previous mark
				preview = "m:", -- Preview mark
				set_bookmark0 = "m0", -- Set bookmark (sign)
				delete_bookmark = "dm-", -- Delete bookmark
				delete_bookmark0 = "dm=", -- Delete all bookmarks
			},
		},
	},
}
