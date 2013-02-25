#!/bin/sh
##_ver=20130218_140415
##_ver=20130221_184531
##_ver=20130225_150004




## set $dir=/mnt/diskut/filebench_d

_tmpdir="30.tmp";			# temporary directory
_tlog_wloadgen=".tlog.wloadgen";	# testlog for workload generation
_tlog_iotrace=".tlog.iotrace";		# testlog for iotrace
_flag_iotrace_start="/tmp/.filebench_flag.iotrace.start";	# flag to make iotrace start
_tdir_root="tdir";			# test directory root

_filebench_wload_src="wloadsrc.f";	# workload file source
_filebench_wload_exe="wloadexe.f";	# workload file executable
_fb_wl_tgt_file=".tconf_wltgt.conf";	# filebench workload target conf. file

#echo "#>> _fb_wl_tgt_file is '$_fb_wl_tgt_file', and the contents is '$(cat $_fb_wl_tgt_file)'";
if [ -f $_fb_wl_tgt_file ]; then
	_conf_status="configured from file";
	_filebench_wload_src_target="$(cat $_fb_wl_tgt_file)";
fi
if [ "X$_filebench_wload_src_target" = "X" ]; then
	_conf_status="configured manually";
	#_filebench_wload_src_target="fileserver.f";
	#_filebench_wload_src_target="mongo.f"; # error-prone
	#_filebench_wload_src_target="netsfs.f";
	#_filebench_wload_src_target="networkfs.f";
	#_filebench_wload_src_target="oltp.f"; # error-prone
	#_filebench_wload_src_target="tpcso.f"; # error-prone
	#_filebench_wload_src_target="varmail.f";
	#_filebench_wload_src_target="videoserver.f";
	#_filebench_wload_src_target="webserver.f";
fi
echo "#>> _filebench_wload_src_target: '$_filebench_wload_src_target' ($_conf_status)";

_filebench_runntime_in_sec="60";
_filebench_waiting_for_iotrace="n";	# if 'y', filebench will not be started waiting for start of iotrace

_blktrace_opt_target_dev="-d /dev/sdd";




