-- Git UI powered by libgit2, inspired by Magit for Emacs
-- See: https://github.com/NeogitOrg/neogit

return {
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
				section = { "", "" }, -- collapsed, opened
				item = { "", "" },
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
}
