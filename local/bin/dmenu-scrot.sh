#!/bin/bash

name=$($name | dmenu -i -l 1 -p "Screenshot_Name")

menu="dmenu -i -l 20 -p 'Screenshot_Option'"
options=$(echo -e "quick_fullscreen\ndelayed_fullscreen\nsection" | $menu)

case $options in

	quick_fullscreen)	maim -d 1 ~/Pictures/Screenshots/$name.png;;
	delayed_fullscreen)	delay=$($delay | rofi  -dmenu -i -p "Delay-Seconds")
			maim -d $delay ~/Pictures/Screenshots/$name.png;;
	section)	maim -s ~/Pictures/Screenshots/$name.png;;

esac
