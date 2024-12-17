local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Circus"
config.enable_tab_bar = false
config.font = wezterm.font("JetBrainsMono Nerd Font")

return config
