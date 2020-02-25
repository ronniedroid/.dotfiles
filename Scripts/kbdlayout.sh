#!/bin/sh


if setxkbmap -query| grep "us" ; then
	setxkbmap ar ;
else 
	setxkbmap us ;

fi
