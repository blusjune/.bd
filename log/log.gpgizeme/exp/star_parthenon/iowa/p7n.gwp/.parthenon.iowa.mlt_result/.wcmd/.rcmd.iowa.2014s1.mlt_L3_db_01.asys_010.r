#_author="Brian M. JUNG <brian.m.jung@gmail.com>";
#_ver=20140509_193734
#_ver=20140512_230604
#_ver=20140519_211144;




#sink('/dev/null');

datafile_in <- Sys.getenv("_DATAFILE_IN")

radix <- datafile_in;
radix <- gsub(pattern=".tmp.", replacement="", radix);
radix <- gsub(pattern=".txt", replacement="", radix);
#print (datafile_in)

d <- read.table(datafile_in)
colnames(d) <- c( "fname", "a_count", "r_count", "w_count", "r_bytes", "w_bytes",
"r_wait_sum", "r_wait_avg", "r_wait_max", "r_wait_min",
"w_wait_sum", "w_wait_avg", "w_wait_max", "w_wait_min");

opt1_horiz=F;
opt1_axes=T;
opt1_axname=T;
opt1_log_default="";
opt1_log_y="y";
opt1_col_read='#3388ff';
opt1_col_write='#ffaa33';

barplot_iocount <- function(d, opt_log=opt1_log_default) {
	barplot( rbind(as.double(d$r_count), as.double(d$w_count)),
		main="IO counts per DB file // TPC-C workload",
		legend.text = c("# of reads", "# of writes"),
		col=c(opt1_col_read, opt1_col_write),
		names.arg = d$fname, beside=T, log=opt_log,
		horiz=opt1_horiz, axes=opt1_axes, axisnames=opt1_axname
		);
}

barplot_iobytes <- function(d, opt_log=opt1_log_default) {
	barplot( rbind(as.double(d$r_bytes), as.double(d$w_bytes)),
		main="Bytes read/written per DB file // TPC-C workload",
		legend.text = c("bytes read", "bytes written"),
		col=c(opt1_col_read, opt1_col_write),
		names.arg = d$fname, beside=T, log=opt_log,
		horiz=opt1_horiz, axes=opt1_axes, axisnames=opt1_axname
		);
}

barplot_iowaittot <- function(d, opt_log=opt1_log_default) {
	barplot( rbind(as.double(d$r_wait_sum), as.double(d$w_wait_sum)),
		main="IO Wait time (total) per DB file // TPC-C workload",
		legend.text = c("total wait time for reads", "total wait time for writes"),
		col=c(opt1_col_read, opt1_col_write),
		names.arg = d$fname, beside=T, log=opt_log,
		horiz=opt1_horiz, axes=opt1_axes, axisnames=opt1_axname
		);
}

barplot_iowaitavg <- function(d, opt_log=opt1_log_default) {
	barplot( rbind(as.double(d$r_wait_avg), as.double(d$w_wait_avg)),
		main="IO Wait time (average) per DB file // TPC-C workload",
		legend.text = c("average wait time for reads", "average wait time for writes"),
		col=c(opt1_col_read, opt1_col_write),
		names.arg = d$fname, beside=T, log=opt_log,
		horiz=opt1_horiz, axes=opt1_axes, axisnames=opt1_axname
		);
}

img_w = 4096
img_h =  512

# y scale: normal
png(filename=paste("img.mlt_L3_db_01__iocount.", radix, ".png", sep=""), width=img_w, height=img_h, units="px")
barplot_iocount(d);
dev.off()

png(filename=paste("img.mlt_L3_db_01__iobytes.", radix, ".png", sep=""), width=img_w, height=img_h, units="px")
barplot_iobytes(d);
dev.off()

png(filename=paste("img.mlt_L3_db_01__iowaittot.", radix, ".png", sep=""), width=img_w, height=img_h, units="px")
barplot_iowaittot(d);
dev.off()

png(filename=paste("img.mlt_L3_db_01__iowaitavg.", radix, ".png", sep=""), width=img_w, height=img_h, units="px")
barplot_iowaitavg(d);
dev.off()

## y scale: log (but you will get 'error messages' from R if your data has negative value items)
#png(filename=paste("img.mlt_L3_db_01__iocount_log.", radix, ".png", sep=""), width=img_w, height=img_h, units="px")
#barplot_iocount(d, opt_log=opt1_log_y);
#dev.off()
#
#png(filename=paste("img.mlt_L3_db_01__iobytes_log.", radix, ".png", sep=""), width=img_w, height=img_h, units="px")
#barplot_iobytes(d, opt_log=opt1_log_y);
#dev.off()
#
#png(filename=paste("img.mlt_L3_db_01__iowaittot_log.", radix, ".png", sep=""), width=img_w, height=img_h, units="px")
#barplot_iowaittot(d, opt_log=opt1_log_y);
#dev.off()
#
#png(filename=paste("img.mlt_L3_db_01__iowaitavg_log.", radix, ".png", sep=""), width=img_w, height=img_h, units="px")
#barplot_iowaitavg(d, opt_log=opt1_log_y);
#dev.off()

#sink();




