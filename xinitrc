setxkbmap -option ctrl:nocaps
sxhkd -c $HOME/.config/sxhkd/sxhkdrc &
wall-d -f -r &
xrdb -merge ~/.Xresources &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
picom &
nm-applet &
volumeicon &


exec awesome
