#!/bin/sh
##.bdx.0100.y.microsoft_iotrace_preproc.sh
##_ver=20130312_201930
##_ver=20130312_211755
##_ver=20130313_103945
##_ver=20130401_212704
##_ver=20130402_173426
##_ver=20130402_205507
##_ver=20130404_001551
##_ver=20130404_113547




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
		cat $_i | grep -e '\<DiskRead\>' -e '\<DiskWrite\>' | grep -v 'TimeStamp' | cut -d ',' -f 1,2,3,4,6,7,14,15 --output-delimiter=" , " | bsc.iowa.lsp.preproc_msiotout_s010 > ${_tid}.${_i};
		_count=$(expr $_count + 1);
	done
	_ts_2=$(tstamp-e);
	echo "[$_tid] Elapsed time: $(expr $_ts_2 - $_ts_1) seconds";
} # _func_t010()




_func_t011()
{
	_t011_timestamp_processing=".tmp.T011.timestamp_proc.py";
	_t011_lasttime_file=".tmp.T011.lasttime.txt";
	cat > $_t011_timestamp_processing << EOF
#!/usr/bin/env python
import os, sys
from string import maketrans
trtab_1 = maketrans(" ()", "   ")
trtab_2 = maketrans(":\\"\\\\", "___")

lasttime_default = 0
lasttime_in_prevfile = int(os.getenv('LASTTIME_IN_PREVFILE', lasttime_default))
for line in sys.stdin:
	li = line.strip().split(',')
	li[1] = int(li[1]) + lasttime_in_prevfile
	fld_lasttime = li[1]
	tkn = li[2].translate(trtab_1).strip().split()	# li[2] -> fld_prid
	if tkn.__len__() == 2:
		fld_prid = tkn[0] + "_" + tkn[1]
	else:
		print "[T011] ERROR in processing _prid_ -- EXIT"
		sys.exit(1)
	fld_path = li[7].translate(trtab_2).strip()	# li[7] -> fld_path
	print "_iorw_ " + str(li[0]) + ' , ' + "_time_ " + str(li[1]) + ' , ' + "_prid_ " + str(fld_prid) + ' , ' + "_thid_ " + str(li[3]) + ' , ' + "_addr_ " + str(li[4]) + ' , ' + "_iosz_ " + str(li[5]) + ' , ' + "_fobj_ " + str(li[6]) + ' , ' + "_path_ " + str(fld_path)
f = open('$_t011_lasttime_file', 'w')
f.write(str(fld_lasttime))
f.close()
EOF
	chmod 755 $_t011_timestamp_processing;
	
	_tasknum="011"; _tid="T${_tasknum}";
	_infile_list=$(ls -1 T010.*);
	_infile_totalnum=$(ls -1 T010.* | wc -l);
	_outfile="${_tid}.${_basename}.out";
	_outfile_011=$_outfile;
	export _outfile_011;
	echo "[$_tid] '$_outfile' file will be generated";
	_ts_1=$(tstamp-e);
	_count=1;
	for _i in $_infile_list; do
		echo "[$_tid] [${_count}/${_infile_totalnum}] processing '$_i' ...";
	#	cat $_i >> ${_outfile};
		cat $_i | $_t011_timestamp_processing >> ${_outfile};
		LASTTIME_IN_PREVFILE=$(cat $_t011_lasttime_file);
		export LASTTIME_IN_PREVFILE;
		_count=$(expr $_count + 1);
	done
	_ts_2=$(tstamp-e);
	echo "[$_tid] Elapsed time: $(expr $_ts_2 - $_ts_1) seconds";
} # _func_t011()




_func_t020()
{	# no need to execute this (20130404_113200) - we decided to include all the fields 1,2,3,...,8
	_tasknum="020"; _tid="T${_tasknum}";
	_infile=$_outfile_011;
	_outfile="${_tid}.${_basename}.A.out";
	_outfile_020=$_outfile;
	export _outfile_020;
	echo "[$_tid] '$_outfile' file will be generated";
	
	_ts_1=$(tstamp-e);
	cat $_infile | cut -d ',' -f 2,3,4,5,6,7,8 > $_outfile;
	# extract timestamp, pid, tid, offset, size, file_id, path
	_ts_2=$(tstamp-e);
	echo "[$_tid] Elapsed time: $(expr $_ts_2 - $_ts_1) seconds";
} # _func_t020()




_func_t021()
{
	_tasknum="021"; _tid="T${_tasknum}";
	_infile=$_outfile_011;
	_outfile="${_tid}.${_basename}.R.out";
	_outfile_021=$_outfile;
	export _outfile_021;
	echo "[$_tid] '$_outfile' file will be generated";
	
	_ts_1=$(tstamp-e);
#	cat $_infile | grep -e '\<DiskRead\>' | cut -d ',' -f 2,3,4,5,6,7,8 > $_outfile; # extract timestamp, pid, tid, offset, size, file_id, path
	cat $_infile | grep -e '\<DiskRead\>' > $_outfile; # only for Read I/O
	_ts_2=$(tstamp-e);
	echo "[$_tid] Elapsed time: $(expr $_ts_2 - $_ts_1) seconds";
} # _func_t021()




_func_t022()
{
	_tasknum="022"; _tid="T${_tasknum}";
	_infile=$_outfile_011;
	_outfile="${_tid}.${_basename}.W.out";
	_outfile_022=$_outfile;
	export _outfile_022;
	echo "[$_tid] '$_outfile' file will be generated";
	
	_ts_1=$(tstamp-e);
#	cat $_infile | grep -e '\<DiskWrite\>' | cut -d ',' -f 2,3,4,5,6,7,8 > $_outfile; # extract timestamp, pid, tid, offset, size, file_id, path
	cat $_infile | grep -e '\<DiskWrite\>' > $_outfile; # only for Write I/O
	_ts_2=$(tstamp-e);
	echo "[$_tid] Elapsed time: $(expr $_ts_2 - $_ts_1) seconds";
} # _func_t022()




_func_t031()
{
	_tasknum="031"; _tid="T${_tasknum}";
	_infile=$_outfile_011;
	if [ "X$_infile" = "X" ]; then
		echo "[$_tid] '_infile' is not specified -- EXIT";
		exit 1;
	fi

	_outfile_prefix_031="${_tid}.${_basename}.fld_dstr";
	export _outfile_prefix_031;
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
		
		_outfile="${_outfile_prefix_031}.${_field_name}.out";
		_outfile_031=$_outfile;
		echo -n "[$_tid] '$_outfile' file will be generated ... ";
	
		_ts_1=$(tstamp-e);
		cat $_infile | cut -d ',' -f $_field_num | sort | uniq -c | sort -n > $_outfile_031;
		_ts_2=$(tstamp-e);
		echo "elapsed time: $(expr $_ts_2 - $_ts_1) seconds";
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
	_infile=$_outfile_011;
	if [ "X$_infile" = "X" ]; then
		echo "[$_tid] '_infile' is not specified -- EXIT";
		exit 1;
	fi

	_outfile_prefix_032="${_tid}.${_basename}.fld_list";
	export _outfile_prefix_032;
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
		
		_outfile="${_outfile_prefix_032}.${_field_name}.out";
		_outfile_032=$_outfile;
		echo -n "[$_tid] '$_outfile' file will be generated ... ";
	
		_ts_1=$(tstamp-e);
		cat $_infile | cut -d ',' -f $_field_num | sort -u > $_outfile_032;
		_ts_2=$(tstamp-e);
		echo "elapsed time: $(expr $_ts_2 - $_ts_1) seconds";
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
	_infile="../${_outfile_011}";
	_outfile_prefix_033="${_tid}.${_basename}.discovery";
	export _outfile_prefix_033;
	_outfile_prefix_033_4plot="${_tid}.${_basename}.discovery_4plot";
	export _outfile_prefix_033_4plot;

	_t033_subfunc=".tmp.T033.subfunc.py";
	cat > $_t033_subfunc << EOF
#!/usr/bin/env python
import sys,os
import fileinput
from string import maketrans
field_name = os.getenv('_field_name')
if field_name is None:
	print "'_field_name' environment variable SHOULD be defined and exported -- EXIT"
	sys.exit(1)
trtab1 = maketrans(" ()", "   ")
trtab2 = maketrans(" ()", "___")
for line in fileinput.input():
	param = line.strip()
	token = param.translate(trtab1).strip().split()
	if token.__len__() == 1:
		radix = token[0]
	elif token.__len__() == 2:
		radix = token[0] + "_" + token[1]
	else:
		radix = param.translate(trtab2).strip()
	outfile_1 = "${_outfile_prefix_033}." + field_name + "." + radix + ".out"
	outfile_2 = "${_outfile_prefix_033_4plot}." + field_name + "." + radix + ".out"
	cmd_1 = "cat ${_infile} | grep -e '\<" + param + "\>' > " + outfile_1
	cmd_2 = "cat " + outfile_1 + " | cut -d ',' -f 2,5 > " + outfile_2
	print cmd_1
	os.system(cmd_1)
	print cmd_2
	os.system(cmd_2)
sys.exit(0)
EOF
	chmod 755 $_t033_subfunc;


#	_t033_field_name_list="process_id thread_id file_obj full_path address";
	_t033_field_name_list="process_id thread_id file_obj full_path";
	for _field_name in $_t033_field_name_list; do
		export _field_name;
		_inconf=${_outfile_prefix_032}.${_field_name}.out;
		echo "[$_tid] processing $_field_name with $_inconf ...";
		_discovery_dir="${_tid}.discovery.${_field_name}";
		mkdir $_discovery_dir;
		(cd $_discovery_dir; cat ../$_inconf | ../$_t033_subfunc;)
	done


} # _func_t033()




_func_clear_workspace()
{
	rm .tmp.*
}




############################
##
## main() execution point ##
##
############################




_func_fake_init()
{
	_outfile_011="T011.msn_filesrvr.out";
	export _outfile_011;

	_outfile_prefix_032="T032.msn_filesrvr.fld_list";
	export _outfile_prefix_032;
}




tstamp;
_ts_whole_1=$(tstamp-e);


#_func_fake_init;
_func_t010;
_func_t011;
#_func_t020;
_func_t021;
_func_t022;
_func_t031;
_func_t032;
_func_t033;
#_func_clear_workspace;


tstamp;
_ts_whole_2=$(tstamp-e);
echo "#>> Elapsed time (whole process): $(expr $_ts_whole_2 - $_ts_whole_1) seconds";




