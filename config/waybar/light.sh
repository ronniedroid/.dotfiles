#!/bin/bash

brightness=$(light -G | awk -F "." '{print $1}')

if grep -q open /proc/acpi/button/lid/LID/state; then
    echo "" $brightness"%"
else
    echo "ﯥ"
fi
