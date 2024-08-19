#!/usr/bin/env bash

# Home folders
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"

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
export GOPATH="$HOME/.go"

# Default apps
export TERMINAL="foot"
export EDITOR="$HOME/.local/bin/lvim"
export VISUAL="neovide --neovim-bin $EDITOR"
export BROWSER="brave"
export VIEWER="zathura"

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
if [ -d "$GOPATH/bin" ]; then
    PATH="$GOPATH/bin:$PATH"
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
if [ -d "$XDG_DATA_HOME/JetBrains/Toolbox/scripts" ]; then
    PATH="$XDG_DATA_HOME/JetBrains/Toolbox/scripts:$PATH"
fi
if [ -d "$HOME/.config/vifm/scripts" ]; then
    PATH="$HOME/.config/vifm/scripts:$PATH"
fi

# export SSH_AUTH_SOCK
if [[ -z "${SSH_CONNECTION}" ]]; then
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi

# Create config directories if they don't exist
if [ ! -d "$WGETDIR" ] || [ ! -d "$GNUPGHOME" ]; then
    mkdir -p "$WGETDIR" "$GNUPGHOME"
fi

# Bashrc
source "$BASHRC"

# Starting wayland session
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    sh "$HOME/.config/sway/winitrc" &>/dev/null
    logout
fi
