#!/usr/bin/env bash

# grab monitor status (varies with the machine)
### T480 monitors
monitor1=$(cat /sys/class/drm/card1-DP-1/status)
monitor2=$(cat /sys/class/drm/card1-HDMI-A-2/status)
sleep 2

# if monitors are connected, then use xrandr to set desired settings
if [ "$monitor1" = "connected" ] && [ "$monitor2" = "connected" ]; then
    xrandr --output eDP1 --mode 1920x1080 --pos 3200x0 --rotate normal \
           --output HDMI2 --primary --mode 1920x1080 --rate 100.00 --pos 1280x0 --rotate normal \
           --output DP1 --mode 1280x1024 --rate 75.00 --pos 0x0 --rotate normal
elif [ "$monitor1" = "connected" ]; then
    xrandr --output eDP1 --primary --auto \
           --output HDMI2 --auto --scale-from 1920x1080 --same-as eDP1
elif [ "$monitor2" = "connected" ]; then
    xrandr --output eDP1 --primary --auto \
           --output DP1 --auto --scale-from 1920x1080 --same-as eDP1
else
    xrandr --output eDP1 --primary --auto \
           --output DP1 --off \
           --output HDMI2 --off
fi
