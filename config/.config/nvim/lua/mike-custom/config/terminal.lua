-- Terminal integration
return {
	"akinsho/toggleterm.nvim",
	version = "*", -- Latest stable
	opts = {
		size = 20,
		open_mapping = [[<c-\>]], -- Toggle terminal with ctrl+\
		hide_numbers = true,
		shade_terminals = true,
		shading_factor = 2,
		direction = "float", -- could also be "horizontal" or "vertical"
		float_opts = {
			border = "curved",
			winblend = 3,
		},
		shell = vim.o.shell, -- default shell
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		-- Example: terminal for running Django server
		local Terminal = require("toggleterm.terminal").Terminal

		local django = Terminal:new({
			cmd = "python manage.py runserver",
			hidden = true,
			direction = "horizontal",
			on_open = function(term)
				vim.cmd("startinsert!")
			end,
		})

		vim.keymap.set("n", "<leader>td", function()
			django:toggle()
		end, { desc = "[T]oggle [D]jango dev server" })

		-- Example: terminal for Angular dev server
		local angular = Terminal:new({
			cmd = "npm start",
			hidden = true,
			direction = "horizontal",
			on_open = function(term)
				vim.cmd("startinsert!")
			end,
		})

		vim.keymap.set("n", "<leader>ta", function()
			angular:toggle()
		end, { desc = "[T]oggle [A]ngular dev server" })
	end,
}
