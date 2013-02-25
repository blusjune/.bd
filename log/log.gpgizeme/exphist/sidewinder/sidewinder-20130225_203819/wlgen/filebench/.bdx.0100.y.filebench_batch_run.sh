#!/bin/sh
##.bdx.0100.y.run_fb_8tests.sh
##_ver="20130225_145612"
##/x/var/iowa/sidewinder/wlgen/filebench


_proc_count=0;
_target_wlgen_proc()
{
	_proc_count=`expr $_proc_count + 1`;
	_wl_tgt_file=".tconf_wltgt.conf";	# filebench workload target conf. file
	(cd /mnt/diskut/filebench_d/; rm -fr *)
	echo "#>> [$_proc_count] processing '$_target' ...";
	(cd .filebench; echo "$_target" > 20.conf/$_wl_tgt_file; _BDX)
}


_target="fileserver.f"; _target_wlgen_proc;
#_target="mongo.f"; _target_wlgen_proc;
_target="networkfs.f"; _target_wlgen_proc;
#_target="oltp.f"; _target_wlgen_proc;
#_target="tpcso.f"; _target_wlgen_proc;
_target="varmail.f"; _target_wlgen_proc;
_target="videoserver.f"; _target_wlgen_proc;
_target="webserver.f"; _target_wlgen_proc;


