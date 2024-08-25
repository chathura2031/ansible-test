#!/bin/bash
# Update existing packages
../pre-install.sh

# Install chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm -v google-chrome-stable_current_amd64.deb

file_dir=$HOME"/.config"
rm -vrf $file_dir"/google-chrome"
mkdir --parents $file_dir
cp -vr google-chrome $file_dir
