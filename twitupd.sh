#!/bin/bash

# Recommended crontab entry
# 0 0 * * * /mystic/scripts/twitupd.sh && logger -t "mystic_twitupd.sh" "[crontab] blacklist.txt updated"

if [[ -z "$1" ]]; then
  MYS_HOME="/mystic"
else
  MYS_HOME="$1"
fi

MYS_DATA="$MYS_HOME/data"
MYS_LOGS="$MYS_HOME/logs"

URLS=(
      "https://erb.pw/blacklist"
      "https://ibbs.archaicbinary.net/ibbs-bots"
)

IFS=$'\n'
#for I in $(curl -s https://erb.pw/blacklist); do 
for URL in ${URLS[@]}; do
  for I in $(curl -s $URL); do 
    CHECK=$(grep -c $I $MYS_DATA/blacklist.txt)
    if [[ $CHECK -lt 1 ]]; then
      echo $I >> $MYS_DATA/blacklist.txt
      echo "[[1;32m+[0m] $I"
      echo "$(date) [+] $I" >> $MYS_LOGS/twitupd.log
    else
      echo "[[1;33m✔[0m] $I"
      echo "$(date) [✔] $I" >> $MYS_LOGS/twitupd.log
    fi
  done
done
