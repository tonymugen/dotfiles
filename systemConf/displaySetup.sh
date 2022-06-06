#!/bin/sh
# check if the NVIDIA GPU is active and tell xorg to use it for the dsiplay
# this script goes into /etc/lightdm
xrandr --output $( xrandr | grep eDP | awk '{print $1}' ) --auto --primary --dpi 144
if [ $( xrandr | grep '^DP1' | awk '{print $2}' ) == "connected" ]; then 
	output=$( xrandr | grep '^DP1' | awk '{print $1}' )
	xrandr --output $output --auto --right-of eDP1
fi
if [ $( xrandr | grep '^DP2' | awk '{print $2}' ) == "connected" ]; then 
	output=$( xrandr | grep '^DP2' | awk '{print $1}' )
	xrandr --output $output --auto --left-of eDP1
fi
if [ $( xrandr | grep '^DP3' | awk '{print $2}' ) == "connected" ]; then 
	output=$( xrandr | grep '^DP3' | awk '{print $1}' )
	xrandr --output $output --auto --left-of eDP1
fi

