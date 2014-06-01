# 20140429_103432




d.tpcc.1_of_3.xfs <- read.table('./L3_C018_1_of_3/m01-xfs/tpcc.p030.tp10s_trx1.jung');
d.tpcc.1_of_3.ext4 <- read.table('./L3_C018_1_of_3/m02-ext4/tpcc.p030.tp10s_trx1.jung');
d.tpcc.1_of_3.f2fs <- read.table('./L3_C018_1_of_3/m03-f2fs/tpcc.p030.tp10s_trx1.jung');

d.tpcc.2_of_3.xfs <- read.table('./L3_C018_2_of_3/m01-xfs/tpcc.p030.tp10s_trx1.jung');
d.tpcc.2_of_3.ext4 <- read.table('./L3_C018_2_of_3/m02-ext4/tpcc.p030.tp10s_trx1.jung');
d.tpcc.2_of_3.f2fs <- read.table('./L3_C018_2_of_3/m03-f2fs/tpcc.p030.tp10s_trx1.jung');

d.tpcc.3_of_3.xfs <- read.table('./L3_C018_3_of_3/m01-xfs/tpcc.p030.tp10s_trx1.jung');
d.tpcc.3_of_3.ext4 <- read.table('./L3_C018_3_of_3/m02-ext4/tpcc.p030.tp10s_trx1.jung');
d.tpcc.3_of_3.f2fs <- read.table('./L3_C018_3_of_3/m03-f2fs/tpcc.p030.tp10s_trx1.jung');




max_tpcc <- max(d.tpcc.1_of_3.xfs, d.tpcc.1_of_3.ext4, d.tpcc.1_of_3.f2fs, d.tpcc.2_of_3.xfs, d.tpcc.2_of_3.ext4, d.tpcc.2_of_3.f2fs, d.tpcc.3_of_3.xfs, d.tpcc.3_of_3.ext4, d.tpcc.3_of_3.f2fs);




par(mfrow=c(3,3));




d<-d.tpcc.1_of_3.xfs; plot.ts(d, main="TPC-C Performance\nTestCase: L3_C018_1_of_3 (lru_scan_depth=128)\nFileSystem: XFS", ylab="Tp10s", xlab="time (10-sec)", type='b');
abline(h=mean(unlist(d)), col='blue');
d<-d.tpcc.1_of_3.ext4; plot.ts(d, main="TPC-C Performance\nTestCase: L3_C018_1_of_3 (lru_scan_depth=128)\nFileSystem: Ext4", ylab="Tp10s", xlab="time (10-sec)", type='b');
abline(h=mean(unlist(d)), col='blue');
d<-d.tpcc.1_of_3.f2fs; plot.ts(d, main="TPC-C Performance\nTestCase: L3_C018_1_of_3 (lru_scan_depth=128)\nFileSystem: F2FS", ylab="Tp10s", xlab="time (10-sec)", type='b');
abline(h=mean(unlist(d)), col='blue');

d<-d.tpcc.2_of_3.xfs; plot.ts(d, main="TPC-C Performance\nTestCase: L3_C018_2_of_3 (lru_scan_depth=1024)\nFileSystem: XFS", ylab="Tp10s", xlab="time (10-sec)", type='b');
abline(h=mean(unlist(d)), col='blue');
d<-d.tpcc.2_of_3.ext4; plot.ts(d, main="TPC-C Performance\nTestCase: L3_C018_2_of_3 (lru_scan_depth=1024)\nFileSystem: Ext4", ylab="Tp10s", xlab="time (10-sec)", type='b');
abline(h=mean(unlist(d)), col='blue');
d<-d.tpcc.2_of_3.f2fs; plot.ts(d, main="TPC-C Performance\nTestCase: L3_C018_2_of_3 (lru_scan_depth=1024)\nFileSystem: F2FS", ylab="Tp10s", xlab="time (10-sec)", type='b');
abline(h=mean(unlist(d)), col='blue');

