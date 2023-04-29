#!/bin/bash

#  ____                   _        _   _ _
# |  _ \ ___  _ __  _ __ (_) ___  | \ | (_)___ ___  __ _ _ __
# | |_) / _ \| '_ \| '_ \| |/ _ \ |  \| | / __/ __|/ _` | '_ \
# |  _ < (_) | | | | | | | |  __/ | |\  | \__ \__ \ (_| | | | |
# |_| \_\___/|_| |_|_| |_|_|\___| |_| \_|_|___/___/\__,_|_| |_|
#

Poweroff() {
	MENU="wofi --dmenu -i -p "-PowerOff?" --height 85 --width 200"
	P=$(echo -e "YES\nNO" | $MENU)

	case "$P" in
	YES) systemctl poweroff ;;
	NO) exit 0 ;;
	esac
}

Reboot() {
	MENU="wofi --dmenu -i -p "-Reboot?" --height 85 --width 200"
	R=$(echo -e "YES\nNO" | $MENU)

	case "$R" in
	YES) systemctl reboot ;;
	NO) exit 0 ;;
	esac
}

Logout() {
	MENU="wofi --dmenu -i -p "-Logout?" --height 85 --width 200"
	L=$(echo -e "YES\nNO" | $MENU)

	case "$L" in
	YES) swaymsg exit ;;
	NO) exit 0 ;;
	esac
}

Lock() {
	MENU="wofi --dmenu -i -p "-Lock?" --height 85 --width 200"
	L=$(echo -e "YES\nNO" | $MENU)

	case "$L" in
	YES) swaylock -f -i ~/Pictures/wallpaper.png --ring-color 000000 -r -K --key-hl-color 92baff --separator-color 92baff ;;
	NO) exit 0 ;;
	esac
}

MENU="wofi --dmenu -i -p "-PowerMenu" --height 140 --width 200"
PM=$(echo -e " Lock\n Logout\n Reboot\n Poweroff" | $MENU)

case "$PM" in
*Poweroff) Poweroff ;;
*Reboot) Reboot ;;
*Logout) Logout ;;
*Lock) Lock ;;
esac
