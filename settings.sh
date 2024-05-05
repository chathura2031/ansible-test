# Set scrolling direction
# gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false

# Set yakuake as the default terminal for gnome
gsettings set org.gnome.desktop.default-applications.terminal exec /usr/bin/yakuake
gsettings set org.gnome.desktop.default-applications.terminal exec-arg "-x"

# Set yakuake as the default terminal for cinnamon
gsettings set org.cinnamon.desktop.default-applications.terminal exec /usr/bin/yakuake

# sudo apt remove gnome-terminal
# sudo apt autoremove
ln -s /etc/vim/.vimrc ~/.ideavimrc

# Set the icon size for the dock
# gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 24