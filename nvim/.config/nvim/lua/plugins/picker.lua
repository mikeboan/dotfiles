return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "echasnovski/mini.icons" },
		cmd = "FzfLua",
		keys = {
			-- File pickers
			{ "<leader>ff", function() require("fzf-lua").files() end, desc = "Find files" },
			{ "<leader>fg", function() require("fzf-lua").live_grep() end, desc = "Live grep" },
			{ "<leader>fw", function() require("fzf-lua").grep_cword() end, desc = "Grep word under cursor" },
			{ "<leader>fW", function() require("fzf-lua").grep_cWORD() end, desc = "Grep WORD under cursor" },
			{ "<leader>fr", function() require("fzf-lua").resume() end, desc = "Resume last picker" },
			{ "<leader>fo", function() require("fzf-lua").oldfiles() end, desc = "Recent files" },

			-- Buffer/navigation
			{ "<leader>fb", function() require("fzf-lua").buffers() end, desc = "Buffers" },
			{ "<leader>fh", function() require("fzf-lua").helptags() end, desc = "Help tags" },
			{ "<leader>fk", function() require("fzf-lua").keymaps() end, desc = "Keymaps" },
			{ "<leader>f:", function() require("fzf-lua").command_history() end, desc = "Command history" },
			{ "<leader>f/", function() require("fzf-lua").search_history() end, desc = "Search history" },

			-- Git
			{ "<leader>gs", function() require("fzf-lua").git_status() end, desc = "Git status" },
			{ "<leader>gc", function() require("fzf-lua").git_commits() end, desc = "Git commits" },
			{ "<leader>gb", function() require("fzf-lua").git_branches() end, desc = "Git branches" },

			-- LSP
			{ "<leader>fs", function() require("fzf-lua").lsp_document_symbols() end, desc = "Document symbols" },
			{ "<leader>fS", function() require("fzf-lua").lsp_workspace_symbols() end, desc = "Workspace symbols" },
			{ "<leader>fd", function() require("fzf-lua").diagnostics_document() end, desc = "Document diagnostics" },
			{ "<leader>fD", function() require("fzf-lua").diagnostics_workspace() end, desc = "Workspace diagnostics" },
		},
		opts = {
			"telescope",
			files = {
				cwd_prompt = false,
				git_icons = true,
				file_icons = true,
				fd_opts = "--type f --hidden --exclude .git",
			},
			grep = {
				rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --hidden --glob=!.git/",
			},
			keymap = {
				fzf = {
					-- Inside the fzf window
					["ctrl-q"] = "select-all+accept", -- send all to quickfix
					["ctrl-d"] = "half-page-down",
					["ctrl-u"] = "half-page-up",
				},
				builtin = {
					-- Inside the nvim picker
					["<C-d>"] = "preview-page-down",
					["<C-u>"] = "preview-page-up",
				},
			},
		},
	},
}
