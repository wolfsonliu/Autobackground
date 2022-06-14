#! /bin/bash
BG_DIR=$HOME/Pictures/NASA
PAGE_LINK="https://apod.nasa.gov/apod/"

PAGE=$(curl ${RSS_LINK} 2>/dev/null)

FIG_LINK=${PAGE_LINK}$(echo ${PAGE} | tr '><' '\n'| grep IMG | head -1 | tr '"' '\n' | grep image)
FIG_NAME=${FIG_LINK##*/}
FIG_PATH=${BG_DIR}/${FIG_NAME}

if [ ! -e ${FIG_PATH} ]; then
    wget -q ${FIG_LINK} -O ${FIG_PATH}
    SCRIPT='tell application "Finder" to set desktop picture to POSIX file '\"${FIG_PATH}\"
    osascript -e "${SCRIPT}"
fi

################################################################################
