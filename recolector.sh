#!/bin/ash 
cd /opt

. /opt/scripts/lib/comun.sh
tmp_file=`mktemp`
ls $data_dir > $tmp_file

for i in $(cat $tmp_file); do 
	scp -i /etc/dropbear/dropbear_rsa_host_key "$data_dir/$i" $server_user@$server:$server_dir
	if [ $? = 0 ]; then 
		rm "$data_dir/$i"
        else
		   exit
	fi
done

if ! test -z $comprimir; then
	date=$(sonda_date);
	cd $data_dir; tar cvzf ${sondaid}_${date}.tar.gz *.txt
fi

rm $tmp_file
