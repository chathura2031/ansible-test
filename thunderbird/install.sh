#!/bin/bash
# wget -O thunderbird.tar.bz2 "https://download.mozilla.org/?product=thunderbird-latest&os=linux64&lang=en-US"
# tar -xvf thunderbird.tar.bz2
# rm -v thunderbird.tar.bz2
sudo apt install thunderbird

read -p "Thunderbird will open after you press enter. Once opened, please login to your email account and close Thunderbird. " tmp
thunderbird
thunderbird_folder=$(echo ~/.thunderbird/$(ls -1 ~/.thunderbird/ | grep -E "\.default-release$")/ImapMail/outlook.office365.com)
cp -v msgFilterRules.dat $thunderbird_folder