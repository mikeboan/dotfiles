return {
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
}
