#!/bin/ash 

. /opt/scripts/lib/comun.sh


date=$(sonda_date)
file_ping="${data_dir}/${sondaid}_ping_${date}.txt"

echo "" >> $file_ping
grafana_timestamp >> $file_ping
gw=$(route -n | egrep "^0.0.0.0" | tr -s ' ' ' ' | cut -d' ' -f2)
ping $gw -c4 -q >> $file_ping 
