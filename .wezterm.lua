local wezterm = require('wezterm')

local config = wezterm.config_builder()

-- config.color_scheme = 'Solarized Dark (Gogh)'
config.color_scheme = 'Gruvbox Light'
-- config.color_scheme = 'Atelier Cave (base16)'
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font('Aporetic Sans Mono')
config.font_size = 18
config.enable_wayland = true
config.cursor_blink_rate = 0
config.audible_bell = "Disabled"

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
