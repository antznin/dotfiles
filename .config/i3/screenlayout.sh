#!/bin/sh

num=$(xrandr --listactivemonitors)
num=${num:10:1}

if [ $num == 2 ]; then
	xrandr --output HDMI1 --mode 1920x1080 --pos 1920x0 --rotate normal --output VIRTUAL1 --off --output eDP1 --primary --mode 1280x1024 --pos 0x520 --rotate normal --output VGA1 --off
fi
