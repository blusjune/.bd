#!/bin/sh
#.bdx.0100.y.preproc_plot.sh
#/home/X0101/a1mjjung/x/tracelog/MS_Production/MSNStorageFileServer/tdir/iowa-mw10m/data.out/20130502_134226--f010.T021.msnfs.R.out--iowa_anal_s0010.sio_25.mw_600000000.t1_60000000/periodicity
#_ver=20130522_202121




_mwid="0";
_maxval="36";
_infile=".f040.msnfs.anal_s0010.__list__periodicity_metric__.out";
touch .tstamp.01.$(tstamp);
while [ $_mwid -lt $_maxval ]; do
	echo "#>> processing [$_mwid / $_maxval]";
	
	_outfile_01=$(printf "f050.prd.mw%04d" $_mwid)
	cat $_infile | grep "mw\[ $_mwid \]" > $_outfile_01;

	_outfile_02=$(printf "f051.prd.mw%04d" $_mwid)
#	cat $_outfile_01 | awk '{ print $9 }' | sort | uniq -c | sort > $_outfile_02;
	cat $_outfile_01 | awk '{ print $9 }' | sort | uniq -c | sort | awk '{ print $2, $1 }' | sort > $_outfile_02;

	_mwid=$(expr $_mwid + 1);
done
touch .tstamp.01.$(tstamp);