d<-d.tpcc.3_of_3.xfs; plot.ts(d, main="TPC-C Performance\nTestCase: L3_C018_3_of_3 (lru_scan_depth=2048)\nFileSystem: XFS", ylab="Tp10s", xlab="time (10-sec)", type='b');
abline(h=mean(unlist(d)), col='blue');
d<-d.tpcc.3_of_3.ext4; plot.ts(d, main="TPC-C Performance\nTestCase: L3_C018_3_of_3 (lru_scan_depth=2048)\nFileSystem: Ext4", ylab="Tp10s", xlab="time (10-sec)", type='b');
abline(h=mean(unlist(d)), col='blue');
d<-d.tpcc.3_of_3.f2fs; plot.ts(d, main="TPC-C Performance\nTestCase: L3_C018_3_of_3 (lru_scan_depth=2048)\nFileSystem: F2FS", ylab="Tp10s", xlab="time (10-sec)", type='b');
abline(h=mean(unlist(d)), col='blue');




readline(prompt="plot next?");




d<-d.tpcc.1_of_3.xfs; plot.ts(d, main="TPC-C Performance\nTestCase: L3_C018_1_of_3 (lru_scan_depth=128)\nFileSystem: XFS", ylab="Tp10s", xlab="time (10-sec)", type='b', ylim=c(0,max_tpcc));
abline(h=mean(unlist(d)), col='blue');
d<-d.tpcc.1_of_3.ext4; plot.ts(d, main="TPC-C Performance\nTestCase: L3_C018_1_of_3 (lru_scan_depth=128)\nFileSystem: Ext4", ylab="Tp10s", xlab="time (10-sec)", type='b', ylim=c(0,max_tpcc));
abline(h=mean(unlist(d)), col='blue');
d<-d.tpcc.1_of_3.f2fs; plot.ts(d, main="TPC-C Performance\nTestCase: L3_C018_1_of_3 (lru_scan_depth=128)\nFileSystem: F2FS", ylab="Tp10s", xlab="time (10-sec)", type='b', ylim=c(0,max_tpcc));
abline(h=mean(unlist(d)), col='blue');

d<-d.tpcc.2_of_3.xfs; plot.ts(d, main="TPC-C Performance\nTestCase: L3_C018_2_of_3 (lru_scan_depth=1024)\nFileSystem: XFS", ylab="Tp10s", xlab="time (10-sec)", type='b', ylim=c(0,max_tpcc));
abline(h=mean(unlist(d)), col='blue');
d<-d.tpcc.2_of_3.ext4; plot.ts(d, main="TPC-C Performance\nTestCase: L3_C018_2_of_3 (lru_scan_depth=1024)\nFileSystem: Ext4", ylab="Tp10s", xlab="time (10-sec)", type='b', ylim=c(0,max_tpcc));
abline(h=mean(unlist(d)), col='blue');
d<-d.tpcc.2_of_3.f2fs; plot.ts(d, main="TPC-C Performance\nTestCase: L3_C018_2_of_3 (lru_scan_depth=1024)\nFileSystem: F2FS", ylab="Tp10s", xlab="time (10-sec)", type='b', ylim=c(0,max_tpcc));
abline(h=mean(unlist(d)), col='blue');

d<-d.tpcc.3_of_3.xfs; plot.ts(d, main="TPC-C Performance\nTestCase: L3_C018_3_of_3 (lru_scan_depth=2048)\nFileSystem: XFS", ylab="Tp10s", xlab="time (10-sec)", type='b', ylim=c(0,max_tpcc));
abline(h=mean(unlist(d)), col='blue');
d<-d.tpcc.3_of_3.ext4; plot.ts(d, main="TPC-C Performance\nTestCase: L3_C018_3_of_3 (lru_scan_depth=2048)\nFileSystem: Ext4", ylab="Tp10s", xlab="time (10-sec)", type='b', ylim=c(0,max_tpcc));
abline(h=mean(unlist(d)), col='blue');
d<-d.tpcc.3_of_3.f2fs; plot.ts(d, main="TPC-C Performance\nTestCase: L3_C018_3_of_3 (lru_scan_depth=2048)\nFileSystem: F2FS", ylab="Tp10s", xlab="time (10-sec)", type='b', ylim=c(0,max_tpcc));
abline(h=mean(unlist(d)), col='blue');




