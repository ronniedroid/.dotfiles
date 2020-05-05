#!/bin/bash

bookmarksf=~/.Scripts/bookmarks

declare -a bookmarks

bookmarks=($(<$bookmarksf))

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
items=$(printf '%s\n' "${bookmarks[@]}" | $menu )

[ -n "$items" ] && qutebrowser $items || exit 0
