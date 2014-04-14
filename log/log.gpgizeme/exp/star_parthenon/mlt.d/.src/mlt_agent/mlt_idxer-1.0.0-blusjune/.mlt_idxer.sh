#!/bin/sh
#_ver=20140403_102237

_this_prog=".mlt_idxer";

if [ $# -lt 2 ]; then
	echo "#>> $_this_prog needs at least two parameters -- EXIT 1";
	exit 1;
fi

_interval="$1" # measurement interval in seconds
_count="$2" # how many times do we measure
_sarbinlog="aux_idx";
_sarbinlog_gz="${_sarbinlog}.binz";

if [ _$(which sar) != "_" ]; then
	sar -A -o $_sarbinlog $_interval $_count > /dev/null 2>&1
fi

gzip $_sarbinlog;
mv ${_sarbinlog}.gz $_sarbinlog_gz
