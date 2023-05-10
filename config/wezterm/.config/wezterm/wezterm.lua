local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-----------------------------
-- general
-----------------------------
config.automatically_reload_config = true
config.default_cursor_style = 'SteadyBar'

-----------------------------
-- window
-----------------------------
config.adjust_window_size_when_changing_font_size = true
config.window_padding = {
  left = '10px',
  right = '10px',
  top = '10px',
  bottom = '10px',
}
config.window_decorations = "RESIZE"

config.keys = {
  {
    key = 'n',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.TogglePaneZoomState,
  },
}

-----------------------------
-- background
-----------------------------
config.window_background_opacity = 0.5
config.macos_window_background_blur = 0

-----------------------------
-- tab bar
-----------------------------
config.hide_tab_bar_if_only_one_tab = true

-----------------------------
-- cursor
-----------------------------
config.hide_mouse_cursor_when_typing = true

-----------------------------
-- font
-----------------------------
config.font_size = 12.0
config.font = wezterm.font 'MesloLGS NF'
config.cell_width = 1.1
config.line_height = 1.2

-----------------------------
-- color
-----------------------------
-- config.color_scheme = 'AdventureTime'
-- config.color_scheme = 'OneHalfDark'


return config
