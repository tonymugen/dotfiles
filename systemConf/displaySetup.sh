#!/bin/sh
# check if the NVIDIA GPU is active and tell xorg to use it for the dsiplay
# this script goes into /etc/lightdm
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --output $( xrandr | grep eDP | awk '{print $1}' ) --auto --primary --dpi 144
if [ $( xrandr | grep HDMI | awk 'print $2}' ) == "connected" ]; then 
	output=$( xrandr | grep HDMI | awk '{print $1}' )
	xrandr --output $output --auto --left-of eDP-1-1
fi

