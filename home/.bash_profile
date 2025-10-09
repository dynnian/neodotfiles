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
export BROWSER="qutebrowser"
export VIEWER="zathura"

# Programming languages specific environment variables
# Set default text editor to either neovim or vim
if command -v nvim >/dev/null 2>&1; then
  export EDITOR="nvim"
elif command -v vim >/dev/null 2>&1; then
  export EDITOR="vim"
fi

# Set visual editor to zed if installed
if command -v zed >/dev/null 2>&1; then
  export VISUAL="zed"
fi

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

# Bitwarden SSH Agent
export SSH_AUTH_SOCK="$HOME/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock"

# Starting wayland session
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    startsway &>/dev/null
    logout
fi
