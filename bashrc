##   ____  ____  _  __
##  |  _ \|  _ \| |/ /
##  | | | | |_) | ' /  Clay Gomera (Drake)
##  | |_| |  _ <| . \  This is my custom bassh config for my laptop
##  |____/|_| \_\_|\_\
##

### EXPORT
export TERM="xterm-256color"                      # getting proper colors
export HISTCONTROL=ignoredups:erasedups           # no duplicate entries
export ALTERNATE_EDITOR=""                        # setting for emacsclient
export EDITOR="emacsclient -t -a ''"              # $EDITOR use Emacs in terminal
export VISUAL="emacsclient -c -a emacs"           # $VISUAL use Emacs in GUI mode

### SET MANPAGER
### "bat" as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### SET VI MODE ###
# Comment this line out to enable default emacs-like bindings
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

### PATH
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/Applications" ] ;
  then PATH="$HOME/Applications:$PATH"
fi

### CHANGE TITLE OF TERMINALS
case ${TERM} in
  xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|alacritty|st|konsole*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
        ;;
  screen*)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
    ;;
esac

### SHOPT
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize # checks term size when bash regains control

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

### ALIASES
# navigation
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# bat as cat
alias cat='bat'

# vim and DOOM emacs
alias vim='nvim'
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

# pacman and yay
alias pac-up='sudo pacman -Syyu'                      # update the whole system
alias pac-get='sudo pacman -S --needed'               # install a program
alias pac-qry-sync='sudo pacman -Ss'                  # query details about a program
alias pac-qry='sudo pacman -Q'                        # query details about a program
alias pac-rmv='sudo pacman -Rcns'                     # remove a package with all its dependencies (it may brake something)
alias pac-rmv-sec='sudo pacman -Runs'                 # remove a package with all its dependencies (secure way)
alias pac-cln='sudo pacman -Rns (pacman -Qtdq)'       # remove unnecesary packages
alias pac-unlock='sudo rm /var/lib/pacman/db.lck'     # remove pacman lock
alias yay-up='yay -Sua --noconfirm'                   # update only AUR pkgs (yay)
alias yay-get='yay -S'                                # install a program for the AUR

# get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

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
alias po='poweroff'
alias sp='systemctl suspend'
alias rb='reboot'

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
alias games='cd /run/media/Storage/multimedia/games/linux && ls'
alias anime='cd /run/media/Storage/multimedia/anime/ && ls'
alias manga='cd /run/media/Storage/multimedia/manga/ && ls'
alias videos='cd /run/media/Storage/multimedia/videos/ && ls'

# the terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

### SETTING THE STARSHIP PROMPT ###
eval "$(starship init bash)"
