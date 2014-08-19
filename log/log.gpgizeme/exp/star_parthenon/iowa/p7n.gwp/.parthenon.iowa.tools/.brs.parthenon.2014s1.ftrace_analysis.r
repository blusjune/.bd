#_ver=20140619_010943

dat_file <- readline(prompt="kernel profile result data file: [d.tab] ");
if (dat_file == "") {
	dat_file = 'd.tab';
}
d <- read.table(dat_file, header=T);
dd <- d;
d <- dd[c(-2,-4,-6,-8)];

d[with(d, order(-f_overhead_total)),];
d[with(d, order(-call_count)),];
d[with(d, order(-mean_us)),];

d_call_count <- d[with(d, order(-call_count)),];
d_mean <- d[with(d, order(-mean_us)),];
d_fot <- d[with(d, order(-f_overhead_total)),];


p7n.gwp.blrd.colors <- function(k) {
		return (hsv(h=seq.int(from=60/100, to=1/100, length.out=k), s=.4));
}


# vertical bar plot
mlt_ktr_plot_v <- function(dat, k=20) {
	text_cex = 1;
	text_xoff = .4;

	k=min(k, dim(dat)[1]);

	d_call_count_topk <- dat[with(dat, order(-call_count)),][1:k,];
	d_mean_topk <- dat[with(dat, order(-mean_us)),][1:k,];
	d_fot_topk <- dat[with(dat, order(-f_overhead_total)),][1:k,];
	
	ans <- readline(prompt="plot now? (call-count) ");
	if (ans != 'n') {
		dat = d_call_count_topk;
		text_yoff = max(dat$call_count) / 10;
		#barplot(dat$call_count, names.arg=dat$function_name, density=c(seq(50,10,length.out=dim(dat)[1])), main="call_count");
		bp <- barplot(dat$call_count, col=p7n.gwp.blrd.colors(dim(dat)[1]) , main="call_count");
		text(paste(dat$call_count, " : ", dat$function_name), cex=text_cex, x=bp-text_xoff, y=text_yoff, xpd=T, srt=90, pos=4)
	}
	
	ans <- readline(prompt="plot now? (average elapsed time - usec) ");
	if (ans != 'n') {
		dat = d_mean_topk;
		text_yoff = max(dat$mean_us) / 10;
		#barplot(dat$mean_us, names.arg=dat$function_name, density=c(seq(50,10,length.out=dim(dat)[1])), main="elapsed time mean");
		bp <- barplot(dat$mean_us, col=p7n.gwp.blrd.colors(dim(dat)[1]) , main="elapsed time mean (usec)");
		text(paste(dat$mean_us, " : ", dat$function_name), cex=text_cex, x=bp-text_xoff, y=text_yoff, xpd=T, srt=90, pos=4)
	}
	
	ans <- readline(prompt="plot now? (function overhead total) ");
	if (ans != 'n') {
		dat = d_fot_topk;
		text_yoff = max(dat$f_overhead_total) / 10;
		#barplot(dat$f_overhead_total, names.arg=dat$function_name, density=c(seq(50,10,length.out=dim(dat)[1])), main="function overhead total");
		bp <- barplot(dat$f_overhead_total, col=p7n.gwp.blrd.colors(dim(dat)[1]) , main="function overhead total");
		text(paste(dat$f_overhead_total, " : ", dat$function_name), cex=text_cex, x=bp-text_xoff, y=text_yoff, xpd=T, srt=90, pos=4)
	}
}


# horizontal bar plot
mlt_ktr_plot_h <- function(dat, k=20) {
	text_cex = 1;
	text_xoff = 0; # .4;

	k=min(k, dim(dat)[1]);

	d_call_count_topk <- dat[with(dat, order(-call_count)),][1:k,];
	d_mean_topk <- dat[with(dat, order(-mean_us)),][1:k,];
	d_fot_topk <- dat[with(dat, order(-f_overhead_total)),][1:k,];
	
	ans <- readline(prompt="plot now? (call-count) ");
	if (ans != 'n') {
		dat = d_call_count_topk;
		text_yoff = max(dat$call_count) / 10;
		#barplot(dat$call_count, names.arg=dat$function_name, density=c(seq(50,10,length.out=dim(dat)[1])), main="call_count");
		bp <- barplot(dat$call_count, col=p7n.gwp.blrd.colors(dim(dat)[1]) , horiz=T, main="call_count");
		text(paste(dat$call_count, " : ", dat$function_name), cex=text_cex, y=bp-text_xoff, x=text_yoff, xpd=T, srt=0, pos=4)
	}
	
	ans <- readline(prompt="plot now? (average elapsed time - usec) ");
	if (ans != 'n') {
		dat = d_mean_topk;
		text_yoff = max(dat$mean_us) / 10;
		#barplot(dat$mean_us, names.arg=dat$function_name, density=c(seq(50,10,length.out=dim(dat)[1])), main="elapsed time mean");
		bp <- barplot(dat$mean_us, col=p7n.gwp.blrd.colors(dim(dat)[1]) , horiz=T, main="elapsed time mean (usec)");
		text(paste(dat$mean_us, " : ", dat$function_name), cex=text_cex, y=bp-text_xoff, x=text_yoff, xpd=T, srt=0, pos=4)
	}
	
	ans <- readline(prompt="plot now? (function overhead total) ");
	if (ans != 'n') {
		dat = d_fot_topk;
		text_yoff = max(dat$f_overhead_total) / 10;
		#barplot(dat$f_overhead_total, names.arg=dat$function_name, density=c(seq(50,10,length.out=dim(dat)[1])), main="function overhead total");
		bp <- barplot(dat$f_overhead_total, col=p7n.gwp.blrd.colors(dim(dat)[1]) , horiz=T, main="function overhead total");
		text(paste(dat$f_overhead_total, " : ", dat$function_name), cex=text_cex, y=bp-text_xoff, x=text_yoff, xpd=T, srt=0, pos=4)
	}
}


mlt_ktr_plot_h(dat=d, k=30); 
