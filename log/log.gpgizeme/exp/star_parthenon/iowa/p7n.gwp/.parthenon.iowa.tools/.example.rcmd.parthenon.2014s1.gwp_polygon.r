



#
#d <- list();
#i = 0;
#
#d[(i=i+1)] <- read.table('./L3_C019_1_of_5/m02-ext4/result-m/mlt.20140513_155140.star-m02m.L3_C019m.1_of_5.innodb_io_capacity.200/.gwp.d/p7n.l2.blk.20140613_111645.sdb.gwp_summary.txt');
#d[(i=i+1)] <- read.table('./L3_C019_2_of_5/m02-ext4/result-m/mlt.20140513_170413.star-m02m.L3_C019m.2_of_5.innodb_io_capacity.1000/.gwp.d/p7n.l2.blk.20140613_144154.sdb.gwp_summary.txt');
#d[(i=i+1)] <- read.table('./L3_C019_3_of_5/m02-ext4/result-m/mlt.20140513_181640.star-m02m.L3_C019m.3_of_5.innodb_io_capacity.10000/.gwp.d/p7n.l2.blk.20140613_175609.sdb.gwp_summary.txt');
#d[(i=i+1)] <- read.table('./L3_C019_4_of_5/m02-ext4/result-m/mlt.20140513_192819.star-m02m.L3_C019m.4_of_5.innodb_io_capacity.100000/.gwp.d/p7n.l2.blk.20140613_210900.sdb.gwp_summary.txt');
#d[(i=i+1)] <- read.table('./L3_C019_5_of_5/m02-ext4/result-m/mlt.20140513_204000.star-m02m.L3_C019m.5_of_5.innodb_io_capacity.1000000/.gwp.d/p7n.l2.blk.20140614_002338.sdb.gwp_summary.txt');
#
#d[(i=i+1)] <- read.table('./L3_C019_1_of_5/m03-f2fs/result-m/mlt.20140515_132608.star-m03m.L3_C019m.1_of_5.innodb_io_capacity.200/.gwp.d/p7n.l2.blk.20140613_234952.sdb.gwp_summary.txt');
#d[(i=i+1)] <- read.table('./L3_C019_2_of_5/m03-f2fs/result-m/mlt.20140515_144028.star-m03m.L3_C019m.2_of_5.innodb_io_capacity.1000/.gwp.d/p7n.l2.blk.20140614_045830.sdb.gwp_summary.txt');
#d[(i=i+1)] <- read.table('./L3_C019_3_of_5/m03-f2fs/result-m/mlt.20140515_155349.star-m03m.L3_C019m.3_of_5.innodb_io_capacity.10000/.gwp.d/p7n.l2.blk.20140614_045831.sdb.gwp_summary.txt');
#d[(i=i+1)] <- read.table('./L3_C019_4_of_5/m03-f2fs/result-m/mlt.20140515_170700.star-m03m.L3_C019m.4_of_5.innodb_io_capacity.100000/.gwp.d/p7n.l2.blk.20140614_045831.sdb.gwp_summary.txt');
#d[(i=i+1)] <- read.table('./L3_C019_5_of_5/m03-f2fs/result-m/mlt.20140515_182139.star-m03m.L3_C019m.5_of_5.innodb_io_capacity.1000000/.gwp.d/p7n.l2.blk.20140614_050112.sdb.gwp_summary.txt');
#
#d[(i=i+1)] <- read.table('/x/lib/p7n.l2.blk.0_min.sdb.gwp_summary.txt');
#last_i = i;
#
#da_ext4 <- d[last_i];
#for (j in 1:5) {
#	da_ext4 <- rbind(da_ext4$V4, d[j]$V4);
#}
#
#da_f2fs <- d[last_i];
#for (j in 6:10) {
#	da_f2fs <- rbind(da_f2fs$V4, d[j]$V4);
#}
#
#col_names <- paste(d[1]$V1, d[1]$V2, sep="");
#




d1 <- read.table('./L3_C019_1_of_5/m02-ext4/result-m/mlt.20140513_155140.star-m02m.L3_C019m.1_of_5.innodb_io_capacity.200/.gwp.d/p7n.l2.blk.20140613_111645.sdb.gwp_summary.txt');
d2 <- read.table('./L3_C019_2_of_5/m02-ext4/result-m/mlt.20140513_170413.star-m02m.L3_C019m.2_of_5.innodb_io_capacity.1000/.gwp.d/p7n.l2.blk.20140613_144154.sdb.gwp_summary.txt');
d3 <- read.table('./L3_C019_3_of_5/m02-ext4/result-m/mlt.20140513_181640.star-m02m.L3_C019m.3_of_5.innodb_io_capacity.10000/.gwp.d/p7n.l2.blk.20140613_175609.sdb.gwp_summary.txt');
d4 <- read.table('./L3_C019_4_of_5/m02-ext4/result-m/mlt.20140513_192819.star-m02m.L3_C019m.4_of_5.innodb_io_capacity.100000/.gwp.d/p7n.l2.blk.20140613_210900.sdb.gwp_summary.txt');
d5 <- read.table('./L3_C019_5_of_5/m02-ext4/result-m/mlt.20140513_204000.star-m02m.L3_C019m.5_of_5.innodb_io_capacity.1000000/.gwp.d/p7n.l2.blk.20140614_002338.sdb.gwp_summary.txt');

