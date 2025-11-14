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
config.adjust_window_size_when_changing_font_size = false
config.window_padding = {
  left = 5,
  right = 5,
  top = 5,
  bottom = 5,
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
-- https://wezfurlong.org/wezterm/colorschemes/b/index.html#blazer-gogh
-- config.color_scheme = 'Ollie'
config.color_scheme = 'Argonaut'

config.colors = {
  cursor_bg = "#ccaa00",     -- カーソルの背景色（変更したい色）
  cursor_fg = "#000000",     -- カーソルの前景色（テキストの色）
  cursor_border = "#ccaa00", -- カーソルの境界線色
}

config.text_background_opacity = 1
config.window_background_opacity = 0.85
config.macos_window_background_blur = 1

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
config.font_size = 12
config.font = wezterm.font_with_fallback({
  "JetBrainsMonoNerdFont",
  "Noto Sans CJK JP", -- FallBack fonts
  "Noto Serif CJK JP",
})
config.cell_width = 1.0
config.line_height = 1.2


-----------------------------
-- color
-----------------------------
-- config.color_scheme = 'AdventureTime'
-- config.color_scheme = 'OneHalfDark'

return config
