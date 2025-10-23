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
export VISUAL="emacsclient -c -a 'emacs'"
export VIEWER="zathura"
export VIDEO="mpv"
export BROWSER="firefox"

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

## jetbrains toolbox
if [ -d "$XDG_DATA_HOME/JetBrains/Toolbox/scripts" ]; then
    PATH="$XDG_DATA_HOME/JetBrains/Toolbox/scripts:$PATH"
fi

# Create config directories if they don't exist
if [ ! -d "$WGETDIR" ] || [ ! -d "$GNUPGHOME" ]; then
    mkdir -p "$WGETDIR" "$GNUPGHOME"
fi

export SSH_AUTH_SOCK="$HOME/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock"

# Bashrc
source "$BASHRC"

# Starting xsession
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    startx "$XINITRC" -- vt1 -keeptty &>> /dev/null
    logout
fi
