-- Core editor enhancements: surround, comment, text objects
return {
	-- Auto pairs for brackets, quotes, etc.
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		-- Optional dependency
		dependencies = { "hrsh7th/nvim-cmp" },
		config = function()
			require("nvim-autopairs").setup({})
			-- If you want to automatically add `(` after selecting a function or method
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	-- Collection of various small independent plugins/modules
	{
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()

			-- Simple and easy statusline.
			-- You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			local statusline = require("mini.statusline")
			-- set use_icons to true if you have a Nerd Font
			statusline.setup({ use_icons = vim.g.have_nerd_font, set_vim_settings = false })

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			-- statusline.section_location = function()
			-- 	return "%2l:%-2v"
			-- end

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim

			-- Comment in/out in normal or visual mode with:
			-- gcc - toggle line
			-- gc - toggle block
			-- Also defines comment text object of 'gc', as in 'dgc' for
			-- 'delete text block'
			require("mini.comment").setup()

			-- Highlight word under cursor. Makes 'diw', etc. more predictable.
			require("mini.cursorword").setup()

			-- Pretty icons
			require("mini.icons").setup()

			-- Move visual selection with <M-h/j/k/l>
			require("mini.move").setup()
		end,
	},

	-- Enhanced folding
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async", -- required for ufo
		},
		event = "BufReadPost", -- Lazy load after file read
		opts = {
			provider_selector = function(_, filetype, _)
				-- Prefer Treesitter, fallback to indent
				return { "treesitter", "indent" }
			end,
		},
		config = function(_, opts)
			vim.o.foldcolumn = "1" -- Show fold column (or 'auto', '2', '0', etc).
			vim.o.foldlevel = 99 -- Start with all folds open
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
			vim.o.fillchars = "eob: ,fold:▏,foldopen:,foldsep: ,foldclose:"

			require("ufo").setup(opts)

			-- Optional keymaps
			vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
			vim.keymap.set("n", "zp", function()
				require("ufo").peekFoldedLinesUnderCursor()
			end, { desc = "Peek fold under cursor" })
		end,
	},

	-- Automatically set tab character settings based on current buffer
	{
		"tpope/vim-sleuth",
	},

	-- Vim training wheels (disabled by default)
	{
		"m4xshen/hardtime.nvim",
		lazy = false,
		enabled = false,
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
		opts = {
			force_exit_insert_mode = true,
		},
	},

	-- Search and replace across multiple files with a powerful UI
	{
		"nvim-pack/nvim-spectre",
		cmd = "Spectre",
		keys = {
			{
				"<leader>rr",
				function()
					require("spectre").toggle()
				end,
				desc = "[R]eplace: Toggle Spectre UI",
			},
			{
				"<leader>rw",
				function()
					require("spectre").open_visual({ select_word = true })
				end,
				desc = "[R]eplace: Word in project",
				mode = { "n" },
			},
			{
				"<leader>rp",
				function()
					require("spectre").open_file_search({ select_word = true })
				end,
				desc = "[R]eplace: Current [P]ath/file",
			},
		},
		opts = {
			open_cmd = "noswapfile vnew", -- opens in vertical split
			live_update = true, -- auto update as you type
			result_padding = " │ ",
			highlight = {
				ui = "String",
				search = "DiffChange",
				replace = "DiffDelete",
			},
		},
	},

	-- Todo comment highlighting
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	-- Split/join with treesitter intelligence.
	-- eg () => [a, b, c] to () => { return [a, b, c]; } and reverse
	{
		"Wansmer/treesj",
		-- default keys repeated here for documentation
		keys = { "<space>m", "<space>j", "<space>s" },
		dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
		config = function()
			require("treesj").setup({ --[[ your config ]]
			})
		end,
	},

	-- <C-x> and <C-a> for booleans, Months, color names, and more
	{
		"nat-418/boole.nvim",
		config = function()
			require("boole").setup({
				mappings = {
					increment = "<C-a>",
					decrement = "<C-x>",
				},
				-- User defined loops
				-- additions = {
				--   {'Foo', 'Bar'},
				--   {'tic', 'tac', 'toe'}
				-- },
				-- allow_caps_additions = {
				--   {'enable', 'disable'}
				--   -- enable → disable
				--   -- Enable → Disable
				--   -- ENABLE → DISABLE
				-- }
			})
		end,
	},

	-- Multiple cursors (like Ctrl+D in VSCode/IntelliJ)
	-- Primary: vim-visual-multi
	{
		"mg979/vim-visual-multi",
		enabled = true,
		branch = "master",
		keys = {
			{ "<C-n>", mode = { "n", "x" }, desc = "Select next occurrence" },
			{ "<C-p>", mode = { "n", "x" }, desc = "Unselect previous occurrence" },
			{ "<C-S-n>", mode = { "n", "x" }, desc = "Select all occurrences" },
		},
		config = function()
			-- Configure vim-visual-multi to match ideavimrc behavior
			vim.g.VM_maps = {
				["Find Under"] = "<C-n>", -- Select next occurrence
				["Find Subword Under"] = "<C-n>",
				["Skip Region"] = "<C-p>", -- Skip current, select next
				["Remove Region"] = "<C-p>", -- Unselect current
				["Select All"] = "<C-S-n>", -- Select all occurrences
				["Start Regex Search"] = "\\/",
				["Add Cursor Down"] = "<C-Down>",
				["Add Cursor Up"] = "<C-Up>",
				["Visual Cursors"] = "<C-S-l>",
			}
			-- Don't show mappings on startup
			vim.g.VM_show_warnings = 0
		end,
	},

	-- Alternative: nvim-multi-cursor (disabled by default for testing)
	{
		"jake-stewart/multicursor.nvim",
		enabled = false, -- Set to true to test this instead of vim-visual-multi
		branch = "1.0",
		config = function()
			local mc = require("multicursor-nvim")

			mc.setup()

			-- Match ideavimrc keybindings
			vim.keymap.set({ "n", "v" }, "<C-n>", function()
				mc.matchAddCursor(1)
			end, { desc = "Add cursor and jump to next match" })

			vim.keymap.set({ "n", "v" }, "<C-p>", function()
				mc.matchSkipCursor(1)
			end, { desc = "Skip current and add cursor to next match" })

			vim.keymap.set({ "n", "v" }, "<C-S-n>", function()
				mc.matchAllAddCursors()
			end, { desc = "Add cursor to all matches" })

			-- Clear cursors with Esc
			vim.keymap.set({ "n", "v" }, "<Esc>", function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				elseif mc.hasCursors() then
					mc.clearCursors()
				else
					-- Default <esc> handler
				end
			end)

			-- Customize how it looks
			vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "Cursor" })
			vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
			vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
			vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
		end,
	},
}
