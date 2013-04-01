#!/bin/sh
##.bdx.0100.y.microsoft_iotrace_preproc.sh
##_ver=20130312_201930
##_ver=20130312_211755
##_ver=20130313_103945
##_ver=20130401_212704




##




read -p "#>> prefix for target tracelog file name: " _tracelog_prefix;
if [ "X$_tracelog_prefix" = "X" ]; then
	echo "'_tracelog_prefix' should be specified -- EXIT";
	exit 1;
fi

_infile_list=$(ls -1 ${_tracelog_prefix}*.csv);
_infile_totalnum=$(ls -1 ${_tracelog_prefix}*.csv | wc -l);
echo "$_infile_list";
echo "----
# of input files: $_infile_totalnum
----
";
read -p "#>> basename for fileouts: " _basename;
if [ "X$_basename" = "X" ]; then
	_basename="_noname_";
fi




_func_t010()
{
	_tasknum="010"; _tid="T${_tasknum}";
	_ts_1=$(tstamp-e);
	_count=1;
	for _i in $_infile_list; do
		echo "[$_tid] [${_count}/${_infile_totalnum}] processing '$_i' ...";
		cat $_i | grep -e 'DiskRead' -e 'DiskWrite' | grep -v 'TimeStamp' | cut -d ',' -f 1,2,3,4,6,7,14,15 --output-delimiter=" , " | bsc.iowa.lsp.preproc_msiotout_s010 > ${_tid}.${_i};
		_count=$(expr $_count + 1);
	done
	_ts_2=$(tstamp-e);
	echo "[$_tid] Elapsed time: $(expr $_ts_2 - $_ts_1) seconds";
} # _func_t010()




_func_t011()
{
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
	export _fileout_011;
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
} # _func_t011()




_func_t020()
{
	_tasknum="020"; _tid="T${_tasknum}";
	_infile=$_fileout_011;
	_fileout="${_tid}.${_basename}.A.out";
	_fileout_020=$_fileout;
	export _fileout_020;
	echo "[$_tid] '$_fileout' file will be generated";
	
	_ts_1=$(tstamp-e);
	cat $_infile | cut -d ',' -f 2,5,6,7,8 > $_fileout; # extract timestamp, offset, size, file_id, path
	_ts_2=$(tstamp-e);
	echo "[$_tid] Elapsed time: $(expr $_ts_2 - $_ts_1) seconds";
} # _func_t020()




_func_t021()
{
	_tasknum="021"; _tid="T${_tasknum}";
	_infile=$_fileout_011;
	_fileout="${_tid}.${_basename}.R.out";
	_fileout_021=$_fileout;
	export _fileout_021;
	echo "[$_tid] '$_fileout' file will be generated";
	
	_ts_1=$(tstamp-e);
	cat $_infile | grep DiskRead | cut -d ',' -f 2,5,6,7,8 > $_fileout; # extract timestamp, offset, size, file_id, path
	_ts_2=$(tstamp-e);
	echo "[$_tid] Elapsed time: $(expr $_ts_2 - $_ts_1) seconds";
} # _func_t021()




_func_t022()
{
	_tasknum="022"; _tid="T${_tasknum}";
	_infile=$_fileout_011;
	_fileout="${_tid}.${_basename}.W.out";
	_fileout_022=$_fileout;
	export _fileout_022;
	echo "[$_tid] '$_fileout' file will be generated";
	
	_ts_1=$(tstamp-e);
	cat $_infile | grep DiskWrite | cut -d ',' -f 2,5,6,7,8 > $_fileout; # extract timestamp, offset, size, file_id, path
	_ts_2=$(tstamp-e);
	echo "[$_tid] Elapsed time: $(expr $_ts_2 - $_ts_1) seconds";
} # _func_t022()




