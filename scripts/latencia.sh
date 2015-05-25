#!/bin/ash 

. /opt/scripts/lib/comun.sh

check_name="latencia"

file_export="${data_dir}/${sondaid}_${check_name}_${date}.txt"

res=`ping $gw -c4 -q`
if [ $? -eq 0 ]; then
   value=`echo $res | grep "round-trip min/avg/max" | sed -e "s/.* = \([0-9\.]*\)\/.*/\1/"`
else
   value=$max
fi

echo "$base_metrics.$check_name $value $time_stamp" >> $file_export



