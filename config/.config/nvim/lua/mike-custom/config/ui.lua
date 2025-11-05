-- Interface and visual (colorscheme, status line, etc)
return {
	-- Colorschemes
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- Ensure it loads first
		-- enabled = false,
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
				vim.cmd.colorscheme("tokyonight-storm")
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
		"shaunsingh/nord.nvim",
		priority = 1000,
		enabled = false,
		config = function()
			if not vim.env.INTELLIJ then
				vim.cmd.colorscheme("nord")
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

	-- Color highlighting
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				tailwind = true, -- Tailwind class highlighting
				-- names = true, -- Support for color names like 'red', 'blue'
				-- css = true, -- Enable all CSS color parsing
				-- css_fn = true, -- Enable functions like `rgb(...)`, `hsl(...)`
				mode = "virtualtext", -- Show color via colored square character (can use 'background' too)
				-- sass = { enable = true }, -- Support for SCSS `!default` and variables
				-- virtualtext = "■", -- Symbol used when mode is 'virtualtext' (if you switch)
			},
		},
	},

	-- Indentation guides
	{ -- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- See `:help ibl`
		main = "ibl",
		opts = {
			indent = {
				char = "│",
			},
		},
	},

	-- Status line and UI components
	{
		"folke/snacks.nvim",
		priority = 1000,
		enabled = false,
		lazy = false,
		opts = {},
	},

	-- Subtle animations on yank, paste, search, undo, redo, etc.
	{
		"rachartier/tiny-glimmer.nvim",
		event = "VeryLazy",
		priority = 10, -- Low priority to catch other plugins' keybindings
		config = function()
			require("tiny-glimmer").setup({ enabled = true })
		end,
	},
}
