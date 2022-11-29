#!/usr/bin/env bash

setxkbmap -option ctrl:nocaps
laptop.sh &
nitrogen --restore &
nm-applet --indicator &
udiskie --no-automount --no-notify --tray &
caffeine &
volumeicon &
/usr/libexec/polkit-gnome-authentication-agent-1 &
picom &
