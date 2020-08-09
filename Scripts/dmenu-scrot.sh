#!/bin/bash

name=$($name | dmenu -i -p "Screenshot_Name")

menu="dmenu -i -l 20 -p 'Screenshot_Option'"
options=$(echo -e "quick_fullscreen\ndelayed_fullscreen\nsection" | $menu)

case $options in

	quick_fullscreen)	scrot -d 1 -q 100 $name.png -e 'mv $f ~/Pictures' ;;
	delayed_fullscreen)	delay=$($delay | dmenu -i -p "Delay-Seconds")
			scrot -d $delay -q 100 $name.png -e 'mv $f ~/Pictures'  ;;
	section)	scrot -q 100 -s $name.png -e 'mv $f ~/Pictures' ;;

esac
