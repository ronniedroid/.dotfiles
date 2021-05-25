#!/bin/bash
#
#  ____                   _        _   _ _
# |  _ \ ___  _ __  _ __ (_) ___  | \ | (_)___ ___  __ _ _ __
# | |_) / _ \| '_ \| '_ \| |/ _ \ |  \| | / __/ __|/ _` | '_ \
# |  _ < (_) | | | | | | | |  __/ | |\  | \__ \__ \ (_| | | | |
# |_| \_\___/|_| |_|_| |_|_|\___| |_| \_|_|___/___/\__,_|_| |_|
#

# Dmenu script for editing some of my more frequently edited config files.

declare options=("alacritty
neovim
sway
waybar
waybar-style
fish")

choice=$(echo -e "${options[@]}" | rofi -dmenu -i -l 10 -c -p ' Configs' -width 300)

case "$choice" in
	quit)
		echo "Program terminated." && exit 1
	;;
	alacritty)
		choice="$HOME/.config/alacritty/alacritty.yml"
	;;
	neovim)
		choice="$HOME/.config/nvim/init.vim"
	;;
	waybar)
		choice="$HOME/.config/waybar/config"
	;;
	waybar-style)
		choice="$HOME/.config/waybar/style"
	;;
    fish)
		choice="$HOME/.config/fish/config.fish"
	;;
	*)
		exit 1
	;;
esac
alacritty -e nvim "$choice"
