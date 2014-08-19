
# $ cat mlt.L2_sys_io.tlog | grep "$_target_disk" | awk '{ print tstamp_a tstamp_b r_kbps w_kbps r_await w_await }' > io.log
io_log_file = 'io.log';
num_of_samples = 10;

d <- read.table(header=T, io_log_file);

min_offset = 2
max_offset = 1
r_await_min <- unique(sort(d$r_await, decreasing=F))[min_offset:(min_offset+num_of_samples-1)]; # [2:6]
w_await_min <- unique(sort(d$w_await, decreasing=F))[min_offset:(min_offset+num_of_samples-1)]; # [2:6]
r_await_max <- unique(sort(d$r_await, decreasing=T))[max_offset:(max_offset+num_of_samples-1)]; # [1:5]
w_await_max <- unique(sort(d$w_await, decreasing=T))[max_offset:(max_offset+num_of_samples-1)]; # [1:5]

j = 0;
for (i in 1:num_of_samples) {
	target_time <- d$tstamp_b[d$r_await == r_await_min[i]][1];
	print (target_time);
	write(paste("grep ", target_time, " $_btl >> p1.blktr.r_await.", j, ".log", sep=""), file="gen_p1_data.r_await.sh", append=T);
	j = j + 1;
}
for (i in 1:num_of_samples) {
	target_time <- d$tstamp_b[d$r_await == r_await_max[i]][1];
	print (target_time);
	write(paste("grep ", target_time, " $_btl >> p1.blktr.r_await.", j, ".log", sep=""), file="gen_p1_data.r_await.sh", append=T);
	j = j + 1;
}

j = 0;
for (i in 1:num_of_samples) {
	target_time <- d$tstamp_b[d$w_await == w_await_min[i]][1];
	print (target_time);
	write(paste("grep ", target_time, " $_btl >> p1.blktr.w_await.", j, ".log", sep=""), file="gen_p1_data.w_await.sh", append=T);
	j = j + 1;
}
for (i in 1:num_of_samples) {
	target_time <- d$tstamp_b[d$w_await == w_await_max[i]][1];
	print (target_time);
	write(paste("grep ", target_time, " $_btl >> p1.blktr.w_await.", j, ".log", sep=""), file="gen_p1_data.w_await.sh", append=T);
	j = j + 1;
}


min_offset = 2
max_offset = 1
r_kbps_min <- unique(sort(d$r_kbps, decreasing=F))[min_offset:(min_offset+num_of_samples-1)]; # [2:6]
w_kbps_min <- unique(sort(d$w_kbps, decreasing=F))[min_offset:(min_offset+num_of_samples-1)]; # [2:6]
r_kbps_max <- unique(sort(d$r_kbps, decreasing=T))[max_offset:(max_offset+num_of_samples-1)]; # [1:5]
w_kbps_max <- unique(sort(d$w_kbps, decreasing=T))[max_offset:(max_offset+num_of_samples-1)]; # [1:5]

j = 0;
for (i in 1:num_of_samples) {
	target_time <- d$tstamp_b[d$r_kbps == r_kbps_min[i]][1];
	print (target_time);
	write(paste("grep ", target_time, " $_btl >> p1.blktr.r_kbps.", j, ".log", sep=""), file="gen_p1_data.r_kbps.sh", append=T);
	j = j + 1;
}
for (i in 1:num_of_samples) {
	target_time <- d$tstamp_b[d$r_kbps == r_kbps_max[i]][1];
	print (target_time);
	write(paste("grep ", target_time, " $_btl >> p1.blktr.r_kbps.", j, ".log", sep=""), file="gen_p1_data.r_kbps.sh", append=T);
	j = j + 1;
}

j = 0;
for (i in 1:num_of_samples) {
	target_time <- d$tstamp_b[d$w_kbps == w_kbps_min[i]][1];
	print (target_time);
	write(paste("grep ", target_time, " $_btl >> p1.blktr.w_kbps.", j, ".log", sep=""), file="gen_p1_data.w_kbps.sh", append=T);
	j = j + 1;
}
for (i in 1:num_of_samples) {
	target_time <- d$tstamp_b[d$w_kbps == w_kbps_max[i]][1];
	print (target_time);
	write(paste("grep ", target_time, " $_btl >> p1.blktr.w_kbps.", j, ".log", sep=""), file="gen_p1_data.w_kbps.sh", append=T);
	j = j + 1;
}

