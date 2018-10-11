#! /bin/bash
BG_DIR=$HOME/Pictures/Wallpapers
BING_ADDR="https://www.bing.com"
JSON_LINK="http://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1"

JSON=$(curl ${JSON_LINK} 2>/dev/null)

FIG_LINK=${BING_ADDR}$(echo ${JSON} | tr ',' '\n' | grep \"url\" | cut -d: -f 2 | tr -d '"')
FIG_NAME=${FIG_LINK##*/}

wget -q ${FIG_LINK} -O ${BG_DIR}/${FIG_NAME}

FIG_PREFIX=file://$HOME/Pictures/Wallpapers

FIG_STR=${FIG_PREFIX}/${FIG_NAME}

gsettings set org.gnome.desktop.background picture-uri ${FIG_STR}

################################################################################
