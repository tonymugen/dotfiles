#!/usr/bin/bash

case $2 in
	 up|vpn-up)
		/usr/bin/chronyc online > /dev/null 2>&1
		;;
	down|vpn-down)
		/usr/bin/chronyc offline > /dev/null 2>&1
		;;
	connectivity-change)
		if [[ $CONNECTIVITY_STATE = "FULL" ]]; then
			/usr/bin/chronyc online > /dev/null 2>&1
		else
			/usr/bin/chronyc offline > /dev/null 2>&1
		fi
		;;
	*)
		/usr/bin/chronyc offline > /dev/null 2>&1
		;;
esac

