#!/bin/sh
##.bdx.0100.y.run_main_test.sh
##_ver=20130221_155606
##_ver=20130305_032931
##_ver=20130306_174929


_sio_percent=25;
_iow_size=100;
_prd_t1=1000;
_cmd=".bdx.0200.n.run_sub_test.sh";

echo "$_sio_percent" > .ioc_threshold_percent;
echo "$_iow_size" > .iow_size;
echo "$_prd_t1" > .prd_t1;

echo "SigIO_Threshold= ${_sio_percent} %; IOW_size= ${_iow_size} ; Periodicity_T1= ${_prd_t1}";

. $_cmd;
