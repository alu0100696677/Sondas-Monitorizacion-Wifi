#!/bin/ash 

. /opt/scripts/lib/comun.sh

check_name="ancho_banda"

file_export="${data_dir}/${sondaid}_${check_name}_${date}.txt"

res=`/usr/bin/iperf -c $server -t 10 -f m`

if [ $? -eq 0 ]; then
   value=`echo $res | tail -1 | tr -s " " | sed -e "s/.*MBytes \([0-9\.]*\) Mbits.*/\1/"`
else
   value=$min
fi

echo "$base_metrics.$check_name $value $time_stamp" >> $file_export



