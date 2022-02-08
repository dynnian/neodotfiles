#!/bin/sh
#     _____          ___           ___     
#    /  /::\        /  /\         /__/|    
#   /  /:/\:\      /  /::\       |  |:|     ***This script was made by Clay Gomera (Drake)***
#  /  /:/  \:\    /  /:/\:\      |  |:|      - Description: A simple power menu dmenu script
# /__/:/ \__\:|  /  /:/~/:/    __|  |:|      - Dependencies: dmenu (Everything else can be changed)
# \  \:\ /  /:/ /__/:/ /:/___ /__/\_|:|____
#  \  \:\  /:/  \  \:\/:::::/ \  \:\/:::::/
#   \  \:\/:/    \  \::/~~~~   \  \::/~~~~ 
#    \  \::/      \  \:\        \  \:\     
#     \__\/        \  \:\        \  \:\    
#                   \__\/         \__\/    

option1=" Logout"
option2=" Reboot"
option3=" Power off"
option4="💤 Suspend"
option5="🔒lock"
option6="❌Cancel"
session=loginctl list | awk '$1 ~ "c" { print $1 }'

options="$option1\n$option2\n$option3\n$option4\n$option5\n$option6"

action=$(echo "$options" | dmenu -b -i -p " ")

case "$action" in
    $option1)
        loginctl kill-session "$session";;
    $option2)
        loginctl reboot;;
    $option3)
        loginctl poweroff;;
    $option4)
        loginctl suspend && betterlockscreen -l;;
    $option5)
        betterlockscreen -l;;
    $option6)
        exit 0
esac
