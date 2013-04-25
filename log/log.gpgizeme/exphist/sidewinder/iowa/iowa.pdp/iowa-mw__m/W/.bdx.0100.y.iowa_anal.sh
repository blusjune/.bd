#!/bin/sh
#./W/.bdx.0100.y.iowa_anal.sh
#_ver=20130424_001228




#_target="msnfs"
#_sig_ioc_percentage="25"
#_iomw_sz_in_minute="30"
#_prd_t1_in_minute="1"
. ../.iowa_anal.conf




_iowa_anal_cmd="bsc.iowa.lsp.anal_s0010";
_iomw_sz="$(expr 60000000 \* $_iomw_sz_in_minute)";
_prd_t1="$(expr 60000000 \* $_prd_t1_in_minute)";

_file_010="f010.T022.${_target}.W.out";
_file_020="f020.iowa_anal_s0010.in";
_file_030="f030.iowa_anal_s0010.out";
_file_040="f040.iomw_acs_cnt.sorted_by_acs_cnt.plot.in";

cat $_file_010 | awk '{ print $5, ",", $14}' > $_file_020
cat $_file_020 | $_iowa_anal_cmd -c $_sig_ioc_percentage -w $_iomw_sz -p $_prd_t1 > $_file_030
cat $_file_030 | grep __list__iomw_acs_cnt | awk '{ print $9, $3, $6 }' | sort -n > $_file_040




