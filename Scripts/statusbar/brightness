#!/bin/sh

bri=$(light -G | sed 's/\..*//g')

if [ "$bri" -gt "90" ]; then
	icon=" "
elif [ "$bri" -gt "70" ]; then
	icon=" "
elif [ "$bri" -eq "0" ]; then
    icon=" "
elif [ "$bri" -lt "30" ]; then
	icon=" "

else
	icon=""
fi

printf "%s%% \n" "$icon $bri"
