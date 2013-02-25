#!/bin/sh
##.bdx.0100.y.run_wloadgen_filebench.sh
##_ver=20130219_103944
##_ver=20130225_234440


#. ../20.conf/.tconf.sh
. ./.tconf.sh


_tstamp="$(tstamp)";
echo "$_tstamp" > ../${_tmpdir}/${_tlog_wloadgen};


_tdir="${_tdir_root}/${_tstamp}";
if [ -d $_tdir_root ]; then
	mkdir $_tdir;
else
	echo "#>> ERROR: '$_tdir_root' does not exist -- EXIT";
	exit 1;
fi


##
## create symbolic link
if [ -f $_filebench_wload_src ]; then
	rm $_filebench_wload_src
fi
ln -s workloads/$_filebench_wload_src_target $_filebench_wload_src


##
## create executable workload file
cat $_filebench_wload_src > ${_tdir}/${_filebench_wload_exe};
echo "
stats command \"touch ${_flag_iotrace_start}\"
sleep 10
run $_filebench_runntime_in_sec
" >> ${_tdir}/${_filebench_wload_exe};


##
## function definition
_iotrace_start()
{
	echo "#>> start iotrace -- DireX[../34.iotrace/]";
	( cd ../34.iotrace; _BDX ) &
}
_iotrace_stop()
{
	rm ${_flag_iotrace_start};
	_direx_pid="$(lsof $_tdir | grep blktrace | awk '{print $2}')";
	echo "#>> stop iotrace -- kill -2 $_direx_pid";
	kill -2 $_direx_pid;
}


##
## execute iotrace before executing filebench
_iotrace_start;


##
## execute filebench to generate workload and to evaluate performance
echo "";
echo "----------------------------------------------------";
echo "#>> Ok, now start workload generation [TestID:$_tstamp]";
_this_time=$(tstamp); echo "started: $_this_time"; touch ${_tdir}/time_bgns_${_this_time};
echo "----------------------------------------------------";
filebench -f ${_tdir}/${_filebench_wload_exe}; _iotrace_stop;
echo "----------------------------------------------------";
_this_time=$(tstamp); echo "finished: $_this_time"; touch ${_tdir}/time_ends_${_this_time};
echo "#>> workload generation completed (STOP iotrace now)";
echo "----------------------------------------------------";