_func_t031()
{
	_tasknum="031"; _tid="T${_tasknum}";
	_infile=$_fileout_011;
	if [ "X$_infile" = "X" ]; then
		echo "[$_tid] '_infile' is not specified -- EXIT";
		exit 1;
	fi

	_fileout_prefix_031="${_tid}.${_basename}.fld_dstr";
	export _fileout_prefix_031;
	_func_fld_dstr()
	{
		if [ "X$_field_num" = "X" ]; then
			echo "_field_num is empty -- EXIT";
			exit 1;
		fi
		if [ "X$_field_name" = "X" ]; then
			echo "_field_name is empty -- EXIT";
			exit 1;
		fi
		
		_fileout="${_fileout_prefix_031}.${_field_name}.out";
		_fileout_031=$_fileout;
		echo "[$_tid] '$_fileout' file will be generated";
	
		_ts_1=$(tstamp-e);
		cat $_infile | cut -d ',' -f $_field_num | sort | uniq -c | sort -n > $_fileout_031;
		_ts_2=$(tstamp-e);
		echo "[$_tid] Elapsed time: $(expr $_ts_2 - $_ts_1) seconds";
	}
	
	_field_num=3; _field_name="process_id"; _func_fld_dstr;
	_field_num=4; _field_name="thread_id"; _func_fld_dstr;
	_field_num=5; _field_name="address"; _func_fld_dstr;
	_field_num=7; _field_name="file_obj"; _func_fld_dstr;
	_field_num=8; _field_name="full_path"; _func_fld_dstr;
} # _func_t031()




_func_t032()
{
	_tasknum="032"; _tid="T${_tasknum}";
	_infile=$_fileout_011;
	if [ "X$_infile" = "X" ]; then
		echo "[$_tid] '_infile' is not specified -- EXIT";
		exit 1;
	fi

	_fileout_prefix_032="${_tid}.${_basename}.fld_list";
	export _fileout_prefix_032;
	_func_fld_list()
	{
		if [ "X$_field_num" = "X" ]; then
			echo "_field_num is empty -- EXIT";
			exit 1;
		fi
		if [ "X$_field_name" = "X" ]; then
			echo "_field_name is empty -- EXIT";
			exit 1;
		fi
		
		_fileout="${_fileout_prefix_032}.${_field_name}.out";
		_fileout_032=$_fileout;
		echo "[$_tid] '$_fileout' file will be generated";
	
		_ts_1=$(tstamp-e);
		cat $_infile | cut -d ',' -f $_field_num | sort -u > $_fileout_032;
		_ts_2=$(tstamp-e);
		echo "[$_tid] Elapsed time: $(expr $_ts_2 - $_ts_1) seconds";
	}
	
	_field_num=3; _field_name="process_id"; _func_fld_list;
	_field_num=4; _field_name="thread_id"; _func_fld_list;
	_field_num=5; _field_name="address"; _func_fld_list;
	_field_num=7; _field_name="file_obj"; _func_fld_list;
	_field_num=8; _field_name="full_path"; _func_fld_list;
} # _func_t032()




_func_t033()
{
	_tasknum="033"; _tid="T${_tasknum}";
	_infile=${_fileout_011};


	## field name: process_id (#3)
	_inconf=${_fileout_prefix_032}.process_id.out;


	_process_id_list=$(cat $_inconf | sed -e 's/[0-9]* *\(p[0-9]*\) ( *\(.*\))/\1_\2/g');
	for _process_id in $_process_id_list; do
		echo "$_process_id"
	done
}






































############################
##
## main() execution point ##
##
############################




_func_fake_init()
{
	_fileout_011="T011.msn_filesrvr.out";
	export _fileout_011;
}




tstamp;
_ts_whole_1=$(tstamp-e);


_func_fake_init;
_func_t031;
_func_t032;


tstamp;
_ts_whole_2=$(tstamp-e);
echo "#>> Elapsed time (whole process): $(expr $_ts_whole_2 - $_ts_whole_1) seconds";




