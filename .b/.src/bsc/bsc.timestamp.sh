#!/bin/sh
## bsc.timestamp.sh
## Beee's timestamp print program

##tstamp: 20121108_232229




_this_prog=$(basename $0);

case $_this_prog in
	"bsc.timestamp.sh"|"timestamp"|"tstamp"|"tstamp-a"|"..ts"|"..tsa")
		date +%Y%m%d_%H%M%S;
		;;
	"tstamp-b"|"..tsb")
		date +%Y%m%d_%H%M;
		;;
	"tstamp-c"|"..tsc")
		date +%Y%m%d_%H;
		;;
	"tstamp-d"|"..tsd")
		date +%Y%m%d;
		;;
	"tstamp-e"|"..tse")
		date +%s;
		;;
	"tstamp-f"|"..tsf")
		date +%N;
		;;
	*)
		echo "_NOT_DEFINED_";
		;;
esac

