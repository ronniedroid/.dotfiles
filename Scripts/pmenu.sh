#!/bin/bash


MENU="rofi -dmenu -i -location 3 -width 15 -lines 4 -xoffset -10 -yoffset 35 -eh 1 -p "-PowerMenu""
C=$(echo -e " Lock\n Logout\n Reboot\n Shutdown\n" | $MENU)
            case "$C" in
                *Lock) i3lock-fancy ;;
                *Logout) ~/.Scripts/exit.sh ;;
                *Reboot) ~/.Scripts/reboot.sh  ;;
                *Shutdown) ~/.Scripts/poweroff.sh
esac
