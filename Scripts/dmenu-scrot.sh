#!/bin/bash

name=$($name | rofi -dmenu -i -l 1 -p "Screenshot_Name")

menu="rofi -dmenu -i -l 20 -p 'Screenshot_Option'"
options=$(echo -e "quick_fullscreen\ndelayed_fullscreen\nsection" | $menu)

case $options in

	quick_fullscreen)	maim ~/Pictures/$name.png;;
	delayed_fullscreen)	delay=$($delay | rofi  -dmenu -i -p "Delay-Seconds")
			maim -d $delay ~/Pictures//$name.png;;
	section)	maim -s ~/Pictures/$name.png;;

esac
