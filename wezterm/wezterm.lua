-- Pull in the wezterm API
local wezterm = require("wezterm")
-- local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
-- local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

local config = wezterm.config_builder()
-- This is where you actually apply your config choices
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.color_scheme = "Everforest Dark (Gogh)"
config.font = wezterm.font("ShureTechMono Nerd Font")
config.font_size = 16.0

config.window_decorations = "RESIZE"

config.enable_tab_bar = false

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false

config.default_prog = { os.getenv("SHELL") }

config.tab_max_width = 360

config.leader = { key = "a", mods = "CMD|CTRL|OPT", timeout_milliseconds = 2000 }

config.default_workspace = "~"

return config
