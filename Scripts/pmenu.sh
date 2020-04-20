#!/bin/bash

Poweroff() {
 MENU="dmenu -i -l 2 -p "-PowerOff?""
 P=$(echo -e "YES\nNO\n" | $MENU)

case "$P" in
   YES) systemctl poweroff ;;
    NO) exit 0
  esac 
}

Reboot() {
 MENU="dmenu -i -l 2 -p "-Reboot?""
 R=$(echo -e "YES\nNO\n" | $MENU)

case "$R" in
   YES) systemctl poweroff ;;
    NO) exit 0
  esac 
}

Logout() {
 MENU="dmenu -i -l 2 -p "-Logout?""
 L=$(echo -e "YES\nNO\n" | $MENU)

case "$L" in
   YES) bspc quit ;;
    NO) exit 0
  esac 
}

MENU="dmenu -i -l 3 -p "-PowerMenu""
PM=$(echo -e " Logout\n Reboot\n Poweroff\n" | $MENU)
    
  case "$PM" in
    *Poweroff) Poweroff ;;
    *Reboot) Reboot ;;
    *Logout) Logout 
  esac 
