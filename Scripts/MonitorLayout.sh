#!/bin/bash

screen1=$(xrandr --listactivemonitors | grep "+" | awk '{print $4}' | awk NR==1)
screen2=$(xrandr --listactivemonitors | grep "+" | awk '{print $4}' | awk NR==2)

MENU="dmenu -i -l 2 -p "Screen-Layout""
MODE=$(echo -e "Dual\nSingle\n" | $MENU)

	case "$MODE" in
		*Dual) xrandr --output $screen1 --primary --mode 1366x768 --pos 0x0 --rotate normal --output $screen2 --mode 1920x1080 --pos 1366x0 --rotate normal && $HOME/.Scripts/defaultwallpaper.sh ;;
		*Single) xrandr --output $screen1 --primary --mode 1366x768 --pos 0x0 --rotate normal --output screen2 --off
	esac

