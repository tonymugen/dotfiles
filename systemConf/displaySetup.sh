#!/bin/sh
# check if the NVIDIA GPU is active and tell xorg to use it for the dsiplay
# this script goes into /etc/lightdm
if system76-power graphics | grep -q 'nvidia'; then
	xrandr --setprovideroutputsource modesetting NVIDIA-0
	xrandr --auto
	if [ $( xrandr | grep HDMI | cut -d ' ' -f2 ) == "connected" ]; then 
		xrandr --output HDMI-0 --auto --left-of eDP-1-1
	fi
fi

