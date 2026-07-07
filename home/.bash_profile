# .bash_profile

# Home XDG folders
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_LIB_HOME="$HOME/.local/lib"
export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_SOURCE_HOME="$HOME/.local/src"

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
export EDITOR="nvim"
export VISUAL="st -n nvim -c nvim -e nvim"
export VIEWER="zathura"
export VIDEO="mpv"
export BROWSER="librewolf"

# Configure Golang
if command -v go >/dev/null 2>&1; then
  export GOPATH="${GOPATH:-$XDG_DATA_HOME/go}"
  mkdir -p "$GOPATH"

  case ":$PATH:" in
    *":$GOPATH/bin:"*) ;;
    *) PATH="$GOPATH/bin:$PATH" ;;
  esac

  export PATH
fi

# Configure .NET
if command -v dotnet >/dev/null 2>&1; then
  mkdir -p "$HOME/.dotnet/tools"
  export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGet"

  case ":$PATH:" in
    *":$HOME/.dotnet/tools:"*) ;;
    *) PATH="$HOME/.dotnet/tools:$PATH" ;;
  esac

  export PATH
fi

# Configure Rust & Cargo
if command -v cargo >/dev/null 2>&1; then
  export CARGO_HOME="${CARGO_HOME:-$XDG_DATA_HOME/cargo}"
  mkdir -p "$CARGO_HOME/bin"

  case ":$PATH:" in
    *":$CARGO_HOME/bin:"*) ;;
    *) PATH="$CARGO_HOME/bin:$PATH" ;;
  esac

  export PATH
fi

# Set path
## local bin paths
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Create config directories if they don't exist
if [ ! -d "$WGETDIR" ] || [ ! -d "$GNUPGHOME" ]; then
    mkdir -p "$WGETDIR" "$GNUPGHOME"
fi

# Bashrc
source "$BASHRC"

# Starting xsession
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    # Define and ensure the log directory exists
    export X11LOGDIR="$XDG_DATA_HOME/logs/x11"
    mkdir -p "$X11LOGDIR"

    # Save a backup of the previous session log if it exists
    [ -f "$X11LOGDIR/dwm.log" ] && mv "$X11LOGDIR/dwm.log" "$X11LOGDIR/dwm.log.old"

    echo "=== Session started on $(date) ===" > "$X11LOGDIR/dwm.log"

    # Route both stdout and stderr to the log file
    startx "$XINITRC" -- vt1 -keeptty >> "$X11LOGDIR/dwm.log" 2>&1

    logout
fi

# Added by Antigravity CLI installer
export PATH="/home/drk/.local/bin:$PATH"
