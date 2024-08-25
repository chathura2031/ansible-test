# Set scrolling direction
# gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false

# Set yakuake as the default terminal for gnome
# ### Moved to yakuake install script
# gsettings set org.gnome.desktop.default-applications.terminal exec /usr/bin/yakuake
# gsettings set org.gnome.desktop.default-applications.terminal exec-arg "-x"

# ### Moved to yakuake install script
# Set yakuake as the default terminal for cinnamon
# gsettings set org.cinnamon.desktop.default-applications.terminal exec /usr/bin/yakuake

# Set the icon size for the dock
# gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 24

# Set the theme to dark
gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y-Dark-Aqua"

# Change password for root user
sudo passwd root
echo "Defaults     rootpw" | sudo EDITOR='tee -a' visudo
