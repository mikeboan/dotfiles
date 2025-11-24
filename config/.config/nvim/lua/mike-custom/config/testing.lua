-- Test runners and debugging
return {
	-- Modern test runner with inline results
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			-- Test adapters
			"nvim-neotest/neotest-jest",
			"nvim-neotest/neotest-python",
			"olimorris/neotest-rspec",
			"marilari88/neotest-vitest",
		},
		keys = {
			-- Core test operations (matching ideavimrc pattern)
			{
				"<leader>t",
				function()
					require("neotest").run.run()
				end,
				desc = "Run nearest test",
			},
			{
				"<leader>T",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Run file tests",
			},
			{
				"<leader>a",
				function()
					require("neotest").run.run(vim.fn.getcwd())
				end,
				desc = "Run all tests",
			},
			{
				"<leader>l",
				function()
					require("neotest").run.run_last()
				end,
				desc = "Run last test",
			},
			{
				"<leader>tv",
				function()
					require("neotest").jump.next({ status = "failed" })
				end,
				desc = "Visit next failed test",
			},
			-- Neotest UI features
			{
				"<leader>ts",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Toggle test summary",
			},
			{
				"<leader>to",
				function()
					require("neotest").output.open({ enter = true, auto_close = true })
				end,
				desc = "Show test output",
			},
			{
				"<leader>tO",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "Toggle test output panel",
			},
			-- Debug test
			{
				"<leader>td",
				function()
					require("neotest").run.run({ strategy = "dap" })
				end,
				desc = "Debug nearest test",
			},
			-- Stop test
			{
				"<leader>tx",
				function()
					require("neotest").run.stop()
				end,
				desc = "Stop test",
			},
			-- Watch tests
			{
				"<leader>tw",
				function()
					require("neotest").watch.toggle(vim.fn.expand("%"))
				end,
				desc = "Toggle watch mode",
			},
		},
		config = function()
			require("neotest").setup({
				adapters = {
					-- Jest for TypeScript, JavaScript, React, Angular
					require("neotest-jest")({
						jestCommand = "npm test --",
						jestConfigFile = "jest.config.js",
						env = { CI = true },
						cwd = function()
							return vim.fn.getcwd()
						end,
					}),
					-- Pytest for Python and Django
					require("neotest-python")({
						dap = { justMyCode = false },
						runner = "pytest",
						python = function()
							-- Try to use virtual environment python
							local venv = vim.fn.findfile("bin/python", vim.fn.getcwd() .. "/.venv")
							if venv ~= "" then
								return vim.fn.getcwd() .. "/.venv/bin/python"
							end
							return "python"
						end,
						args = { "--log-level", "DEBUG", "--verbose" },
					}),
					-- RSpec for Ruby/Rails
					require("neotest-rspec")({
						rspec_cmd = function()
							return vim.tbl_flatten({
								"bundle",
								"exec",
								"rspec",
							})
						end,
					}),
					-- Vitest for modern TypeScript projects
					require("neotest-vitest"),
				},
				-- Display configuration
				icons = {
					passed = "✓",
					running = "●",
					failed = "✗",
					skipped = "○",
					unknown = "?",
				},
				-- Inline virtual text
				output = {
					open_on_run = false,
				},
				-- Status signs in gutter
				status = {
					enabled = true,
					virtual_text = true,
					signs = true,
				},
				-- Floating windows
				floating = {
					border = "rounded",
					max_height = 0.8,
					max_width = 0.9,
				},
			})
		end,
	},

	-- Test coverage visualization
	{
		"andythigpen/nvim-coverage",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>tc",
				function()
					require("coverage").load(true)
					require("coverage").show()
				end,
				desc = "Show test coverage",
			},
			{
				"<leader>tC",
				function()
					require("coverage").toggle()
				end,
				desc = "Toggle coverage display",
			},
			{
				"<leader>tcc",
				function()
					require("coverage").clear()
				end,
				desc = "Clear coverage",
			},
		},
		config = function()
			require("coverage").setup({
				auto_reload = true,
				-- Language-specific coverage commands
				lang = {
					python = {
						-- Django/pytest coverage
						coverage_command = "coverage json -q -o -",
					},
					javascript = {
						-- Jest coverage
						coverage_file = "coverage/coverage-final.json",
					},
					typescript = {
						-- Jest coverage for TS
						coverage_file = "coverage/coverage-final.json",
					},
					ruby = {
						-- SimpleCov for Rails
						coverage_file = "coverage/.resultset.json",
					},
				},
				-- Visual display
				signs = {
					covered = { hl = "CoverageCovered", text = "▎" },
					uncovered = { hl = "CoverageUncovered", text = "▎" },
					partial = { hl = "CoveragePartial", text = "▎" },
				},
				highlights = {
					covered = { fg = "#8ec07c" }, -- Green
					uncovered = { fg = "#fb4934" }, -- Red
					partial = { fg = "#fabd2f" }, -- Yellow
				},
			})
		end,
	},
	
	-- Debug adapter protocol (DAP)
	{
		"mfussenegger/nvim-dap",
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
			--     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
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
	},
}
