#!/usr/bin/bash
status=$2

case $status in
	 up|vpn-up)
		/usr/bin/chronyc online ;;
	down|vpn-down)
		/usr/bin/chronyc offline ;;
	*)
		/usr/bin/chronyc offline ;;
esac

