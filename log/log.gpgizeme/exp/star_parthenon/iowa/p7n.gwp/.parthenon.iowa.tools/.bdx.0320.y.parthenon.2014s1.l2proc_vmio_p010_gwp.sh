#!/bin/sh
#_ver=20140616_225104


. .parthenon.cf;


_target_disk=$_p7n_LmCnnn_target_disk;
_target_tag=$_p7n_LmCnnn_target_tag;
_rcmd_file=$_bdx_0320_file_rcmd_gwp_vmio;

_tlog_io_list=$(find $_p7n_LmCnnn_root_dir -name "$_mlt_tlog_l2_sys_io" | grep $_p7n_LmCnnn_find_cond_1 | grep $_target_tag);
_root_path=$(pwd);
for _i in $_tlog_io_list; do
	_dir=$(dirname $_i);
	(cd $_dir;

	 	cat $_mlt_tlog_l2_sys_io | grep $_target_disk > $_tla_p010_l2_sys_io;

	 	_nlines=$(cat $_mlt_tlog_l2_sys_vm | wc -l);
		_nlines=$(expr $_nlines - 2);
		cat $_mlt_tlog_l2_sys_vm | tail -${_nlines} > $_tla_p010_l2_sys_vm;

		echo "

d_vm <- read.table('$_tla_p010_l2_sys_vm');
d_io <- read.table('$_tla_p010_l2_sys_io');
d_io <- d_io[c(-1,-3)];
colnames(d_vm) <- c('tstamp_a', 'tstamp_b', 'prc_r', 'prc_b', 'mem_swpd', 'mem_free', 'mem_buff', 'mem_cache', 'swp_si', 'swp_so', 'io_bi', 'io_bo', 'sys_in', 'sys_cs', 'cpu_us', 'cpu_sy', 'cpu_id', 'cpu_wa');
colnames(d_io) <- c('tstamp_b', 'r_rqmps', 'w_rqmps', 'r_rps', 'w_rps', 'r_kBps', 'w_kBps', 'avgrq_sz', 'avgqu_sz', 'await', 'r_await', 'w_await', 'svctm', 'pct_util');
d_vmio <- merge(x=d_vm, y=d_io, by='tstamp_b');
d <- d_vmio;

d.avg <- data.frame(
cpu_us = mean(d\$cpu_us),
cpu_sy = mean(d\$cpu_sy),
cpu_id = mean(d\$cpu_id),
cpu_wa = mean(d\$cpu_wa),
cpu_ussy = mean(d\$cpu_us + d\$cpu_sy),
cpu_waid = mean(d\$cpu_wa + d\$cpu_id),
pct_util = mean(d\$pct_util),
io_bi = mean(d\$io_bi),
io_bo = mean(d\$io_bo),
r_rps = mean(d\$r_rps),
w_rps = mean(d\$w_rps),
r_kbps = mean(d\$r_kBps),
w_kbps = mean(d\$w_kBps),
rq_sz = mean(d\$avgrq_sz),
qu_sz = mean(d\$avgqu_sz),
r_await = mean(d\$r_await),
w_await = mean(d\$w_await)
);

d.sd <- data.frame(
cpu_us = sd(d\$cpu_us),
cpu_sy = sd(d\$cpu_sy),
cpu_id = sd(d\$cpu_id),
cpu_wa = sd(d\$cpu_wa),
cpu_ussy = sd(d\$cpu_us + d\$cpu_sy),
cpu_waid = sd(d\$cpu_wa + d\$cpu_id),
pct_util = sd(d\$pct_util),
io_bi = sd(d\$io_bi),
io_bo = sd(d\$io_bo),
r_rps = sd(d\$r_rps),
w_rps = sd(d\$w_rps),
r_kbps = sd(d\$r_kBps),
w_kbps = sd(d\$w_kBps),
rq_sz = sd(d\$avgrq_sz),
qu_sz = sd(d\$avgqu_sz),
r_await = sd(d\$r_await),
w_await = sd(d\$w_await)
);











#write.table(df, file='df.txt', append=T);

		 ${_root_path}/${_rcmd_file};

		" >> ${_rcmd_file};





	)
done




