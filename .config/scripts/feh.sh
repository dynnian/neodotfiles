#!/bin/sh
# This is my script to set my wallpaper with feh

# Wallpapers directory and chosen wallpaper here
walldir="$HOME/Pictures/Wallpapers/"
wallpaper="gruvbox_solaris.png"
# Main command
feh --bg-fill "$walldir/$wallpaper"
