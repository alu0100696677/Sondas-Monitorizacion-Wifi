#!/bin/ash 

. /opt/scripts/lib/comun.sh

check_name="ruido"

file_export="${data_dir}/${sondaid}_${check_name}_${date}.txt"

ifconfig wlan0 up

res=`iwinfo wlan0 assoclist | grep SNR`
if [ $? -eq 0 ]; then
  value=`echo $res | grep SNR | sed -e "s/.*SNR \([-0-9]*\).*/\1/"`
else
  value=$min
fi

echo "$base_metrics.$check_name $value $time_stamp" >> $file_export

