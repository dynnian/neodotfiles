#!/bin/sh
#     _____          ___           ___     
#    /  /::\        /  /\         /__/|    
#   /  /:/\:\      /  /::\       |  |:|     ***This script was made by Clay Gomera (Drake)***
#  /  /:/  \:\    /  /:/\:\      |  |:|      - Description: A simple wifi-menu dmenu script
# /__/:/ \__\:|  /  /:/~/:/    __|  |:|      - Dependencies: dmenu, notify-send, NetworkManager, ping
# \  \:\ /  /:/ /__/:/ /:/___ /__/\_|:|____
#  \  \:\  /:/  \  \:\/:::::/ \  \:\/:::::/
#   \  \:\/:/    \  \::/~~~~   \  \::/~~~~ 
#    \  \::/      \  \:\        \  \:\     
#     \__\/        \  \:\        \  \:\    
#                   \__\/         \__\/    

# Dmenu variables
DMENU1="dmenu -l 10 -b -i -p"
DMENU2="dmenu -b -i -p"

# Scanning Networks and notification
notify-send "Scanning Networks"
nmcli -t d wifi rescan
scan=$(nmcli --fields SSID,SECURITY,BARS device wifi list | sed '/^--/d' | sed 1d | sed -E "s/WPA*.?\S/~~/g" | sed "s/~~ ~~/~~/g;s/802\.1X//g;s/--/~~/g;s/  *~/~/g;s/~  */~/g;s/_/ /g" | column -t -s '~')

# Selecting Network
selectnet() {
  bssid=$(echo "$scan" | uniq -u | $DMENU1 "Select Wifi  :" | cut -d' ' -f1)
  if [ "$bssid" ]; then
  query=$bssid
  else
    exit 0
  fi
}
selectnet

# Typing password
selectpass() {
  pass=$($DMENU2 "Enter Password  :")
  if [ "$pass" ]; then
  passqry=$pass
  else
    exit 0
  fi
}
selectpass

# Main connection command
nmcli device wifi connect "$query" password "$passqry" || nmcli device wifi connect "$query"

# Check notification
  notify-send "Checking if the connection was successful"

# Check process
  sleep 10
  if ping -q -c 2 -W 2 google.com >/dev/null; then
    notify-send "Your internet is working :)"
  else
    notify-send "Your internet is not working :("
  fi
