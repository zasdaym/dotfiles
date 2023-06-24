local wezterm = require 'wezterm'

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Dark+'
  else
    return 'Gruvbox Light'
  end
end

local color_scheme = scheme_for_appearance(get_appearance())
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
        italic = false,
			}
		},
	},
	font = wezterm.font_with_fallback({"Berkeley Mono", "JetBrains Mono", "Menlo"}),
	font_size = 13,
	front_end = "WebGpu",
	hide_tab_bar_if_only_one_tab = true,
	keys = {
		{
			mods = 'CMD',
			key = 'd',
			action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
		},
		{
			mods = 'CMD',
			key = 'D',
			action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
		},
	},
	native_macos_fullscreen_mode = true,
	show_new_tab_button_in_tab_bar = false,
	tab_max_width = 100,
	use_fancy_tab_bar = false,
	window_background_opacity = 0.999,
}
