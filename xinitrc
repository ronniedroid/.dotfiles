setxkbmap -option ctrl:nocaps
sxhkd -c $HOME/.config/sxhkd/sxhkdrc &
xsetroot -cursor_name left_ptr
wall-d -f -r &
#dwmstatbar &
xrdb -merge ~/.Xresources &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
#picom &
emacs --daemon &

exec spectrwm
