-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
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
config.font_size = 13.0

-- config.enable_tab_bar = false
config.window_decorations = "RESIZE"

config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

config.colors = {
	tab_bar = {
		background = "#2D353B",
		active_tab = {
			bg_color = "#35A77C",
			fg_color = "#2D353B",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#2D353B",
			fg_color = "#D3C6AA",
		},
		inactive_tab_hover = {
			bg_color = "#2D353B",
			fg_color = "#DFDDC8",
			italic = false,
		},
	},
}
config.tab_max_width = 36

local function tab_title(tab_info)
	local index = tab_info.tab_index
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return index .. title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return index .. ": " .. tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = tab_title(tab)
	if tab.is_active then
		return {
			{ Text = " " .. title .. " " },
			-- { Foreground = { Color = "#343F44" } },
			-- { Text = "🮇" },
			-- { Text = "🮉" },
		}
	end
	return {
		{ Text = " " .. title .. " " },
		-- { Foreground = { Color = "#5C6A72" } },
		-- { Text = "🮉" },
	}
end)

wezterm.on("update-right-status", function(window, _)
	local SOLID_LEFT_ARROW = ""
	local ARROW_FOREGROUND = { Foreground = { Color = "#35A77C" } }
	local prefix = ""

	if window:leader_is_active() then
		prefix = " " .. utf8.char(0x1f336) .. "  " -- ocean wave
		SOLID_LEFT_ARROW = utf8.char(0xe0b2)
	end

	if window:active_tab():tab_id() ~= 0 then
		ARROW_FOREGROUND = { Foreground = { Color = "#2D353B" } }
	end -- arrow color based on if tab is first pane
	window:set_left_status(wezterm.format({
		{ Background = { Color = "#2D353B" } },
		{ Text = prefix },
		ARROW_FOREGROUND,
		{ Text = SOLID_LEFT_ARROW },
	}))
end)

config.leader = { key = "a", mods = "CMD|CTRL|OPT", timeout_milliseconds = 2000 }
config.keys = {
	{
		mods = "LEADER",
		key = "g",
		action = wezterm.action.SpawnCommandInNewTab({
			args = { os.getenv("SHELL"), "-c lazygit" }, -- Replace with your command
		}),
	},
	{
		mods = "LEADER",
		key = "f",
		action = wezterm.action.SpawnCommandInNewTab({
			args = { os.getenv("SHELL"), "-c _wezterm_nvim_dir" }, -- Replace with your command
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

for i = 0, 9 do
	-- leader + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i),
	})
end

-- and finally, return the configuration to wezterm
return config
