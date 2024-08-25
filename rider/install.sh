#!/bin/bash
wd=$(pwd)

# Update existing packages
../pre-install.sh

# Install vim
cd ../vim/
./install.sh
cd $wd

# Install rider
version=2024.1.4
tar_file_name=JetBrains.Rider-$version
extracted_folder_name="JetBrains Rider-$version"
program_folder_name=rider-$version
desktop_file=jetbrains-rider.desktop

# Get the program files
wget https://download-cdn.jetbrains.com/rider/$tar_file_name.tar.gz
tar -vxf "$tar_file_name.tar.gz"

# Move the program files to the relevant folder
sudo mkdir --parents "/usr/share/jetbrains/"
mv -v "$extracted_folder_name/" "$program_folder_name/"
sudo mv -v "$program_folder_name/" "/usr/share/jetbrains/"

# Delete the compressed files
rm -v "$tar_file_name.tar.gz"

# Generate the desktop file
rm -v $desktop_file
echo "[Desktop Entry]" >> $desktop_file
echo "Version=1.0" >> $desktop_file
echo "Type=Application" >> $desktop_file
echo "Name=JetBrains Rider" >> $desktop_file
echo "Icon=/usr/share/jetbrains/$program_folder_name/bin/rider.svg" >> $desktop_file
echo "Exec="/usr/share/jetbrains/$program_folder_name/bin/rider.sh" %f" >> $desktop_file
echo "Comment=A corss-platform IDE for .NET" >> $desktop_file
echo "Categories=Development;IDE;" >> $desktop_file
echo "Terminal=false" >> $desktop_file
echo "StartupWMClass=jetbrains-rider" >> $desktop_file
echo "StartupNotify=true" >> $desktop_file

# Move the desktop file to the relevant folder
sudo mv -v $desktop_file /usr/share/applications/
