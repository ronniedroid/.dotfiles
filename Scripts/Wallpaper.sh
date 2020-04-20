#!/bin/bash


DIR="$HOME/Pictures/wallpapers/"
FILE=$(sxiv -t -o $DIR) 

Center(){
  xwallpaper --center $FILE  && sed -i "s|xwallpaper.*|xwallpaper  --center $FILE|" $HOME/.Scripts/defaultwallpaper.sh
}
Stretch(){
  xwallpaper --stretch $FILE  && sed -i "s|xwallpaper.*|xwallpaper  --stretch $FILE|" $HOME/.Scripts/defaultwallpaper.sh
}
Tile(){
  xwallpaper --tile $FILE  && sed -i "s|xwallpaper.*|xwallpaper  --tile $FILE|" $HOME/.Scripts/defaultwallpaper.sh
}
Zoom(){
  xwallpaper --zoom $FILE  && sed -i "s|xwallpaper.*|xwallpaper  --zoom $FILE|" $HOME/.Scripts/defaultwallpaper.sh
}
No-randr(){
  xwallpaper --no-randr --stretch $FILE  && sed -i "s|xwallpaper.*|xwallpaper --no-randr --stretch $FILE|" $HOME/.Scripts/defaultwallpaper.sh
}

if [ -z "$FILE" ]
then
  exit 0
else 
  $MENU
fi

MENU="dmenu -l 5"
MODE=$(echo -e "center\nstretch\ntile\nzoom\nno-randr" | $MENU)
  case "$MODE" in
    center) Center ;;
    stretch) Stretch;;
    tile) Tile ;;
    zoom) Zoom ;;
    no-randr) No-randr 
  esac
