#!/bin/sh

if pgrep -x waybar > /dev/null; then
    pkill -USR1 waybar
else
    waybar -c ~/.config/waybar/config &
fi
