#!/bin/sh
echo "direxing ../orange/ ... ";
( cd ../orange; touch $(..ts); iostat -t 1 > iostat.log ) &
echo "OK, after direxing ../orange/ ... ";
sleep 2;
touch $(..ts);
read -p "do you want to stop ../orange/ direx? [y|n] " _ans;
if [ "X$_ans" = "Xy" ]; then
	_direx_pid="$(lsof ../orange | grep iostat | awk '{print $2}')";
	echo "DireX PID: $_direx_pid";
	kill -9 $_direx_pid;
fi
