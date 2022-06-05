### STARTING XSESSION
if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]
then
  startx
fi
export GST_VAAPI_ALL_DRIVERS=1
export EDITOR="nvim"                               # $EDITOR use neovim
#export EDITOR="emacsclient -t -a ''"              # $EDITOR use Emacs in terminal
#export VISUAL="emacsclient -c -a emacs"           # $VISUAL use Emacs in GUI mode
export READER="zathura"
export TERMINAL="alacritty"
export BROWSER="qutebrowser"
export WM="dwm"
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
source $HOME/.bashrc
