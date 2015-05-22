#!/bin/ash 

. /opt/scripts/lib/comun.sh

check_name="ssid"

file_export="${data_dir}/${sondaid}_${check_name}_${date}.txt"

ifconfig wlan0 up
#echo timestamp
#iw dev wlan0 scan | egrep "SSID|signal|^BSS|primary channel" 

#file_snr="${data_dir}/${sondaid}_snr_${date}.txt"
#echo timestamp
#iwinfo wlan0 assoclist | grep SNR 

res=`iwinfo wlan0 assoclist | grep SNR`
if [ $? -eq 0 ]; then
  value=`echo $res | grep SNR | sed -e "s/.*SNR \([-0-9]*\).*/\1/"`
else
  value=$min
fi
echo $value
echo "$base_metrics.$check_name $value $time_stamp" > $file_export

