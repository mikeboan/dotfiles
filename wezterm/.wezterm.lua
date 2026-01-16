-- ~/.wezterm.lua
-- WezTerm config optimized for nvim + tmux IDE-like workflow
local wezterm = require("wezterm")
local act = wezterm.action

-----------------------------------------------------------
--  UTILITIES
-----------------------------------------------------------

-- Try to get Git project name for current pane directory
local function project_name_from_git(cwd)
	if not cwd then
		return nil
	end
	local success, stdout = wezterm.run_child_process({
		"bash",
		"-c",
		string.format("cd '%s' && git rev-parse --show-toplevel 2>/dev/null", cwd),
	})
	if success and stdout and #stdout > 0 then
		local path = stdout:gsub("%s+$", "")
		return path:match("([^/]+)$")
	end
	return nil
end

-----------------------------------------------------------
--  EVENT: FORMAT WINDOW TITLE
-----------------------------------------------------------
-- wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
-- 	-- local cwd_uri = pane:get_current_working_dir()
-- 	if not cwd_uri then
-- 		return "WezTerm"
-- 	end
-- 	local cwd = cwd_uri.file_path or ""
-- 	local git_name = project_name_from_git(cwd)
-- 	local cwd_name = cwd:match("([^/]+)$") or cwd
--
-- 	if git_name and git_name ~= cwd_name then
-- 		return string.format("%s  %s", git_name, cwd_name)
-- 	else
-- 		return cwd_name
-- 	end
-- end)

-----------------------------------------------------------
--  MAIN CONFIG
-----------------------------------------------------------
local config = {}

-- ===========================
-- RENDERING & PERFORMANCE
-- ===========================
-- WebGpu can cause input issues on some systems. Try "OpenGL" if you have problems.
config.front_end = "OpenGL"
config.animation_fps = 60
config.max_fps = 60
config.scrollback_lines = 10000
config.adjust_window_size_when_changing_font_size = false
config.warn_about_missing_glyphs = false

-- ===========================
-- TERMINAL FEATURES
-- ===========================
-- Use "wezterm" for proper terminal capabilities and color support
-- This enables undercurl, colored underlines, and other modern features
-- Requires wezterm terminfo to be installed (handled by bootstrap.sh)
config.term = "wezterm"

-- ===========================
-- APPEARANCE
-- ===========================
-- Color scheme is controlled by central theme configuration
-- Use the `theme` command to switch between themes
local function get_color_scheme()
	-- Read from environment variable set by theme.sh
	local wezterm_theme = os.getenv("WEZTERM_THEME")
	if wezterm_theme then
		return wezterm_theme
	end
	-- Default fallback
	return "Tokyo Night Storm"
end

-- Custom color scheme for Kanagawa Lotus (no built-in WezTerm theme)
config.color_schemes = {
	["Kanagawa Lotus"] = {
		foreground = "#545464",
		background = "#f2ecbc",
		cursor_fg = "#f2ecbc",
		cursor_bg = "#43436c",
		cursor_border = "#43436c",
		selection_fg = "#545464",
		selection_bg = "#c9cbd1",
		scrollbar_thumb = "#8a8980",
		split = "#e7dba0",
		ansi = {
			"#545464", -- black
			"#c84053", -- red
			"#6f894e", -- green
			"#de9800", -- yellow
			"#4d699b", -- blue
			"#624c83", -- magenta
			"#4e8ca2", -- cyan
			"#dcd7ba", -- white
		},
		brights = {
			"#8a8980", -- bright black
			"#d7474b", -- bright red
			"#5e857a", -- bright green
			"#f9d791", -- bright yellow
			"#6693bf", -- bright blue
			"#b35b79", -- bright magenta
			"#5a7785", -- bright cyan
			"#f2ecbc", -- bright white
		},
	},
}

config.color_scheme = get_color_scheme()

-- Font configuration
-- Note: Complex harfbuzz_features can cause input issues. Uncomment if needed.
config.font = wezterm.font_with_fallback({
	"FiraCode Nerd Font",
	"JetBrains Mono",
	"Menlo",
})
-- If you want ligatures, uncomment this instead:
-- config.font = wezterm.font_with_fallback({
-- 	{
-- 		family = "FiraCode Nerd Font",
-- 		harfbuzz_features = { "calt", "liga" },
-- 	},
-- 	"JetBrains Mono",
-- 	"Menlo",
-- })
config.font_size = 16.0
config.line_height = 1.1

-- Better rendering for nvim diagnostics (LSP underlines)
config.underline_thickness = "200%"
config.underline_position = "-2pt"

-- Bold text uses brighter ANSI colors
config.bold_brightens_ansi_colors = true

