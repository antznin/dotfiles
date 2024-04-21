#!/usr/bin/env sh

# Double monitor
xrandr --prop \
  | grep -A 2 "HDMI-1 connected" \
  | grep -q "00ffffffffffff0010acbaa055474433" \
  && xrandr \
  --output eDP-1 --primary --mode 1920x1080 --pos 1920x120 --rotate normal \
  --output HDMI-1 --mode 1920x1200 --pos 0x0 --rotate normal \
  --output DP-1 --off \
  --output DP-2 --off \
  && exit 0

# Double monitor
xrandr --query | grep -q "HDMI-1 connected" && xrandr \
  --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
  --output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate normal \
  --output DP-1 --off \
  --output DP-2 --off \
  && exit 0

# Triple monitor
xrandr --query | grep -q "DP-2-1 connected" && xrandr \
  --output eDP-1 --primary --mode 1920x1080 --pos 3840x60 --rotate normal \
  --output HDMI-1 --off \
  --output DP-1 --off \
  --output DP-2 --off \
  --output DP-2-1 --mode 1920x1200 --pos 0x0 --rotate normal \
  --output DP-2-2 --mode 1920x1200 --pos 1920x0 --rotate normal \
  --output DP-2-3 --off \
  && exit 0
