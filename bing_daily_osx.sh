#! /bin/bash
BG_DIR=$HOME/Pictures/Wallpapers
BING_ADDR="https://www.bing.com"
JSON_LINK="http://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1"
JSON=$(curl ${JSON_LINK} 2>/dev/null)

FIG_LINK=${BING_ADDR}$(echo ${JSON} | tr ',' '\n' | grep \"url\" | cut -d: -f 2 | tr -d '"')
FIG_NAME=${FIG_LINK##*/}
FIG_PATH=${BG_DIR}/${FIG_NAME}

if [ ! -e ${FIG_PATH} ]; then
    wget -q ${FIG_LINK} -O ${FIG_PATH}
    SCRIPT='tell application "Finder" to set desktop picture to POSIX file '\"${FIG_PATH}\"
    osascript -e "${SCRIPT}"
fi

################################################################################
