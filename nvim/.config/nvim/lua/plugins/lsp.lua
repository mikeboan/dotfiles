return {
	-- Mason: package manager for LSP servers, formatters, linters
	{
		"williamboman/mason.nvim",
		lazy = false,
		opts = {},
	},

	-- Auto-install LSP servers via Mason
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"basedpyright",
				"ruff",
				"vtsls",
				"html",
				"cssls",
				"tailwindcss",
				"emmet_ls",
				"jsonls",
				"yamlls",
				"marksman",
				"angularls",
			},
			automatic_installation = true,
		},
	},

	-- LSP keybindings and settings (using Neovim 0.11+ native config)
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			-- Keybindings when LSP attaches to a buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Navigation
					map("gd", vim.lsp.buf.definition, "Go to definition")
					map("gD", vim.lsp.buf.declaration, "Go to declaration")
					map("gr", vim.lsp.buf.references, "Go to references")
					map("gi", vim.lsp.buf.implementation, "Go to implementation")
					map("gy", vim.lsp.buf.type_definition, "Go to type definition")

					-- Info
					map("K", vim.lsp.buf.hover, "Hover documentation")
					map("gK", vim.lsp.buf.signature_help, "Signature help")

					-- Actions
					map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
					map("<leader>ca", vim.lsp.buf.code_action, "Code action")

					-- Diagnostics
					map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
					map("]d", vim.diagnostic.goto_next, "Next diagnostic")
					map("<leader>d", vim.diagnostic.open_float, "Show diagnostic")

					-- Highlight references on cursor hold
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end

					-- Toggle inlay hints (if supported)
					if client and client.server_capabilities.inlayHintProvider then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "Toggle inlay hints")
					end
				end,
			})

			-- Diagnostic display settings
			vim.diagnostic.config({
				virtual_text = { prefix = "●" },
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					border = "rounded",
					source = true,
				},
			})

			-- Disable servers we don't want (prevents auto-attach)
			vim.lsp.enable("pyright", false) -- using basedpyright instead
			vim.lsp.enable("ts_ls", false) -- using vtsls instead
			vim.lsp.config("angularls", {})
			vim.lsp.enable("angularls")

			-- Configure LSP servers using Neovim 0.11+ native vim.lsp.config
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = { vim.env.VIMRUNTIME },
						},
						completion = { callSnippet = "Replace" },
						diagnostics = { globals = { "vim" } },
					},
				},
			})

			vim.lsp.config("basedpyright", {})
			vim.lsp.config("ruff", {})
			vim.lsp.config("vtsls", {})
			vim.lsp.config("html", {})
			vim.lsp.config("cssls", {})
			vim.lsp.config("tailwindcss", {})
			vim.lsp.config("emmet_ls", {})
			vim.lsp.config("jsonls", {})
			vim.lsp.config("yamlls", {})
			vim.lsp.config("marksman", {})

			-- Enable only the servers we want
			vim.lsp.enable({
				"lua_ls",
				"basedpyright",
				"ruff",
				"vtsls",
				"html",
				"cssls",
				"tailwindcss",
				"emmet_ls",
				"jsonls",
				"yamlls",
				"marksman",
			})
		end,
	},
}
