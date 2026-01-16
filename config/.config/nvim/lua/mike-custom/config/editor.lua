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

	-- ===================================================================
	-- BIDIRECTIONAL FILE SYNCING
	-- Auto-save and auto-reload for seamless integration with external tools
	-- ===================================================================
	{
		"tmillr/sos.nvim",
		-- Event-driven loading: only activate when actually editing files
		event = { "BufEnter", "FocusGained" },
		opts = {
			-- ============================================================
			-- AUTOSAVE CONFIGURATION
			-- Automatically saves modified buffers after a timeout period
			-- ============================================================

			-- Timeout in milliseconds before triggering autosave
			-- Default: 10000 (10 seconds) - longer than most plugins to avoid conflicts
			-- The timer resets on every buffer change, so rapid typing won't trigger premature saves
			timeout = 10000,

			-- Should all buffers be saved, or just the current one?
			-- true  = :wall (save all modified buffers)
			-- false = :write (save only current buffer)
			-- Recommended: false to avoid saving unrelated buffers you might not want saved yet
			save_on_cmd = "some", -- "all" | "some" | "none"

			-- Should we save buffers when Neovim loses focus?
			-- true = Ensures external tools see your latest changes immediately
			-- This is critical for Claude Code bidirectional syncing
			save_on_focuslost = true,

			-- Should we save buffers when BufLeave fires (switching buffers)?
			-- false = Disabled because it conflicts with oil.nvim mutations
			-- (save_on_focuslost + timer still provide coverage)
			save_on_bufleave = false,

			-- ============================================================
			-- BUFFER FILTERING
			-- Determine which buffers should be auto-saved
			-- ============================================================

			-- Function to determine if a buffer should be auto-saved
			-- Returns true if buffer should be saved, false otherwise
			on_timer = function()
				local buf = vim.api.nvim_get_current_buf()

				-- Get buffer properties
				local buftype = vim.bo[buf].buftype
				local filetype = vim.bo[buf].filetype
				local bufname = vim.api.nvim_buf_get_name(buf)
				local modifiable = vim.bo[buf].modifiable
				local modified = vim.bo[buf].modified

				-- ========================================
				-- EXCLUSION RULES (return false to skip)
				-- ========================================

				-- Skip special buffer types (terminal, quickfix, help, etc.)
				if buftype ~= "" then
					return false
				end

				-- Skip non-modifiable buffers (read-only files)
				if not modifiable then
					return false
				end

				-- Skip if buffer hasn't been modified
				if not modified then
					return false
				end

				-- Skip unnamed/scratch buffers (no filename)
				if bufname == "" or bufname == nil then
					return false
				end

				-- Skip oil.nvim buffers (they handle their own saving via mutations)
				if bufname:match("^oil://") then
					return false
				end

				-- Skip git commit messages (never autosave these!)
				if filetype == "gitcommit" or filetype == "gitrebase" then
					return false
				end

				-- Skip log files (you probably don't want to save log viewers)
				if bufname:match("%.log$") then
					return false
				end

				-- Skip temporary directories
				if bufname:match("^/tmp/") or bufname:match("^/var/tmp/") then
					return false
				end

				-- Skip system log directories
				if bufname:match("^/var/log/") then
					return false
				end

				-- Check if buffer has manually disabled autosave via :AutosaveOff
				-- (We'll add this command below)
				if vim.b[buf].autosave_disabled then
					return false
				end

				-- ========================================
				-- PASSED ALL CHECKS - SAFE TO SAVE
				-- ========================================
				return true
			end,
		},

		-- ============================================================
		-- ADDITIONAL SETUP: Commands and Auto-reload Notifications
		-- ============================================================
		config = function(_, opts)
			-- Setup the plugin with our options
			require("sos").setup(opts)

			-- ========================================
			-- MANUAL TOGGLE COMMANDS
			-- Per-buffer commands to disable/enable autosave
			-- ========================================

			-- :AutosaveOff - Disable autosave for current buffer
			vim.api.nvim_create_user_command("AutosaveOff", function()
				vim.b.autosave_disabled = true
				vim.notify("Autosave disabled for this buffer", vim.log.levels.INFO)
			end, {
				desc = "Disable autosave for current buffer",
			})

			-- :AutosaveOn - Re-enable autosave for current buffer
			vim.api.nvim_create_user_command("AutosaveOn", function()
				vim.b.autosave_disabled = false
				vim.notify("Autosave enabled for this buffer", vim.log.levels.INFO)
			end, {
				desc = "Enable autosave for current buffer",
			})

			-- ========================================
			-- AUTO-RELOAD NOTIFICATION
			-- Notify user when external changes are detected
			-- ========================================

			-- Track the last notification time per buffer to avoid spam
			local last_notify_time = {}
			local notify_cooldown_ms = 2000 -- Don't notify more than once per 2 seconds per buffer

			-- Listen for FileChangedShellPost event (fires after external change detected)
			vim.api.nvim_create_autocmd("FileChangedShellPost", {
				group = vim.api.nvim_create_augroup("sos-reload-notify", { clear = true }),
				callback = function(args)
					local buf = args.buf
					local bufname = vim.api.nvim_buf_get_name(buf)
					local filename = vim.fn.fnamemodify(bufname, ":t") -- Get just the filename

					-- Check cooldown to prevent notification spam
					local now = vim.loop.now()
					local last_time = last_notify_time[buf] or 0

					if (now - last_time) > notify_cooldown_ms then
						vim.notify(
							string.format("󰑓 Reloaded: %s", filename),
							vim.log.levels.INFO,
							{ title = "File Changed" }
						)
						last_notify_time[buf] = now
					end
				end,
			})

			-- ========================================
			-- EXCLUDE OIL.NVIM FROM BUFLEAVE SAVES
			-- Oil handles its own mutations; autosave interferes
			-- ========================================
			vim.api.nvim_create_autocmd("BufEnter", {
				group = vim.api.nvim_create_augroup("sos-oil-exclude", { clear = true }),
				pattern = "oil://*",
				callback = function()
					vim.b.autosave_disabled = true
				end,
			})

			-- ========================================
			-- ENABLE NATIVE AUTOREAD
			-- Ensures Neovim automatically reads external changes
			-- ========================================
			vim.opt.autoread = true

			-- Trigger checktime on various events to detect external changes quickly
			-- sos.nvim does this internally, but we're being explicit for clarity
			vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
				group = vim.api.nvim_create_augroup("sos-checktime", { clear = true }),
				callback = function()
					-- checktime checks all buffers for external modifications
					if vim.fn.getcmdwintype() == "" then -- Don't run in command window
						vim.cmd.checktime()
					end
				end,
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
	{
		"hat0uma/csvview.nvim",
		---@module "csvview"
		---@type CsvView.Options
		opts = {
			parser = { comments = { "#", "//" } },
			keymaps = {
				-- Text objects for selecting fields
				textobject_field_inner = { "if", mode = { "o", "x" } },
				textobject_field_outer = { "af", mode = { "o", "x" } },
				-- Excel-like navigation:
				-- Use <Tab> and <S-Tab> to move horizontally between fields.
				-- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
				-- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
				jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
				jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
				jump_next_row = { "<Enter>", mode = { "n", "v" } },
				jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
			},
		},
		cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
	},
}
