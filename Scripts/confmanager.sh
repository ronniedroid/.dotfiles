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
doom.d/config.el
doom.d/init.el
neovim
picom
polybar
qtile
spectrwm
spectrwm_bindings
sxhkd
xresources
zsh")

choice=$(echo -e "${options[@]}" | rofi -dmenu -i -l 10 -c -p ' Configs' -width 300)

case "$choice" in
	quit)
		echo "Program terminated." && exit 1
	;;
	alacritty)
		choice="$HOME/.config/alacritty/alacritty.yml"
	;;
    doom.d/config.el)
		choice="$HOME/.config/doom/config.el"
	;;
    doom.d/init.el)
		choice="$HOME/.config/doom/init.el"
	;;
	neovim)
		choice="$HOME/.config/nvim/init.vim"
	;;
	picom)
		choice="$HOME/.config/picom/picom.conf"
	;;
	polybar)
		choice="$HOME/.config/polybar/config"
	;;
	qtile)
		choice="$HOME/.config/qtile/config.py"
	;;
	spectrwm)
		choice="$HOME/.config/spectrwm/spectrwm.conf"
	;;
	spectrwm_bindings)
		choice="$HOME/.config/spectrwm/spectrwm_us.conf"
	;;
	sxhkd)
		choice="$HOME/.config/sxhkd/sxhkdrc"
	;;
	xresources)
		choice="$HOME/.Xresources"
	;;
	zsh)
		choice="$HOME/.config/zsh/.zshrc"
	;;
	*)
		exit 1
	;;
esac
alacritty -e nvim "$choice"
