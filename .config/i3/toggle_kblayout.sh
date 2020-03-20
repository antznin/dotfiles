#!/bin/bash

# Getting keyboard variant
kblayout=$(setxkbmap -query | grep variant | awk '{print $2}')

if [ "$kblayout" == "intl" ]; then
	setxkbmap gb # set layout on us
else
	setxkbmap gb -variant intl # set on us intl
fi
