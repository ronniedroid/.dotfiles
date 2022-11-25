#!/usr/bin/env bash

# setxkbmap -layout us,ara
setxkbmap -option ctrl:nocaps
# setxkbmap -option grp:win_space_toggle
nitrogen --restore &
nm-applet --indicator &
udiskie --no-automount --no-notify --tray &
/usr/libexec/polkit-gnome-authentication-agent-1 &
picom &
