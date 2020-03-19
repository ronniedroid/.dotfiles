#!/usr/bin/env sh

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

export MONITOR1=$(xrandr -q | grep " connected" | cut -d ' ' -f1 | head -n 1)

polybar bar1 &
#polybar second &

echo "Bars launched..."
