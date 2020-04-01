#!/bin/bash


$(cd ~/ && ls -lR | grep '/\|pdf$' | find -iname '*.pdf' | dmenu -l 10 | xargs -r zathura)
