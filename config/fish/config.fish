##       ____             __
##      / __ \_________ _/ /_____
##     / / / / ___/ __ `/ //_/ _ \
##    / /_/ / /  / /_/ / ,< /  __/  Clay Gomera (Drake)
##   /_____/_/   \__,_/_/|_|\___/   My custom fish config
##

### ADDING TO THE PATH
# First line removes the path; second line sets it.  Without the first line,
# your path gets massive and fish becomes very slow.
set -e fish_user_paths
set -U fish_user_paths $HOME/.bin  $HOME/.local/bin $HOME/.go/bin $HOME/.cargo/bin $HOME/.local/lib/flutter/bin $HOME/.local/lib/android/emulator $HOME/.local/share/JetBrains/Toolbox/scripts /var/lib/flatpak/exports/bin/ $fish_user_paths

### EXPORT ###
set fish_greeting                                 # Supresses fish's intro message
set TERM "xterm-256color"                         # Sets the terminal type

### SET BAT AS MANPAGER
set -x MANPAGER "sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

### SET EITHER DEFAULT EMACS MODE OR VI MODE ###
function fish_user_key_bindings
  # fish_default_key_bindings
  fish_vi_key_bindings
end
### END OF VI MODE ###

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
set fish_color_normal brcyan
set fish_color_autosuggestion '#504945'
set fish_color_command brcyan
set fish_color_error '#fb4934'
set fish_color_param brcyan

### FUNCTIONS ###
# Functions needed for !! and !$
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

# The bindings for !! and !$
if [ "$fish_key_bindings" = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# unlock ssh keys
function unlock
    ssh-add "$HOME/.ssh/$argv[1]"
end

### END OF FUNCTIONS ###

### ALIASES ###
# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# use lunarvim or neovim for vim if present.
if test -x "$HOME/.local/bin/lvim"
    alias vim "$HOME/.local/bin/lvim"
else if test -x (command -v nvim)
    alias vim "nvim"
end

# bat as cat
if test -x (command -v bat)
    alias cat "bat"
end

# Changing "ls" to "eza"
alias ls='eza -al --color=always --group-directories-first' # my preferred listing
alias la='eza -a --color=always --group-directories-first'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first'  # long format
alias lt='eza -aT --color=always --group-directories-first' # tree listing
alias l.='eza -a | egrep "^\."'

# package management
alias pku="paru -Syu"
alias pki="paru -S"
alias pkr="paru -Rcns"
alias pks="paru -Ss"
alias pkc="sudo pacman -Scc && sudo pacman -Rns (pacman -Qtdq)"

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# file management
alias fm="yazi"
alias flm="yazi"
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -vI'
alias mkd='mkdir -pv'
alias mkdir='mkdir -pv'
alias du='dust'

# audio
alias mx='pulsemixer'
alias amx='alsamixer'
alias mk='cmus'
alias ms='cmus'
alias music='cmus'

# multimedia scripts
alias fli='flix-cli'
alias ani='ani-cli'
alias aniq='ani-cli -q'

# adding flags
alias df='df -h'
alias free='free -m'

# ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# git
alias git-adu='git add -u'
alias git-adl='git add .'
alias git-brn='git branch'
alias git-chk='git checkout'
alias git-cln='git clone'
alias git-cmt='git commit -m'
alias git-fth='git fetch'
alias git-pll='git pull origin'
alias git-psh='git push origin'
alias git-sts='git status'
alias git-tag='git tag'
alias git-ntg='git tag -a'

# power management
alias po='systemctl poweroff'
alias sp='systemctl suspend'
alias rb='systemctl reboot'

# youtube-
alias yta-aac="yt-dlp --extract-audio --audio-format aac "
alias yta-best="yt-dlp --extract-audio --audio-format best "
alias yta-flac="yt-dlp --extract-audio --audio-format flac "
alias yta-m4a="yt-dlp --extract-audio --audio-format m4a "
alias yta-mp3="yt-dlp --extract-audio --audio-format mp3 "
alias yta-opus="yt-dlp --extract-audio --audio-format opus "
alias yta-vorbis="yt-dlp --extract-audio --audio-format vorbis "
alias yta-wav="yt-dlp --extract-audio --audio-format wav "
alias ytv-best="yt-dlp -f bestvideo+bestaudio "
alias yt='ytfzf -ftslT chafa'
alias youtube='ytfzf -ftslT chafa'
alias ytm='ytfzf -mtslT chafa'
alias youtube-music='ytfzf -mtslT chafa'

# network and bluetooth
alias netstats='nmcli dev'
alias wfi='nmtui-connect'
alias wfi-scan='nmcli dev wifi rescan && nmcli dev wifi list'
alias wfi-edit='nmtui-edit'
alias wfi-on='nmcli radio wifi on'
alias wfi-off='nmcli radio wifi off'
alias blt='bluetoothctl'

### SETTING THE STARSHIP PROMPT ###
starship init fish | source
zoxide init fish | source