-- ===========================
-- CURSOR (IDE-like blinking bar)
-- ===========================
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- ===========================
-- VISUAL BELL (No beeping!)
-- ===========================
config.audible_bell = "Disabled"
config.visual_bell = {
	fade_in_duration_ms = 75,
	fade_out_duration_ms = 75,
	target = "CursorColor",
}

-- ===========================
-- WINDOW APPEARANCE
-- ===========================
config.window_background_opacity = 1.0

-- Window decorations options:
-- "TITLE | RESIZE"              - Native macOS controls (red/yellow/green buttons in title bar)
-- "INTEGRATED_BUTTONS | RESIZE" - Modern integrated buttons in tab bar (requires enable_tab_bar = true)
-- "RESIZE"                      - Minimal, no decorations (fullscreen-like)
config.window_decorations = "RESIZE"

config.window_padding = { left = 8, right = 6, top = 2, bottom = 2 }
config.window_close_confirmation = "NeverPrompt"

-- Dim inactive panes slightly (helps with focus in tmux)
-- Note: tmux also has pane highlighting, you may want to disable one or the other
config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.8,
}

-- ===========================
-- TAB BAR
-- ===========================
-- Since you use tmux, keep the tab bar disabled
-- Tmux handles all windowing/tabbing
config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false

-- If you ever want to use wezterm tabs alongside tmux:
-- config.tab_bar_at_bottom = true
-- config.tab_max_width = 32

-- ===========================
-- SHELL
-- ===========================
config.default_prog = { "/bin/zsh", "-l" }

