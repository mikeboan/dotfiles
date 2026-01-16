-- ===================================================================
-- LANGUAGE SUPPORT CONFIGURATION
-- Comprehensive language support including LSP, Treesitter,
-- Formatting, Linting, and Diagnostics
--
-- LSP server configs are in ~/.config/nvim/lsp/*.lua (Neovim 0.11+ native)
-- Per-project configs via .nvim.lua files (enabled by vim.o.exrc = true)
-- ===================================================================

return {
	-- ===================================================================
	-- MASON: Package manager for LSP servers, formatters, linters
	-- Only handles installation, NOT automatic enabling
	-- ===================================================================
	{
		"williamboman/mason.nvim",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				-- Python
				"basedpyright",
				"ruff",
				-- TypeScript/JavaScript
				"vtsls",
				-- Angular
				"angularls",
				-- Web
				"html",
				"cssls",
				"tailwindcss",
				"emmet_ls",
				-- Lua
				"lua_ls",
				-- Ruby
				"ruby_lsp",
				-- Markdown
				"marksman",
				-- JSON/YAML
				"jsonls",
				"yamlls",
			},
			-- CRITICAL: Do NOT auto-enable servers - we use vim.lsp.enable() instead
			automatic_enable = false,
		},
	},

	-- ===================================================================
	-- LSP CORE CONFIGURATION
	-- Uses Neovim 0.11+ native vim.lsp.config() and vim.lsp.enable()
	-- Server configs are in ~/.config/nvim/lsp/*.lua
	-- ===================================================================
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"b0o/schemastore.nvim",
		},
		config = function()
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			-- Enhanced capabilities for completion
			local capabilities = cmp_nvim_lsp.default_capabilities()

			-- Apply capabilities to all LSP servers
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			-- Configure JSON schemas (requires schemastore to be loaded)
			vim.lsp.config("jsonls", {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})

			-- Configure YAML schemas
			vim.lsp.config("yamlls", {
				settings = {
					yaml = {
						schemaStore = {
							enable = false,
							url = "",
						},
						schemas = require("schemastore").yaml.schemas(),
					},
				},
			})

			-- Global LSP keybindings (set when any LSP attaches)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Navigation
					map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")
					map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
					map("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					map("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]efinition")

					-- Documentation and Help
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("gK", vim.lsp.buf.signature_help, "Signature Help")

					-- Code Actions and Refactoring
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					map("<leader>cA", function()
						vim.lsp.buf.code_action({
							apply = true,
							context = { only = { "source.addMissingImports" }, diagnostics = {} },
						})
					end, "[C]ode [A]ction (auto-import)")
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Workspace and Document Symbols
					map("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]ymbols")
					map("<leader>ws", require("fzf-lua").lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")

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
					prefix = "●",
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = true,
					header = "",
					prefix = "",
				},
			})

			-- Enable all LSP servers (configs loaded from ~/.config/nvim/lsp/*.lua)
			vim.lsp.enable({
				"basedpyright",
				"ruff",
				"vtsls",
				"angularls",
				"lua_ls",
				"html",
				"cssls",
				"tailwindcss",
				"emmet_ls",
				"jsonls",
				"yamlls",
				"marksman",
				"ruby_lsp",
			})
		end,
	},

	-- ===================================================================
	-- PYTHON VIRTUAL ENVIRONMENT SELECTOR
	-- Supports poetry, pyenv, pipenv, conda, venv
	-- ===================================================================
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-telescope/telescope.nvim",
			"mfussenegger/nvim-dap-python",
		},
		lazy = false,
		config = function()
			require("venv-selector").setup({
				settings = {
					search = {
						-- Poetry virtualenvs
						poetry = {
							command = "fd python$ ~/.cache/pypoetry/virtualenvs --type x --full-path",
						},
						-- Pyenv versions
						pyenv = {
							command = "fd python$ ~/.pyenv/versions --type x --full-path",
						},
						-- Pipenv
						pipenv = {
							command = "fd python$ ~/.local/share/virtualenvs --type x --full-path",
						},
						-- Local .venv directories
						venv = {
							command = "fd python$ .venv --type x --full-path",
						},
						-- Conda environments
						conda = {
							command = "fd python$ ~/anaconda3/envs --type x --full-path 2>/dev/null || fd python$ ~/miniconda3/envs --type x --full-path 2>/dev/null",
						},
					},
				},
				options = {
					notify_user_on_venv_activation = true,
				},
			})
		end,
		keys = {
			{ "<leader>vs", "<cmd>VenvSelect<cr>", desc = "[V]env [S]elect" },
			{ "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "[V]env Select [C]ached" },
		},
	},

	-- ===================================================================
	-- SCHEMA STORE for JSON/YAML validation
	-- ===================================================================
	{
		"b0o/schemastore.nvim",
	},

	-- ===================================================================
	-- ENHANCED LSP UI
	-- ===================================================================
	{
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
					enable = false,
				},
			})
		end,
	},

	-- ===================================================================
	-- TREESITTER CONFIGURATION
	-- Highlight, edit, and navigate code
	-- ===================================================================
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		opts = {
			ensure_installed = {
				"bash",
				"diff",
				"go",
				"gomod",
				"gowork",
				"gosum",
				"html",
				"javascript",
				"json",
				"lua",
				"luadoc",
				"rust",
				"css",
				"vue",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["ab"] = "@block.outer",
						["ib"] = "@block.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]m"] = "@function.outer",
						["]c"] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[c"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["]a"] = "@parameter.inner",
					},
					swap_previous = {
						["[a"] = "@parameter.inner",
					},
				},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			max_lines = 5,
			trim_scope = "outer",
			multiline_threshold = 20,
			mode = "cursor",
		},
	},

	-- ===================================================================
	-- FORMATTING CONFIGURATION
	-- ===================================================================
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				local lsp_format_opt
				if disable_filetypes[vim.bo[bufnr].filetype] then
					lsp_format_opt = "never"
				else
					lsp_format_opt = "fallback"
				end
				return {
					timeout_ms = 1000,
					lsp_format = lsp_format_opt,
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format", "black" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				scss = { "prettierd", "prettier", stop_after_first = true },
				sql = { "sql_formatter" },
			},
		},
	},

	-- ===================================================================
	-- LINTING CONFIGURATION
	-- ===================================================================
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				markdown = { "markdownlint" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					if vim.opt_local.modifiable:get() then
						lint.try_lint()
					end
				end,
			})
		end,
	},

	-- ===================================================================
	-- DIAGNOSTICS DISPLAY
	-- ===================================================================
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
}
