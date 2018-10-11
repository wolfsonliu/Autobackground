#! /bin/bash
BG_DIR=$HOME/Pictures/NASA
RSS_LINK="https://www.nasa.gov/rss/dyn/lg_image_of_the_day.rss"

RSS=$(curl ${RSS_LINK} 2>/dev/null)

FIG_LINK=$(echo ${RSS} | tr '><' '\n'| grep enclosure | head -1 | tr '"' '\n' | grep http)

FIG_NAME=${FIG_LINK##*/}

wget -q ${FIG_LINK} -O ${BG_DIR}/${FIG_NAME}

FIG_PREFIX=file://${BG_DIR}

FIG_STR=${FIG_PREFIX}/${FIG_NAME}

gsettings set org.gnome.desktop.background picture-uri ${FIG_STR}
gsettings set org.gnome.desktop.screensaver picture-uri ${FIG_STR}
################################################################################
