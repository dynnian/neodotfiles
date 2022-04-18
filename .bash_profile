### STARTING XSESSION
if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]
then
  startx
fi
source $HOME/.bashrc
