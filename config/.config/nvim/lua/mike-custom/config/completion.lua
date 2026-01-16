return { -- Autocompletion
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		{
			"L3MON4D3/LuaSnip",
			build = (function()
				-- Build Step is needed for regex support in snippets.
				-- This step is not supported in many windows environments.
				-- Remove the below condition to re-enable on windows.
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
			dependencies = {
				-- `friendly-snippets` contains a variety of premade snippets.
				--    See the README about individual language/framework/plugin snippets:
				--    https://github.com/rafamadriz/friendly-snippets
				{
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
						-- Load Angular/NgRx/RxJS snippets
						local angular_path = vim.fn.stdpath("data") .. "/lazy/friendly-snippets/snippets/frameworks/angular"
						require("luasnip.loaders.from_vscode").load_standalone({
							path = angular_path .. "/typescript.json",
							ft = "typescript",
						})
						require("luasnip.loaders.from_vscode").load_standalone({
							path = angular_path .. "/html.json",
							ft = "html",
						})
						-- Load Django/DRF snippets
						local django_path = vim.fn.stdpath("data") .. "/lazy/friendly-snippets/snippets/frameworks/django"
						require("luasnip.loaders.from_vscode").load_standalone({
							path = django_path .. "/models.json",
							ft = "python",
						})
						require("luasnip.loaders.from_vscode").load_standalone({
							path = django_path .. "/views.json",
							ft = "python",
						})
						require("luasnip.loaders.from_vscode").load_standalone({
							path = django_path .. "/urls.json",
							ft = "python",
						})
						require("luasnip.loaders.from_vscode").load_standalone({
							path = django_path .. "/forms.json",
							ft = "python",
						})
						require("luasnip.loaders.from_vscode").load_standalone({
							path = django_path .. "/admin.json",
							ft = "python",
						})
						require("luasnip.loaders.from_vscode").load_standalone({
							path = django_path .. "/django_rest/views.json",
							ft = "python",
						})
						require("luasnip.loaders.from_vscode").load_standalone({
							path = django_path .. "/django_rest/serializers.json",
							ft = "python",
						})
					end,
				},
			},
		},
		"saadparwaiz1/cmp_luasnip",

		-- Adds other completion capabilities.
		--  nvim-cmp does not ship with all sources by default. They are split
		--  into multiple repos for maintenance purposes.
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp-signature-help",
	},
	config = function()
		-- See `:help cmp`
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		luasnip.config.setup({})

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			-- Show completions even if one menu option; don't auto-insert.
			completion = { completeopt = "menu,menuone,noinsert" },

			-- Vim-native keybindings: C-n/C-p navigate, C-y confirm, C-e abort
			mapping = cmp.mapping.preset.insert({
				-- Navigate completion menu
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),

				-- Confirm or abort
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-e>"] = cmp.mapping.abort(),

				-- Scroll the documentation window
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),

				-- Think of <c-l> as moving to the right of your snippet expansion.
				--  So if you have a snippet that's like:
				--  function $name($args)
				--    $body
				--  end
				--
				-- <c-l> will move you to the right of each of the expansion locations.
				-- <c-h> is similar, except moving you backwards.
				["<C-l>"] = cmp.mapping(function()
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping(function()
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),

				-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
				--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
			}),
			sources = {
				{
					name = "lazydev",
					-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
					group_index = 0,
				},
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "nvim_lsp_signature_help" },
			},
		})
	end,
}

