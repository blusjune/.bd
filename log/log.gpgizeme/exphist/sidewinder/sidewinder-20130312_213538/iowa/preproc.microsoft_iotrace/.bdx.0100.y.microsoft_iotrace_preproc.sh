#!/bin/sh
##.bdx.0100.y.microsoft_iotrace_preproc.sh
##_ver=20130312_201930
##_ver=20130312_211755
##_ver=20130313_103945
##_ver=20130313_151241




tstamp;
_ts_whole_1=$(tstamp-e);




_tasknum="010"; _tid="T${_tasknum}";
_infile_list=$(ls -1 *.csv);
_infile_totalnum=$(ls -1 *.csv | wc -l);
echo "$_infile_list";
echo "----
# of input files: $_infile_totalnum
----
";
read -p "#>> basename for fileouts: " _basename;
if [ "X$_basename" = "X" ]; then
	_basename="_noname_";
fi

_ts_1=$(tstamp-e);
_count=1;
for _i in $_infile_list; do
	echo "[$_tid] [${_count}/${_infile_totalnum}] processing '$_i' ...";
	cat $_i | grep -e 'DiskRead' -e 'DiskWrite' | grep -v 'TimeStamp' | cut -d ',' -f 1,2,3,4,6,7,14,15 --output-delimiter=" , " | bsc.iowa.lsp.preproc_msiotout_s010 > ${_tid}.${_i};
	_count=$(expr $_count + 1);
done
_ts_2=$(tstamp-e);
echo "[$_tid] Elapsed time: $(expr $_ts_2 - $_ts_1) seconds";




_T011_timestamp_processing=".tmp.T011.timestamp_proc.py";
_T011_lasttime_file=".tmp.T011.lasttime.txt";
cat > $_T011_timestamp_processing << EOF
#!/usr/bin/env python
import os, sys
_lasttime_default = 0
_lasttime_in_prevfile = int(os.getenv('LASTTIME_IN_PREVFILE', _lasttime_default))
for _line in sys.stdin:
	_li = _line.strip().split(',')
	_li[1] = int(_li[1]) + _lasttime_in_prevfile
	_lasttime = _li[1]
	print str(_li[0]) + ' , ' + str(_li[1]) + ' , ' + str(_li[2]) + ' , ' + str(_li[3]) + ' , ' + str(_li[4]) + ' , ' + str(_li[5]) + ' , ' + str(_li[6]) + ' , ' + str(_li[7])
f = open('$_T011_lasttime_file', 'w')
f.write(str(_lasttime))
f.close()
EOF
chmod 755 $_T011_timestamp_processing;




_tasknum="011"; _tid="T${_tasknum}";
_infile_list=$(ls -1 T010.*);
_infile_totalnum=$(ls -1 T010.* | wc -l);
_fileout="${_tid}.${_basename}.out";
_fileout_011=$_fileout;
echo "[$_tid] '$_fileout' file will be generated";
_ts_1=$(tstamp-e);
_count=1;
for _i in $_infile_list; do
	echo "[$_tid] [${_count}/${_infile_totalnum}] processing '$_i' ...";
#	cat $_i >> ${_fileout};
	cat $_i | $_T011_timestamp_processing >> ${_fileout};
	LASTTIME_IN_PREVFILE=$(cat $_T011_lasttime_file);
	export LASTTIME_IN_PREVFILE;
	_count=$(expr $_count + 1);
done
_ts_2=$(tstamp-e);
echo "[$_tid] Elapsed time: $(expr $_ts_2 - $_ts_1) seconds";




_tasknum="020"; _tid="T${_tasknum}";
_infile=$_fileout_011;
_fileout="${_tid}.${_basename}.A.out";
_fileout_020=$_fileout;
echo "[$_tid] '$_fileout' file will be generated";

_ts_1=$(tstamp-e);
cat $_infile | cut -d ',' -f 2,5,6,7,8 > $_fileout; # extract timestamp, offset, size, file_id, path
_ts_2=$(tstamp-e);
echo "[$_tid] Elapsed time: $(expr $_ts_2 - $_ts_1) seconds";




_tasknum="021"; _tid="T${_tasknum}";
_infile=$_fileout_011;
_fileout="${_tid}.${_basename}.R.out";
_fileout_021=$_fileout;
echo "[$_tid] '$_fileout' file will be generated";

_ts_1=$(tstamp-e);
cat $_infile | grep DiskRead | cut -d ',' -f 2,5,6,7,8 > $_fileout; # extract timestamp, offset, size, file_id, path
_ts_2=$(tstamp-e);
echo "[$_tid] Elapsed time: $(expr $_ts_2 - $_ts_1) seconds";




_tasknum="022"; _tid="T${_tasknum}";
_infile=$_fileout_011;
_fileout="${_tid}.${_basename}.W.out";
_fileout_022=$_fileout;
echo "[$_tid] '$_fileout' file will be generated";

_ts_1=$(tstamp-e);
cat $_infile | grep DiskWrite | cut -d ',' -f 2,5,6,7,8 > $_fileout; # extract timestamp, offset, size, file_id, path
_ts_2=$(tstamp-e);
echo "[$_tid] Elapsed time: $(expr $_ts_2 - $_ts_1) seconds";




tstamp;
_ts_whole_2=$(tstamp-e);
echo "#>> Elapsed time (whole process): $(expr $_ts_whole_2 - $_ts_whole_1) seconds";




