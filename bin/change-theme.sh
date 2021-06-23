#!/usr/bin/env bash

set -o errexit
set -o nounset

old_theme=$(grep colorscheme ~/.config/nvim/init.vim | cut -d " " -f 2)
new_theme=$1

sed -i "s/${old_theme}/${new_theme}/g" $(realpath ~/.config/alacritty/alacritty.yml)
sed -i "s/${old_theme}/${new_theme}/g" $(realpath ~/.config/tmux/tmux.conf)
sed -i "s/colorscheme ${old_theme}/colorscheme ${new_theme}/g" $(realpath ~/.config/nvim/init.vim)

tmux source-file ~/.config/tmux/tmux-${new_theme}.conf
