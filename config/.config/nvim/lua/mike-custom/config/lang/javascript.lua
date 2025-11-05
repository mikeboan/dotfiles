-- JavaScript/TypeScript/Angular specific language support
return {
	-- Plain-english 'translations' of typescript errors
	{
		"dmmulroy/ts-error-translator.nvim",
		config = function()
			require("ts-error-translator").setup()
		end,
	},
	
	-- TypeScript Tools LSP Setup
	-- Streamlined tsserver replacement with extended features for modern TS/JS/Angular dev
	-- See: https://github.com/pmizio/typescript-tools.nvim
	{
		"pmizio/typescript-tools.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
		},
		opts = {
			settings = {
				-- Use your system's TypeScript version instead of a bundled one if available
				expose_as_code_action = {
					"add_missing_imports",
					"remove_unused",
					"remove_unused_imports",
					"organize_imports",
					"fix_all",
				},
				tsserver_plugins = {},
				tsserver_file_preferences = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = false,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
				tsserver_format_options = {
					allowIncompleteCompletions = false,
					allowRenameOfImportPath = true,
				},
				complete_function_calls = true,
				include_completions_with_insert_text = true,
			},
		},
	},
}
