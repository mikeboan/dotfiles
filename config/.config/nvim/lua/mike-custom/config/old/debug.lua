-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
return {
	-- NOTE: Yes, you can install new plugins here!
	"mfussenegger/nvim-dap",
	-- NOTE: And you can specify dependencies as well
	dependencies = {
		-- Creates a beautiful debugger UI
		"rcarriga/nvim-dap-ui",

		-- Required dependency for nvim-dap-ui
		"nvim-neotest/nvim-nio",

		-- Installs the debug adapters for you
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",

		-- JS/TS/Angular/React
		"mxsdev/nvim-dap-vscode-js",
		{
			"microsoft/vscode-js-debug",
			build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
		},

		-- Python/Django
		"mfussenegger/nvim-dap-python",

		-- Ruby/Rails
		-- No additional plugin needed, just mason install "ruby"
	},
	keys = {
		-- Function key bindings for debugging (classic IDE-style)
		{
			"<F5>",
			function()
				require("dap").continue()
			end,
			desc = "Debug: Start/Continue",
		},
		{
			"<F1>",
			function()
				require("dap").step_into()
			end,
			desc = "Debug: Step Into",
		},
		{
			"<F2>",
			function()
				require("dap").step_over()
			end,
			desc = "Debug: Step Over",
		},
		{
			"<F3>",
			function()
				require("dap").step_out()
			end,
			desc = "Debug: Step Out",
		},
		{
			"<F7>",
			function()
				require("dapui").toggle()
			end,
			desc = "Debug: Toggle UI",
		},
		{
			"<leader>b",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Debug: Toggle Breakpoint",
		},
		{
			"<leader>B",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Debug: Set Breakpoint",
		},

		-- Leader-key based bindings (mnemonic and ergonomic)
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Debug: Continue",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "Debug: Step Into",
		},
		{
			"<leader>do",
			function()
				require("dap").step_over()
			end,
			desc = "Debug: Step Over",
		},
		{
			"<leader>du",
			function()
				require("dap").step_out()
			end,
			desc = "Debug: Step Out",
		},
		{
			"<leader>dt",
			function()
				require("dapui").toggle()
			end,
			desc = "Debug: Toggle UI",
		},
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Debug: Toggle Breakpoint",
		},
		{
			"<leader>dB",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Debug: Set Breakpoint Conditionally",
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("mason-nvim-dap").setup({
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_installation = true,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},

			-- You'll need to check that you have the required things installed
			-- online, please don't ask me how to install them :)
			ensure_installed = {
				-- Update this to ensure that you have the debuggers for the langs you want
				"js-debug-adapter",
				"python",
				"ruby",
			},
		})

		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		dapui.setup({
			-- Set icons to characters that are more likely to work in every terminal.
			--    Feel free to remove or use ones that you like more! :)
			--    Don't feel like these are good choices.
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})

		-- Change breakpoint icons
		-- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
		-- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
		-- local breakpoint_icons = vim.g.have_nerd_font
		--     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
		--   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
		-- for type, icon in pairs(breakpoint_icons) do
		--   local tp = 'Dap' .. type
		--   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
		--   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
		-- end

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		-- JS/TS/Angular/React (via vscode-js-debug)
		require("dap-vscode-js").setup({
			debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
			adapters = { "pwa-node", "pwa-chrome" },
		})

		for _, lang in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
			dap.configurations[lang] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-chrome",
					request = "launch",
					name = "Launch Chrome",
					-- TODO: un-hardcode this url/port
					url = "http://localhost:4200",
					webRoot = "${workspaceFolder}",
				},
			}
		end

		-- Python/Django
		require("dap-python").setup("python") -- change to virtualenv path if needed

		-- Ruby/Rails
		dap.adapters.ruby = {
			type = "executable",
			command = "readapt",
			args = { "stdio" },
		}
		dap.configurations.ruby = {
			{
				type = "ruby",
				name = "Rails server",
				request = "launch",
				program = "bin/rails",
				programArgs = { "server" },
			},
		}
	end,
}
