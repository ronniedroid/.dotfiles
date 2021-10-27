#!/bin/bash

screen1=$( xrandr | grep -v "disconnected" | grep "connected" | awk '{print $1}' | awk NR==1)
screen2=$( xrandr | grep -v "disconnected" | grep "connected" | awk '{print $1}' | awk NR==2)
MENU="rofi -dmenu -i -l 2 -c -p "Screen_Layout" -width 200"
MODE=$(echo -e "Single\nDual\n" | $MENU)

	case "$MODE" in
		*Dual) xrandr --output $screen1 --primary --mode 1366x768 --pos 0x0 --rotate normal --output $screen2 --mode 1920x1080 --pos 1366x0 && Wall-d -f -r ;;
		*Single) xrandr --output $screen1 --primary --mode 1366x768 --pos 0x0 --rotate normal --output $screen2 --off
	esac

