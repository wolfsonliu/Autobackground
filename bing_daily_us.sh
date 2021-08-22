#! /bin/bash
for x in $(ps -C gnome-session-b -o pid | tail -1); do
    if [ $(lsb_release -d | grep -i ubuntu | wc -l) -gt 0 ]; then
        if [ $(stat -c %U /proc/${x}/environ) = $(whoami) ]; then
            export $(xargs -0 -a "/proc/${x}/environ")
        fi
    fi
done

BG_DIR=$HOME/Pictures/Wallpapers
BING_ADDR="https://www.bing.com"
JSON_LINK="http://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1"

JSON=$(curl ${JSON_LINK} 2>/dev/null)

FIG_LINK=${BING_ADDR}$(echo ${JSON} | tr ',' '\n' | grep \"url\" | cut -d: -f 2 | tr -d '"')
FIG_NAME=${FIG_LINK##*/}
FIG_NAME=${FIG_NAME%%&*}
FIG_NAME=${FIG_NAME##*=}
FIG_PATH=${BG_DIR}/${FIG_NAME}

if [ ! -e ${FIG_PATH} ]; then
    wget -q ${FIG_LINK} -O ${FIG_PATH}
    AUTHOR_INFO=$(curl -s www.bing.com | sed -nE 's/.*<div class="copyright" id="copyright">(.*)<\/div><\/div><\/div><div class="headline">.*$/\1/p')
    FIG_INFO=$(curl -s www.bing.com | sed -nE 's/.*<h1 class="text" id="headline">(.*)<\/h1><\/a><\/div><div class="nav">.*/\1/p')
    echo -e $(date -I'date') "\t" ${FIG_NAME} "\t" ${FIG_INFO} \(${AUTHOR_INFO}\)
 >> ${BG_DIR}/author.txt
    FIG_STR=file://${FIG_PATH}
    gsettings set org.gnome.desktop.background picture-uri ${FIG_STR}
    gsettings set org.gnome.desktop.screensaver picture-uri ${FIG_STR}
fi


################################################################################
