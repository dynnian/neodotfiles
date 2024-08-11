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
export TERMINAL="kitty"
export EDITOR="$HOME/.local/bin/lvim"
export VISUAL="kitty --class neovim -- $EDITOR"
export BROWSER="brave"
export VIEWER="zathura"

# Dev Tools Envs
export GOPATH="$HOME/.go"

# Set path
if [ -d "$HOME/.bin" ]; then
    PATH="$HOME/.bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/.cargo/bin" ]; then
    PATH="$HOME/.cargo/bin:$PATH"
fi
if [ -d "$HOME/.go/bin" ]; then
    PATH="$HOME/.go/bin:$PATH"
fi
if [ -d "$HOME/.local/lib/flutter/bin" ]; then
    PATH="$HOME/.local/lib/flutter/bin:$PATH"
fi
if [ -d $HOME/.dotnet/tools ]; then
    PATH="$HOME/.dotnet/tools:$PATH"
fi
if [ -d "$HOME/Applications" ]; then
    PATH="$HOME/Applications:$PATH"
fi
if [ -d $XDG_DATA_HOME/JetBrains/Toolbox/scripts ]; then
    PATH="$XDG_DATA_HOME/JetBrains/Toolbox/scripts:$PATH"
fi
if [ -d $HOME/.config/vifm/scripts ]; then
    PATH="$HOME/.config/vifm/scripts:$PATH"
fi

# Bashrc
source "$BASHRC"

# Create config directories if they don't exist
if [ ! -d "$WGETDIR" ] || [ ! -d "$GNUPGHOME" ]; then
    mkdir -p "$WGETDIR" "$GNUPGHOME"
fi
if [ ! -f "$WGETRC" ]; then
    touch "$WGETRC"
fi

# bind sshagent
if [[ -z "${SSH_CONNECTION}" ]]; then
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi

# Starting xsession
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    startx "$XINITRC" -- vt1 -keeptty &>> /dev/null
    logout
fi
