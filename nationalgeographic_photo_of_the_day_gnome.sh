#! /usr/bin/bash
for x in $(ps -C gnome-session-b -o pid | tail -2); do
    if [ $(stat -c %U /proc/${x}/environ) = $(whoami) ]; then
        export $(xargs -0 -a "/proc/${x}/environ")
    fi
done


BG_DIR=$HOME/Pictures/NationalGeographic
if [ ! -e ${BG_DIR} ]; then
    mkdir -p ${BG_DIR}
fi

FIG_LINK=`wget -q https://www.nationalgeographic.com/photography/photo-of-the-day/ -O - | tr ' ' '\n' | tr '"' '\n' | grep yourshot | head -1`

FIG_PATH=${BG_DIR}/$(date -I'date').jpg

if [ ! -e ${FIG_PATH} ]; then
    wget -q ${FIG_LINK} -O ${FIG_PATH}
fi

FIG_STR=file://${FIG_PATH}

gsettings set org.gnome.desktop.background picture-uri ${FIG_STR}
gsettings set org.gnome.desktop.screensaver picture-uri ${FIG_STR}
################################################################################
