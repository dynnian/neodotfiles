#!/usr/bin/env bash

# Home folders
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"

# X11
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"

# Sanely export XDG Base dir variables
eval "$(sed 's/^[^#].*/export &/g;t;d' ~/.config/user-dirs.dirs)"

# Clean home
export W3M_DIR="$XDG_DATA_HOME/w3m"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export WGETDIR="$XDG_CONFIG_HOME/wget"
export WGETRC="$WGETDIR/wgetrc"
export INPUTRC="$HOME/.config/X11/inputrc"
export GNUPGHOME="$HOME/.local/share/gnupg"
export LESSHISTFILE="-"
export BASHRC="$HOME/.bashrc"

# Default apps
export TERMINAL="st"
export EDITOR="$HOME/.local/bin/lvim"
export VISUAL="st -e $EDITOR"
export BROWSER="flatpak run com.brave.Browser"
export VIEWER="zathura"

# Bashrc
source "$BASHRC"

# Create config directories if they don't exist
if [ ! -d "$WGETDIR" ] || [ ! -d "$GNUPGHOME" ]; then
    mkdir -p "$WGETDIR" "$GNUPGHOME"
fi

if [ ! -f "$WGETRC" ]; then
    touch "$WGETRC"
fi

# Starting xsession
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    startx "$XINITRC" -- vt1 -keeptty &>> /dev/null
    logout
fi

