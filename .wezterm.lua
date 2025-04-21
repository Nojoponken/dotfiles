local wezterm = require('wezterm')

local config = wezterm.config_builder()

config.color_scheme = 'Spacegray Eighties (Gogh)'
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font('FiraCode Nerd Font')
config.font_size = 20
config.enable_wayland = true
config.cursor_blink_rate = 0

local scheme = wezterm.color.get_builtin_schemes()[config.color_scheme]
config.colors = {
  tab_bar = {
    active_tab = {
      bg_color = scheme.background,
      fg_color = scheme.foreground,
    }
  }
}

return config
