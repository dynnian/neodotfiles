# .bash_profile

# Home XDG folders
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_LIB_HOME="$HOME/.local/lib"
export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_SOURCE_HOME="$HOME/.local/src"

# Sanely export XDG Base dir variables
eval "$(sed 's/^[^#].*/export &/g;t;d' ~/.config/user-dirs.dirs)"

# Clean home
export W3M_DIR="$XDG_DATA_HOME/w3m"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export WGETDIR="$XDG_CONFIG_HOME/wget"
export WGETRC="$WGETDIR/wgetrc"
export GNUPGHOME="$HOME/.local/share/gnupg"
export LESSHISTFILE="-"
export BASHRC="$HOME/.bashrc"

# Text editor
export EDITOR="nvim"
export VISUAL="foot -T nvim -a io.neovim.nvim nvim"

# Programming languages specific environment variables
## Go
export GOPATH="$XDG_DATA_HOME/go"

## Rust
export CARGO_HOME="$XDG_DATA_HOME/cargo"

# Set path
## local bin paths
if [ -d "$XDG_BIN_HOME" ]; then
    PATH="$XDG_BIN_HOME:$PATH"
fi

## rust tools and programs
if [ -d "$CARGO_HOME/bin" ]; then
    PATH="$CARGO_HOME/bin:$PATH"
fi

## golang tools and programs
if [ -d "$GOPATH/bin" ]; then
    PATH="$GOPATH/bin:$PATH"
fi

## dotnet tools
if [ -d "$HOME/.dotnet/tools" ]; then
    PATH="$HOME/.dotnet/tools:$PATH"
fi

## jetbrains toolbox
if [ -d "$XDG_DATA_HOME/JetBrains/Toolbox/scripts" ]; then
    PATH="$XDG_DATA_HOME/JetBrains/Toolbox/scripts:$PATH"
fi

# Create config directories if they don't exist
if [ ! -d "$WGETDIR" ] || [ ! -d "$GNUPGHOME" ]; then
    mkdir -p "$WGETDIR" "$GNUPGHOME"
fi

# Bashrc
source "$BASHRC"

# Starting wayland session
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    Hyprland &>/dev/null
    logout
fi
