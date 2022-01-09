#!/usr/bin/env bash

option1=" lock"
option2=" logout"
option3=" reboot"
option4=" power off"
option5=" suspend"

options="$option1\n$option2\n$option3\n$option4\n$option5"

choice=$(echo -e "$options" | rofi -dmenu -i -no-show-icons -lines 5 -width 20 -p " ")

case $choice in
    $option1)
        betterlockscreen -l ;;
    $option2)
        killall awesome;;
    $option3)
        systemctl reboot ;;
    $option4)
        systemctl poweroff ;;
    $option5)
        systemctl suspend ;;
esac
