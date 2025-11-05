return { -- Collection of various small independent plugins/modules
	"echasnovski/mini.nvim",
	config = function()
		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()

		-- Simple and easy statusline.
		-- You could remove this setup call if you don't like it,
		--  and try some other statusline plugin
		local statusline = require("mini.statusline")
		-- set use_icons to true if you have a Nerd Font
		statusline.setup({ use_icons = vim.g.have_nerd_font, set_vim_settings = false })

		-- You can configure sections in the statusline by overriding their
		-- default behavior. For example, here we set the section for
		-- cursor location to LINE:COLUMN
		---@diagnostic disable-next-line: duplicate-set-field
		-- statusline.section_location = function()
		-- 	return "%2l:%-2v"
		-- end

		-- ... and there is more!
		--  Check out: https://github.com/echasnovski/mini.nvim

		-- Comment in/out in normal or visual mode with:
		-- gcc - toggle line
		-- gc - toggle block
		-- Also defines comment text object of 'gc', as in 'dgc' for
		-- 'delete text block'
		require("mini.comment").setup()

		-- Highlight word under cursor. Makes 'diw', etc. more predictable.
		require("mini.cursorword").setup()

		-- Pretty icons
		require("mini.icons").setup()

		-- Move visual selection with <M-h/j/k/l>
		require("mini.move").setup()
	end,
}
