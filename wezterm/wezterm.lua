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
  freetype_load_flags = "NO_HINTING",
  front_end = "OpenGL",
  hide_tab_bar_if_only_one_tab = false,
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
  -- show_close_tab_button_in_tabs = false,
  show_new_tab_button_in_tab_bar = false,
  show_tab_index_in_tab_bar = true,
  tab_max_width = 100,
  use_fancy_tab_bar = true,
  window_background_opacity = 0.999,
  window_decorations = "INTEGRATED_BUTTONS|RESIZE",
  window_frame = {
    font = wezterm.font_with_fallback({"Berkeley Mono", "Menlo"}),
    font_size = 14,
  },
}
