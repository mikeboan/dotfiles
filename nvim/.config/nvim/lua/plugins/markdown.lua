return {
	-- In-buffer markdown rendering (pretty headings, bullets, code blocks, etc.)
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
		ft = { "markdown" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			render_modes = { "n", "c", "t" },
		},
	},

	-- Browser-based live preview with Mermaid, KaTeX, PlantUML, etc.
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		ft = { "markdown" },
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
	},

	-- Lightweight browser preview (markdown, HTML, AsciiDoc, SVG) — no npm required
	{
		"brianhuster/live-preview.nvim",
		cmd = { "LivePreview", "StopPreview" },
		dependencies = { "ibhagwan/fzf-lua" },
	},

	-- Image rendering backend (kitty graphics protocol). Uses the ImageMagick
	-- CLI (`magick`, from imagemagick-full) — no luarock needed. Works through
	-- tmux because tmux.conf sets `allow-passthrough on`.
	{
		"3rd/image.nvim",
		ft = { "markdown" },
		opts = {
			backend = "kitty",
			processor = "magick_cli",
			integrations = {
				-- Render linked/embedded images in markdown buffers too.
				markdown = { enabled = true },
			},
			max_width_window_percentage = 80,
			-- Don't let kitty graphics bleed into other tmux windows/panes.
			tmux_show_only_in_active_window = true,
		},
	},

	-- Mermaid (+ PlantUML, D2) rendering via `mmdc` (brew: mermaid-cli).
	-- On-demand popup mode, NOT inline: inline images placed via the kitty
	-- graphics protocol ghost when scrolling under tmux (diagram.nvim only
	-- clears them on BufLeave, never on scroll). Disabling the auto-render
	-- events and popping the diagram at the cursor into a float sidesteps it.
	{
		"3rd/diagram.nvim",
		dependencies = { "3rd/image.nvim" },
		ft = { "markdown" },
		keys = {
			{
				"<leader>md",
				function()
					require("diagram").show_diagram_hover()
				end,
				ft = "markdown",
				desc = "Mermaid diagram popup (at cursor)",
			},
		},
		opts = function()
			return {
				-- Empty render events = no inline auto-render; hover still works.
				events = { render_buffer = {}, clear_buffer = {} },
				integrations = {
					require("diagram.integrations.markdown"),
				},
				renderer_options = {
					mermaid = { theme = "dark" },
				},
			}
		end,
	},
}
