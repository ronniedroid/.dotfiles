#!/bin/bash

MENU="dmenu -i -l 2 -p "-Exit?""
c=$(echo -e "YES\nNO\n" | $MENU)

if [ "$c" == "YES" ];
then
	  pkill dwm

elif [ "$c" == "NO" ];
then
	exit 0
fi
