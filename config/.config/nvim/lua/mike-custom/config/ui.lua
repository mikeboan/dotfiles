-- Interface and visual (colorscheme, status line, etc)
return {
	-- Scrollbar with diagnostic/git markers
	{
		"petertriho/nvim-scrollbar",
		event = "BufReadPost",
		dependencies = {
			"lewis6991/gitsigns.nvim",
		},
		config = function()
			local function get_color(hlgroup, attr)
				local hl = vim.api.nvim_get_hl(0, { name = hlgroup, link = false })
				if hl[attr] then
					return string.format("#%06x", hl[attr])
				end
				return nil
			end

			local function setup_scrollbar()
				require("scrollbar").setup({
					handle = {
						color = get_color("Comment", "fg"),
					},
					marks = {
						Search = { color = get_color("IncSearch", "bg") },
						Error = { color = get_color("DiagnosticError", "fg") },
						Warn = { color = get_color("DiagnosticWarn", "fg") },
						Info = { color = get_color("DiagnosticInfo", "fg") },
						Hint = { color = get_color("DiagnosticHint", "fg") },
						Misc = { color = get_color("Special", "fg") },
					},
					handlers = {
						diagnostic = true,
						gitsigns = true,
						search = true,
					},
				})
			end

			setup_scrollbar()
			require("scrollbar.handlers.gitsigns").setup()

			-- Re-apply colors when colorscheme changes
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = setup_scrollbar,
			})
		end,
	},

	-- Colorschemes
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- Ensure it loads first
		enabled = true,
		config = function()
			-- Configure tokyonight with telescope integration
			require("tokyonight").setup({
				style = "storm", -- Explicitly use the storm variant
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

			-- Get the colorscheme from environment variable (set by theme.sh)
			local colorscheme = os.getenv("NVIM_THEME") or "tokyonight-storm"

			-- I use a onedark theme in intellij, so we want to load the onedark theme
			-- when nvim is launched from the intellij terminal. In iterm and everywhere
			-- else we want to use the configured theme.
			if not vim.env.INTELLIJ and colorscheme == "tokyonight-storm" then
				vim.cmd.colorscheme("tokyonight-storm")
			end
		end,
	},
	{
		"navarasu/onedark.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			local colorscheme = os.getenv("NVIM_THEME") or "tokyonight-storm"

			if vim.env.INTELLIJ then
				require("onedark").load()
			elseif not vim.env.INTELLIJ and colorscheme == "onedark" then
				require("onedark").load()
			end
		end,
	},
	-- {
	-- 	"shaunsingh/nord.nvim",
	-- 	priority = 1000,
	-- 	enabled = true,
	-- 	config = function()
	-- 		local colorscheme = os.getenv("NVIM_THEME") or "tokyonight-storm"
	--
	-- 		if not vim.env.INTELLIJ and colorscheme == "nord" then
	-- 			vim.cmd.colorscheme("nord")
	-- 		end
	-- 	end,
	-- },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		enabled = true,
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

			local colorscheme = os.getenv("NVIM_THEME") or "tokyonight-storm"

			if not vim.env.INTELLIJ then
				if colorscheme == "catppuccin-mocha" then
					vim.cmd.colorscheme("catppuccin-mocha")
				elseif colorscheme == "catppuccin-macchiato" then
					vim.cmd.colorscheme("catppuccin-macchiato")
				end
			end
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		enabled = true,
		config = function()
			require("kanagawa").setup({
				compile = false,
				undercurl = true,
				commentStyle = { italic = true },
				keywordStyle = { italic = true },
				statementStyle = { bold = true },
				transparent = false,
				dimInactive = false,
				terminalColors = true,
				colors = {
					theme = {
						all = {
							ui = {
								bg_gutter = "none",
							},
						},
					},
				},
				overrides = function(colors)
					local theme = colors.theme
					return {
						-- Borderless telescope (same style as other themes)
						TelescopeNormal = { bg = theme.ui.bg_dim, fg = theme.ui.fg_dim },
						TelescopeBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
						TelescopePromptNormal = { bg = theme.ui.bg_p1 },
						TelescopePromptBorder = { bg = theme.ui.bg_p1, fg = theme.ui.bg_p1 },
						TelescopePromptTitle = { bg = theme.ui.bg_p1, fg = theme.ui.bg_p1 },
						TelescopePreviewTitle = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
						TelescopeResultsTitle = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
						-- Popup menu styling
						Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
						PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
						PmenuSbar = { bg = theme.ui.bg_m1 },
						PmenuThumb = { bg = theme.ui.bg_p2 },
					}
				end,
			})

			local colorscheme = os.getenv("NVIM_THEME") or "tokyonight-storm"

			if not vim.env.INTELLIJ then
				if colorscheme == "kanagawa-wave" then
					vim.cmd.colorscheme("kanagawa-wave")
				elseif colorscheme == "kanagawa-dragon" then
					vim.cmd.colorscheme("kanagawa-dragon")
				elseif colorscheme == "kanagawa-lotus" then
					vim.cmd.colorscheme("kanagawa-lotus")
				end
			end
		end,
	},
	--
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

	-- Zen mode for distraction-free coding
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		keys = {
			{
				"<leader>z",
				function()
					require("zen-mode").toggle()
				end,
				desc = "Toggle Zen Mode",
			},
		},
		opts = {
			window = {
				width = 120, -- Width of zen window
				options = {
					signcolumn = "no", -- Disable signcolumn
					number = false, -- Disable number column
					relativenumber = false, -- Disable relative numbers
					cursorline = false, -- Disable cursor line
					cursorcolumn = false, -- Disable cursor column
					foldcolumn = "0", -- Disable fold column
					list = false, -- Disable whitespace characters
				},
			},
			plugins = {
				-- Disable some things during zen mode
				options = {
					enabled = true,
					ruler = false, -- Disables the ruler text in the cmd line area
					showcmd = false, -- Disables the command in the last line of the screen
					laststatus = 0, -- Hides the statusline
				},
				twilight = { enabled = false }, -- Can enable if you want dim unfocused code
				gitsigns = { enabled = false }, -- Disables git signs
				tmux = { enabled = false }, -- Disables tmux statusline
			},
			on_open = function()
				-- Optional: additional actions when entering zen mode
			end,
			on_close = function()
				-- Optional: additional actions when exiting zen mode
			end,
		},
	},
}
