#!/bin/bash

MYS_DATA="/mystic/data"
MYS_LOGS="/mystic/logs"

IFS=$'\n'
for I in $(curl https://www.erb.pw/blacklist 2>/dev/null); do 
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
