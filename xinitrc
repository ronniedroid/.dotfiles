
sxhkd -c $HOME/.config/sxhkd/sxhkdrc &
/bin/bash -c "sleep 1.8 && xrandr --output LVDS1 --primary --mode 1366x768 --pos 0x0 --rotate normal --output HDMI1 --off"
<<<<<<< HEAD
dwmblocks &
Wall-d -r &
=======
Wall-d -r &
dwmblocks &
>>>>>>> 1b2771184417abd2403ca7bfeff85cd4bc63b2f1
xrdb ~/.Xresources &


exec bspwm