-- ===========================
-- HYPERLINKS (Clickable file paths!)
-- ===========================
-- This is HUGE for IDE workflow - click on file:line patterns
-- Works in tmux panes! Cmd+Click to open in $EDITOR
config.hyperlink_rules = {
	-- File paths with line numbers (from grep, test output, LSP, etc)
	-- Matches: /path/to/file.ts:123  or  file.ts:123:45  or  "file.ts:123"
	{
		regex = [[["]?([\w\d]{1}[\w\d\.\-\_\/]+):(\d+):?(\d+)?["]?]],
		format = "$1:$2",
		highlight = 1,
	},

	-- Standard URLs (http, https, file, etc)
	{
		regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
		format = "$0",
	},

	-- Email addresses
	{
		regex = "\\b[\\w.-]+@[\\w.-]+\\.[\\w.-]+\\b",
		format = "mailto:$0",
	},

	-- GitHub PR/Issue references (customize for your repos)
	-- Example: #123 or PR#123 or issue#123
	{
		regex = [[\b[iI][sS][sS][uU][eE]#(\d+)\b]],
		format = "https://github.com/YOUR_ORG/YOUR_REPO/issues/$1",
	},
	{
		regex = [[\b[pP][rR]#(\d+)\b]],
		format = "https://github.com/YOUR_ORG/YOUR_REPO/pull/$1",
	},
}

-- ===========================
-- KEYBINDINGS
-- ===========================
-- Strategy: Use CMD-based bindings so they don't conflict with tmux (C-a prefix)
-- Tmux handles: panes, windows, sessions
-- WezTerm handles: terminal-level features, clipboard, scrollback, launcher

config.keys = {
	-- ===========================
	-- TABS (WezTerm level - optional, since tmux handles this)
	-- ===========================
	{ key = "t", mods = "CMD", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "w", mods = "CMD", action = act.CloseCurrentTab({ confirm = false }) },

	-- Quick tab navigation (like IDE tabs or browser tabs)
	{ key = "1", mods = "CMD", action = act.ActivateTab(0) },
	{ key = "2", mods = "CMD", action = act.ActivateTab(1) },
	{ key = "3", mods = "CMD", action = act.ActivateTab(2) },
	{ key = "4", mods = "CMD", action = act.ActivateTab(3) },
	{ key = "5", mods = "CMD", action = act.ActivateTab(4) },
	{ key = "6", mods = "CMD", action = act.ActivateTab(5) },
	{ key = "7", mods = "CMD", action = act.ActivateTab(6) },
	{ key = "8", mods = "CMD", action = act.ActivateTab(7) },
	{ key = "9", mods = "CMD", action = act.ActivateTab(-1) },

	-- ===========================
	-- CLIPBOARD
	-- ===========================
	{ key = "c", mods = "CMD", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },

	-- ===========================
	-- SEARCH & SCROLLBACK
	-- ===========================
	-- Find in scrollback (works in tmux panes!)
	{ key = "f", mods = "CMD", action = act.Search("CurrentSelectionOrEmptyString") },

	-- Copy mode - vim-style scrollback navigation
	-- Note: Tmux also has copy mode (prefix + [). Choose which you prefer:
	-- - WezTerm copy mode: Works at terminal level, faster
	-- - Tmux copy mode: More integrated with tmux, can copy across panes
	-- Both work! Try both and see which feels better.
	{ key = "[", mods = "CMD", action = act.ActivateCopyMode },

	-- ===========================
	-- LAUNCHER & PRODUCTIVITY
	-- ===========================
	-- Command palette (like Cmd+Shift+P in VSCode or Cmd+Shift+A in IntelliJ)
	{ key = "p", mods = "CMD|SHIFT", action = act.ActivateCommandPalette },

	-- Launcher menu - quick access to projects, commands, etc
	{ key = "l", mods = "CMD|SHIFT", action = act.ShowLauncher },

	-- ===========================
	-- DEBUGGING & UTILITIES
	-- ===========================
	-- Toggle fullscreen
	{ key = "f", mods = "CMD|CTRL", action = "ToggleFullScreen" },

	-- Debug overlay (check true color support, unicode, etc)
	{ key = "d", mods = "CMD|SHIFT", action = act.ShowDebugOverlay },

	-- Reload config without restarting
	{ key = "r", mods = "CMD|SHIFT", action = act.ReloadConfiguration },

	-- ===========================
	-- CLEAR PANE (iTerm2-style)
	-- ===========================
	-- Clear the current tmux pane with Cmd+K
	{
		key = "k",
		mods = "CMD",
		action = act.Multiple({
			act.SendKey({ key = "l", mods = "CTRL" }), -- Clear screen (like 'clear' command)
			act.ClearScrollback("ScrollbackAndViewport"), -- Also clear scrollback
		}),
	},

	-- ===========================
	-- FONT SIZE
	-- ===========================
	{ key = "=", mods = "CMD", action = act.IncreaseFontSize },
	{ key = "-", mods = "CMD", action = act.DecreaseFontSize },
	{ key = "0", mods = "CMD", action = act.ResetFontSize },
}

-- ===========================
-- MOUSE BINDINGS
-- ===========================
config.mouse_bindings = {
	-- Cmd+Click to open URLs and file paths
	-- This works in tmux panes! Super useful for clicking file:line from grep/test output
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CMD",
		action = act.OpenLinkAtMouseCursor,
	},

	-- Right click to paste (optional, some prefer this)
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = act.PasteFrom("Clipboard"),
	},

	-- Cmd+Click and drag to select without entering mouse mode in tmux/nvim
	{
		event = { Down = { streak = 1, button = "Left" } },
		mods = "CMD",
		action = act.SelectTextAtMouseCursor("Cell"),
	},
}

-- ===========================
-- KEY TABLES (Modal keybindings)
-- ===========================

-- Copy mode - vim-style scrollback navigation
-- Alternative to tmux copy mode - choose which you prefer!
-- Enter with Cmd+[ or Cmd+f (if searching)
config.key_tables = {
	copy_mode = {
		-- Exit
		{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
		{ key = "q", mods = "NONE", action = act.CopyMode("Close") },
		{ key = "c", mods = "CTRL", action = act.CopyMode("Close") },

		-- Movement (vim-style)
		{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
		{ key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
		{ key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
		{ key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },

		-- Word movement
		{ key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
		{ key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
		{ key = "e", mods = "NONE", action = act.CopyMode("MoveForwardWordEnd") },

		-- Line movement
		{ key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
		{ key = "$", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
		{ key = "^", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },

		-- Screen movement
		{ key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
		{ key = "G", mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom") },
		{ key = "H", mods = "NONE", action = act.CopyMode("MoveToViewportTop") },
		{ key = "M", mods = "NONE", action = act.CopyMode("MoveToViewportMiddle") },
		{ key = "L", mods = "NONE", action = act.CopyMode("MoveToViewportBottom") },
		{ key = "d", mods = "CTRL", action = act.CopyMode("PageDown") },
		{ key = "u", mods = "CTRL", action = act.CopyMode("PageUp") },
		{ key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },
		{ key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },

		-- Visual mode
		{ key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
		{ key = "V", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Line" }) },
		{ key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },

		-- Copy (yank)
		{
			key = "y",
			mods = "NONE",
			action = act.Multiple({
				act.CopyTo("ClipboardAndPrimarySelection"),
				act.CopyMode("Close"),
			}),
		},

		-- Search
		{ key = "/", mods = "NONE", action = act.Search("CurrentSelectionOrEmptyString") },
		{ key = "?", mods = "NONE", action = act.Search({ CaseInSensitiveString = "" }) },
		{ key = "n", mods = "NONE", action = act.CopyMode("NextMatch") },
		{ key = "N", mods = "NONE", action = act.CopyMode("PriorMatch") },
	},

	search_mode = {
		-- Exit search
		{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
		{ key = "Enter", mods = "NONE", action = "ActivateCopyMode" },

		-- Navigate matches
		{ key = "n", mods = "CTRL", action = act.CopyMode("NextMatch") },
		{ key = "p", mods = "CTRL", action = act.CopyMode("PriorMatch") },
		{ key = "n", mods = "NONE", action = act.CopyMode("NextMatch") },
		{ key = "N", mods = "NONE", action = act.CopyMode("PriorMatch") },

		-- Cycle match type (regex, case-sensitive, etc)
		{ key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },

		-- Clear search
		{ key = "u", mods = "CTRL", action = act.CopyMode("ClearPattern") },
	},
}

-- ===========================
-- LAUNCH MENU
-- ===========================
-- Quick access to common directories
-- Access with Cmd+Shift+L
config.launch_menu = {
	{
		label = "Home",
		args = { "zsh", "-l" },
		cwd = wezterm.home_dir,
	},
	{
		label = "Projects",
		args = { "zsh", "-l" },
		cwd = wezterm.home_dir .. "/Projects",
	},
	{
		label = "Dotfiles",
		args = { "zsh", "-l" },
		cwd = wezterm.home_dir .. "/dotfiles",
	},
	{
		label = "Src",
		args = { "zsh", "-l" },
		cwd = wezterm.home_dir .. "/Src",
	},
}

-- ===========================
-- ENVIRONMENT
-- ===========================
config.set_environment_variables = {
	-- Tell tmux about 24-bit color support
	COLORTERM = "truecolor",
}

-- ===========================
-- MISC
-- ===========================
-- IME (Input Method Editor) - keep enabled for proper macOS keyboard handling
config.use_ime = true
config.disable_default_key_bindings = false
config.automatically_reload_config = true

-----------------------------------------------------------
-- TMUX INTEGRATION NOTES
-----------------------------------------------------------
--[[

RECOMMENDED WORKFLOW WITH TMUX:

1. WINDOWING:
   - Use tmux for panes/windows/sessions (C-a prefix)
   - Keep wezterm tabs disabled (tab bar is hidden)
   - Your tmux.conf already handles vim-tmux-navigator for C-h/j/k/l

2. CLIPBOARD:
   - Use CMD+c/v in wezterm (works everywhere, including tmux)
   - Tmux copy mode also works (C-a [, then vim bindings)
   - Both work great! Use what feels natural in the moment.

3. SCROLLBACK:
   - Option A: WezTerm copy mode (CMD+[ or CMD+f)
     * Faster, works at terminal level
     * Vim-style navigation (configured above)
   - Option B: Tmux copy mode (C-a [)
     * Your tmux.conf has vim bindings configured
     * More integrated with tmux
   - Try both! They don't conflict.

4. SMART LINKS:
   - CMD+Click on file:line patterns works in tmux panes!
   - Super useful for test output, grep results, LSP errors
   - Set EDITOR env var to open in nvim: export EDITOR=nvim

5. VISUAL FEATURES:
   - Font ligatures: Work everywhere, including tmux
   - True color: Works in tmux (COLORTERM=truecolor)
   - Undercurl: Works in nvim inside tmux (TERM=wezterm)
   - Inactive pane dimming: Both wezterm and tmux support this
     You may want to disable one. In tmux: set -g window-style 'bg=default'

6. KEYBINDINGS:
   - WezTerm: CMD-based (won't conflict with tmux)
   - Tmux: C-a prefix (won't conflict with wezterm)
   - Nvim: <leader> (space) and vim motions
   - All three layers work together harmoniously!

QUICK REFERENCE:
   CMD+t           New wezterm tab (optional, you might not need this)
   CMD+1-9         Switch wezterm tabs (optional)
   CMD+f           Search scrollback
   CMD+[           Copy mode (vim-style)
   CMD+Shift+p     Command palette
   CMD+Shift+l     Launcher menu (quick project access)
   CMD+Click       Open file:line or URL
   CMD+c/v         Copy/paste

   C-a |           Tmux split horizontal
   C-a -           Tmux split vertical
   C-a h/j/k/l     Tmux pane navigation (or C-h/j/k/l with vim-tmux-navigator)
   C-a [           Tmux copy mode
   C-a r           Reload tmux config

   <leader>ff      Nvim find files
   <leader>gg      Nvim lazygit
   <leader>e       Nvim file explorer
   C-h/j/k/l       Nvim/tmux seamless navigation

RECOMMENDED: Set this in your ~/.zshrc
   export EDITOR="nvim"
   export VISUAL="nvim"
This makes CMD+Click open files in nvim!

]]

return config
