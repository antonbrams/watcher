#!/bin/bash
set -euo pipefail 
IFS=$'\n\t'

# colors
txt_blue="\033[94m"
txt_yellow="\033[33m"
end="\033[0m"

# variables
function getTimeStamp {
    ls -Tl * | awk '{print $8}'
}
timestamps="$(getTimeStamp)"
printf "${txt_blue}[watcher] Killroy watching you, what ever you do...${end}\n"

# load config as source file
source "$(pwd)/watcher.config"
setup
trap end EXIT

# loop
while true; do
    difference="$(getTimeStamp)"
    if [ ! "$timestamps" == "$difference" ]; then
        timestamps="$difference"
        printf "${txt_yellow}[watcher] changes found...${end}\n"
        loop
    fi
    sleep 1
done
