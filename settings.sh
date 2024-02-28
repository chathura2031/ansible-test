# Set scrolling direction
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false
# Set yakuake as the default terminal
gsettings set org.gnome.desktop.default-applications.terminal exec /usr/bin/yakuake
gsettings set org.gnome.desktop.default-applications.terminal exec-arg "-x"
# sudo apt remove gnome-terminal
# sudo apt autoremove