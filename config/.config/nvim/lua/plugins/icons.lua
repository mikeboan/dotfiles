return {
	{
		"echasnovski/mini.icons",
		lazy = false, -- load early so other plugins can use it
		config = function()
			require("mini.icons").setup()
			MiniIcons.mock_nvim_web_devicons()
		end,
	},
}
