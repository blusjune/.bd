#!/bin/sh
##.bdx.0100.y.microsoft_iotrace_preproc.sh
##_ver=20130312_201930
##_ver=20130312_203653
##_ver=20130312_211755




tstamp;




_tasknum="010"; _tid="T${_tasknum}";
_infile_list=$(ls -1 *.csv);
_infile_totalnum=$(ls -1 *.csv | wc -l);
echo "$_infile_list";
echo "----
# of input files: $_infile_totalnum
----
";
read -p "[${_tid}] basename for a new file: " _basename;
if [ "X$_basename" = "X" ]; then
	_basename="_noname_";
fi
_fileout="${_tid}.${_basename}.out";
echo "[$_tid] '$_fileout' file will be generated";

_ts_1=$(tstamp-e);
_count=1;
for _i in $_infile_list; do
	echo "[$_tid] [${_count}/${_infile_totalnum}] processing $_i ...";
	cat $_i | grep -e 'DiskRead' -e 'DiskWrite' | grep -v 'TimeStamp' | cut -d ',' -f 1,3,4,6,7,14,15 --output-delimiter=" , " >> ${_fileout};
	_count=$(expr $_count + 1);
done
_ts_2=$(tstamp-e);
echo "[$_tid] Elapsed time: $(expr $_ts_2 - $_ts_1) seconds";




_tasknum="020"; _tid="T${_tasknum}";
_infile=$_fileout;
_fileout="${_tid}.${_basename}.out";
echo "[$_tid] '$_fileout' file will be generated";

_ts_1=$(tstamp-e);
cat $_infile | cut -d ',' -f 4 | bsc.lsp.hex2dec > $_fileout; # extract only byte-offset and convert hexadecimal to decimal value
_ts_2=$(tstamp-e);
echo "[$_tid] Elapsed time: $(expr $_ts_2 - $_ts_1) seconds";




tstamp;




