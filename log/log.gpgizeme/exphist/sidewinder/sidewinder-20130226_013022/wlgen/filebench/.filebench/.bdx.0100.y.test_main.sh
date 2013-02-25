#!/bin/sh
##_ver=20130219_104009

if [ "X$(id -u)" != "X0" ]; then
	echo "#>> ERROR: you should have root priviledge -- EXIT";
	exit 1;
fi

echo "#>> cleaning up '30.tmp/' directory before 32.wloadgen/ direx"; # direx: directory execution using _BDX
(cd 30.tmp; rm .tlog.*;)

#echo "#>> Now ready for generating workload specified in '20.conf/.tconf.sh'";
#echo "#>> please run iotrace (blktrace) in '34.iotrace/' to start workload generation";
(cd 32.wloadgen; _BDX;)


