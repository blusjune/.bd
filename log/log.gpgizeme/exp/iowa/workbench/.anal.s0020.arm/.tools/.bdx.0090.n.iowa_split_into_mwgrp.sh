#!/bin/sh
#.bdx.0100.y.iowa_split_into_mwgrp.sh
# : to make smaller split files for iowa.anal_s0020 (ARM - Association Rules Mining)
#_ver=20130528_133737
#_ver=20130528_144831


# 19680678 lines - datain (Reads only workload, from real trace log of msnfs 6h)
# 21719 mwid max (21719 measurement windows of 1-second duration)


_filein=".datain.whole";

_mwid_maxval=21719 # 21719
_mw_step=1000
_mwgid_maxval=$(echo "($_mwid_maxval / $_mw_step) + 1" | bc)    # '22' for '21719' and '1000'

_mwgid=0
_mwid_range_start=$(expr $_mwgid \* $_mw_step)
_mwid_range_stop=$(expr $_mwid_range_start + $_mw_step)
while [ $_mwgid -lt $_mwgid_maxval ]; do
        _mwid=$_mwid_range_start;
        _fileout=$(printf "datain.%04d.log" $_mwgid);
        echo "$_fileout <- [ $_mwid_range_start ~ $_mwid_range_stop )";
        while [ $_mwid -lt $_mwid_range_stop -a $_mwid -le $_mwid_maxval ]; do
                echo "[MW: $_mwid / $_mwid_maxval]";
## { ## real task code here

                cat $_filein | grep "mw\[ $_mwid \]" >> $_fileout

## }
                _mwid=$(expr $_mwid + 1);
        done

        ## update loop variable
        _mwgid=$(expr $_mwgid + 1);
        _mwid_range_start=$(expr $_mwgid \* $_mw_step)
        _mwid_range_stop=$(expr $_mwid_range_start + $_mw_step)
done


