#!/bin/sh

time_stamp=`date +%s`
date=`date +%d%m%y_%H`
max="65000"
min="0"

gw=$(route -n | egrep "^0.0.0.0" | tr -s ' ' ' ' | cut -d' ' -f2)
mac=$(ifconfig eth0 | grep  HWaddr | tr -s ' ' | cut -d' ' -f5 | tr -d ':')
sondaid="$mac"
data_dir="/data/"

server="10.219.3.202"
server_user="admincom"
server_dir="/home/admincom/data"

base_metrics="whisper.sondas.$sondaid"
