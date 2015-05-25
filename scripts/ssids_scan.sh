#!/bin/ash 

. /opt/scripts/lib/comun.sh



check_name="ssid_scan"

iw wlan0 scan > /tmp/out

file_export="${data_dir}/${sondaid}_${check_name}_${date}.txt"


data=""
for i in `seq 1 13`; do
     value=`grep "DS Parameter set: channel $i" /tmp/out | wc -l`
     if [ -z "$data" ]; then
         data="$base_metrics.$check_name.channel$i $value $time_stamp" 
     else
         data="${data}\n$base_metrics.$check_name.channel$i $value $time_stamp"
     fi
done

echo -e $data >> $file_export


ssid_check (){
  check_name="canal_$1"
  aux=`grep -A 2 "SID: $1$" /tmp/out | grep "DS Parameter set: channel" | sed -e "s/.* channel \([0-9]*\)/\1/"`
  for i in $aux; do
    echo "$base_metrics.$check_name$i $i $time_stamp" >> $file_export
  done

}


ssid_check "eduroam"
ssid_check "ULL"
ssid_check "ULL-CONECTA"


