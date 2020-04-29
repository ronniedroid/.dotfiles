
sxhkd -c $HOME/.config/sxhkd/sxhkdrc &
nitrogen --restore &
/bin/bash -c "sleep 1.8 && xrandr --output LVDS1 --primary --mode 1366x768 --pos 0x0 --rotate normal --output HDMI1 --off"
$HOME/.config/Wall-d/defaultwallpaper.sh
dwmblocks &

exec dwm
