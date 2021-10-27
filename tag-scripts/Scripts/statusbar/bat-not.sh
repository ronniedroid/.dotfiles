#!/usr/bin/env bash

bat0=$(cat /sys/class/power_supply/BAT0/capacity)

notify-send "Battery: " "$bat0"
