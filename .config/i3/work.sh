#!/usr/bin/env bash

day="$(date +%u)"
hour="$(date +%H)"

if [[ ! $(date +%u) -gt 5 ]]; then
    if [ $hour -ge 8 ] && [ $hour -lt 18 ]; then
        slack & disown
        teams & disown
        thunderbird & disown
    fi
fi
