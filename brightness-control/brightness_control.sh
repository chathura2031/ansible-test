#!/bin/bash

ICONS_PATH="/home/chathura/ansible-test/brightness-control/"
ICON_BRIG0=$ICONS_PATH"brig0.png"
ICON_BRIG1=$ICONS_PATH"brig1.png"
ICON_BRIG2=$ICONS_PATH"brig2.png"
ICON_BRIG3=$ICONS_PATH"brig3.png"
ICON_BRIG4=$ICONS_PATH"brig4.png"

# Get the brightness of the screen as a percentage (eg. 10)
get_brightness() {
    brightness=$(xbacklight -get | cut -d '.' -f1)
}

# Get the icon to display in the notifications for the active device
get_icon() {
    echo $brightness
    if [[ $brightness -lt 1 ]]; then
        icon_name=$ICON_BRIG0
    elif [[ $brightness -lt 25 ]]; then
        icon_name=$ICON_BRIG1
    elif [[ $brightness -lt 50 ]]; then
        icon_name=$ICON_BRIG2
    elif [[ $brightness -lt 75 ]]; then
        icon_name=$ICON_BRIG3
    else
        icon_name=$ICON_BRIG4
    fi
}

notify() {
    get_brightness
    get_icon
    dunstify -a brightness-controller -u low -r 9994 -h int:value:$brightness -i $icon_name -t 1000 "Brightness: $brightness%"
}

# Set the brightness of the individual devices to max
initialise() {
    echo "Changing brightness..."
}

# Increase the brightness
increase() {
    xbacklight +1
}

# Decrease the brightness
decrease() {
    xbacklight -1
}

initialise
if [[ $1 = "inc" ]]; then
    increase
    notify
elif [[ $1 = "dec" ]]; then
    decrease
    notify
else
    echo "UNKNOWN COMMAND"
    exit 1
fi
