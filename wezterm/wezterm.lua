local wezterm = require 'wezterm'

return {
	color_scheme = 'Dark+',
	colors = {
		tab_bar = {
			active_tab = {
				bg_color = '#1e1e1e',
				fg_color = '#cccccc',
			},
		},
	},
	font = wezterm.font_with_fallback({"JetBrains Mono", "Menlo"}),
	font_size = 13,
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
}
