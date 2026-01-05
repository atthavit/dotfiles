local wezterm = require("wezterm")

local config = wezterm.config_builder()
local act = wezterm.action

config.initial_cols = 120
config.initial_rows = 28
config.font = wezterm.font("JetBrains Mono")
config.font_size = 11
config.harfbuzz_features = { "calt=0" }
config.color_scheme = "GruvboxDarkHard"
config.colors = { background = "black" }
config.tab_bar_at_bottom = true

config.mouse_bindings = {
	{
		event = { Down = { streak = 3, button = "Left" } },
		action = act.SelectTextAtMouseCursor("SemanticZone"),
		mods = "NONE",
	},
	{
		event = { Up = { streak = 1, button = 'Left' } },
		mods = 'NONE',
		action = act.CompleteSelection 'ClipboardAndPrimarySelection',
	},
	{
		event = { Up = { streak = 1, button = 'Left' } },
		mods = 'CMD',
		action = act.OpenLinkAtMouseCursor,
	},
	{
		event = { Up = { streak = 1, button = 'Left' } },
		mods = 'CTRL',
		action = act.OpenLinkAtMouseCursor,
	},
}

config.leader = { key = "b", mods = "CTRL" }
config.keys = {
	{ key = "b", mods = "LEADER|CTRL",  action = act.SendString("\x02") },
	{
		key = "%",
		mods = "LEADER|SHIFT",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{ key = '"', mods = "LEADER|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "z", mods = "LEADER",       action = act.TogglePaneZoomState },
	{ key = "c", mods = "LEADER",       action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "q", mods = "LEADER",       action = act.PaneSelect({ alphabet = "1234567890" }) },
	{ key = "o", mods = "LEADER",       action = act.ActivatePaneDirection("Prev") },
	{ key = "o", mods = "LEADER|CTRL",  action = act.RotatePanes("Clockwise") },
	{ key = "h", mods = "LEADER",       action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER",       action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER",       action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER",       action = act.ActivatePaneDirection("Right") },
	{ key = "H", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Left", 10 }) },
	{ key = "J", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Down", 10 }) },
	{ key = "K", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Up", 10 }) },
	{ key = "L", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Right", 10 }) },
	{ key = "1", mods = "LEADER",       action = act.ActivateTab(0) },
	{ key = "2", mods = "LEADER",       action = act.ActivateTab(1) },
	{ key = "3", mods = "LEADER",       action = act.ActivateTab(2) },
	{ key = "4", mods = "LEADER",       action = act.ActivateTab(3) },
	{ key = "5", mods = "LEADER",       action = act.ActivateTab(4) },
	{ key = "6", mods = "LEADER",       action = act.ActivateTab(5) },
	{ key = "7", mods = "LEADER",       action = act.ActivateTab(6) },
	{ key = "8", mods = "LEADER",       action = act.ActivateTab(7) },
	{ key = "9", mods = "LEADER",       action = act.ActivateTab(8) },
	{ key = "n", mods = "LEADER",       action = act.ActivateTabRelative(1) },
	{ key = "p", mods = "LEADER",       action = act.ActivateTabRelative(-1) },
	{ key = "x", mods = "LEADER",       action = act.CloseCurrentPane({ confirm = true }) },

	-- WORKSPACES
	{ key = "s", mods = "LEADER",       action = act.ShowLauncherArgs({ flags = "WORKSPACES" }) },
	{ key = "l", mods = "LEADER|SHIFT", action = act.SwitchWorkspaceRelative(-1) },
	{ key = "(", mods = "LEADER|SHIFT", action = act.SwitchWorkspaceRelative(-1) },
	{ key = ")", mods = "LEADER|SHIFT", action = act.SwitchWorkspaceRelative(1) },
	{ key = "[", mods = "LEADER",       action = act.ActivateCopyMode },
	{
		key = "$",
		mods = "LEADER|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for workspace",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
				end
			end),
		}),
	},
	{
		key = ",",
		mods = "LEADER",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
}

local copy_mode = wezterm.gui.default_key_tables().copy_mode
for _, key in ipairs({
	{ key = "[",        mods = "CTRL",  action = act.CopyMode("Close") },
	{
		key = "?",
		mods = "SHIFT",
		action = act.Multiple({
			act.CopyMode("ClearPattern"),
			act.Search({ CaseSensitiveString = "" }),
		}),
	},
	{
		key = "/",
		mods = "NONE",
		action = act.Multiple({
			act.CopyMode("ClearPattern"),
			act.Search({ CaseSensitiveString = "" }),
		}),
	},
	{
		key = "y",
		mods = "NONE",
		action = act.Multiple({
			act.CopyTo("PrimarySelection"),
			act.ClearSelection,
			act.CopyMode("ClearSelectionMode"),
		}),
	},
	{ key = "n",        mods = "NONE",  action = act.CopyMode("NextMatch") },
	{ key = "n",        mods = "SHIFT", action = act.CopyMode("PriorMatch") },
	{ key = "u",        mods = "CTRL",  action = act.ScrollByPage(-0.5) },
	{ key = "y",        mods = "CTRL",  action = act.ScrollByLine(-1) },
	{ key = "d",        mods = "CTRL",  action = act.ScrollByPage(0.5) },
	{ key = "e",        mods = "CTRL",  action = act.ScrollByLine(1) },
	{ key = "PageUp",   mods = "NONE",  action = act.ScrollByPage(-0.5) },
	{ key = "PageDown", mods = "NONE",  action = act.ScrollByPage(0.5) },
}) do
	table.insert(copy_mode, key)
end

local search_mode = wezterm.gui.default_key_tables().search_mode
for _, key in ipairs({
	{ key = "[",      mods = "CTRL", action = act.ActivateCopyMode },
	{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
	{ key = "c",      mods = "CTRL", action = act.CopyMode("Close") },
	{ key = "Enter",  mods = "NONE", action = act.CopyMode("AcceptPattern") },
	{ key = "w",      mods = "CTRL", action = act.Search({ CaseInSensitiveString = "" }) },
}) do
	table.insert(search_mode, key)
end

config.key_tables = {
	copy_mode = copy_mode,
	search_mode = search_mode,
}

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

local function tabname(tab)
	if #tab.tab_title == 0 then
		return ""
	end
	return tab.tab_title .. " "
end

local tabconfig = {
	"index",
	tabname,
	{ "process", padding = { left = 0, right = 1 } },
	{ "output",  padding = 0 },
}

tabline.setup({
	options = { theme = config.color_scheme },
	sections = {
		tabline_a = { "workspace" },
		tabline_b = { "" },
		tabline_c = { "" },
		tab_active = tabconfig,
		tab_inactive = tabconfig,
		tabline_x = { "ram", "cpu" },
		tabline_y = { "datetime", "battery" },
		tabline_z = { "domain" },
	},
})

tabline.apply_to_config(config)
config.window_decorations = "TITLE | RESIZE"

return config
