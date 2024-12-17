local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Circus (base16)"
config.enable_tab_bar = false
config.font = wezterm.font("fira code")
config.enable_wayland = true

return config
