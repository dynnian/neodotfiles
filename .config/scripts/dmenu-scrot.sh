#!/bin/sh
#     _____          ___           ___     
#    /  /::\        /  /\         /__/|    
#   /  /:/\:\      /  /::\       |  |:|     ***This script was made by Clay Gomera (Drake)***
#  /  /:/  \:\    /  /:/\:\      |  |:|      - Description: A simple screenshot dmenu script
# /__/:/ \__\:|  /  /:/~/:/    __|  |:|      - Dependencies: scrot, dmenu, notify-send
# \  \:\ /  /:/ /__/:/ /:/___ /__/\_|:|____
#  \  \:\  /:/  \  \:\/:::::/ \  \:\/:::::/
#   \  \:\/:/    \  \::/~~~~   \  \::/~~~~ 
#    \  \::/      \  \:\        \  \:\     
#     \__\/        \  \:\        \  \:\    
#                   \__\/         \__\/    

mkdir -p "$HOME/Pictures/Screenshots"
option1=" Entire screen"
option2=" Entire screen with delay"
option3=" Focused window"
option4=" Select area"

options="$option1\n$option2\n$option3\n$option4"

choice=$(echo "$options" | dmenu -b -i -p " ")

case $choice in
    $option1)
        scrot -e 'mv $f ~/Pictures/Screenshots/' && notify-send -a 'Scrot' 'Screenshot saved.' -i 'dialog-information' -t 2000 ;;
    $option2)
        delayoption1="Take screenshot with 3 sec delay"
        delayoption2="Take screenshot with 5 sec delay"
        delayoption3="Take screenshot with 10 sec delay"
        delayoptions="$delayoption1\n$delayoption2\n$delayoption3"
        delay=$(echo "$delayoptions" | dmenu -b -i -p " ")
        case $delay in
            $delayoption1)
                scrot -d 3 -e 'mv $f ~/Pictures/Screenshots/' && notify-send -a 'Scrot' 'Screenshot saved.' -i 'dialog-information' -t 2000 ;;
            $delayoption2)
                scrot -d 5 -e 'mv $f ~/Pictures/Screenshots/' && notify-send -a 'Scrot' 'Screenshot saved.' -i 'dialog-information' -t 2000 ;;
            $delayoption3)
                scrot -d 10 -e 'mv $f ~/Pictures/Screenshots/' && notify-send -a 'Scrot' 'Screenshot saved.' -i 'dialog-information' -t 2000 ;;
        esac ;;
    $option3)
        scrot -u -b -e 'mv $f ~/Pictures/Screenshots/' && notify-send -a 'Scrot' 'Screenshot saved.' -i 'dialog-information' -t 2000 ;;
    $option4)
        scrot -s -e 'mv $f ~/Pictures/Screenshots/' && notify-send -a 'Scrot' 'Screenshot saved.' -i 'dialog-information' -t 2000 ;;
esac
