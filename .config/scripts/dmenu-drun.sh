#!/bin/sh
#     _____          ___           ___     
#    /  /::\        /  /\         /__/|    
#   /  /:/\:\      /  /::\       |  |:|     ***This script was made by Clay Gomera (Drake)***
#  /  /:/  \:\    /  /:/\:\      |  |:|      - Description: A simple desktop dmenu script
# /__/:/ \__\:|  /  /:/~/:/    __|  |:|      - Dependencies: dmenu, j4-dmenu-desktop
# \  \:\ /  /:/ /__/:/ /:/___ /__/\_|:|____
#  \  \:\  /:/  \  \:\/:::::/ \  \:\/:::::/
#   \  \:\/:/    \  \::/~~~~   \  \::/~~~~ 
#    \  \::/      \  \:\        \  \:\     
#     \__\/        \  \:\        \  \:\    
#                   \__\/         \__\/    

DMENU="dmenu -l 10 -b -i -p Launch:"
j4-dmenu-desktop --dmenu "$DMENU" --no-generic
