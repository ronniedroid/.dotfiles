#!/bin/sh


if setxkbmap -query | grep "us" ; then
	setxkbmap ku ;
else
	setxkbmap us ;
fi
