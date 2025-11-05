-- Session and project management, etc.
return {
	-- Session Management
	{
		"stevearc/resession.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VimEnter",
		config = function()
			local resession = require("resession")
			resession.setup({
				autosave = {
					enabled = true,
					interval = 60, -- seconds
					notify = false,
				},
			})

			-- Auto load session for project root
			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function()
					-- Don't load session if inside a git commit message
					if vim.bo.filetype == "gitcommit" then
						return
					end

					local cwd = vim.fn.getcwd()
					if resession.get_session(cwd) then
						resession.load(cwd)
					end
				end,
			})

			-- Keymaps
			vim.keymap.set("n", "<leader>sl", resession.load, { desc = "[S]ession [L]oad" })
			vim.keymap.set("n", "<leader>ss", resession.save, { desc = "[S]ession [S]ave" })
			vim.keymap.set("n", "<leader>sd", resession.delete, { desc = "[S]ession [D]elete" })
		end,
	},
	
	-- Task runner
	{
		"stevearc/overseer.nvim",
		cmd = {
			"OverseerToggle",
			"OverseerRun",
			"OverseerRunCmd",
			"OverseerBuild",
			"OverseerQuickAction",
		},
		keys = {
			{ "<leader>oo", "<cmd>OverseerToggle<CR>", desc = "[O]verseer [O]pen task list" },
			{ "<leader>or", "<cmd>OverseerRun<CR>", desc = "[O]verseer [R]un task" },
		},
		config = function()
			local overseer = require("overseer")

			overseer.setup({
				strategy = {
					"toggleterm",
					use_shell = true,
				},
				task_list = {
					direction = "bottom",
					min_height = 25,
					bindings = {
						["q"] = function()
							vim.cmd("OverseerClose")
						end,
					},
				},
			})
		end,
	},
	
	-- Scratch files for quick notes
	{
		"LintaoAmons/scratch.nvim",
		event = "VeryLazy",
		config = function()
			require("scratch").setup({
				scratch_file_dir = vim.fn.stdpath("cache") .. "/scratch.nvim", -- where your scratch files will be put
				filetypes = { "lua", "js", "sh", "ts", "md", "txt", "http", "html", "puml", "py" }, -- you can simply put filetype here
				window_cmd = "edit", -- 'vsplit' | 'split' | 'edit' | 'tabedit' | 'rightbelow vsplit'
				-- file_picker = "fzflua",
				localKeys = {
					{
						filenameContains = { "sh" },
						LocalKeys = {
							{
								cmd = "<CMD>RunShellCurrentLine<CR>",
								key = "<C-r>",
								modes = { "n", "i", "v" },
							},
						},
					},
				},
			})
			
			-- Keymaps
			vim.keymap.set({ "n", "v", "i" }, "<M-C-n>", "<cmd>Scratch<cr>")
			vim.keymap.set({ "n", "v", "i" }, "<M-C-o>", "<cmd>ScratchOpen<cr>")
		end,
	},
}
