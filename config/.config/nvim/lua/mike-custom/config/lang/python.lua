-- Python and Django-specific tools
return {
	-- Django template support and navigation
	{
		"tweekmonster/django-plus.vim",
		ft = { "python", "htmldjango" },
		config = function()
			-- Django template detection
			vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
				pattern = { "*/templates/*.html", "*/templates/**/*.html" },
				callback = function()
					vim.bo.filetype = "htmldjango"
				end,
			})
		end,
	},
}
