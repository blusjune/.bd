#!/usr/bin/env R




# assign column name to each field of blktr_p010 data
#mlt_blktr_p010_colnames <- function(d) {
#	colnames(d) <- c( "timestamp_z", "timestamp_a", "timestamp_b", "io_interval", "blk_opr", "req_type", "dev", "addr", "iosz", "pname", "cpucore", "ioseqnum", "pid", "rwbs", "_", "tag_iot", "tag_iosz_align", "tag_iosz_huge", "tag_iointv");
#}


# time series plot
#tsplot <- function(d, rec_start, rec_end, axis_y) {
#	plot(d[rec_start:rec_end,][c("timestamp_z", axis_y)], cex=.5, pch=1);
#}


#mlt_blktr_read_p010_data <- function(blktr_p010_log) {
#	if (blktr_p010_log == "") {
#		blktr_p010_log <- readline(prompt="Q1. blktr input file [blktr.??.p010.jung] ")
#	}
#	data_blktr <- readline(prompt="Q2. variable name to store blktr data [d.blktr.??] ")
#	assign(data_blktr, read.table(blktr_p010_log));
#	data_blktr <- read.table(blktr_p010_log);
#	mlt_blktr_p010_colnames(data_blktr);
#	return(data_blktr);
#}


#plot_analysis <- function(d, rec_start, rec_end, plot_ylim) {
#	readline("time-addr plot with tag_iosz_align");
#	plot(d[rec_start:rec_end,][c("timestamp_z", "addr")], col=ifelse(d[c("tag_iosz_align")] == "_IOSZ_ALIGN_N", "red", "blue"), cex=.5, pch=1, ylim=plot_ylim);
#	readline("time-addr plot with tag_iosz_huge");
#	plot(d[rec_start:rec_end,][c("timestamp_z", "addr")], col=ifelse(d[c("tag_iosz_huge")] == "_IOSZ_HUGE_Y", "red", "blue"), cex=.5, pch=1, ylim=plot_ylim);
#	readline("time-addr plot with pname");
#	plot(d[rec_start:rec_end,][c("timestamp_z", "addr")], col=ifelse(d[c("pname")] == "[mysqld]", "blue", "red"), cex=.5, pch=1, ylim=plot_ylim);
#}


#readline(prompt='>> Now you can use two functions');
#readline(prompt='>> tsplot(d, 1, 1000, "iosz");');
#readline(prompt='>> plot_analysis(d, 10000, 20000, c( 6400000, 6800000 ));');
#plot_analysis(d, 0, 20000, c( 0, 6800000 ));
#plot_analysis(d, 10000, 20000, c( 6400000, 6800000 ));

#colormap_pname <- data.frame(pname=c("[mysqld]", "[flush-8:32]", "[xfsaild/sdc1]", "[kworker/1:1]", "[kworker/1:2]"), color=heat.colors(5));
#colormap_rwbs <- data.frame(pname=c("R", "WS", "WBSM", "W", "WM"), color=topo.colors(5));
#par(mfrow=c(2,3)) # number of rows:2, number of columns: 3

#plot(d.blktr.m1$addr, cex=.3, col=colormap_pname$color[d.blktr.m1$pname], main="address - master 1", xlim=c(0, 4e+06), ylim=c(0,2e+09));
#plot(d.blktr.s1$addr, cex=.3, col=colormap_pname$color[d.blktr.s1$pname], main="address - slave 1", xlim=c(0, 4e+06), ylim=c(0,2e+09));
#plot(d.blktr.s2$addr, cex=.3, col=colormap_pname$color[d.blktr.s2$pname], main="address - slave 2", xlim=c(0, 4e+06), ylim=c(0,2e+09));
#plot(d.blktr.m1$iosz, cex=.3, col=colormap_pname$color[d.blktr.m1$pname], main="iosz - master 1", xlim=c(0, 4e+06));
#plot(d.blktr.s1$iosz, cex=.3, col=colormap_pname$color[d.blktr.s1$pname], main="iosz - slave 1", xlim=c(0, 4e+06));
#plot(d.blktr.s2$iosz, cex=.3, col=colormap_pname$color[d.blktr.s2$pname], main="iosz - slave 2", xlim=c(0, 4e+06));

