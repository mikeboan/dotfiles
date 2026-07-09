return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			-- IDE-like debug UI panels (variables, watches, call stack, console)
			{
				"rcarriga/nvim-dap-ui",
				dependencies = { "nvim-neotest/nvim-nio" },
				opts = {},
			},

			-- Inline variable values next to code during debugging
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {},
			},

			-- Auto-install debug adapters via mason
			{
				"jay-babu/mason-nvim-dap.nvim",
				dependencies = { "williamboman/mason.nvim" },
				opts = {
					ensure_installed = { "python", "js" },
					automatic_installation = true,
				},
			},

			-- Python/Django debugging via debugpy
			{
				"mfussenegger/nvim-dap-python",
				ft = "python",
				config = function()
					-- mason installs debugpy here
					local debugpy_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
					require("dap-python").setup(debugpy_path)
				end,
			},
		},
		keys = {
			-- Standard F-key bindings (universal across editors)
			{ "<F5>", function() require("dap").continue() end, desc = "Debug: continue/start" },
			{ "<F10>", function() require("dap").step_over() end, desc = "Debug: step over" },
			{ "<F11>", function() require("dap").step_into() end, desc = "Debug: step into" },
			{ "<F12>", function() require("dap").step_out() end, desc = "Debug: step out" },

			-- Leader bindings
			{ "<leader>dc", function() require("dap").continue() end, desc = "Continue/start" },
			{ "<leader>do", function() require("dap").step_over() end, desc = "Step over" },
			{ "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
			{ "<leader>dO", function() require("dap").step_out() end, desc = "Step out" },
			{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
			{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional breakpoint" },
			{ "<leader>dl", function() require("dap").run_last() end, desc = "Run last" },
			{ "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
			{ "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
			{ "<leader>du", function() require("dapui").toggle() end, desc = "Toggle debug UI" },
			{ "<leader>de", function() require("dapui").eval() end, mode = { "n", "x" }, desc = "Eval expression" },
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Auto-open/close UI when debug session starts/ends
			dap.listeners.after.event_initialized["dapui"] = function() dapui.open() end
			dap.listeners.before.event_terminated["dapui"] = function() dapui.close() end
			dap.listeners.before.event_exited["dapui"] = function() dapui.close() end

			-- Breakpoint signs
			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticWarn" })
			vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiagnosticInfo", linehl = "CursorLine" })
		end,
	},
}
