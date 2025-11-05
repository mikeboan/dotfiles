-- LSP Configuration
-- Comprehensive setup for IDE-like experience with automatic server management

return {
	{
		-- Mason: Package manager for LSP servers, DAP servers, linters, and formatters
		"williamboman/mason.nvim",
		config = true,
	},
	{
		-- Mason-LSPConfig: Bridges mason.nvim with nvim-lspconfig
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				-- Automatically install these language servers
				ensure_installed = {
					-- Web Development
					"html",           -- HTML
					"cssls",          -- CSS
					"tailwindcss",    -- Tailwind CSS
					"emmet_ls",       -- Emmet for HTML/CSS
					"angularls",      -- Angular

					-- Python/Django
					"pyright",        -- Python (fast, TypeScript-based)
					-- "pylsp",       -- Alternative Python LSP (uncomment if pyright issues)
					"ruff",           -- Python linting/formatting (replaces ruff_lsp)

					-- Ruby/Rails
					"ruby_lsp",       -- Ruby (newer, faster than Solargraph)

					-- Lua
					"lua_ls",         -- Lua

					-- Markdown
					"marksman",       -- Markdown

					-- JSON/YAML
					"jsonls",         -- JSON
					"yamlls",         -- YAML
				},
				automatic_installation = true,
			})
		end,
	},
	{
		-- LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp", -- LSP completion source
		},
		config = function()
			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			-- Enhanced capabilities for completion
			local capabilities = cmp_nvim_lsp.default_capabilities()

			-- Global LSP keybindings and settings
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Navigation
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

					-- Documentation and Help
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("gK", vim.lsp.buf.signature_help, "Signature Help")

					-- Code Actions and Refactoring
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Workspace and Document Symbols
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

					-- Diagnostics
					map("<leader>q", vim.diagnostic.setloclist, "Open diagnostic Location list")
					map("<leader>Q", vim.diagnostic.setqflist, "Open diagnostic Quickfix list")
					map("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
					map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
					map("<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")

					-- Highlight references when cursor holds
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})
					end

					-- Toggle inlay hints (if supported)
					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- Configure diagnostic display
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●", -- Could be '■', '▎', etc.
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})

			-- Server-specific configurations
			local servers = {
				-- HTML
				html = {
					filetypes = { "html", "templ" },
				},

				-- CSS
				cssls = {
					settings = {
						css = {
							validate = true,
							lint = {
								unknownAtRules = "ignore",
							},
						},
						scss = {
							validate = true,
							lint = {
								unknownAtRules = "ignore",
							},
						},
					},
				},

				-- Tailwind CSS
				tailwindcss = {
					filetypes = { "html", "css", "scss", "javascript", "typescript", "javascriptreact", "typescriptreact" },
					settings = {
						tailwindCSS = {
							experimental = {
								classRegex = {
									"tw`([^`]*)", -- tw`...`
									"tw=\"([^\"]*)", -- <div tw="..." />
									"tw={\"([^\"}]*)", -- <div tw={"..."} />
									"tw\\.\\w+`([^`]*)", -- tw.xxx`...`
									"tw\\(.*?\\)`([^`]*)", -- tw(Component)`...`
								},
							},
						},
					},
				},

				-- Emmet
				emmet_ls = {
					filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss" },
				},

				-- Angular
				angularls = {
					root_dir = lspconfig.util.root_pattern("angular.json", "project.json"),
				},

				-- Python
				pyright = {
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								diagnosticMode = "workspace",
								useLibraryCodeForTypes = true,
								typeCheckingMode = "basic",
								autoImportCompletions = true,
							},
							pythonPath = vim.fn.exepath("python3") or vim.fn.exepath("python"),
						},
					},
					root_dir = function(fname)
						local root_files = {
							"pyproject.toml",
							"setup.py",
							"setup.cfg",
							"requirements.txt",
							"Pipfile",
							"pyrightconfig.json",
							"manage.py", -- Django
						}
						return lspconfig.util.root_pattern(unpack(root_files))(fname)
							or lspconfig.util.find_git_ancestor(fname)
					end,
					on_init = function(client)
						-- Try to detect virtual environment
						local venv_path = os.getenv("VIRTUAL_ENV")
						if venv_path then
							client.config.settings.python.pythonPath = venv_path .. "/bin/python"
						else
							-- Try Poetry
							local poetry_venv = vim.fn.system("poetry env info --path 2>/dev/null"):gsub("\n", "")
							if vim.v.shell_error == 0 and poetry_venv ~= "" then
								client.config.settings.python.pythonPath = poetry_venv .. "/bin/python"
							end
						end
					end,
				},

				-- Ruff (Python linting/formatting)
				ruff = {
					init_options = {
						settings = {
							-- Ruff server configuration
							args = {},
							lineLength = 88,
						},
					},
				},

				-- Ruby
				ruby_lsp = {
					init_options = {
						formatter = "auto",
					},
				},

				-- Lua
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = {
								checkThirdParty = false,
								library = {
									"${3rd}/luv/library",
									unpack(vim.api.nvim_get_runtime_file("", true)),
								},
							},
							completion = {
								callSnippet = "Replace",
							},
							diagnostics = { disable = { "missing-fields" } },
						},
					},
				},

				-- Markdown
				marksman = {},

				-- JSON
				jsonls = {
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},

				-- YAML
				yamlls = {
					settings = {
						yaml = {
							schemaStore = {
								enable = false,
								url = "",
							},
							schemas = require("schemastore").yaml.schemas(),
						},
					},
				},
			}

			-- Setup each server
			for server_name, config in pairs(servers) do
				config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
				lspconfig[server_name].setup(config)
			end
		end,
	},
	{
		-- Schema store for JSON/YAML validation
		"b0o/schemastore.nvim",
	},
	{
		-- Enhanced LSP UI
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		config = function()
			require("lspsaga").setup({
				ui = {
					border = "rounded",
					winblend = 10,
				},
				symbol_in_winbar = {
					enable = true,
				},
				lightbulb = {
					enable = false, -- Disable to avoid conflicts with code actions
				},
			})
		end,
	},
}