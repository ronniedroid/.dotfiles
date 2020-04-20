#!/bin/bash


MENU="dmenu -i -l 2 -p "ScreenLayout""
C=$(echo -e "Dual\nSingle\n" | $MENU)

	case "$C" in
		*Dual) xrandr --output LVDS1 --primary --mode 1366x768 --pos 0x0 --rotate normal --output HDMI1 --mode 1920x1080 --pos 1366x0 --rotate normal && $HOME/.Scripts/defaultwallpaper.sh ;;
		*Single) xrandr --output LVDS1 --primary --mode 1366x768 --pos 0x0 --rotate normal --output HDMI1 --off
	esac 
 
