return {
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
}
