#!/bin/bash
../pre-install.sh

sudo apt install -y yakuake

file_dir=$HOME"/.config"
mkdir --parents $file_dir
cp -v yakuakerc $file_dir

# Set yakuake to autostart
ln -s /usr/share/applications/org.kde.yakuake.desktop $file_dir/autostart/yakuake.desktop

# Set yakuake as default terminal for gnome
gsettings set org.gnome.desktop.default-applications.terminal exec /usr/bin/yakuake
gsettings set org.gnome.desktop.default-applications.terminal exec-arg "-x"

# Set yakuake as default terminal for cinnamon
gsettings set org.cinnamon.desktop.default-applications.terminal exec /usr/bin/yakuake
gsettings set org.cinnamon.desktop.default-applications.terminal exec-arg "-x"

# sudo apt install qtchooser qdbus-qt5
# curl https://raw.githubusercontent.com/jesustorresdev/yakuake-session/master/yakuake-session > yakuake-session
# chmod +x yakuake-session
