#!/bin/sh

##bsc.iowa.analyze_blkparselog.sh
## : this script is the top management file
##   which executes the other required script files

##tstamp: 20121119_233356
##_ver=20130107_204032




_this_prog=$(basename $0);
. ..bhdr; echo "$_BHDR $_this_prog)";
_tstamp="$(tstamp)";
_cmd__extract_rawdata="bsc.iowa.extract_rawdata_from_blkparselog";
_cmd__mk_hitfreq_dist_table="bsc.iowa.mk_hitfreq_dist_table";
_print_help()
{
	echo "#>> $_this_prog <blkparse_output_log_file>";
	echo "#>> blkparse output log file name should be specified";
}
_workdir="iowa.$_tstamp";




if [ "X$1" != "X" ]; then
	if [ "X$1" = "X-h" -o "X$1" = "X--help" ]; then
		_print_help;
		exit 0;
	fi
	_tracefile="$1";
else
	if [ "X$_tracefile" = "X" ]; then
		read -p "#?? blkparse logfile: " _tracefile;
	fi
fi
echo "#>> OK, '$_tracefile' will be analyzed";




mkdir $_workdir;
( cd $_workdir;
	ln -s ../$_tracefile;
	
	$_cmd__extract_rawdata $_tracefile;
	
	_if=$_tracefile;
	_f_A_addr="$_if.A.addr"; ## All (read + write)
	_f_A_seek="$_if.A.seek"; ## All (read + write)
	_f_R_addr="$_if.R.addr"; ## Read
	_f_R_seek="$_if.R.seek"; ## Read
	_f_W_addr="$_if.W.addr"; ## Write
	_f_W_seek="$_if.W.seek"; ## Write
	

	## calculating hit freq for All (R/W) operations...
	mkdir anal.A.addr;
	( cd anal.A.addr;
		ln -s ../$_f_A_addr;
		$_cmd__mk_hitfreq_dist_table $_f_A_addr;
	)
	mkdir anal.A.seek;
	( cd anal.A.seek;
		ln -s ../$_f_A_seek;
		$_cmd__mk_hitfreq_dist_table $_f_A_seek;
	)

	
	## calculating hit freq for R operations...
	mkdir anal.R.addr;
	( cd anal.R.addr;
		ln -s ../$_f_R_addr;
		$_cmd__mk_hitfreq_dist_table $_f_R_addr;
	)
	mkdir anal.R.seek;
	( cd anal.R.seek;
		ln -s ../$_f_R_seek;
		$_cmd__mk_hitfreq_dist_table $_f_R_seek;
	)
	

	## calculating hit freq for W operations...
	mkdir anal.W.addr;
	( cd anal.W.addr;
		ln -s ../$_f_W_addr;
		$_cmd__mk_hitfreq_dist_table $_f_W_addr;
	)
	mkdir anal.W.seek;
	( cd anal.W.seek;
		ln -s ../$_f_W_seek;
		$_cmd__mk_hitfreq_dist_table $_f_W_seek;
	)
)
