#!/bin/bash

bookmarksf="$HOME/.Scripts/bookmarks"


input="$2"
addnew() {
    echo $input >> $bookmarksf
}


while getopts a: option; do
    case "${option}" in
        a) addnew && exit 0 ;;
    esac
done

menu="dmenu -i -l 10 -p "Bookmarks""
items=$(cat $bookmarksf | awk -F "-" '{print $1}' | $menu )

bms=$(cat $bookmarksf | grep "$items" | awk -F "-" '{print $2}')

[ -n "$items" ] && firefox $bms || exit 0

