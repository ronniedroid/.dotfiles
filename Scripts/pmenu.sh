#!/bin/bash


MENU="dmenu -i -l 4 -p "-PowerMenu""
C=$(echo -e " Lock\n Logout\n Reboot\n Shutdown\n" | $MENU)
            case "$C" in
                *Lock) i3lock-fancy ;;
                *Logout) ~/.Scripts/exit.sh ;;
                *Reboot) ~/.Scripts/reboot.sh  ;;
                *Shutdown) ~/.Scripts/poweroff.sh
esac
