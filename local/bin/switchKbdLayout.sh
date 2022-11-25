#!/bin/sh

if setxkbmap -query | grep "us" ; then
	setxkbmap ara ;
else
	setxkbmap us ;
fi
