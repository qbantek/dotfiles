-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux
local action = wezterm.action

local config = wezterm.config_builder()

config.color_scheme = "tokyonight"
config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 15

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

config.default_workspace = "projects"

-- simulate tmux leader key
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }

-- Register a callback to be executed on the "gui-startup" event.
wezterm.on("gui-startup", function(cmd)
	-- Spawn a new window using any provided startup command line arguments.
	local _, _, window = mux.spawn_window(cmd or {})
	-- Maximize the GUI window associated with the spawned window.
	window:gui_window():maximize()
end)

-- Define constants for repeated string literals
local LEADER = "LEADER"
local CURRENT_PANE_DOMAIN = "CurrentPaneDomain"

local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

-- determine if the current pane is inside Neovim
-- if you are *NOT* lazy-loading smart-splits.nvim (recommended)
local function is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == "true"
end

local function split_nav(actionType, key)
	local mods = actionType == "resize" and "META" or "CTRL"

	return {
		key = key,
		mods = mods,
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- Inside Neovim: pass the key + modifier through
				win:perform_action({
					SendKey = {
						key = key,
						mods = mods,
					},
				}, pane)
			else
				-- Outside Neovim: move or resize panes
				if actionType == "resize" then
					win:perform_action({
						AdjustPaneSize = {
							direction_keys[key],
							3,
						},
					}, pane)
				else
					win:perform_action({
						ActivatePaneDirection = direction_keys[key],
					}, pane)
				end
			end
		end),
	}
end

local function getKeyBindings()
	local keys = {
		-- move between split panes
		split_nav("move", "h"),
		split_nav("move", "j"),
		split_nav("move", "k"),
		split_nav("move", "l"),

		-- resize panes
		split_nav("resize", "h"),
		split_nav("resize", "j"),
		split_nav("resize", "k"),
		split_nav("resize", "l"),

		-- CTRL-b|: Split the current pane horizontally
		{
			key = "|",
			mods = LEADER,
			action = action.SplitHorizontal({ domain = CURRENT_PANE_DOMAIN }),
		},

		-- CTRL-b-: Split the current pane vertically
		{
			key = "-",
			mods = LEADER,
			action = action.SplitVertical({ domain = CURRENT_PANE_DOMAIN }),
		},

		-- CTRL-bw: Fuzzy workspace switcher
		{
			key = "w",
			mods = LEADER,
			action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
		},

		-- CTRL-bc: Create a new tab in the current workspace
		{
			key = "c",
			mods = LEADER,
			action = action.SpawnTab(CURRENT_PANE_DOMAIN),
		},

		-- CTRL-bn: Create a new window in a new workspace (prompt for name)
		{
			key = "n",
			mods = LEADER,
			action = wezterm.action.PromptInputLine({
				description = "Enter name for new workspace",
				action = wezterm.action_callback(function(window, pane, line)
					if line and line:match("^%s*(.-)%s*$") ~= "" then
						window:perform_action(
							wezterm.action.SwitchToWorkspace({
								name = line,
							}),
							pane
						)
					else
						window:toast_notification("Error", "Workspace name cannot be empty", nil, 4000)
					end
				end),
			}),
		},

		-- CTRL-bz: Toggle zoom state of the current pane
		{
			key = "z",
			mods = LEADER,
			action = action.TogglePaneZoomState,
		},

		-- activate copy mode or vim mode
		{
			key = "Enter",
			mods = LEADER,
			action = wezterm.action.ActivateCopyMode,
		},
	}

	-- CTRL-b1..9: Switch to tab 1..9
	for i = 1, 9 do
		table.insert(keys, {
			key = tostring(i),
			mods = LEADER,
			action = action.ActivateTab(i - 1),
		})
	end

	return keys
end

-- add the key bindings to the config
config.keys = getKeyBindings()

-- and finally, return the configuration to wezterm
return config
