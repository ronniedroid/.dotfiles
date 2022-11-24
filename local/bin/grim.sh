#!/usr/bin/env bash

#  ____                   _        _   _ _
# |  _ \ ___  _ __  _ __ (_) ___  | \ | (_)___ ___  __ _ _ __
# | |_) / _ \| '_ \| '_ \| |/ _ \ |  \| | / __/ __|/ _` | '_ \
# |  _ < (_) | | | | | | | |  __/ | |\  | \__ \__ \ (_| | | | |
# |_| \_\___/|_| |_|_| |_|_|\___| |_| \_|_|___/___/\__,_|_| |_|
#

MENU="wofi --dmenu -c -i -l 4 -p "Grim" -width 200"
name=$(echo "" | wofi --dmenu -c -i -l 0 -p "Name" -width 200)

dir=$(xdg-user-dir PICTURES)/"$name.png"

quick() {
    sleep 1 && grim $dir
}

delayed() {
    delay=$(echo -e "5\n10\n15" | $MENU)
    sleep $delay && grim $dir
}

monitor() {
    monitors=$(swaymsg -t get_outputs | grep name | sed 's/"name":\ "//g;s/",//g'| $MENU)
    grim -o $monitors $dir
}

selection() {
    grim -g "$(slurp)" $dir
}

while getopts qdms option; do
    case "${option}" in
        q) quick && exit;;
        d) delayed && exit ;;
        m) monitor && exit;;
	s) selection && exit
    esac
done
