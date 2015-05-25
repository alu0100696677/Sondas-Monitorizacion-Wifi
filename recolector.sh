#!/bin/ash 

cd /opt

. /opt/scripts/lib/comun.sh
tmp_file=`mktemp`
ls $data_dir >> $tmp_file
buffer=""

for i in $(cat $tmp_file); do 
        cat /data/$i  | /usr/bin/python /opt/carbon.py -H $server -p 2003 --tcp 
	if [ $? = 0 ]; then 
		rm "$data_dir/$i"
	fi
done

if ! test -z $comprimir; then
	date=$(sonda_date);
	cd $data_dir; tar cvzf ${sondaid}_${date}.tar.gz *.txt
fi

rm $tmp_file