#par(mfrow=c(3,1))
#plot(d.blktr.m1$addr, cex=.3, col=ifelse(d.blktr.m1$tag_iot == '_IOT_R', 'green', ifelse(d.blktr.m1$tag_iosz_align == '_IOSZ_ALIGN_Y', 'blue', 'red')), main="address accessed over time (m1)");
#plot(d.blktr.s1$addr, cex=.3, col=ifelse(d.blktr.s1$tag_iot == '_IOT_R', 'green', ifelse(d.blktr.s1$tag_iosz_align == '_IOSZ_ALIGN_Y', 'blue', 'red')), main="address accessed over time (m1)");
#plot(d.blktr.s2$addr, cex=.3, col=ifelse(d.blktr.s2$tag_iot == '_IOT_R', 'green', ifelse(d.blktr.s2$tag_iosz_align == '_IOSZ_ALIGN_Y', 'blue', 'red')), main="address accessed over time (m1)")

#if (readline(prompt="read blktr? [Y|n] ") != "n") {
#	blktrfile <- readline(prompt="blktr file name? [blktr.*.p010.jung] ");
#	d.blktr <- read.table(blktrfile);
#	colnames(d.blktr) <- c( "timestamp_z", "timestamp_a", "timestamp_b", "io_interval", "blk_opr", "req_type", "dev", "addr", "iosz", "pname", "cpucore", "ioseqnum", "pid", "rwbs", "_", "tag_iot", "tag_iosz_align", "tag_iosz_huge", "tag_iointv");
#}




## 20140425_112217
##
##	b@himembig:L3_C018_1_of_3_128 %2$ pwd
##	/opt/iowa/iowa.20140424_140116/L3_C018_1_of_3_128
##	
##	b@himembig:L3_C018_1_of_3_128 %2$ ls -alF
##	total 3620
##	drwxrwxr-x 5 b b   4096 Apr 25 11:06 ./
##	drwxrwxr-x 5 b b   4096 Apr 25 01:50 ../
##	lrwxrwxrwx 1 b b     34 Apr 24 15:55 .bdx.0100.y.proc_tpcc_result.sh -> ../.bdx.0100.y.proc_tpcc_result.sh*
##	-rwxr-xr-x 1 b b    348 Apr 24 17:07 .mv.sh*
##	-rw------- 1 b b   1230 Apr 24 16:12 .rhist.plot.r
##	lrwxrwxrwx 1 b b      7 Apr 24 14:31 1.xfs -> m01-xfs/
##	lrwxrwxrwx 1 b b      8 Apr 24 14:31 2.ext4 -> m02-ext4/
##	lrwxrwxrwx 1 b b      8 Apr 24 14:31 3.f2fs -> m03-f2fs/
##	lrwxrwxrwx 1 b b    106 Apr 25 10:57 blktr.1.xfs.m.sdb.p010.jung -> 1.xfs/result-m/mlt.20140423_075903.star-m01m.L3_C018m.1_of_3.innodb_lru_scan_depth.128/blktr.sdb.p010.jung
##	lrwxrwxrwx 1 b b    106 Apr 25 10:57 blktr.1.xfs.s.sdb.p010.jung -> 1.xfs/result-s/mlt.20140423_080042.star-m01s.L3_C018s.1_of_3.innodb_lru_scan_depth.128/blktr.sdb.p010.jung
##	lrwxrwxrwx 1 b b    107 Apr 25 10:58 blktr.2.ext4.m.sdb.p010.jung -> 2.ext4/result-m/mlt.20140423_080023.star-m02m.L3_C018m.1_of_3.innodb_lru_scan_depth.128/blktr.sdb.p010.jung
##	lrwxrwxrwx 1 b b    107 Apr 25 10:59 blktr.2.ext4.s.sdb.p010.jung -> 2.ext4/result-s/mlt.20140423_075839.star-m02s.L3_C018s.1_of_3.innodb_lru_scan_depth.128/blktr.sdb.p010.jung
##	lrwxrwxrwx 1 b b    107 Apr 25 10:59 blktr.3.f2fs.m.sdb.p010.jung -> 3.f2fs/result-m/mlt.20140423_091821.star-m03m.L3_C018m.1_of_3.innodb_lru_scan_depth.128/blktr.sdb.p010.jung
##	lrwxrwxrwx 1 b b    107 Apr 25 11:00 blktr.3.f2fs.s.sdb.p010.jung -> 3.f2fs/result-s/mlt.20140423_091658.star-m03s.L3_C018s.1_of_3.innodb_lru_scan_depth.128/blktr.sdb.p010.jung
##	-rw-rw-r-- 1 b b 610903 Apr 24 16:49 l2_sys_io.1.xfs.m.sdb.dat
##	-rw-rw-r-- 1 b b 610900 Apr 24 16:49 l2_sys_io.1.xfs.s.sdb.dat
##	-rw-rw-r-- 1 b b 610906 Apr 24 16:51 l2_sys_io.2.ext4.m.sdb.dat
##	-rw-rw-r-- 1 b b 610900 Apr 24 16:51 l2_sys_io.2.ext4.s.sdb.dat
##	-rw-rw-r-- 1 b b 610903 Apr 24 16:52 l2_sys_io.3.f2fs.m.sdb.dat
##	-rw-rw-r-- 1 b b 610900 Apr 24 16:52 l2_sys_io.3.f2fs.s.sdb.dat
##	drwxrwxr-x 4 b b    151 Apr 24 17:15 m01-xfs/
##	drwxrwxr-x 4 b b    151 Apr 24 15:28 m02-ext4/
##	drwxrwxr-x 4 b b   4096 Apr 24 15:27 m03-f2fs/




