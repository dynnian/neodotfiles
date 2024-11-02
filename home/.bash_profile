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
export TERMINAL="foot"
export EDITOR="$HOME/.local/bin/lvim"
export VISUAL="foot -T lunarvim -a lunarvim lvim"
export BROWSER="flatpak run org.mozilla.firefox"
export VIEWER="zathura"

# Programming languages specific environment variables
## Go
export GOPATH="$XDG_DATA_HOME/go"

## Rust
export CARGO_HOME="$XDG_DATA_HOME/cargo"

## Flutter
export CHROME_EXECUTABLE="/var/lib/flatpak/app/io.github.ungoogled_software.ungoogled_chromium/x86_64/stable/active/export/bin/io.github.ungoogled_software.ungoogled_chromium"
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
export JAVA_HOME="/usr/lib/jvm/openjdk21"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"

## Dotnet
export DOTNET_CLI_HOME="$XDG_LIB_HOME/dotnet"
export DOTNET_ROOT="$DOTNET_CLI_HOME"
export DOTNET_CLI_TELEMETRY_OPTOUT=true
export DOTENT_SKIP_FIRST_TIME_EXPERIENCE=true

# Set path
## local bin paths
if [ -d "$HOME/.bin" ]; then
    PATH="$HOME/.bin:$PATH"
fi
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

## flutter sdk
if [ -d "$FLUTTER_ROOT/bin" ]; then
    PATH="$FLUTTER_ROOT/bin:$PATH"
fi

## android sdk
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

## dotnet cli
if [ -d $DOTNET_CLI_HOME ]; then
    PATH="$DOTNET_CLI_HOME:$PATH"
fi

## dotnet sdk tools
if [ -d $DOTNET_CLI_HOME/.dotnet/tools ]; then
    PATH="$DOTNET_CLI_HOME/.dotnet/tools:$PATH"
fi

## AppImage applications
if [ -d "$HOME/Applications" ]; then
    PATH="$HOME/Applications:$PATH"
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

# Starting xsession
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    startx "$XINITRC" -- vt1 -keeptty &>> /dev/null
    logout
fi
