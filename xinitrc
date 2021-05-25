if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
	eval $(dbus-launch --exit-with-session --sh-syntax)
fi
systemctl --user import-environment DISPLAY XAUTHORITY

if command -v dbus-update-activation-environment >/dev/null 2>&1; then
        dbus-update-activation-environment DISPLAY XAUTHORITY
fi

setxkbmap -option ctrl:nocaps
sxhkd -c $HOME/.config/sxhkd/sxhkdrc &
wall-d -f -r &
xrdb -merge ~/.Xresources &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
picom &
nm-applet &
volumeicon &
udiskie --no-automount --no-notify --tray &

#exec /home/ronnie/.config/rpenrose/target/release/rpenrose &> ~/.rpenrose.log
exec awesome
#exec spectrwm
