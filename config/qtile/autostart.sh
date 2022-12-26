#!/usr/bin/env bash

setxkbmap -option ctrl:nocaps
xsetroot -cursor_name left_ptr
laptop.sh &
nitrogen --restore &
nm-applet --indicator &
udiskie --no-automount --no-notify --tray &
/usr/libexec/polkit-gnome-authentication-agent-1 &
picom &
