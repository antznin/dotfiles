#!/bin/bash

# Getting keyboard variant
kblayout=$(setxkbmap -query | grep variant | awk '{print $2}')

if [ "$kblayout" == "intl" ]; then
	setxkbmap us # set layout on us
else
	setxkbmap us -variant intl # set on us intl
fi
