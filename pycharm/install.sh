#!/bin/bash
wd=$(pwd)

# Update existing packages
../pre-install.sh

# Install vim
cd ../vim/
./install.sh
cd $wd

# Install pycharm
program_name=pycharm
version=2024.1.3
folder_name=$program_name-professional-$version
file_name=$folder_name.tar.gz
desktop_file=jetbrains-$program_name.desktop

# Get the program files
wget https://download-cdn.jetbrains.com/python/$file_name
tar -vxf $file_name

# Move the program files to the relevant folder
sudo mkdir --parents /usr/share/jetbrains/
sudo mv -v $program_name-$version/ /usr/share/jetbrains/

# Delete the compressed files
rm -v $file_name

# Generate the desktop file
rm -v $desktop_file
echo "[Desktop Entry]" >> $desktop_file
echo "Version=1.0" >> $desktop_file
echo "Type=Application" >> $desktop_file
echo "Name=PyCharm Professional Edition" >> $desktop_file
echo "Icon=/usr/share/jetbrains/$program_name-$version/bin/pycharm.svg" >> $desktop_file
echo "Exec="/usr/share/jetbrains/$program_name-$version/bin/pycharm.sh" %f" >> $desktop_file
echo "Comment=Python IDE for Professional Developers" >> $desktop_file
echo "Categories=Development;IDE;" >> $desktop_file
echo "Terminal=false" >> $desktop_file
echo "StartupWMClass=jetbrains-pycharm" >> $desktop_file
echo "StartupNotify=true" >> $desktop_file

# Move the desktop file to the relevant folder
sudo mv -v $desktop_file /usr/share/applications/
