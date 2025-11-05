-- ~/.wezterm.lua
local wezterm = require("wezterm")

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
wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
	local cwd_uri = pane:get_current_working_dir()
	if not cwd_uri then
		return "WezTerm"
	end
	local cwd = cwd_uri.file_path or ""
	local git_name = project_name_from_git(cwd)
	local cwd_name = cwd:match("([^/]+)$") or cwd

	if git_name and git_name ~= cwd_name then
		return string.format("%s  %s", git_name, cwd_name)
	else
		return cwd_name
	end
end)

-----------------------------------------------------------
--  MAIN CONFIG
-----------------------------------------------------------
local config = {}

config.front_end = "WebGpu"
config.animation_fps = 1
config.max_fps = 60
config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.scrollback_lines = 10000
config.adjust_window_size_when_changing_font_size = false
config.warn_about_missing_glyphs = false

-- Appearance
-- config.color_scheme = "Tokyo Night Storm"
-- config.color_scheme = "Atom OneDark (Gogh)"
config.color_scheme = "nord"
config.font = wezterm.font_with_fallback({
	"FiraCode Nerd Font",
	"JetBrains Mono",
	"Menlo",
})
config.font_size = 16.0
config.line_height = 1.1
config.window_background_opacity = 1.0
config.window_decorations = "RESIZE"
config.window_padding = { left = 8, right = 6, top = 2, bottom = 2 }
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.window_close_confirmation = "NeverPrompt"

config.default_prog = { "/bin/zsh", "-l" }

-- macOS native keybindings
config.keys = {
	{ key = "t", mods = "CMD", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
	{ key = "f", mods = "CMD|CTRL", action = "ToggleFullScreen" },
	{ key = "v", mods = "CMD", action = wezterm.action.PasteFrom("Clipboard") },
	{ key = "c", mods = "CMD", action = wezterm.action.CopyTo("Clipboard") },
}

-- Uncomment for Vim/tmux-style bindings
--[[
config.keys = {
  { key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
  { key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
  { key = "Enter", mods = "ALT", action = "ToggleFullScreen" },
  { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
  { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
}
]]

config.set_environment_variables = {
	TERM = "xterm-256color",
}

config.use_ime = false
config.disable_default_key_bindings = false
config.automatically_reload_config = true

return config
