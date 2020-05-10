#!/bin/bash

#  ____                   _        _   _ _
# |  _ \ ___  _ __  _ __ (_) ___  | \ | (_)___ ___  __ _ _ __
# | |_) / _ \| '_ \| '_ \| |/ _ \ |  \| | / __/ __|/ _` | '_ \
# |  _ < (_) | | | | | | | |  __/ | |\  | \__ \__ \ (_| | | | |
# |_| \_\___/|_| |_|_| |_|_|\___| |_| \_|_|___/___/\__,_|_| |_|
#


Poweroff() {
 MENU="dmenu -i -l 2 -p "-PowerOff?""
 P=$(echo -e "YES\nNO" | $MENU)

case "$P" in
   YES) loginctl poweroff ;;
    NO) exit 0
  esac
}

Reboot() {
 MENU="dmenu -i -l 2 -p "-Reboot?""
 R=$(echo -e "YES\nNO" | $MENU)

case "$R" in
   YES) loginctl reboot ;;
    NO) exit 0
  esac
}

Logout() {
 MENU="dmenu -i -l 2 -p "-Logout?""
 L=$(echo -e "YES\nNO" | $MENU)

case "$L" in
   YES) pkill dwm ;;
    NO) exit 0
  esac
}

MENU="dmenu -i -l 3 -p "-PowerMenu""
PM=$(echo -e " Logout\n Reboot\n Poweroff" | $MENU)

  case "$PM" in
    *Poweroff) Poweroff ;;
    *Reboot) Reboot ;;
    *Logout) Logout
  esac
