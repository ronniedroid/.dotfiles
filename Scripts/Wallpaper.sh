#!/bin/bash


DIR="$HOME/Pictures/wallpapers/" # Path to wallpapers
FILE=$(sxiv -t -o $DIR | xargs)  # running sxiv, and marking either one or two files
FILE1=$(printf "%s" "$FILE" | awk '{print $1}')  # Print the path to the first marked picture
FILE2=$(printf "%s" "$FILE" | awk '{print $2}')  # Print the path to the second marked picture
screen1=$(xrandr --listactivemonitors | grep "+" | awk '{print $4}' | awk NR==1) # Select the first screen for the dual function
screen2=$(xrandr --listactivemonitors | grep "+" | awk '{print $4}' | awk NR==2) # Select the second screen if attached for the dual function


Center(){
    xwallpaper --center $FILE1  && sed -i "s|xwallpaper.*|xwallpaper  --center $FILE1|" $HOME/.Scripts/defaultwallpaper.sh # set the first marked picture as wallpaper in Center mode and replace it in the defaultwallpaper script to make sure it loads with the x session
}
Stretch(){
    xwallpaper --stretch $FILE1  && sed -i "s|xwallpaper.*|xwallpaper  --stretch $FILE1|" $HOME/.Scripts/defaultwallpaper.sh # same as above but in Stretch mode

}
Tile(){
    xwallpaper --tile $FILE1  && sed -i "s|xwallpaper.*|xwallpaper  --tile $FILE1|" $HOME/.Scripts/defaultwallpaper.sh # same as above but in Tile mode
}
Zoom(){
    xwallpaper --zoom $FILE1  && sed -i "s|xwallpaper.*|xwallpaper  --zoom $FILE1|" $HOME/.Scripts/defaultwallpaper.sh # same as above but in Zoom mode

}
No-randr(){
    xwallpaper --no-randr --stretch $FILE1  && sed -i "s|xwallpaper.*|xwallpaper --no-randr --stretch $FILE1|" $HOME/.Scripts/defaultwallpaper.sh # same as above but in No-randr mode

}

# issue here
dual() {
    xwallpaper --output $screen1 --zoom $FILE1 --output $screen2 --zoom $FILE2
}

# if no picture is marked in sxiv, exit.
if [ -z "$FILE" ]
then
  exit 0
else
  $MENU
fi

MENU="dmenu -l 6"
MODE=$(echo -e "center\nstretch\ntile\nzoom\nno-randr\ndual" | $MENU)
  case "$MODE" in
    center) Center ;;
    stretch) Stretch;;
    tile) Tile ;;
    zoom) Zoom ;;
    no-randr) No-randr ;;
    dual) dual
  esac
