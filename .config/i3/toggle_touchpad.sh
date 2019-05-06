#!/bin/bash

state=$(xinput list-props 'FocalTechPS/2 FocalTech Touchpad' | grep 'Device Enabled' | awk '{print $4}')

if [ "$state" == "1" ]; then
	xinput disable 'FocalTechPS/2 FocalTech Touchpad'
else
	xinput enable 'FocalTechPS/2 FocalTech Touchpad'
fi
