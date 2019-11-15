#! /bin/bash

for x in $(ps -C gnome-session-b -o pid | tail -1); do
    if [ $(lsb_release -d | grep -i ubuntu | wc -l) -gt 0 ]; then
        if [ $(stat -c %U /proc/${x}/environ) = $(whoami) ]; then
            export $(xargs -0 -a "/proc/${x}/environ")
        fi
    fi
done

BG_DIR=$HOME/Pictures/NASA
RSS_LINK="https://www.nasa.gov/rss/dyn/lg_image_of_the_day.rss"

RSS=$(curl ${RSS_LINK} 2>/dev/null)

FIG_LINK=$(echo ${RSS} | tr '><' '\n'| grep enclosure | head -1 | tr '"' '\n' | grep http)
FIG_NAME=${FIG_LINK##*/}
FIG_PATH=${BG_DIR}/${FIG_NAME}

if [ ! -e ${FIG_PATH} ]; then
    wget -q ${FIG_LINK} -O ${FIG_PATH}
    FIG_STR=file://${FIG_PATH}
    gsettings set org.gnome.desktop.background picture-uri ${FIG_STR}
    gsettings set org.gnome.desktop.screensaver picture-uri ${FIG_STR}
    echo $FIG_NAME
fi

################################################################################
