#!/usr/bin/env bash

set -o errexit
set -o nounset

old_theme="gruvbox-dark"
new_theme="nord"

if [[ $(grep -c nord ~/.config/alacritty/alacritty.yml) -eq 1 ]]; then
	old_theme="nord"
	new_theme="gruvbox-dark"
fi

sed -i "s/${old_theme}/${new_theme}/g" $(realpath ~/.config/alacritty/alacritty.yml)
sed -i "s/${old_theme}/${new_theme}/g" $(realpath ~/.config/tmux/tmux.conf)

tmux source-file ~/.config/tmux/tmux-${new_theme}.conf
