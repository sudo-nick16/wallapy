#!/bin/bash

# Note: "feh" should be installed on your system.

set_wallpaper () {
    feh --bg-scale "${1}"
}

# path to the text file that contains wallpaper's filename
data_path="./wallapy.txt"

# path to the wallpapers directory
wallpapers_path="$HOME/Pictures/temp/"

wallpapers=$(ls $wallpapers_path)
total=$(ls $wallpapers_path | wc -l)
first_wallpaper=$(ls $wallpapers_path | head -1)
index=1
found=0

# running for the first time
if [ ! -f $data_path ]; then
    echo $first_wallpaper > $data_path
    set_wallpaper "$wallpapers_path$first_wallpaper"
    exit
fi

# iterating through wallpapers
IFS=$'\n'
for wall in $wallpapers
do
    # exhausted wallpapers - could mean - 1. wallpaper was deleted 2. last wallpaper is currently set 
    if [ $index == $total ]; then
        echo $first_wallpaper > $data_path
        set_wallpaper "$wallpapers_path$first_wallpaper"
        break
    fi


    # if current wallpaper exists, set flag
    if [ $wall == $(cat $data_path) ]; then
        found=1
        continue
    fi

    # setting the next wallpaper
    if [ $found == 1 ]; then
        echo $wall > $data_path
        set_wallpaper "$wallpapers_path$wall"
        break
    fi

    index=$((index+1))
done