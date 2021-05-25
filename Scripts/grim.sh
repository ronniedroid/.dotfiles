#!/usr/bin/env bash

#  ____                   _        _   _ _
# |  _ \ ___  _ __  _ __ (_) ___  | \ | (_)___ ___  __ _ _ __
# | |_) / _ \| '_ \| '_ \| |/ _ \ |  \| | / __/ __|/ _` | '_ \
# |  _ < (_) | | | | | | | |  __/ | |\  | \__ \__ \ (_| | | | |
# |_| \_\___/|_| |_|_| |_|_|\___| |_| \_|_|___/___/\__,_|_| |_|
#

dir=$(xdg-user-dir PICTURES)/$(date +'%s_grim.png')
MENU="rofi -dmenu -c -i -l 4 -p "Grim" -width 200"


quick() {
    sleep 1 && grim $dir
}

delayed() {
    delay=$(echo -e "5\n10\n15" | $MENU)
    sleep $delay && grim $dir
}

selection() {
    monitors=$(swaymsg -t get_outputs | grep name | sed 's/"name":\ "//g;s/",//g'| $MENU)
    grim -o $monitors $dir
}

# Lock() {
# }

PM=$(echo -e "quick\ndelayed\nselection" | $MENU)

  case "$PM" in
    *quick) quick ;;
    *delayed) delayed ;;
    *selection) selection ;;
esac
 
