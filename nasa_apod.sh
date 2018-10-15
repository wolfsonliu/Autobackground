#! /bin/bash

for x in $(ps -C gnome-session-b -o pid | tail -2); do
    if [ $(stat -c %U /proc/${x}/environ) = $(whoami) ]; then
        export $(xargs -0 -a "/proc/${x}/environ")
    fi
done

BG_DIR=$HOME/Pictures/NASA
PAGE_LINK="https://apod.nasa.gov/apod/"

PAGE=$(curl ${RSS_LINK} 2>/dev/null)

FIG_LINK=${PAGE_LINK}$(echo ${PAGE} | tr '><' '\n'| grep IMG | head -1 | tr '"' '\n' | grep image)
FIG_NAME=${FIG_LINK##*/}
FIG_PATH=${BG_DIR}/${FIG_NAME}

if [ ! -e ${FIG_PATH} ]; then
    wget -q ${FIG_LINK} -O ${FIG_PATH}
fi

FIG_STR=file://${FIG_PATH}

gsettings set org.gnome.desktop.background picture-uri ${FIG_STR}
gsettings set org.gnome.desktop.screensaver picture-uri ${FIG_STR}
################################################################################
