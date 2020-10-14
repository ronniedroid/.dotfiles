#!/bin/sh

trap 'update' 5

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

update() {
    echo "$(wthr)| $(kbd)| $(bri)| $(volume)| $(bat)| $(ctime)| $(net)" &
    wait
}

while :; do
    update
    sleep 10 &
    wait
done
