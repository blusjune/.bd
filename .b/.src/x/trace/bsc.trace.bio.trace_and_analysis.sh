#!/bin/sh

## bsc.trace.bio.trace_and_analysis.sh
##
## Mon Mar 19 02:10:14 KST 2012
## Mon Mar 19 17:17:27 KST 2012




_this_prog="$(basename $0)";
_timestamp="$(date +%Y%m%d_%H%M%S)";




_btt_opt_base="-o bio_anal -A -B blkno_ -I iostat_ -l lat_d2c_ -p iodump_ -P iotree_ -q lat_q2c_ -Q aqdepth_ -s seeks_ -z lat_q2d_";




case $_this_prog in
##########
"bsc.bio.trace"|"bio.trace"|"bio.tr")
	if [ $# -eq 0 ]; then
		echo "--";
		echo "Block I/O Trace and then Analysis";
		echo "[usage] $_this_prog <list of devices '/dev/xxx1 /dev/xxx2 ...'>";
		exit 0;
	fi
	_devlist="$*";

	_bpout="bpout";
	for _i in $_devlist; do
		_devid="$(echo $_i | sed -e 's/\/dev\/\(.*\)/\1/')";
		_bpout=${_bpout}_${_devid};
	done
	_bpout="${_bpout}.$_timestamp";

	echo ">>> blktrace $_devlist -o - | blkparse -i - -d $_bpout";
	blktrace $_devlist -o - | blkparse -i - -d $_bpout;
	;;
##########
"bsc.bio.analysis"|"bio.analysis"|"bio.anal")

	if [ ! $# -eq 1 ]; then
		echo "--";
		echo "Block I/O Analysis";
		echo "[usage] $_this_prog <input_file_path>";
		exit 0;
	fi
	_btt_input="$1";

	echo ">>> bio analysis";
	mkdir bio_analysis;
	(
	cd bio_analysis;
	btt -i ../${_btt_input} $_btt_opt_base;
	)
	;;
##########
"bsc.bio.trace_n_analysis"|"bio.trace_n_analysis"|"bio.tr_n_anal")
	if [ $# -eq 0 ]; then
		echo "--";
		echo "Block I/O Trace and then Analysis";
		echo "[usage] $_this_prog <list of devices '/dev/xxx1 /dev/xxx2 ...'>";
		exit 0;
	fi
	_devlist="$*";

	_bpout="bpout";
	for _i in $_devlist; do
		_devid="$(echo $_i | sed -e 's/\/dev\/\(.*\)/\1/')";
		_bpout=${_bpout}_${_devid};
	done
	_bpout="${_bpout}.$_timestamp";

	echo ">>> blktrace $_devlist -o - | blkparse -i - -d $_bpout";
	blktrace $_devlist -o - | blkparse -i - -d $_bpout;

	echo ">>> bio analysis";
	mkdir bio_analysis;
	(
	cd bio_analysis;
	btt -i ../$_bpout $_btt_opt_base;
	)
	;;
##########
*)
	echo ">>> ERROR: undefined command";
	exit 1;
esac