blktr_jung_hdr <- c(
"dummy",
"tstamp_z",
"tstamp_a",
"tstamp_b",
"tdiff",
"dev",
"core",
"ioseqnum",
"pid",
"blk_opr",
"rwbs",
"iot",
"addr",
"iosz",
"pname"
);


blktr_jung_plot_t01 <- function(d_blktr) {
	colnames(d_blktr) <- blktr_jung_hdr;
		plotmain=paste("LBA access pattern over time - ", readline(prompt="type the main title of this plot: "));
		plot(d_blktr$addr, cex=.3,
				col=ifelse(d_blktr$tag_iot == '_IOT_R', 'green',
					ifelse(d_blktr$tag_iosz_align == '_IOSZ_ALIGN_Y', 'blue', 'red')
					),
				main=plotmain
				);
}


blktr_jung_plot_t02 <- function(d_blktr) {

	d <- d_blktr;
	colnames(d) <- blktr_jung_hdr;

	xl <- d$tstamp_z;
	xr <- d$tstamp_z;
	yb <- d$addr;
	yt <- d$addr + d$iosz;

#	col__ <- "#dddddd";
#	col_q <- "#aaaaaa";
#	col_i <- "#888888";
#	col_d <- "#555555";
#	col_c <- "#ffcc00";

	col__ <- 'red';
	col_q <- 'green';
	col_i <- 'orange';
	col_d <- 'pink';
	col_c <- 'violet';

	if (readline(prompt="plot IO access pattern? [Y|n] ") != "n") {
		plotmain=paste("LBA access pattern over time - ", readline(prompt="type the main title of this plot: "));
		plot(y=d$addr, x=d$tstamp_z, main=plotmain, cex=.3,
#				pch=d$blk_opr,
				pch=0,
				col=ifelse(d$iot == 'R', '#cccccc',
					ifelse(d$iot == 'W', '#333333', 'green')
					)
				);
		readline(prompt="plot next? ");
		dlen <- dim(d)[1];


		for (i in 1:dlen) {
#			rect(xl, yb, xr, yt,
			rect(
				d[i,]$tstamp_z,
				d[i,]$addr,
				d[i+1,]$tstamp_z,
				d[i,]$addr + d[i,]$iosz,
					col=ifelse(d[i,]$blk_opr == 'Q', col_q,
						ifelse(d[i,]$blk_opr == 'I', col_i,
							ifelse(d[i,]$blk_opr == 'D', col_d,
								ifelse(d[i,]$blk_opr == 'C', col_c, col__)
								)
							)
						)
					);

		}

	}
}




# $_d <- read.table($_fname);
# colnames(${_d}) <- blktr_jung_hdr;
# blktr_jung_plot_t02($_d, 




