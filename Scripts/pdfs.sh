#!/bin/bash


$(cd ~/ && ls -lR | grep '/\|pdf$' | find -iname '*.pdf' | rofi -dmenu | xargs -r zathura)
