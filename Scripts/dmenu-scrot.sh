#!/bin/bash

name=$($name | dmenu -i -c -p "Screenshot_Name")

menu="dmenu -i -l 20 -p 'Screenshot_Option'"
options=$(echo -e "quick_fullscreen\ndelayed_fullscreen\nsection" | $menu)

case $options in

	quick_fullscreen)	maim ~/Pictures/$name.png;;
	delayed_fullscreen)	delay=$($delay | dmenu -i -p "Delay-Seconds")
			maim -d $delay ~/Pictures//$name.png;;
	section)	maim -s ~/Pictures/$name.png;;

esac
