#!/bin/ash

cd /opt
mkdir -p /data
. ./scripts/lib/comun.sh

tmp_file=`mktemp`


ls ./scripts/*.sh >  $tmp_file



for i in $(cat $tmp_file); do 
  if [ -x $i ]; then
    $i
  fi 
done

rm $tmp_file
