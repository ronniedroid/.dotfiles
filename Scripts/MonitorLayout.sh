#!/bin/bash

screen1=$( xrandr | grep -v "disconnected" | grep "connected" | awk '{print $1}' | awk NR==1)
screen2=$( xrandr | grep -v "disconnected" | grep "connected" | awk '{print $1}' | awk NR==2)
MENU="dmenu -i -l 2 -p "Screen_Layout""
MODE=$(echo -e "Single\nDual\n" | $MENU)

	case "$MODE" in
		*Dual) xrandr --output $screen1 --primary --mode 1366x768 --pos 0x0 --rotate normal --output $screen2 --mode 1366x768 --pos 1366x0 --rotate left && Wall-d -f -r ;;
		*Single) xrandr --output $screen1 --primary --mode 1366x768 --pos 0x0 --rotate normal --output $screen2 --off
	esac

