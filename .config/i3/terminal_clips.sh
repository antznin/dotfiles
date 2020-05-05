#!/bin/bash

source $HOME/Documents/terminal_clips.txt

printf '%s' "${clips[$1]}" | xclip -i -selection clipboard
xdotool key --clearmodifiers "ctrl+Shift+v"
