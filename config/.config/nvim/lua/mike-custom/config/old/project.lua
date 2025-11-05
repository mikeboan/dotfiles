-- Session Management
-- resession.nvim manages restoring full sessions (buffers, layout, etc.)
-- LSP handles project root detection automatically

return {

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
}
