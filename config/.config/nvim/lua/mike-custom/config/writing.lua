-- Markdown, note-taking, etc.
return {
	-- Obsidian vault integration
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*",
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			workspaces = {
				{
					name = "MikeNotes",
					path = "/Users/mike/Library/Mobile Documents/iCloud~md~obsidian/Documents/MikeNotes",
				},
			},

			-- Optional: Customize note ID generation
			note_id_func = function(title)
				-- Create note IDs from title or random suffix
				local suffix = ""
				if title ~= nil then
					-- Use title with spaces replaced by hyphens
					suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
				else
					-- Random suffix for untitled notes
					for _ = 1, 4 do
						suffix = suffix .. string.char(math.random(65, 90))
					end
				end
				return suffix
			end,

			-- Daily notes configuration
			daily_notes = {
				folder = "daily",
				date_format = "%Y-%m-%d",
				alias_format = "%B %-d, %Y",
			},

			-- Completion settings
			completion = {
				nvim_cmp = true,
				min_chars = 2,
			},

			-- Wiki link handling
			follow_url_func = function(url)
				-- Open URLs in default browser
				vim.fn.jobstart({ "open", url })
			end,

			-- Template settings
			templates = {
				subdir = "templates",
				date_format = "%Y-%m-%d",
				time_format = "%H:%M",
			},

			-- Frontmatter settings
			frontmatter = {
				enabled = true,
			},

			-- Open module settings (use advanced URI for following links)
			open = {
				use_advanced_uri = true,
			},

			-- Search settings
			search = {
				sort_by = "modified",
				sort_reversed = true,
			},

			-- Finder for searching notes (using Telescope)
			finder = "telescope.nvim",

			-- Open notes in current window
			open_notes_in = "current",

			-- Use new command format (e.g., "Obsidian backlinks" instead of "ObsidianBacklinks")
			legacy_commands = false,
		},
		keys = {
			-- Daily note - global keymap (works from any buffer, loads plugin on demand)
			{ "<leader>od", "<cmd>Obsidian today<cr>", desc = "[O]bsidian [D]aily note" },
			-- Quick note switching
			{ "<leader>on", "<cmd>Obsidian quick_switch<cr>", desc = "[O]bsidian [N]otes" },
			-- Search notes
			{ "<leader>os", "<cmd>Obsidian search<cr>", desc = "[O]bsidian [S]earch" },
			-- Create new note
			{ "<leader>oc", "<cmd>Obsidian new<cr>", desc = "[O]bsidian [C]reate note" },
			-- Open in Obsidian app (markdown only - needs current file context)
			{ "<leader>oo", "<cmd>Obsidian open<cr>", desc = "[O]bsidian [O]pen in app", ft = "markdown" },
			-- Follow link under cursor (markdown only)
			{ "gf", "<cmd>Obsidian follow_link<cr>", desc = "Follow Obsidian link", ft = "markdown" },
			-- Backlinks (markdown only)
			{ "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "[O]bsidian [B]acklinks", ft = "markdown" },
			-- Insert link (markdown only)
			{
				"<leader>ol",
				"<cmd>Obsidian link<cr>",
				desc = "[O]bsidian [L]ink",
				mode = "v",
				ft = "markdown",
			},
			-- Insert new link (markdown only)
			{
				"<leader>oL",
				"<cmd>Obsidian link_new<cr>",
				desc = "[O]bsidian [L]ink new",
				mode = "v",
				ft = "markdown",
			},
			-- Templates (markdown only)
			{ "<leader>ot", "<cmd>Obsidian template<cr>", desc = "[O]bsidian [T]emplate", ft = "markdown" },
		},
	},

	-- Enhanced markdown rendering
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"echasnovski/mini.nvim", -- if you use the mini plugin
		},
		ft = { "markdown" }, -- Only load for markdown files
		opts = {
			-- Configure headings
			heading = {
				-- Turn on / off heading icon & background
				enabled = true,
				-- Turn on / off any sign column related rendering
				sign = true,
				-- Determines how icons fill the available space:
				--  inline: underlying markup is concealed resulting in a left shift
				--  overlay: result is left padded with spaces to hide any background
				position = "overlay",
				-- Replaces '#+' of 'atx_h._marker'
				-- The number of '#' in the heading determines the 'level'
				-- The 'level' is used to index into the array using a cycle
				icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
				-- Added to the sign column if enabled
				-- The 'level' is used to index into the array using a cycle
				signs = { "󰫎 " },
				-- Width of the heading background:
				--  block: width of the heading text
				--  full: full width of the window
				-- Can also be an integer to set a custom width
				width = "full",
				-- Amount of margin to add to the left of headings
				left_margin = 0,
				-- Amount of padding to add to the left of headings
				left_pad = 0,
				-- Amount of padding to add to the right of headings
				right_pad = 0,
				-- Minimum width to use for headings
				min_width = 0,
				-- Determins if a border is added above and below headings
				border = false,
				-- Highlight the start of the border using the foreground highlight
				border_prefix = false,
				-- Used above heading for border
				above = "▄",
				-- Used below heading for border
				below = "▀",
				-- The 'level' is used to index into the array using a clamp
				-- Highlight for the heading icon and title
				backgrounds = {
					"RenderMarkdownH1Bg",
					"RenderMarkdownH2Bg",
					"RenderMarkdownH3Bg",
					"RenderMarkdownH4Bg",
					"RenderMarkdownH5Bg",
					"RenderMarkdownH6Bg",
				},
				-- The 'level' is used to index into the array using a clamp
				-- Highlight for the heading and sign icons
				foregrounds = {
					"RenderMarkdownH1",
					"RenderMarkdownH2",
					"RenderMarkdownH3",
					"RenderMarkdownH4",
					"RenderMarkdownH5",
					"RenderMarkdownH6",
				},
			},
			-- Configure code blocks
			code = {
				-- Turn on / off code block & inline code rendering
				enabled = true,
				-- Turn on / off any sign column related rendering
				sign = true,
				-- Determines how code blocks & inline code are rendered:
				--  none: disables all rendering
				--  normal: adds highlight group to code blocks & inline code
				--  language: adds language icon to sign column if enabled and icon + name above code blocks
				--  full: normal + language
				style = "full",
				-- Determines where language icon is rendered:
				--  right: right side of code block
				--  left: left side of code block
				position = "left",
				-- Amount of padding to add around the language
				language_pad = 0,
				-- A list of language names for which background highlighting will be disabled
				-- Likely because that language is not one you typically work in
				disable_background = { "diff" },
				-- Width of the code block background:
				--  block: width of the code block
				--  full: full width of the window
				-- Can also be an integer to set a custom width
				width = "full",
				-- Amount of margin to add to the left of code blocks
				left_margin = 0,
				-- Amount of padding to add to the left of code blocks
				left_pad = 0,
				-- Amount of padding to add to the right of code blocks
				right_pad = 0,
				-- Minimum width to use for code blocks
				min_width = 0,
				-- Determins if a border is added above and below code blocks
				border = "thin",
				-- Highlight the start of the border using the foreground highlight
				border_prefix = false,
				-- Used above code blocks for thin border
				above = "▄",
				-- Used below code blocks for thin border
				below = "▀",
				-- Highlight for code blocks
				highlight = "RenderMarkdownCode",
				-- Highlight for inline code
				highlight_inline = "RenderMarkdownCodeInline",
			},
			-- Configure tables
			table = {
				-- Turn on / off table rendering
				enabled = true,
				-- Determines how tables are rendered:
				--  none: disables all rendering
				--  normal: applies the 'cell' style rendering to each row of the table
				--  full: normal + a top & bottom line that fill out the table when lengths match
				style = "full",
				-- Determines if table borders are rendered
				border = {
					"┌",
					"┬",
					"┐",
					"├",
					"┼",
					"┤",
					"└",
					"┴",
					"┘",
					"│",
					"─",
				},
				-- Gets placed in delimiter row for each column, position is based on alignmnet
				alignment_indicator = "━",
				-- Highlight for table heading, delimiter, and the line above
				head = "RenderMarkdownTableHead",
				-- Highlight for everything else, main table rows and the line below
				row = "RenderMarkdownTableRow",
				-- Highlight for inline padding used to add back concealed space
				filler = "RenderMarkdownTableFill",
			},
			-- Configure callouts
			callout = {
				note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
				tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
				important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
				warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownWarn" },
				caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "RenderMarkdownError" },
				-- Obsidian: https://help.obsidian.md/Editing+and+formatting/Callouts
				abstract = { raw = "[!ABSTRACT]", rendered = "󰨸 Abstract", highlight = "RenderMarkdownInfo" },
				summary = { raw = "[!SUMMARY]", rendered = "󰨸 Summary", highlight = "RenderMarkdownInfo" },
				tldr = { raw = "[!TLDR]", rendered = "󰨸 Tldr", highlight = "RenderMarkdownInfo" },
				info = { raw = "[!INFO]", rendered = "󰋽 Info", highlight = "RenderMarkdownInfo" },
				todo = { raw = "[!TODO]", rendered = "󰗡 Todo", highlight = "RenderMarkdownInfo" },
				hint = { raw = "[!HINT]", rendered = "󰌶 Hint", highlight = "RenderMarkdownSuccess" },
				success = { raw = "[!SUCCESS]", rendered = "󰄬 Success", highlight = "RenderMarkdownSuccess" },
				check = { raw = "[!CHECK]", rendered = "󰄬 Check", highlight = "RenderMarkdownSuccess" },
				done = { raw = "[!DONE]", rendered = "󰄬 Done", highlight = "RenderMarkdownSuccess" },
				question = { raw = "[!QUESTION]", rendered = "󰘥 Question", highlight = "RenderMarkdownWarn" },
				help = { raw = "[!HELP]", rendered = "󰘥 Help", highlight = "RenderMarkdownWarn" },
				faq = { raw = "[!FAQ]", rendered = "󰘥 FAQ", highlight = "RenderMarkdownWarn" },
				attention = { raw = "[!ATTENTION]", rendered = "󰀪 Attention", highlight = "RenderMarkdownWarn" },
				failure = { raw = "[!FAILURE]", rendered = "󰅖 Failure", highlight = "RenderMarkdownError" },
				fail = { raw = "[!FAIL]", rendered = "󰅖 Fail", highlight = "RenderMarkdownError" },
				missing = { raw = "[!MISSING]", rendered = "󰅖 Missing", highlight = "RenderMarkdownError" },
				danger = { raw = "[!DANGER]", rendered = "󱐌 Danger", highlight = "RenderMarkdownError" },
				error = { raw = "[!ERROR]", rendered = "󰅖 Error", highlight = "RenderMarkdownError" },
				bug = { raw = "[!BUG]", rendered = "󰨰 Bug", highlight = "RenderMarkdownError" },
				example = { raw = "[!EXAMPLE]", rendered = "󰉹 Example", highlight = "RenderMarkdownHint" },
				quote = { raw = "[!QUOTE]", rendered = "󱆨 Quote", highlight = "RenderMarkdownQuote" },
				cite = { raw = "[!CITE]", rendered = "󱆨 Cite", highlight = "RenderMarkdownQuote" },
			},
			-- Configure bullet points
			bullet = {
				-- Turn on / off list bullet rendering
				enabled = true,
				-- Replaces '-'|'+'|'*' of 'list_item'
				-- How deeply nested the list is determines the 'level'
				-- The 'level' is used to index into the array using a cycle
				-- If the item is a 'checkbox' a conceal is used to hide the bullet instead
				icons = { "●", "○", "◆", "◇" },
				-- Padding to add to the left of bullet point
				left_pad = 0,
				-- Padding to add to the right of bullet point
				right_pad = 0,
				-- Highlight for the bullet icon
				highlight = "RenderMarkdownBullet",
			},
			-- Configure check boxes
			checkbox = {
				-- Turn on / off checkbox rendering
				enabled = true,
				right_pad = 4,
				-- Use overlay position to prevent text cutoff
				-- position = "overlay",
				-- Replaces '[ ]' of 'task_list_marker_unchecked'
				unchecked = {
					-- Conceal checkbox
					icon = "󰄱 ",
					-- Highlight for the unchecked icon
					highlight = "RenderMarkdownUnchecked",
				},
				-- Replaces '[x]' of 'task_list_marker_checked'
				checked = {
					-- Conceal checkbox
					icon = "󰱒 ",
					-- Highligh for the checked icon
					highlight = "RenderMarkdownChecked",
				},
				-- Define custom checkbox states, more involved as they are not part of the markdown grammar
				-- As a result this feature is not as robust as the rest
				custom = {
					todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
				},
			},
			-- Configure quote
			quote = {
				-- Turn on / off block quote & callout rendering
				enabled = true,
				-- Replaces '>' of 'block_quote'
				icon = "▋",
				-- Highlight for the quote icon
				highlight = "RenderMarkdownQuote",
			},
			-- Configure inline code
			pipe_table = {
				-- Turn on / off pipe table rendering
				enabled = true,
				-- Determines how the table as a whole is rendered:
				--  none: disables all rendering
				--  normal: applies the 'cell' style rendering to each row of the table
				--  full: normal + a top & bottom line that fill out the table when lengths match
				style = "full",
				-- Determines if table borders are rendered
				border = {
					"┌",
					"┬",
					"┐",
					"├",
					"┼",
					"┤",
					"└",
					"┴",
					"┘",
					"│",
					"─",
				},
				-- Gets placed in delimiter row for each column, position is based on alignmnet
				alignment_indicator = "━",
				-- Highlight for table heading, delimiter, and the line above
				head = "RenderMarkdownTableHead",
				-- Highlight for everything else, main table rows and the line below
				row = "RenderMarkdownTableRow",
				-- Highlight for inline padding used to add back concealed space
				filler = "RenderMarkdownTableFill",
			},
		},
		config = function(_, opts)
			require("render-markdown").setup(opts)
		end,
	},

	-- Typing practice plugin
	{
		"nvzone/typr",
		dependencies = "nvzone/volt",
		opts = {},
		cmd = { "Typr", "TyprStats" },
	},
}
