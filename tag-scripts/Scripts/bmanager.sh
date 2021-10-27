#!/bin/bash

bookmarksf="$HOME/.Scripts/bookmarks"

addnew() {
keyword=$(rofi -dmenu -i -c -p "Enter Bookmark Name" -width 300)
url=$(xclip -o)

if [ -z "$keyword" ];
then
    exit 0
else
    echo "$keyword+$url" >> $bookmarksf
fi
}

bookmarks() {
items=$(awk -F "+" '{print $1}' $bookmarksf | sort | rofi -dmenu -i -l 10 -c -p "Bookmarks" -width 300)

bms=$(grep -m1 "$items" $bookmarksf | awk -F "+" '{print $2}')

[ -n "$items" ] && firefox $bms || exit 0

}

rbookmark() {
items=$(awk -F "+" '{print $1}' $bookmarksf | sort | rofi -dmenu -i -l 10 -c -p "Remove a Bookmarks" -width 300)

[ -n "$items" ] && sed -i "/$items/d" "$bookmarksf" || exit 0

}

while getopts abr option; do
    case "${option}" in
        a) addnew && exit 0 ;;
        b) bookmarks ;;
        r) rbookmark && exit 0 ;;
    esac
done
