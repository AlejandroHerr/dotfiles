-- Pull in the wezterm API
local wezterm = require("wezterm")
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

local config = wezterm.config_builder()
-- This is where you actually apply your config choices
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
-- For example, changing the color scheme:
config.color_scheme = "Everforest Dark (Gogh)"
-- config.color_scheme = "Everforest Light (Gogh)"
config.font = wezterm.font("ShureTechMono Nerd Font")
config.font_size = 16.0

config.window_decorations = "RESIZE"

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false

config.default_prog = { os.getenv("SHELL") }

config.tab_max_width = 360

config.leader = { key = "a", mods = "CMD|CTRL|OPT", timeout_milliseconds = 2000 }
config.keys = {
	{
		mods = "LEADER",
		key = "g",
		action = wezterm.action.SpawnCommandInNewTab({
			args = { os.getenv("SHELL"), "-ic", "_wezterm_lazygit" }, -- Replace with your command
		}),
	},
	{
		mods = "LEADER",
		key = "f",
		action = wezterm.action.SpawnCommandInNewTab({
			args = { os.getenv("SHELL"), "-ic", " _wezterm_nvim_dir" }, -- Replace with your command
			domain = "CurrentPaneDomain",
		}),
	},
	{
		mods = "LEADER",
		key = "d",
		action = wezterm.action.SpawnCommandInNewTab({
			args = { os.getenv("SHELL"), "-c _wezterm_open_dir" }, -- Replace with your command
		}),
	},
	{
		mods = "LEADER",
		key = "c",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		mods = "LEADER",
		key = "x",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		mods = "LEADER",
		key = "b",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		mods = "LEADER",
		key = "n",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		mods = "LEADER",
		key = "\\",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "-",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "h",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		mods = "LEADER",
		key = "j",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		mods = "LEADER",
		key = "k",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		mods = "LEADER",
		key = "l",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		mods = "LEADER",
		key = "LeftArrow",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		mods = "LEADER",
		key = "RightArrow",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		mods = "LEADER",
		key = "DownArrow",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},
	{
		mods = "LEADER",
		key = "UpArrow",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},
}

for i = 1, 9 do
	-- leader + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

config.default_workspace = "~"
-- config.default_workspace = {
-- 	{
-- 		name = "config",
-- 		panes = {
-- 			{
-- 				cwd = "~/.config",
-- 			},
-- 			{
-- 				cwd = "~/.config/wezterm/",
-- 				cmd = "nvim",
-- 			},
-- 			{
-- 				cwd = "~/.config/nvim/",
-- 				cmd = "nvim",
-- 			},
-- 		},
-- 	},
-- }
workspace_switcher.apply_to_config(config)

local colors = wezterm.color.get_builtin_schemes()[config.color_scheme]

tabline.setup({
	options = {
		icons_enabled = true,
		theme = config.color_scheme,
		tabs_enabled = true,
		section_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
		component_separators = {
			left = wezterm.nerdfonts.pl_left_soft_divider,
			right = wezterm.nerdfonts.pl_right_soft_divider,
		},
		tab_separators = {
			left = "",
			right = "",
		},
		theme_overrides = {
			normal_mode = {
				a = { fg = colors.ansi[0], bg = colors.ansi[8] },
				b = { fg = colors.brights[8], bg = colors.brights[0] },
				c = {
					fg = colors.brights[8],
					bg = colors.background,
				},
			},
			tab = {
				active = { fg = colors.background, bg = colors.brights[7] },
				inactive = { fg = colors.brights[7], bg = colors.split },
				inactive_hover = { fg = colors.foreground, bg = colors.background },
			},
		},
	},
	sections = {
		tabline_a = {
			{
				"mode",
				padding = { left = 1, right = 2 },
				fmt = function(mode, window)
					if window:leader_is_active() then
						return wezterm.nerdfonts.md_fire
					elseif mode == "NORMAL" then
						return wezterm.nerdfonts.cod_code
					elseif mode == "COPY" then
						return wezterm.nerdfonts.md_scissors_cutting
					elseif mode == "SEARCH" then
						return wezterm.nerdfonts.oct_search
					end

					return mode
				end,
			},
		},
		tabline_b = {
			{
				"workspace",
				icons_enabled = true,
			},
		},
		tabline_c = { " " },
		tab_active = {
			{ Attribute = { Intensity = "Bold" } },
			wezterm.nerdfonts.pl_left_hard_divider,
			"index",
			{ "parent", padding = 0 },
			"/",
			{ "cwd", padding = { left = 0, right = 1 } },
			wezterm.nerdfonts.pl_right_hard_divider,
		},
		tab_inactive = {
			{ Attribute = { Intensity = "Bold" } },
			"index",
			{ "process", padding = { left = 0, right = 1 }, icons_enabled = false },
		},
		tabline_x = { "ram", "cpu" },
		tabline_y = { "datetime", "battery" },
		tabline_z = { "hostname", "domain" },
	},
	extensions = { "smart_workspace_switcher" },
})

workspace_switcher.workspace_formatter = function(label)
	return wezterm.format({
		{ Attribute = { Italic = true } },
		{ Text = "󱂬: " .. label },
	})
end

return config
