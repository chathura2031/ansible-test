#!/bin/bash
# Update existing packages
../pre-install.sh

# Install discord
wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb"
sudo apt install -y --fix-broken ./discord.deb
rm -v discord.deb
