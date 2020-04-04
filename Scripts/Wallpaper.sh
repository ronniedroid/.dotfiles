#!/bin/bash


DIR="$HOME/Pictures/"
FILE=$(sxiv -t -o $DIR) 

Center(){
  xwallpaper --center $FILE
}

Stretch(){
  xwallpaper --stretch $FILE
}

Tile(){
  xwallpaper --tile $FILE
}

Zoom(){
  xwallpaper --zoom $FILE
}

if [ -z $FILE ]
then
  exit 0
else 
  $MENU
fi

MENU="dmenu -l 4"
MODE=$(echo -e "center\nstretch\ntile\nzoom" | $MENU)
  case "$MODE" in
    center) Center ;;
    stretch) Stretch;;
    tile) Tile ;;
    zoom) Zoom
  esac
