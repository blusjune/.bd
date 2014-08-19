#!/bin/sh
#_ver=20140520_201232




_blktr_log_list=$(find . -name "mlt.L2_sys_blk.tlog");
_d="$(pwd)/.data";




_disk_space_saving() # DSS: disk space saving
{
	_dss_cf="/tmp/.p7n.dss.cf";
	if [ -r $_dss_cf ]; then
		echo "#>> detected '$_dss_cf' file";
		_dss_cmd=$(cat $_dss_cf);
	else
		_dss_cmd="gzip";
		#_dss_cmd="bzip2";
		#_dss_cmd="rm -f";
	fi
	echo "#>> disk space saving command: '$_dss_cmd'";

	## contingency plan for small disk space
	$_dss_cmd $_btfile_list;
}




for _i in $_blktr_log_list; do
	_dir=$(dirname $_i);
	_file=$(basename $_i);
	(cd $_dir;
	 	echo $_dir;
		_btfile_list=$( ls -1 *.blktrace.* );
		for _btf in $_btfile_list; do
			_devid=$(echo $_btf | awk -F '.' '{ print $1 }')
			_cpuid=$(echo $_btf | awk -F '.' '{ print $3 }')
			_btt_out="btanal.${_devid}.${_cpuid}.btt";
			echo $_btt_out
			btt -i $_btf > $_btt_out;
#			btt -i $_btf -B ${_btt_out}.bno_plot > $_btt_out;
		done

		## contingency plan for small disk space
		_disk_space_saving;
	)
done




