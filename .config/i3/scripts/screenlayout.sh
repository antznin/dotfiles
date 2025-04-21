#!/usr/bin/env sh

external_display="$(xrandr --prop | grep "^DP-.* connected" | cut -d' ' -f1)"
edid_desk=$(xrandr --prop | grep -o 011e010380a05a780aee91a3544c9926)
edid_redroom=$(xrandr --prop | grep -o 0f1f0103803d23782a5fb1a2574fa228)

if [ -n "$external_display" ]; then
  if [ -n "$edid_desk" ]; then
    xrandr \
    --output eDP-1 --primary --mode 2256x1504 --pos 0x0 --rotate normal \
    --output "$external_display" --mode 1920x1080 --pos 2256x0 --rotate normal

  elif [ -n "$edid_redroom" ]; then
    xrandr \
      --output eDP-1 --primary --mode 2256x1504 --pos 0x656 --rotate normal \
      --output "$external_display" --mode 3840x2160 --pos 2256x0 --rotate normal
  else
    xrandr \
      --output eDP-1 --primary --mode 2256x1504 --pos 0x656 --rotate normal \
      --output "$external_display" --mode 3840x2160 --pos 2256x0 --rotate normal \
      --output DP-2 --off \
      --output DP-3 --off \
      --output DP-4 --off
  fi
else
  xrandr \
    --output eDP-1 --primary --mode 2256x1504 --pos 0x0 --rotate normal \
    --output DP-1 --off \
    --output DP-2 --off \
    --output DP-3 --off \
    --output DP-4 --off
fi
