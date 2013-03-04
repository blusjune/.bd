#!/bin/sh
##.bdx.0100.n.run_sub_test.sh
##_ver=20130221_111511


_tstamp="$(tstamp)";
_tdir="tdir/${_tstamp}";
_cf_ioc_percent_file=".ioc_threshold_percent";
_cf_iow_size_file=".iow_size";
_cf_prd_t1=".prd_t1";

if [ ! -f $_cf_ioc_percent_file ]; then
	echo "#>> ERROR: '$_cf_ioc_percent_file' does not exist -- EXIT";
	exit 1;
fi
if [ ! -f $_cf_iow_size_file ]; then
	echo "#>> ERROR: '$_cf_iow_size_file' does not exist -- EXIT";
	exit 1;
fi
if [ ! -f $_cf_prd_t1 ]; then
	echo "#>> ERROR: '$_cf_prd_t1' does not exist -- EXIT";
	exit 1;
fi


if [ ! -d $_tdir ]; then
	mkdir -p $_tdir;
fi


..ts
_ioc_percent="$(cat $_cf_ioc_percent_file)";
_iow_size="$(cat $_cf_iow_size_file)";
_prd_t1="$(cat $_cf_prd_t1)";
_logfile="iowa.sigio_${_ioc_percent}.iowsz_${_iow_size}.t1_${_prd_t1}.log";
_infile=".tracelog.R.addr";
cat infile | bsc.iowa.lsp.sim.iox -c $_ioc_percent -w $_iow_size -p $_prd_t1 > $_tdir/$_logfile
..ts


_mkfile_per_tag()
{
	_fileout="__simout.sigio_${_ioc_percent}.iowsz_${_iow_size}.t1_${_prd_t1}.${_tag}.log";
	cat $_tdir/$_logfile | grep $_tag > $_tdir/$_fileout;
}


_tag="__list__addr_hit_tstamp__"; _mkfile_per_tag;
_tag="__cdst__hits_per_addr__"; _mkfile_per_tag;
_tag="__cdst__addrs_per_hitnum__"; _mkfile_per_tag;
_tag="__valu__sig__"; _mkfile_per_tag;
_tag="__list__hitnum_and_addrs__"; _mkfile_per_tag;
_tag="__list__sig_hitnum_and_addrs__"; _mkfile_per_tag;
_tag="__cdst__addr_hit_interval__"; _mkfile_per_tag;
_tag="__list__periodicity_metric__"; _mkfile_per_tag;


