#!/bin/sh
#_ver=20140614_143438




. .parthenon.cf;




if [ ! -d $_p7n_LmCnnn_dir_aux ]; then
	mkdir $_p7n_LmCnnn_dir_aux;
fi




(cd $_dir_aux;

cat > $_bdx_0550_file_gwp_summary_min << EOF_GWP_SUMMARY_MIN
average_iosize  __r  bytes  0
average_iosize  __w  bytes  0
average_seek_dist_per_io  __a  bytes  0
average_seek_dist_per_io  __r  bytes  0
average_seek_dist_per_io  __w  bytes  0
io_skewness_80  __a  (top_k_addr=min/total_addr=min)  0
io_skewness_50  __a  (top_k_addr=min/total_addr=min)  0
io_skewness_20  __a  (top_k_addr=min/total_addr=min)  0
io_skewness_80  __r  (top_k_addr=min/total_addr=min)  0
io_skewness_50  __r  (top_k_addr=min/total_addr=min)  0
io_skewness_20  __r  (top_k_addr=min/total_addr=min)  0
io_skewness_80  __w  (top_k_addr=min/total_addr=min)  0
io_skewness_50  __w  (top_k_addr=min/total_addr=min)  0
io_skewness_20  __w  (top_k_addr=min/total_addr=min)  0
iocount  __a  ios  0
iocount  __r  ios  0
iocount  __w  ios  0
iocount  __n  ios  0
iocount  __rwratio  (read/write)  0.0000000001
iocount  __rwratio_log10  log10(read/write)  -10 
ioamount  __a  bytes  0
ioamount  __r  bytes  0
ioamount  __w  bytes  0
ioamount  __n  bytes  0
ioamount  __rwratio  (read/write)  0.0000000001
ioamount  __rwratio_log10  log10(read/write)  -10 
io_interval_mean  __a  seconds  0
io_interval_mean  __r  seconds  0
io_interval_mean  __w  seconds  0
io_interval_mean  __n  seconds  NA  
io_interval_sd  __a  seconds  0
io_interval_sd  __r  seconds  0
io_interval_sd  __w  seconds  0
io_interval_sd  __n  seconds  NA  
EOF_GWP_SUMMARY_MIN

) # cd $_dir_aux;




