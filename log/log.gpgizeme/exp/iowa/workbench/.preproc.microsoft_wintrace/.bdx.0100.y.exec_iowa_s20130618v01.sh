#!/bin/sh
#.bdx.0100.y.exec_iowa_s20130618v01.sh
#_ver=20130618_221714




_mw_size="1000000";
_iotrc_raw=".iotrc.txt";


_iotrc_pp_log="iotrc.pp.w1000ms";
_ioptn_tseries="ioptn.tseries";
_ioptn_cdist="ioptn.cdist";




#________________________________________________________________________________________________
#1847 | 0 | Rd | Rand | 42399211520 | 42399211520 | 4096 | xperf.exe | 6856 | 0 | C_/pagefile.sys
#________________________________________________________________________________________________
#   0 | 1 |  2 |    3 |           4 |           5 |    6 |         7 |    8 | 9 |              10
#




_ioptn__pname="${_ioptn_tseries}.pname"; _fld__ioptn__pname="7";	
_ioptn__fname="${_ioptn_tseries}.fname"; _fld__ioptn__fname="10";
_ioptn__iotype="${_ioptn_tseries}.iotype"; _fld__ioptn__iotype="2,3";
_ioptn__ioaddr="${_ioptn_tseries}.ioaddr"; _fld__ioptn__ioaddr="4";
_ioptn__iosize="${_ioptn_tseries}.iosize"; _fld__ioptn__iosize="6";
_ioptn__pname_fname="${_ioptn_tseries}.pname_fname"; _fld__ioptn__pname_fname="7,10";
_ioptn__pname_iotype="${_ioptn_tseries}.pname_iotype"; _fld__ioptn__pname_iotype="7,2,3";
_ioptn__fname_iotype="${_ioptn_tseries}.fname_iotype"; _fld__ioptn__fname_iotype="10,2,3";
_ioptn__iotype_iosize="${_ioptn_tseries}.iotype_iosize"; _fld__ioptn__iotype_iosize="2,3,6";
_ioptn__pname_iosize="${_ioptn_tseries}.pname_iosize"; _fld__ioptn__pname_iosize="7,6";
_ioptn__fname_iosize="${_ioptn_tseries}.fname_iosize"; _fld__ioptn__fname_iosize="10,6";

declare -A _ioptn;
_ioptn=([pname]="7" [fname]="10")
echo ${_ioptn[pname]}
echo ${_ioptn[fname]}
exit 0




echo "#>> cat $_iotrc_raw | bsc.iowa.lsp.preproc_s20130618v01 -w $_mw_size > $_iotrc_pp_log";
cat $_iotrc_raw | bsc.iowa.lsp.preproc_s20130618v01 -w $_mw_size > $_iotrc_pp_log




echo "#>> generating time-series data: $_ioptn__pname"; cat $_iotrc_pp_log | bsc.iowa.lsp.anal_s20130618v01 -f $_fld__ioptn__pname > $_ioptn__pname
echo "#>> generating time-series data: $_ioptn__fname"; cat $_iotrc_pp_log | bsc.iowa.lsp.anal_s20130618v01 -f $_fld__ioptn__fname > $_ioptn__fname
echo "#>> generating time-series data: $_ioptn__iotype"; cat $_iotrc_pp_log | bsc.iowa.lsp.anal_s20130618v01 -f $_fld__ioptn__iotype > $_ioptn__iotype
echo "#>> generating time-series data: $_ioptn__ioaddr"; cat $_iotrc_pp_log | bsc.iowa.lsp.anal_s20130618v01 -f $_fld__ioptn__ioaddr > $_ioptn__ioaddr
echo "#>> generating time-series data: $_ioptn__iosize"; cat $_iotrc_pp_log | bsc.iowa.lsp.anal_s20130618v01 -f $_fld__ioptn__iosize > $_ioptn__iosize
echo "#>> generating time-series data: $_ioptn__pname_fname"; cat $_iotrc_pp_log | bsc.iowa.lsp.anal_s20130618v01 -f $_fld__ioptn__pname_fname > $_ioptn__pname_fname
echo "#>> generating time-series data: $_ioptn__pname_iotype"; cat $_iotrc_pp_log | bsc.iowa.lsp.anal_s20130618v01 -f $_fld__ioptn__pname_iotype > $_ioptn__pname_iotype
echo "#>> generating time-series data: $_ioptn__fname_iotype"; cat $_iotrc_pp_log | bsc.iowa.lsp.anal_s20130618v01 -f $_fld__ioptn__fname_iotype > $_ioptn__fname_iotype
echo "#>> generating time-series data: $_ioptn__iotype_iosize"; cat $_iotrc_pp_log | bsc.iowa.lsp.anal_s20130618v01 -f $_fld__ioptn__iotype_iosize > $_ioptn__iotype_iosize
echo "#>> generating time-series data: $_ioptn__pname_iosize"; cat $_iotrc_pp_log | bsc.iowa.lsp.anal_s20130618v01 -f $_fld__ioptn__pname_iosize > $_ioptn__pname_iosize
echo "#>> generating time-series data: $_ioptn__fname_iosize"; cat $_iotrc_pp_log | bsc.iowa.lsp.anal_s20130618v01 -f $_fld__ioptn__fname_iosize > $_ioptn__fname_iosize




_cal_cdst()
{
	# '_target' variable SHOULD be set properly
	if [ "X$_target" != "X" ]; then
		_fi="${_ioptn_tseries}.${_target}";   # time series
		_fo="${_ioptn_cdist}.${_target}";       # count distribution
		echo "#>> calculating count-distribution: $_target";
		cat $_fi | awk '{ print $5 }' | sort | uniq -c | sort > $_fo;
	else
		echo "ERROR: '_target' variable SHOULD be set properly -- EXIT";
	fi
}
_target="pname"; _cal_cdst;
_target="fname"; _cal_cdst;
_target="iotype"; _cal_cdst;
_target="ioaddr"; _cal_cdst;
_target="iosize"; _cal_cdst;
_target="pname_fname"; _cal_cdst;
_target="pname_iotype"; _cal_cdst;
_target="fname_iotype"; _cal_cdst;
_target="iotype_iosize"; _cal_cdst;
_target="pname_iosize"; _cal_cdst;
_target="fname_iosize"; _cal_cdst;




