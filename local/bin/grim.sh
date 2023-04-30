#!/usr/bin/env bash

#  ____                   _        _   _ _
# |  _ \ ___  _ __  _ __ (_) ___  | \ | (_)___ ___  __ _ _ __
# | |_) / _ \| '_ \| '_ \| |/ _ \ |  \| | / __/ __|/ _` | '_ \
# |  _ < (_) | | | | | | | |  __/ | |\  | \__ \__ \ (_| | | | |
# |_| \_\___/|_| |_|_| |_|_|\___| |_| \_|_|___/___/\__,_|_| |_|
#

get_name=$(echo "" | wofi --dmenu -i -p "Screenshot name? (Optional)" -H 40 -W 250)
now=$(date +"%a-%Y-%m-%d-%I-%M-%S")

[ -z $get_name ] && name=$now || name=$get_name

dir=$(xdg-user-dir PICTURES)/Screenshots/"$name.png"

quick() {
	sleep 1 && grim $dir
}

delayed() {
	delay=$(echo -e "5\n10\n15" | wofi --dmenu -i -p "Delay amount" -H 110 -W 250)
	[ -z $delay ] && exit || sleep $delay && grim $dir
}

monitor() {
	monitors=$(swaymsg -t get_outputs | grep name | sed 's/"name":\ "//g;s/",//g' | $MENU)
	grim -o $monitors $dir
}

selection() {
	grim -g "$(slurp)" $dir
}

options=$(echo -e "Quick\nDelayed\nMonitor\nSelection" | wofi --dmenu -i -p "Screenshot type?" -H 135 -W 250)

case "$options" in
*Quick) quick ;;
*Delayed) delayed ;;
*Monitor) monitor ;;
*Selection) selection ;;
esac
