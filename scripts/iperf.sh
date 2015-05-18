#!/bin/ash 

. /opt/scripts/lib/comun.sh

date=$(sonda_date)
file_iperf="${data_dir}/${sondaid}_iperf_${date}.txt"

timestamp=`grafana_timestamp`
iperf_out=$(/usr/bin/iperf -c $server -t 10 | grep Interval -A 1 | grep -v Interval)
echo "$timestamp $iperf_out" >> $file_iperf
