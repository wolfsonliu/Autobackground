#! /bin/bash
BG_DIR=$HOME/Pictures/NASA
RSS_LINK="https://www.nasa.gov/rss/dyn/lg_image_of_the_day.rss"

RSS=$(curl ${RSS_LINK} 2>/dev/null)

FIG_LINK=$(echo ${RSS} | tr '><' '\n'| grep enclosure | head -1 | tr '"' '\n' | grep http)

FIG_NAME=${FIG_LINK##*/}

wget -q ${FIG_LINK} -O ${BG_DIR}/${FIG_NAME}

FIG_PATH=${BG_DIR}/${FIG_NAME}

osascript -e 'tell application "Finder" to set desktop picture to POSIX file "${FIG_PATH}"'
################################################################################
