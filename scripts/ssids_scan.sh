#!/bin/ash 

. ./lib/comun.sh

date=$(sonda_date)
file_ssids="${data_dir}/${sondaid}_ssids_${date}.txt"

ifconfig wlan0 up
echo ""  >> $file_ssids
grafana_timestamp >> $file_ssids
iw dev wlan0 scan | egrep "SSID|signal|^BSS|primary channel" >> $file_ssids

file_snr="${data_dir}/${sondaid}_snr_${date}.txt"
grafana_timestamp >> $file_snr
iwinfo wlan0 assoclist | grep SNR >> $file_snr
