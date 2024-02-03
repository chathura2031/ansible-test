#!/bin/bash

# Install vim
sudo apt install vim -y

# Configure vim
file_dir="/etc/vim"
sudo mkdir --parents $file_dir
sudo mv -v vimrc $file_dir/.vimrc

