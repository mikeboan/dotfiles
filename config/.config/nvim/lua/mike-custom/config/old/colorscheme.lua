-- Using tokyonight-storm for neovim in the terminal; using
-- onedark for neovim inside of intellij since there's no
-- good tokyonight theme for intellij.
-- Also sometimes it's fun to play with catpuccin so that's here
-- too but it's disabled.
return {
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- Ensure it loads first
		config = function()
			-- Configure tokyonight with telescope integration
			require("tokyonight").setup({
				plugins = { telescope = true },
				on_highlights = function(hl, c)
					local prompt = "#2d3149"
					hl.TelescopeNormal = {
						bg = c.bg_dark,
						fg = c.fg_dark,
					}
					hl.TelescopeBorder = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
					hl.TelescopePromptNormal = {
						bg = prompt,
					}
					hl.TelescopePromptBorder = {
						bg = prompt,
						fg = prompt,
					}
					hl.TelescopePromptTitle = {
						bg = prompt,
						fg = prompt,
					}
					hl.TelescopePreviewTitle = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
					hl.TelescopeResultsTitle = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
				end,
			})

			-- I use a onedark theme in intellij, so we want to load the onedark theme
			-- when nvim is launched from the intellij terminal. In iterm and everywhere
			-- else we want to use tokyonight-storm.
			if not vim.env.INTELLIJ then
				-- vim.cmd.colorscheme("tokyonight-storm")
			end
		end,
	},
	{
		"navarasu/onedark.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			if vim.env.INTELLIJ then
				require("onedark").load()
			end
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		enabled = false,
		config = function()
			require("catppuccin").setup({
				integrations = {
					telescope = {
						enabled = true,
						-- Apply borderless telescope styling like TokyoNight
						style = "nvchad",
					},
				},
				custom_highlights = function(colors)
					return {
						-- Remove telescope borders (same as TokyoNight config)
						TelescopeNormal = {
							bg = colors.mantle,
							fg = colors.text,
						},
						TelescopeBorder = {
							bg = colors.mantle,
							fg = colors.mantle,
						},
						TelescopePromptNormal = {
							bg = colors.surface0,
						},
						TelescopePromptBorder = {
							bg = colors.surface0,
							fg = colors.surface0,
						},
						TelescopePromptTitle = {
							bg = colors.surface0,
							fg = colors.surface0,
						},
						TelescopePreviewTitle = {
							bg = colors.mantle,
							fg = colors.mantle,
						},
						TelescopeResultsTitle = {
							bg = colors.mantle,
							fg = colors.mantle,
						},
					}
				end,
			})

			-- Uncomment one of these to use catppuccin.
			-- Must also turn off tokyonight.
			-- if not vim.env.INTELLIJ then
			-- 	-- vim.cmd.colorscheme("catppuccin-latte")
			-- 	-- vim.cmd.colorscheme("catppuccin-frappe")
			-- 	vim.cmd.colorscheme("catppuccin-macchiato")
			-- 	-- vim.cmd.colorscheme("catppuccin-mocha")
			-- end
		end,
	},
}
