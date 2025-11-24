-- Git tools and integrations
return {
	-- Git signs and hunk management
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			on_attach = function(bufnr)
				local gitsigns = require 'gitsigns'

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map('n', ']c', function()
					if vim.wo.diff then
						vim.cmd.normal { ']c', bang = true }
					else
						gitsigns.nav_hunk 'next'
					end
				end, { desc = 'Jump to next git [c]hange' })

				map('n', '[c', function()
					if vim.wo.diff then
						vim.cmd.normal { '[c', bang = true }
					else
						gitsigns.nav_hunk 'prev'
					end
				end, { desc = 'Jump to previous git [c]hange' })

				-- Actions
				-- visual mode
				map('v', '<leader>hs', function()
					gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
				end, { desc = 'git [s]tage hunk' })
				map('v', '<leader>hr', function()
					gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
				end, { desc = 'git [r]eset hunk' })
				-- normal mode
				map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
				map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
				map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
				map('n', '<leader>hu', gitsigns.stage_hunk, { desc = 'git [u]ndo stage hunk' })
				map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
				map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
				map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
				map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
				map('n', '<leader>hD', function()
					gitsigns.diffthis '@'
				end, { desc = 'git [D]iff against last commit' })
				-- Toggles
				map('n', '<leader>tb', gitsigns.toggle_current_line_blame,
					{ desc = '[T]oggle git show [b]lame line' })
				map('n', '<leader>tD', gitsigns.preview_hunk_inline,
					{ desc = '[T]oggle git show [D]eleted' })
			end,
		},
	},
	
	-- Git UI powered by libgit2, inspired by Magit for Emacs
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for async Git ops
			"sindrets/diffview.nvim", -- Optional, for nicer diffs
		},
		cmd = "Neogit",
		keys = {
			{
				"<leader>gg",
				function()
					require("neogit").open()
				end,
				desc = "[G]it: Open Neo[G]it",
			},
			{
				"<leader>gc",
				function()
					require("neogit").open({ kind = "split" })
				end,
				desc = "[G]it: Open Neo[g]it in split",
			},
		},
		config = function()
			require("neogit").setup({
				integrations = {
					diffview = true, -- Use diffview.nvim for diffs if available
				},
				disable_commit_confirmation = false,
				signs = {
					section = { "", "" }, -- collapsed, opened
					item = { "", "" },
				},
				use_magit_keybindings = true,
				commit_popup = {
					kind = "vsplit", -- or "split" | "tab"
				},
				-- You can further tweak things here like:
				-- disable_hint = false,
				-- console_timeout = 2000,
			})
		end,
	},
	
	-- Git conflict resolution
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = true,
		keys = {
			{ "]x", "<Plug>(git-conflict-next-conflict)", desc = "Next Git conflict" },
			{ "[x", "<Plug>(git-conflict-prev-conflict)", desc = "Previous Git conflict" },
			{ "<leader>co", "<Plug>(git-conflict-ours)", desc = "Choose ours" },
			{ "<leader>ct", "<Plug>(git-conflict-theirs)", desc = "Choose theirs" },
			{ "<leader>cb", "<Plug>(git-conflict-both)", desc = "Choose both" },
			{ "<leader>c0", "<Plug>(git-conflict-none)", desc = "Choose none" },
		},
	},
	
	-- Enhanced diff view
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		config = true,
	},

	-- GitHub integration for PRs, issues, and code review
	{
		"pwntester/octo.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		cmd = "Octo",
		keys = {
			-- Pull Request operations
			{
				"<leader>gpl",
				"<cmd>Octo pr list<cr>",
				desc = "[G]it: [P]R [L]ist",
			},
			{
				"<leader>gpc",
				"<cmd>Octo pr create<cr>",
				desc = "[G]it: [P]R [C]reate",
			},
			{
				"<leader>gpo",
				"<cmd>Octo pr checkout<cr>",
				desc = "[G]it: [P]R Check[o]ut",
			},
			{
				"<leader>gpr",
				"<cmd>Octo review start<cr>",
				desc = "[G]it: [P]R [R]eview start",
			},
			{
				"<leader>gps",
				"<cmd>Octo pr checks<cr>",
				desc = "[G]it: [P]R Check[s] (CI status)",
			},
			{
				"<leader>gpm",
				"<cmd>Octo pr merge<cr>",
				desc = "[G]it: [P]R [M]erge",
			},
			-- Issue operations
			{
				"<leader>gil",
				"<cmd>Octo issue list<cr>",
				desc = "[G]it: [I]ssue [L]ist",
			},
			{
				"<leader>gic",
				"<cmd>Octo issue create<cr>",
				desc = "[G]it: [I]ssue [C]reate",
			},
			{
				"<leader>gio",
				"<cmd>Octo issue close<cr>",
				desc = "[G]it: [I]ssue Cl[o]se",
			},
			-- Review operations
			{
				"<leader>grs",
				"<cmd>Octo review start<cr>",
				desc = "[G]it: [R]eview [S]tart",
			},
			{
				"<leader>grc",
				"<cmd>Octo review commit<cr>",
				desc = "[G]it: [R]eview [C]ommit",
			},
			{
				"<leader>gra",
				"<cmd>Octo review submit approve<cr>",
				desc = "[G]it: [R]eview [A]pprove",
			},
			{
				"<leader>grr",
				"<cmd>Octo review submit request_changes<cr>",
				desc = "[G]it: [R]eview [R]equest changes",
			},
			-- Search
			{
				"<leader>gss",
				"<cmd>Octo search<cr>",
				desc = "[G]it: [S]earch i[s]sues/PRs",
			},
		},
		config = function()
			require("octo").setup({
				-- Enable Tree-sitter highlighting for markdown
				enable_builtin = true,
				-- Default remote to use for PRs when multiple remotes exist
				default_remote = { "origin" },
				-- Use SSH instead of HTTPS for git operations
				ssh_aliases = {},
				-- PR/Issue display configuration
				picker = "telescope",
				-- Use emojis for reactions
				reaction_viewer_hint_icon = "",
				user_icon = " ",
				timeline_marker = "",
				timeline_indent = "2",
				-- Snippet configuration
				snippet_context_lines = 4,
				-- File panel configuration
				file_panel = {
					size = 10,
					use_icons = true,
				},
				-- Mappings within Octo buffers (when viewing PR/issue)
				mappings = {
					issue = {
						close_issue = { lhs = "<leader>ic", desc = "close issue" },
						reopen_issue = { lhs = "<leader>io", desc = "reopen issue" },
						list_issues = { lhs = "<leader>il", desc = "list open issues" },
						reload = { lhs = "<C-r>", desc = "reload issue" },
						open_in_browser = { lhs = "<C-b>", desc = "open in browser" },
						copy_url = { lhs = "<C-y>", desc = "copy url to clipboard" },
						add_assignee = { lhs = "<leader>aa", desc = "add assignee" },
						remove_assignee = { lhs = "<leader>ad", desc = "remove assignee" },
						add_label = { lhs = "<leader>la", desc = "add label" },
						remove_label = { lhs = "<leader>ld", desc = "remove label" },
						goto_issue = { lhs = "<leader>gi", desc = "goto issue" },
					},
					pull_request = {
						checkout_pr = { lhs = "<leader>po", desc = "checkout PR" },
						merge_pr = { lhs = "<leader>pm", desc = "merge PR" },
						list_commits = { lhs = "<leader>pc", desc = "list commits" },
						list_changed_files = { lhs = "<leader>pf", desc = "list changed files" },
						show_pr_diff = { lhs = "<leader>pd", desc = "show PR diff" },
						add_reviewer = { lhs = "<leader>va", desc = "add reviewer" },
						remove_reviewer = { lhs = "<leader>vd", desc = "remove reviewer" },
						close_pr = { lhs = "<leader>ic", desc = "close PR" },
						reopen_pr = { lhs = "<leader>io", desc = "reopen PR" },
						list_prs = { lhs = "<leader>il", desc = "list open PRs" },
						reload = { lhs = "<C-r>", desc = "reload PR" },
						open_in_browser = { lhs = "<C-b>", desc = "open in browser" },
						copy_url = { lhs = "<C-y>", desc = "copy url" },
						goto_file = { lhs = "gf", desc = "goto file" },
						add_assignee = { lhs = "<leader>aa", desc = "add assignee" },
						remove_assignee = { lhs = "<leader>ad", desc = "remove assignee" },
						add_label = { lhs = "<leader>la", desc = "add label" },
						remove_label = { lhs = "<leader>ld", desc = "remove label" },
						goto_issue = { lhs = "<leader>gi", desc = "goto issue" },
					},
					review_thread = {
						goto_issue = { lhs = "<leader>gi", desc = "goto issue" },
						add_comment = { lhs = "<leader>ca", desc = "add comment" },
						delete_comment = { lhs = "<leader>cd", desc = "delete comment" },
						next_comment = { lhs = "]c", desc = "next comment" },
						prev_comment = { lhs = "[c", desc = "previous comment" },
						select_next_entry = { lhs = "]q", desc = "next entry" },
						select_prev_entry = { lhs = "[q", desc = "previous entry" },
						close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
					},
					submit_win = {
						approve_review = { lhs = "<C-a>", desc = "approve review" },
						comment_review = { lhs = "<C-m>", desc = "comment review" },
						request_changes = { lhs = "<C-r>", desc = "request changes" },
						close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
					},
					review_diff = {
						add_review_comment = { lhs = "<leader>ca", desc = "add review comment" },
						add_review_suggestion = { lhs = "<leader>cs", desc = "add review suggestion" },
						focus_files = { lhs = "<leader>e", desc = "focus files panel" },
						toggle_files = { lhs = "<leader>b", desc = "toggle files panel" },
						next_thread = { lhs = "]t", desc = "next thread" },
						prev_thread = { lhs = "[t", desc = "previous thread" },
						select_next_entry = { lhs = "]q", desc = "next entry" },
						select_prev_entry = { lhs = "[q", desc = "previous entry" },
						close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
						toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewed" },
						goto_file = { lhs = "gf", desc = "goto file" },
					},
					file_panel = {
						next_entry = { lhs = "j", desc = "next entry" },
						prev_entry = { lhs = "k", desc = "previous entry" },
						select_entry = { lhs = "<cr>", desc = "select entry" },
						refresh_files = { lhs = "R", desc = "refresh files" },
						focus_files = { lhs = "<leader>e", desc = "focus files" },
						toggle_files = { lhs = "<leader>b", desc = "toggle files" },
						select_next_entry = { lhs = "]q", desc = "next entry" },
						select_prev_entry = { lhs = "[q", desc = "previous entry" },
						close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
						toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewed" },
					},
				},
			})
		end,
	},
}