#d6 <- read.table('./L3_C019_1_of_5/m03-f2fs/result-m/mlt.20140515_132608.star-m03m.L3_C019m.1_of_5.innodb_io_capacity.200/.gwp.d/p7n.l2.blk.20140613_234952.sdb.gwp_summary.txt');
#d7 <- read.table('./L3_C019_2_of_5/m03-f2fs/result-m/mlt.20140515_144028.star-m03m.L3_C019m.2_of_5.innodb_io_capacity.1000/.gwp.d/p7n.l2.blk.20140614_045830.sdb.gwp_summary.txt');
#d8 <- read.table('./L3_C019_3_of_5/m03-f2fs/result-m/mlt.20140515_155349.star-m03m.L3_C019m.3_of_5.innodb_io_capacity.10000/.gwp.d/p7n.l2.blk.20140614_045831.sdb.gwp_summary.txt');
#d9 <- read.table('./L3_C019_4_of_5/m03-f2fs/result-m/mlt.20140515_170700.star-m03m.L3_C019m.4_of_5.innodb_io_capacity.100000/.gwp.d/p7n.l2.blk.20140614_045831.sdb.gwp_summary.txt');
#d10 <- read.table('./L3_C019_5_of_5/m03-f2fs/result-m/mlt.20140515_182139.star-m03m.L3_C019m.5_of_5.innodb_io_capacity.1000000/.gwp.d/p7n.l2.blk.20140614_050112.sdb.gwp_summary.txt');

d0 <- read.table('/x/lib/p7n.l2.blk.0_min.sdb.gwp_summary.txt');

d_ext4 <- rbind(d0$V4, d1$V4, d2$V4, d3$V4, d4$V4, d5$V4);
#d_f2fs <- rbind(d0$V4, d6$V4, d7$V4, d8$V4, d9$V4, d10$V4);

col_names <- paste(d1$V1, d1$V2, sep="");




colnames(d_ext4) <- col_names;
#colnames(d_f2fs) <- col_names;
df_ext4 <- data.frame(d_ext4);
#df_f2fs <- data.frame(d_f2fs);
pcol_vec_ext4 <- c('gray', 'blue', 'darkgreen', 'red', 'orange', 'green');
#pcol_vec_f2fs <- c('gray', 'blue', 'darkgreen', 'green', 'orange', 'red');




loc_xfs = 1;
loc_ext4 = 2;
loc_f2fs = 3;
num_of_filesystems = 3;
tpmc <- read.table('dat.tpmc.txt');
rlen_tpmc <- dim(tpmc)[1]

tpmc_xfs <- tpmc[c((1:rlen_tpmc %% num_of_filesystems) == loc_xfs),]$V2
tpmc_ext4 <- tpmc[c((1:rlen_tpmc %% num_of_filesystems) == loc_ext4),]$V2
tpmc_f2fs <- tpmc[c((1:rlen_tpmc %% num_of_filesystems) == loc_f2fs),]$V2




source('/x/lib/.rlib.p7n.gwp.r');
p7n_gwp_polygon_ad0 <- function(arg_df, arg_pcol, arg_axislabcol='violet') {
	p7n_gwp_polygon(arg_df[c(-3, -6, -7, -8, -10, -11, -13, -14, -(15:18), -20, -(21:24), -26, -27, -30, -31, -34)], maxmin=F, pcol=arg_pcol, axistype=3, axislabcol=arg_axislabcol, plwd=3, plty=1)
}




par(mfrow=c(1,2));

tpmc_ext4_max = max(tpmc_ext4);
text_yoff = tpmc_ext4_max / 20;
ylim_ext4 = tpmc_ext4_max * 1.3;
if (readline(prompt="GWP Polygon for Ext4?") != 'n') {
	p7n_gwp_polygon_ad0(df_ext4, arg_pcol=pcol_vec_ext4);
	bp <- barplot(tpmc_ext4, col=pcol_vec_ext4[2:length(pcol_vec_ext4)], ylim=c(0,ylim_ext4));
	text(bp, tpmc_ext4 + text_yoff, tpmc_ext4);
}

#tpmc_f2fs_max = max(tpmc_f2fs);
#text_yoff = tpmc_f2fs_max / 20;
#ylim_f2fs = tpmc_f2fs_max * 1.3;
#if (readline(prompt="GWP Polygon for F2FS?") != 'n') {
#	p7n_gwp_polygon_ad0(df_f2fs, arg_pcol=pcol_vec_f2fs);
#	bp <- barplot(tpmc_f2fs, col=pcol_vec_f2fs[2:length(pcol_vec_f2fs)], ylim=c(0,ylim_f2fs));
#	text(bp, tpmc_f2fs + text_yoff, tpmc_f2fs);
#}




#da <- rbind(d1$V4, d2$V4, d3$V4);
#col_len = dim(d1)[1];
#dmin <- vector(); for (i in 1:col_len) { dmin[i] <- min(da[i], na.rm=T) }
#dmax <- vector(); for (i in 1:col_len) { dmax[i] <- max(da[i], na.rm=T) }
