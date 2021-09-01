if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
	eval $(dbus-launch --exit-with-session --sh-syntax)
fi
systemctl --user import-environment DISPLAY XAUTHORITY

if command -v dbus-update-activation-environment >/dev/null 2>&1; then
        dbus-update-activation-environment DISPLAY XAUTHORITY
fi


xrdb -merge ~/.Xresources &
setxkbmap -option ctrl:nocaps,altwin:swap_lalt_lwin,grp:win_space_toggle
#kmonad ~/.config/kmonad/ronnie.kbd &
sxhkd -c $HOME/.config/sxhkd/sxhkdrc &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
picom &
nm-applet &
volumeicon &
udiskie --no-automount --no-notify --tray &
autorandr --change &
wall-d -f -r &

#exec awesome
exec qtile start
#exec xmonad
