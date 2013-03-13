#!/bin/sh
##.bdx.0100.y.microsoft_iotrace_preproc.sh
##_ver=20130312_201930
##_ver=20130312_211755
##_ver=20130313_103945




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
	cat $_i >> ${_fileout};
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
cat $_infile | cut -d ',' -f 5 | bsc.lsp.hex2dec > $_fileout; # extract only byte-offset and convert hexadecimal to decimal value
_ts_2=$(tstamp-e);
echo "[$_tid] Elapsed time: $(expr $_ts_2 - $_ts_1) seconds";




_tasknum="021"; _tid="T${_tasknum}";
_infile=$_fileout_011;
_fileout="${_tid}.${_basename}.R.out";
_fileout_021=$_fileout;
echo "[$_tid] '$_fileout' file will be generated";

_ts_1=$(tstamp-e);
cat $_infile | grep DiskRead | cut -d ',' -f 5 | bsc.lsp.hex2dec > $_fileout; # extract only byte-offset and convert hexadecimal to decimal value
_ts_2=$(tstamp-e);
echo "[$_tid] Elapsed time: $(expr $_ts_2 - $_ts_1) seconds";




_tasknum="022"; _tid="T${_tasknum}";
_infile=$_fileout_011;
_fileout="${_tid}.${_basename}.W.out";
_fileout_022=$_fileout;
echo "[$_tid] '$_fileout' file will be generated";

_ts_1=$(tstamp-e);
cat $_infile | grep DiskWrite | cut -d ',' -f 5 | bsc.lsp.hex2dec > $_fileout; # extract only byte-offset and convert hexadecimal to decimal value
_ts_2=$(tstamp-e);
echo "[$_tid] Elapsed time: $(expr $_ts_2 - $_ts_1) seconds";




tstamp;
_ts_whole_2=$(tstamp-e);
echo "#>> Elapsed time (whole process): $(expr $_ts_whole_2 - $_ts_whole_1) seconds";




