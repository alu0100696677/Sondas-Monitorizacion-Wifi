#!/bin/sh

mac=$(ifconfig eth0 | grep  HWaddr | tr -s ' ' | cut -d' ' -f5 | tr -d ':')
sondaid="$mac"
data_dir="/data/"

server="10.219.3.202"
server_user="admincom"
server_dir="/home/admincom/data"

sonda_date() {
	date +%d%m%y_%H
}

grafana_timestamp() {
	date +%s
}
