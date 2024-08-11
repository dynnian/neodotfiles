local awful = require("awful")
-- session manager
awful.util.spawn_with_shell("pidof polkit-gnome-authentication-agent-1 || /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &")
-- automatically hide the cursor
awful.util.spawn_with_shell("pidof unclutter || unclutter --hide-on-touch &")
-- compositor
awful.util.spawn_with_shell("pidof picom || picom --config $HOME/.config/awesome/misc/picom/picom.conf &")
-- autolock
awful.util.spawn_with_shell("pidof xss-lock || xss-lock $HOME/.config/awesome/misc/scripts/lock.sh &")
-- set theeming
awful.util.spawn_with_shell("gsettings set org.gnome.desktop.interface cursor-theme 'Simp1e-Gruvbox-Dark' &")
awful.util.spawn_with_shell("gsettings set org.gnome.desktop.interface cursor-size 16 &")
awful.util.spawn_with_shell("gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark' &")
awful.util.spawn_with_shell("gsettings set org.gnome.desktop.interface gtk-theme 'Gruvbox-Dark' &")
awful.util.spawn_with_shell("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' &")
awful.util.spawn_with_shell("gsettings set org.gnome.desktop.interface font-name 'Inter 10' &")
awful.util.spawn_with_shell("gsettings set org.gnome.desktop.interface document-font-name 'Liberation Sans 10' &")
awful.util.spawn_with_shell("gsettings set org.gnome.desktop.interface monospace-font-name 'Mononoki Nerd Font 10' &")
awful.util.spawn_with_shell("gsettings set org.gnome.desktop.interface font-antialiasing 'rgba' &")
awful.util.spawn_with_shell("gsettings set org.gnome.desktop.interface font-hinting 'full' &")
-- set monitor configuration
awful.util.spawn_with_shell("$HOME/.config/awesome/misc/scripts/monitors.sh &")
-- set wallpaper
awful.util.spawn_with_shell("sleep 1 && $HOME/.fehbg &")
