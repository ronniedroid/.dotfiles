#!/bin/bash

bookmarksf="$HOME/.Scripts/bookmarks"

addnew() {
keyword=$(dmenu -i -p "Enter Bookmark Name")
url=$(xclip -o)

if [ -z "$keyword" ];
then
    exit 0
else
    echo "$keyword+$url" >> $bookmarksf
fi
}

bookmarks() {
items=$(awk -F "+" '{print $1}' $bookmarksf | sort | dmenu -i -l 10 -h 24 -p "Bookmarks")

bms=$(grep -m1 "$items" $bookmarksf | awk -F "+" '{print $2}')

[ -n "$items" ] && firefox $bms || exit 0

}

rbookmark() {
items=$(awk -F "+" '{print $1}' $bookmarksf | sort | dmenu -i -l 10 -p "Remove a Bookmarks")

[ -n "$items" ] && sed -i "/$items/d" "$bookmarksf" || exit 0

}

while getopts abr option; do
    case "${option}" in
        a) addnew && exit 0 ;;
        b) bookmarks ;;
        r) rbookmark && exit 0 ;;
    esac
done
