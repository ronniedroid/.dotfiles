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
