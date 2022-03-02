#!/bin/sh
# This is script is meant to deploy all my configs to an specific directory

# Directory list
dir1="$HOME/.config/awesome/"
dir2="$HOME/.config/alacritty/"
dir3="$HOME/.config/picom/"
dir4="$HOME/.config/vifm/"
dir6="$HOME/.config/doom/"
dir7="$HOME/.config/scripts/"
dir8="$HOME/.config/zsh/"

# File List
newsboaturl="$HOME/.newsboat/urls"
zshrc="$HOME/.zshrc"
bashrc="$HOME/.bashrc"
starshiprc="$HOME/.config/starship.toml"
mocrc="$HOME/.moc/config"
mocth="$HOME/.moc/themes/"
qutepy="$HOME/.config/qutebrowser/config.py"
qutegruvpy="$HOME/.config/qutebrowser/gruvbox.py"

# Deploy directory
echo "Checking the deploy directory, creating if it's not created"
echo "Deleting the last deploy if it's there"
deploydir="$HOME/.deploy"
rm -rf "${deploydir:?}"/*
mkdir -p "$HOME/.deploy/"
mkdir -p "$HOME/.deploy/.config/"
mkdir -p "$HOME/.deploy/.moc/"
mkdir -p "$HOME/.deploy/.newsboat/"
mkdir -p "$HOME/.deploy/.config/qutebrowser/"

# Deploying
echo "Deploying the awesomewm config";
cp -r "$dir1" "$deploydir/.config/";
echo "Deploying the alacritty config";
cp -r "$dir2" "$deploydir/.config/";
echo "Deploying the picom config";
cp -r "$dir3" "$deploydir/.config/";
echo "Deploying the vifm config";
cp -r "$dir4" "$deploydir/.config/";
echo "Deploying the zsh config";
cp "$zshrc" "$deploydir/";
cp -r "$dir8" "$deploydir/.config/";
echo "Deploying the starship config";
cp "$starshiprc" "$deploydir/.config/";
echo "Deploying the bash config";
cp "$bashrc" "$deploydir/";
echo "Deploying the moc config";
cp -r "$mocrc" "$deploydir/.moc/";
echo "Deploying the moc themes";
cp -r "$mocth" "$deploydir/.moc/";
echo "Deploying the DOOM Emacs config";
cp -r "$dir6" "$deploydir/.config/";
echo "Deploying the qutebrowser config";
cp "$qutepy" "$deploydir/.config/qutebrowser/";
cp "$qutegruvpy" "$deploydir/.config/qutebrowser/";
echo "Deploying scripts";
cp -r "$dir7" "$deploydir/.config/";
echo "Deploying the newsboat config";
cp "$newsboaturl" "$deploydir/.newsboat/";
rm "$deploydir"/.config/vifm/vifminfo*
