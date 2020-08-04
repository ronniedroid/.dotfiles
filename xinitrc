sxhkd -c $HOME/.config/sxhkd/sxhkdrc &
xsetroot -cursor_name left_ptr
Wall-d -f -r &
#dwmstatbar &
xrdb -merge ~/.Xresources &&
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
#picom &

xset +fp /home/ronnie/.local/share/fonts
xset fp rehash

exec qtile
