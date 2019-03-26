#!/bin/sh
# check if the NVIDIA GPU is active and tell xorg to use it for the dsiplay
# this script goes into /etc/lightdm
if system76-power graphics | grep -q 'nvidia'; then
	xrandr --setprovideroutputsource modesetting NVIDIA-0
	xrandr --output eDP-1-1 --auto --primary --dpi 144
	if [ $( xrandr | grep HDMI | cut -d ' ' -f2 ) == "connected" ]; then 
		OUT=$( xrandr | grep HDMI | cut -d ' ' -f1 )
		xrandr --output $OUT --auto --left-of eDP-1-1
	fi
fi

