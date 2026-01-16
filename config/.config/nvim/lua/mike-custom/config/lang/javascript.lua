-- JavaScript/TypeScript/Angular specific language support
-- NOTE: TypeScript LSP is now handled via vtsls in lsp/vtsls.lua
return {
	-- Plain-english 'translations' of typescript errors
	{
		"dmmulroy/ts-error-translator.nvim",
		ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
		config = function()
			require("ts-error-translator").setup()
		end,
	},
}
