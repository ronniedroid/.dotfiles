
sxhkd -c $HOME/.config/sxhkd/sxhkdrc &
nitrogen --restore &
/bin/bash -c "sleep 1.8 && xrandr --output LVDS1 --primary --mode 1366x768 --pos 0x0 --rotate normal --output HDMI1 --mode 1920x1080 --pos 1366x0 --rotate normal"
xwallpaper --zoom /home/ron/Pictures/reiseuhu-yr3Vn56Ocys-unsplash.jpg &


exec dwm
