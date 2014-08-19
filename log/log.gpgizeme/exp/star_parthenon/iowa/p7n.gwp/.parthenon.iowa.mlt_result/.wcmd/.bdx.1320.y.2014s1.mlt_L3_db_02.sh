#!/bin/sh
#_author="Brian M. JUNG <brian.m.jung@gmail.com>";
#_ver=20140509_165139
#_ver=20140512_230504
#_ver=20140519_211144;




_datafile="mlt.L3_db_02_onlm.tlog";
_wcmd_01=".bpy.iowa.2014s1.mlt_L3_db_02.parse_data.py";
_wcmd_02=".rcmd.iowa.2014s1.mlt_L3_db_02.asys_010.r"
_cnf_01=".tmp.num_of_bufpool.txt";
_d01=".tmp.dat_preproc.01.txt";




cat $_datafile | $_wcmd_01 > $_d01




if [ ! -r $_d01 ]; then
	echo "#P7N.ERROR>> '$_d01' does not exist -- EXIT"
	exit 1;
fi
if [ -r $_cnf_01 ]; then
	_nobp="$(cat $_cnf_01)"; # number of buffer pools
else
	echo "#P7N.ERROR>> '$_cnf_01' does not exist -- EXIT"
	exit 1;
fi




_i=0;
while [ $_i -lt $_nobp ]; do
#	echo $_i
	#
	# create separate data files for each buffer pool
	_bpid_tag="bufpool_id_${_i}";
	_d02_per_bpid=".tmp.bpid_${_i}.txt";
	cat $_d01 | grep $_bpid_tag > $_d02_per_bpid;
	#
	# analyze the data (for each buffer pool)
	_DATAFILE_IN=$_d02_per_bpid export _DATAFILE_IN;
	echo -n "#P7N>> processing $_DATAFILE_IN ... ";
	R --silent -f $_wcmd_02 2>&1 > /dev/null;
	echo "completed";
	#
	# update loop variable
	_i=$(expr $_i + 1);
done




