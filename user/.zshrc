##       ____             __
##      / __ \_________ _/ /_____
##     / / / / ___/ __ `/ //_/ _ \
##    / /_/ / /  / /_/ / ,< /  __/  Clay Gomera (Drake)
##   /_____/_/   \__,_/_/|_|\___/   My custom zsh config
##

### EXPORT
export TERM="xterm-256color"                      # getting proper colors
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# use neovim for vim if present.
[ -x "$(command -v nvim)" ] && alias vim="nvim" vimdiff="nvim -d"

# use $XINITRC variable if file exists.
[ -f "$XINITRC" ] && alias startx="startx $XINITRC"

### SET VI MODE ###
# Comment this line out to enable default emacs-like bindings
bindkey -v

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

### Function extract for common file formats ###
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace)      unace x ./"$n"      ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

IFS=$SAVEIFS

### ALIASES ###
# navigation
up () {
  local d=""
  local limit="$1"

  # Default to limit of 1
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi

  for ((i=1;i<=limit;i++)); do
    d="../$d"
  done

  # perform cd. Show error if cd fails
  if ! cd "$d"; then
    echo "Couldn't go up $limit dirs.";
  fi
}

# cd
alias \
  ..="cd .." \
  .2="cd ../.." \
  .3="cd ../../.." \
  .4="cd ../../../.." \
  .5="cd ../../../../.."

# bat as cat
[ -x "$(command -v bat)" ] && alias cat="bat"

# DOOM Emacs
[ -x "$(command -v emacs)" ] && alias \
  em="/usr/bin/emacs -nw" \
  emacs="emacsclient -c -a 'emacs'" \
  doomsync="~/.emacs.d/bin/doom sync" \
  doomdoctor="~/.emacs.d/bin/doom doctor" \
  doomupgrade="~/.emacs.d/bin/doom upgrade" \
  doompurge="~/.emacs.d/bin/doom purge"

# Changing "ls" to "exa"
alias \
  ls="exa -al --color=always --group-directories-first" \
  la="exa -a --color=always --group-directories-first" \
  ll="exa -l --color=always --group-directories-first" \
  lt="exa -aT --color=always --group-directories-first" \
  l.='exa -a | egrep "^\."'

# xbps
[ -x "$(command -v xbps-query)" ] && alias \
  xb-up="sudo xbps-install -Su && xcheckrestart" \
  xb-get="sudo xbps-install -S" \
  xb-rmv="sudo xbps-remove -R" \
  xb-rmv-sec="sudo xbps-remove" \
  xb-qry="sudo xbps-query" \
  xb-cln="sudo xbps-remove -o && sudo xbps-remove -O"

# pacman
[ -x "$(command -v pacman)" ] && alias \
  pac-up="sudo pacman -Syyu" \
  pac-get="sudo pacman -S" \
  pac-rmv="sudo pacman -Rcns" \
  pac-rmv-sec="sudo pacman -Runs" \
  pac-qry="sudo pacman -Ss" \
  pac-cln="sudo pacman -Scc"

# colorize grep output (good for log files)
alias \
  grep="grep --color=auto" \
  egrep="egrep --color=auto" \
  fgrep="fgrep --color=auto"

# git
alias \
  addup="git add -u" \
  addall="git add ." \
  branch="git branch" \
  checkout="git checkout" \
  clone="git clone" \
  commit="git commit -m" \
  fetch="git fetch" \
  pull="git pull origin" \
  push="git push origin" \
  stat="git status" \
  tag="git tag" \
  newtag="git tag -a"

# adding flags
alias \
  df="df -h" \
  free="free -m" \
  newsboat="newsboat -u ~/.config/newsboat/urls"

# multimedia scripts
alias \
  fli="flix-cli" \
  ani="ani-cli" \
  aniq="ani-cli -q"

# audio
alias \
  mx="pulsemixer" \
  amx="alsamixer" \
  mk="cmus" \
  ms="cmus" \
  music="cmus"

# power management
[ -x "$(command -v xbps-query)" ] && alias \
  po="loginctl poweroff" \
  sp="loginctl suspend" \
  rb="loginctl reboot"
[ -x "$(command -v pacman)" ] && alias \
  po="systemctl poweroff" \
  sp="systemctl suspend" \
  rb="systemctl reboot"

# file management
alias \
  fm="./.config/vifm/scripts/vifmrun" \
  file="./.config/vifm/scripts/vifmrun" \
  flm="./.config/vifm/scripts/vifmrun" \
  vifm="./.config/vifm/scripts/vifmrun" \
  rm="rm -vI" \
  mv="mv -iv" \
  cp="cp -iv" \
  mkd="mkdir -pv"

# ps
alias \
  psa="ps auxf" \
  psgrep="ps aux | grep -v grep | grep -i -e VSZ -e" \
  psmem="ps auxf | sort -nr -k 4" \
  pscpu="ps auxf | sort -nr -k 3"

# youtube
alias \
  yta-aac="yt-dlp --extract-audio --audio-format aac" \
  yta-best="yt-dlp --extract-audio --audio-format best" \
  yta-flac="yt-dlp --extract-audio --audio-format flac" \
  yta-m4a="yt-dlp --extract-audio --audio-format m4a" \
  yta-mp3="yt-dlp --extract-audio --audio-format mp3" \
  yta-opus="yt-dlp --extract-audio --audio-format opus" \
  yta-vorbis="yt-dlp --extract-audio --audio-format vorbis" \
  yta-wav="yt-dlp --extract-audio --audio-format wav" \
  ytv-best="yt-dlp -f bestvideo+bestaudio" \
  yt="ytfzf -f -t" \
  ytm="ytfzf -m"

# network and bluetooth
alias \
  netstats="nmcli dev" \
  wfi="nmtui-connect" \
  wfi-scan="nmcli dev wifi list" \
  wfi-edit="nmtui-edit" \
  wfi-on="nmcli radio wifi on" \
  wfi-off="nmcli radio wifi off" \
  blt="bluetoothctl"

### SETTING THE STARSHIP PROMPT ###
eval "$(starship init bash)"
