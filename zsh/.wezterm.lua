-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "tokyonight"
config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 15

config.enable_tab_bar = true
-- config.window_decorations = "RESIZE"

-- config.window_background_opacity = 0.75
-- config.macos_window_background_blur = 10

-- and finally, return the configuration to wezterm
return config
