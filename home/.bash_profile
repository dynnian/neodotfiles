# .bash_profile

# Home XDG folders
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
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
export TERMINAL="foot"
export EDITOR="lvim"
export VISUAL="foot -T lunarvim -a lunarvim lvim"
export BROWSER="flatpak run app.zen_browser.zen"
export VIEWER="zathura"

# Programming languages specific environment variables
## Go
export GOPATH="$XDG_DATA_HOME/go"

## Rust
export CARGO_HOME="$XDG_DATA_HOME/cargo"

## Dotnet
export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGet"

# Set path
## local bin paths
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

## rust tools and programs
if [ -d "$CARGO_HOME/bin" ]; then
    PATH="$CARGO_HOME/bin:$PATH"
fi

## golang tools and programs
if [ -d "$GOPATH/bin" ]; then
    PATH="$GOPATH/bin:$PATH"
fi

## dotnet sdk tools
if [ -d "$HOME/.dotnet/tools" ]; then
    PATH="$HOME/.dotnet/tools:$PATH"
fi

## jetbrains toolbox
if [ -d "$XDG_DATA_HOME/JetBrains/Toolbox/scripts" ]; then
    PATH="$XDG_DATA_HOME/JetBrains/Toolbox/scripts:$PATH"
fi

## sway scripts
if [ -d "$XDG_CONFIG_HOME/sway/scripts" ]; then
    PATH="$XDG_CONFIG_HOME/sway/scripts:$PATH"
fi

# Create config directories if they don't exist (stuff crashes if they don't)
if [ ! -d "$WGETDIR" ] || [ ! -d "$GNUPGHOME" ]; then
    mkdir -p "$WGETDIR" "$GNUPGHOME"
fi

# Bashrc
source "$BASHRC"

# Starting wayland session
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    startsway &>/dev/null
    logout
fi
