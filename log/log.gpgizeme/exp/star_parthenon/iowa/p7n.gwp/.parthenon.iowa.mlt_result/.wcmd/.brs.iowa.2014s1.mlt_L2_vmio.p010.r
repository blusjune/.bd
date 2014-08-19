#!/usr/bin/env R
# _ver=20140613_191658
#

# cat mlt.L2_sys_io.tlog | grep $_target_disk > tla.l2_sys_io.p010.jung
# _nlines=$(cat mlt.L2_sys_vm.tlog | wc -l); _nlines=$(expr $_nlines - 2); cat mlt.L2_sys_vm.tlog | tail -${_nlines} > tla.l2_sys_vm.p010.jung

d_vm <- read.table('tla.l2_sys_vm.p010.sdb.jung');
d_io <- read.table('tla.l2_sys_io.p010.sdb.jung');
d_io <- d_io[c(-1,-3)];
colnames(d_vm) <- c("tstamp_a", "tstamp_b", "prc_r", "prc_b", "mem_swpd", "mem_free", "mem_buff", "mem_cache", "swp_si", "swp_so", "io_bi", "io_bo", "sys_in", "sys_cs", "cpu_us", "cpu_sy", "cpu_id", "cpu_wa");
colnames(d_io) <- c("tstamp_b", "r_rqmps", "w_rqmps", "r_rps", "w_rps", "r_kBps", "w_kBps", "avgrq_sz", "avgqu_sz", "await", "r_await", "w_await", "svctm", "pct_util");
d_vmio <- merge(x=d_vm, y=d_io, by="tstamp_b");

