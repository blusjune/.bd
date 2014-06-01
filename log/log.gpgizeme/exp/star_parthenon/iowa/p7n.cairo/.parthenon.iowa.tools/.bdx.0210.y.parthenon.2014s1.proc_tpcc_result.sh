#!/bin/sh

# cat -n tpcc_result_L3_C018_1_of_3_128.log | grep MEASURING # 25 #_start_line="25";
# cat -n tpcc_result_L3_C018_1_of_3_128.log | grep STOPPING # 386 #_finish_line="386";

_automatic="y";

_sl_file="/tmp/.bdx.mlt.tpcc._start_line.tmp";
_fl_file="/tmp/.bdx.mlt.tpcc._finish_line.tmp";

_dirs=$(cat dnrf.tpcc.txt);
for _i in $_dirs; do
	(cd $_i;
	 	_file=$(ls -1 | grep tpcc_result | head -1);
		echo $_file;

		if [ "X$_automatic" = "Xy" ]; then
			_start_line=$( expr $( cat -n $_file | grep MEASURING | awk '{print $1}' ) + 2 );
			_finish_line=$( expr $( cat -n $_file | grep STOPPING | awk '{print $1}' ) - 2);
		else
			#
			# manual way
			#
	
			# check whether previous result exists
			if [ -r $_sl_file ]; then
				_start_line=$(cat $_sl_file | head -1);
			fi
			if [ -r $_fl_file ]; then
				_finish_line=$(cat $_fl_file | head -1);
			fi
	
			# get input from user
			if [ "X$_start_line" = "X" ]; then
				read -p "_start_line: $( cat -n $_file | grep MEASURING | awk '{print $1}' ) + 2 =? " _start_line;
			else
				read -p "_start_line: $( cat -n $_file | grep MEASURING | awk '{print $1}' ) + 2 =? [$_start_line]" _start_line_new;
				if [ "X$_start_line_new" != "X" ]; then
					_start_line=$_start_line_new;
				fi
			fi
			if [ "X$_finish_line" = "X" ]; then
				read -p "_finish_line: $( cat -n $_file | grep STOPPING | awk '{print $1}' ) - 2 =? " _finish_line;
			else
				read -p "_finish_line: $( cat -n $_file | grep STOPPING | awk '{print $1}' ) - 2 =? [$_finish_line]" _finish_line_new;
				if [ "X$_finish_line_new" != "X" ]; then
					_finish_line=$_finish_line_new;
				fi
			fi
			echo $_start_line > $_sl_file;
			echo $_finish_line > $_fl_file;
		fi


		cat $_file | tail -1 > tpcc.p010.tpmc.jung
		cat $_file | head -${_finish_line} | tail -$(expr ${_finish_line} - ${_start_line} + 1) > tpcc.p020.tp10s_full.jung
		cat tpcc.p020.tp10s_full.jung | awk '{ print $2 }' | awk -F'(' '{ print $1 }' > tpcc.p030.tp10s_trx1.jung
	)
done

if [ "X$_automatic" != "Xy" ]; then
	rm $_sl_file $_fl_file;
fi
