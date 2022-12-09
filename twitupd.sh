#!/bin/bash

# Recommended crontab entry
# 0 0 * * * /mystic/scripts/twitupd.sh /path/to/mystic && logger -t "mystic_badips" "[crontab] blacklist.txt/denylist.txt updated"

[[ -z "$1" ]] && MYS_HOME="/mystic" || MYS_HOME="$1"

MYS_DATA="$MYS_HOME/data"
MYS_LOGS="$MYS_HOME/logs"

# URLs containing raw IP's to use for Mystic's blacklist/denylist
URLS=(
      "https://erb.pw/blacklist"
      "https://ibbs.archaicbinary.net/ibbs-bots"
)

# Check if using Mystic's blacklist.txt or denylist.txt
[[ -f $MYS_DATA/denylist.txt ]] && FILE="$MYS_DATA/denylist.txt" || FILE="$MYS_DATA/blacklist.txt"

IFS=$'\n'
for URL in ${URLS[@]}; do
  for I in $(curl -s $URL); do 
    CHECK=$(grep -c $I $FILE)
    if [[ $CHECK -lt 1 ]]; then
      echo $I >> $FILE
      echo "[[1;32m+[0m] $I"
      echo "$(date) [+] $I" >> $MYS_LOGS/twitupd.log
    else
      echo "[[1;33m✔[0m] $I"
      echo "$(date) [✔] $I" >> $MYS_LOGS/twitupd.log
    fi
  done
done
