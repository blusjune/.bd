fname <- readline(prompt='data files to read [d.tab] ');
if (fname == "") {
	d <- read.table('d.tab', header=T);
} else {
	d <- read.table(fname, header=T);
}
cpu_idle_pct <- 100 - (d$cpu_usr_pct + d$cpu_sys_pct);
d <- cbind(d, cpu_idle_pct);
lat_max <- max(d$slat + d$clat);
cpu_max <- 100;


p7n.gwp.blrd.colors <- function(k) {
	        return (hsv(h=seq.int(from=70/100, to=1/100, length.out=k), s=.8));
}


p7n_plot_fiotest_result <- function(arg_y, arg_x, title="metrics", arg_ymax=0) {
	#p7n_plot_fiotest_result(arg_y=d$bandwidth, arg_x=c(1:6,12,24,48,96,192), title="bandwidth(kBps)");

	extend_y_coff = 1.0;
	fio_lty = 3;
	text_cex = 1;
	text_xoff = 0;
	text_yoff = max(arg_y) / 10;

	if (arg_ymax == 0) {
		arg_ymax = max(arg_y);
	}

	xypair <- cbind(arg_x,arg_y);
	plot(xypair, xlab="x", ylab="y", ylim=c(0,arg_ymax), lwd=2, type='l', lty=fio_lty, main=title, new=F);
	points(xypair, pch=10, cex=2, col=p7n.gwp.blrd.colors(length(arg_y)));
	# text(x=pos-text_xoff, y=text_yoff, labels=arg_x, cex=text_cex, xpd=T); # text(..., srt=0, pos=0);
}


par(mfcol=c(2,4));


xvec <- c(1:6, 12, 24, 48, 96, 192);
p7n_plot_fiotest_result(arg_y=d$bandwidth, arg_x=xvec, title="bandwidth(kBps)");
p7n_plot_fiotest_result(arg_y=d$iops, arg_x=xvec, title="IOPS");
p7n_plot_fiotest_result(arg_y=d$slat, arg_x=xvec, title="latency_submit(usec)", arg_ymax=lat_max);
p7n_plot_fiotest_result(arg_y=d$clat, arg_x=xvec, title="latency_complete(usec)", arg_ymax=lat_max);
p7n_plot_fiotest_result(arg_y=d$cpu_usr_pct, arg_x=xvec, title="cpu_time_usr(%)", arg_ymax=100);
p7n_plot_fiotest_result(arg_y=d$cpu_sys_pct, arg_x=xvec, title="cpu_time_sys(%)", arg_ymax=100);
p7n_plot_fiotest_result(arg_y=d$cpu_idle_pct, arg_x=xvec, title="cpu_time_idle(%)", arg_ymax=100);




