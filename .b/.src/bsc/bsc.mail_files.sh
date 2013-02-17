#!/bin/sh

_i=0;
_num_of_files=$#;
_addr_to="brian.m.roses@gmail.com";
_sysinfo="

----------
hostname : $(hostname)
MAC addr : $(ifconfig eth0 | grep -i hwaddr | awk '{ print $5 }')
IP addr  : $(ifconfig eth0 | grep -i inet | awk '{ print $2 }' | sed -e 's/.*:\(.*\)/\1/g')
system   : $(uname -srm)
time     : $(date)
----------

";

for _file in $*; do
	_i=$(expr $_i + 1);
	_subject="[bmail:$_i/$_num_of_files] $_file";
	echo "$_subject $_sysinfo" | mail -s "$_subject" -a "$_file" $_addr_to;
	echo ">>> $_subject"
done
