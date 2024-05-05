#!/bin/bash
sudo apt install -y yakuake

file_dir=$HOME"/.config"
mkdir --parents $file_dir
cp -v yakuakerc $file_dir

# echo "yakuake" >> ~/.config/autostart
ln -s /usr/share/applications/org.kde.yakuake.desktop $file_dir/autostart/yakuake.desktop