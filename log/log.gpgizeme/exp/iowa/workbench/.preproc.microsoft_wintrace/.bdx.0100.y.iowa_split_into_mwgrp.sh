#!/bin/sh
#.bdx.0100.y.iowa_split_into_mwgrp.sh
#_ver=20130528_133737


# 19680678 datain (msnfs)
# 21719 mwid max

_filein=".datain";

_mwid_maxval=21719 # 21719
_mw_step=1000
_mwgid_maxval=$(echo "($_mwid_maxval / $_mw_step) + 1" | bc)	# '22' for '21719' and '1000'

_mwgid=0
_mwid_range_start=$(expr $_mwgid \* $_mw_step)
_mwid_range_stop=$(expr $_mwid_range_start + $_mw_step)
while [ $_mwgid -lt $_mwgid_maxval ]; do
	_mwid=$_mwid_range_start;
	_fileout=$(printf "datain.%04d.log" $_mwgid);
	echo "$_fileout <- [ $_mwid_range_start ~ $_mwid_range_stop )";
	while [ $_mwid -lt $_mwid_range_stop -a $_mwid -le $_mwid_maxval ]; do
		echo "[MW: $_mwid / $_mwid_maxval]";
## {

#		cat $_filein | grep "mw\[ $_mwid \]" >> $_fileout

## }
		_mwid=$(expr $_mwid + 1);
	done

	## update loop variable
	_mwgid=$(expr $_mwgid + 1);
	_mwid_range_start=$(expr $_mwgid \* $_mw_step)
	_mwid_range_stop=$(expr $_mwid_range_start + $_mw_step)
done
