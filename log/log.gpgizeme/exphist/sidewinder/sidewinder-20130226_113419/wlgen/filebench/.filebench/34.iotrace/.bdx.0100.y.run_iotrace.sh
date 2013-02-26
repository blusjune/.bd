#!/bin/sh
##.bdx.0100.y.run_iotrace.sh
##_ver=20130107_200141
##_ver=20130226_101432


#. ../20.conf/.tconf.sh
. ./.tconf.sh


_testid="$(cat ../${_tmpdir}/${_tlog_wloadgen})";
_tdir="${_tdir_root}/${_testid}";
if [ -d $_tdir_root ]; then
	if [ ! -d $_tdir ]; then
		mkdir $_tdir;
	fi
else
	echo "#>> ERROR: '$_tdir_root' does not exist -- EXIT";
	exit 1;
fi


#echo "#>> iotrace is ready to run [TestID:$_testid] -- Waiting for filebench-actual-run";
#while [ ! -f $_flag_iotrace_start ]; do
#	echo -n ".";
#	sleep 1;
#done


sleep 1;
echo "$_testid" > ../${_tmpdir}/${_tlog_iotrace};
(cd $_tdir; blktrace -a read -a write $_blktrace_opt_target_dev;)




#_bpob_file="bpob.$_testid"; # BPOB: BlkParse Output in a Binary format
#_bpot_file="bpot.$_testid"; # BPOT: BlkParse Output in a Text format
#blktrace $_blktrace_opt_target_dev -o - | blkparse -i - -d $_tdir/$_bpob_file > $_tdir/$_bpot_file
#blktrace $_blktrace_opt_target_dev -o - | blkparse -i - -d $_tdir/$_bpob_file




