#!/bin/sh

net() {
    internet
}

ctime() {
    clock
}

bat() {
    battery
}

vol() {
    volume
}

bri() {
    brightness
}

kbd() {
    kbdlayout
}

screens() {
    screenstatus
}
wthr() {
    weather
}

while :; do
    echo "$(wthr)$(kbd)$(ctime)$(bri)$(volume)$(bat)$(net)" &
    sleep 60
done
