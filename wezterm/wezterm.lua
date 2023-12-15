local wezterm = require 'wezterm'

local color_scheme = "Dark+"
local background_color = wezterm.color.get_builtin_schemes()[color_scheme].background
local foreground_color = wezterm.color.get_builtin_schemes()[color_scheme].foreground

return {
  color_scheme = color_scheme,
  colors = {
    tab_bar = {
      active_tab = {
        bg_color = background_color,
        fg_color = foreground_color,
      },
      inactive_tab_hover = {
        bg_color = background_color,
        fg_color = foreground_color,
      }
    },
  },
  font = wezterm.font_with_fallback({"Berkeley Mono", "Menlo"}),
  font_size = 14,
  front_end = "WebGpu",
  hide_tab_bar_if_only_one_tab = true,
  keys = {
    {
      mods = 'CMD',
      key = 'd',
      action = wezterm.action.SplitHorizontal,
    },
    {
      mods = 'CMD',
      key = 'D',
      action = wezterm.action.SplitVertical,
    },
  },
  native_macos_fullscreen_mode = true,
  show_new_tab_button_in_tab_bar = false,
  tab_max_width = 100,
  use_fancy_tab_bar = false,
  window_background_opacity = 0.999,
}
