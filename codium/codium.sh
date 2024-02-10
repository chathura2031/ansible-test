#!/bin/bash

# Install codium
sudo snap install codium --classic

# Install the vim extension
codium --force --install-extension vscodevim.vim

# Configure codium
file_dir=$HOME"/.config/VSCodium/User"
mkdir --parents $file_dir
cp -v settings.json $file_dir
