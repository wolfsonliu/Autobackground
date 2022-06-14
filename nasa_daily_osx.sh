#! /bin/bash
BG_DIR=$HOME/Pictures/NASA
RSS_LINK="https://www.nasa.gov/rss/dyn/lg_image_of_the_day.rss"

RSS=$(curl ${RSS_LINK} 2>/dev/null)

FIG_LINK=$(echo ${RSS} | tr '><' '\n'| grep enclosure | head -1 | tr '"' '\n' | grep http)
FIG_NAME=${FIG_LINK##*/}
FIG_PATH=${BG_DIR}/${FIG_NAME}

if [ ! -e ${FIG_PATH} ]; then
    wget -q ${FIG_LINK} -O ${FIG_PATH}
    SCRIPT='tell application "Finder" to set desktop picture to POSIX file '\"${FIG_PATH}\"
    osascript -e "${SCRIPT}"
fi

################################################################################
