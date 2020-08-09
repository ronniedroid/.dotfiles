#!/usr/bin/env bash


wm=$(grep "exec" $HOME/.xinitrc | awk '{print $2}')

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log


if [ "$wm" = "spectrwm" ]; then
		polybar swm >>/tmp/polybar1.log 2>&1 &
else
		polybar qtile >>/tmp/polybar1.log 2>&1 &
fi

echo "Bars launched..."
