#!/bin/bash

if [ "$#" -ne 2 ] 
 then
    echo "Illegal number of parameters"
    exit 2
fi

KEEPDAYS=$1
let FILES=$2-1

DIRS=`/usr/bin/find /root/backup -type d`

for search_dir in $DIRS
 do
	/usr/bin/find $search_dir -maxdepth 1 -mtime +$KEEPDAYS -type f -name "*.tar.gz" -printf '%T+ %p\n' | sort -r | sed -e "1,${FILES}d" | tail -n 1 | awk '{print $NF}' | xargs rm -f

done

exit 0
