##     ____  ____  _  __
##    |  _ \|  _ \| |/ /
##    | | | | |_) | ' /  Clay Gomera (Drake)
##    | |_| |  _ <| . \  This is my custom fish config for my laptop
##    |____/|_| \_\_|\_\
##

if status is-interactive
    # Commands to run in interactive sessions can go here
end

### EXPORT
set -U fish_greeting ""
set EDITOR "emacsclient -t -a ''"                 # $EDITOR use Emacs in terminal
set VISUAL "emacsclient -c -a emacs"              # $VISUAL use Emacs in GUI mode

### ADDING TO THE PATH
# First line removes the path; second line sets it.  Without the first line,
# your path gets massive and fish becomes very slow.
set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/Applications $fish_user_paths

# Vi mode
function fish_user_key_bindings
  # fish_default_key_bindings
  fish_vi_key_bindings
end

### "bat" as manpager
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

### ALIASES
# navigation
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# text editors
alias vim='nvim'

# bat as cat
alias cat='bat'

# DOOM emacs
alias doom-sync="~/.emacs.d/bin/doom sync"
alias doom-doctor="~/.emacs.d/bin/doom doctor"
alias doom-upgrade="~/.emacs.d/bin/doom upgrade"
alias doom-purge="~/.emacs.d/bin/doom purge"
alias em='/usr/bin/emacs -nw'
alias emacs="emacsclient -c -a 'emacs'"

# Changing "ls" to "exa"
alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -a | egrep "^\."'

# xbps
alias xb-up='sudo xbps-install -Su'         # update the whole system
alias xb-get='sudo xbps-install -S'            # install a program
alias xb-qry='sudo xbps-query'              # query details about a program
alias xb-rmv='sudo xbps-remove -R'             # remove a package with all its dependencies (it may brake something)
alias xb-cln='sudo xbps-remove -o'          # remove unnecesary packages
alias xb-cln-cache='sudo xbps-remove -O'    # clean the package cache

# xbps-src
alias xbsrc='~/.void-packages/./xbps-src pkg'
alias xbins='cd ~/.void-packages/ && xi'

# confirm before overwriting something
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# git
alias gt-cl='git clone'

# ani-cli
alias ani='ani-cli'
alias ani-q='ani-cli -q'    # to select video quality

# ytfzf
alias yt='ytfzf -f'

# mount and unmount drives
alias mnt='sudo mount'
alias umnt='sudo umount'

# mixers
alias mx='pulsemixer'
alias amx='alsamixer'

# music player
alias mk='musikcube'

# battery (just for laptops)
alias bt='acpi'

# power management
alias po='loginctl poweroff'
alias sp='loginctl suspend'
alias rb='loginctl reboot'

# file manager
alias fm='./.config/vifm/scripts/vifmrun'

# system monitor
alias tp='htop'
alias top='htop'

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# youtube-dl
alias yta-aac="youtube-dl --extract-audio --audio-format aac "
alias yta-best="youtube-dl --extract-audio --audio-format best "
alias yta-flac="youtube-dl --extract-audio --audio-format flac "
alias yta-m4a="youtube-dl --extract-audio --audio-format m4a "
alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 "
alias yta-opus="youtube-dl --extract-audio --audio-format opus "
alias yta-vorbis="youtube-dl --extract-audio --audio-format vorbis "
alias yta-wav="youtube-dl --extract-audio --audio-format wav "
alias ytv-best="youtube-dl -f bestvideo+bestaudio "

# Network Manager and bluetooth
alias netstats='nmcli dev'
alias wfi='nmtui-connect'
alias wfi-scan='nmcli dev wifi list'
alias wfi-edit='nmtui-edit'
alias blt='bluetoothctl'

# cd to diferent directories
alias games='cd /media/Storage/multimedia/games/linux && ls'
alias anime='cd /media/Storage/multimedia/anime/ && ls'
alias manga='cd /media/Storage/multimedia/manga/ && ls'
alias videos='cd /media/Storage/multimedia/videos/ && ls'

# the terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

### SETTING THE STARSHIP PROMPT ###
starship init fish | source
