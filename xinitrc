# Prepare D-Bus
#if [ "$DBUS_SESSION_BUS_ADDRESS" ]; then
#	dbus-update-activation-environment --systemd DISPLAY XAUTHORITY
#elif have dbus-run-session; then
#	exec dbus-run-session "$0" "$@" || exit
#elif have dbus-launch; then
#	exec dbus-launch --exit-with-session "$0" "$@" || exit
#fi

#picom &
#autorandr --change &
#wall-d -f -r &

#exec qtile start
