#!/usr/bin/env bash

# Home folders
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_LIB_HOME="$HOME/.local/lib"
export XDG_BIN_HOME="$HOME/.local/bin"

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
export EDITOR="$HOME/.local/bin/lvim"

# Programming languages specific
## Go
export GOPATH="$XDG_DATA_HOME/go"
## Rust
export CARGO_HOME="$XDG_DATA_HOME/cargo"
## Flutter
export CHROME_EXECUTABLE="/var/lib/flatpak/app/com.brave.Browser/x86_64/stable/active/export/bin/com.brave.Browser"
export PUB_CACHE="$XDG_DATA_HOME/pub-cache"
export FLUTTER_ROOT="$XDG_LIB_HOME/flutter"
export FLUTTER_ANALYTICS_DISABLED=true
export ANALYZER_STATE_LOCATION_OVERRIDE="$XDG_CACHE_HOME/dartServer"
## Android SDK/Emulator
export ANDROID_HOME="$XDG_LIB_HOME/android"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export ANDROID_USER_HOME="$XDG_DATA_HOME/android"
export ANDROID_EMULATOR_HOME="$ANDROID_USER_HOME"
export ANDROID_AVD_HOME="$ANDROID_USER_HOME/avd"
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"

# Set path
if [ -d "$HOME/.bin" ]; then
    PATH="$HOME/.bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$CARGO_HOME/bin" ]; then
    PATH="$CARGO_HOME/bin:$PATH"
fi
if [ -d "$GOPATH/bin" ]; then
    PATH="$GOPATH/bin:$PATH"
fi
if [ -d "$FLUTTER_ROOT/bin" ]; then
    PATH="$FLUTTER_ROOT/bin:$PATH"
fi
if [ -d "$ANDROID_HOME/emulator" ]; then
    PATH="$ANDROID_HOME/emulator:$PATH"
fi
if [ -d "$ANDROID_HOME/cmdline-tools/latest/bin" ]; then
    PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
fi
if [ -d "$ANDROID_HOME/tools" ]; then
    PATH="$ANDROID_HOME/tools:$PATH"
fi
if [ -d "$ANDROID_HOME/tools/bin" ]; then
    PATH="$ANDROID_HOME/tools/bin:$PATH"
fi
if [ -d $DOTNET_CLI_HOME/tools ]; then
    PATH="$DOTNET_CLI_HOME/tools:$PATH"
fi
if [ -d "$HOME/Applications" ]; then
    PATH="$HOME/Applications:$PATH"
fi
if [ -d "$XDG_DATA_HOME/JetBrains/Toolbox/scripts" ]; then
    PATH="$XDG_DATA_HOME/JetBrains/Toolbox/scripts:$PATH"
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
    sh "$HOME/.config/sway/scripts/init" &>/dev/null
    logout
fi
