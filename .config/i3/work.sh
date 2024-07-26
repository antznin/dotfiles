#!/usr/bin/env bash

sleep 3

hour="$(date +%H)"

declare -a apps=(
    slack
    thunderbird
    teams
)

if [[ ! $(date +%u) -gt 5 ]]; then
    if [ "$hour" -ge "8" ] && [ "$hour" -lt "18" ]; then
        for app in "${apps[@]}"; do
            $app & disown
        done
    fi
fi
