#_ver=20140701_193059




d_tab_cpu=".mlt_idx.cpu";
d_tab_disk=".mlt_idx.disk";

ans <- readline(prompt=paste("R> Did you make the following files? ", d_tab_cpu, "(-u ALL)", d_tab_disk, "(-d)", " [Y|n] "));
if (ans == "n") {
	quit();	
}

d.cpu <- read.table(d_tab_cpu, header=T)
d.disk <- read.table(d_tab_disk, header=T)
d.all <- merge(x=d.cpu, y=d.disk, by='timestamp')
str(d.all);

p7n_asys_corr <- function(x1, x2, chunk_size, y_lim=c(-1.2, 1.2)) {
#	chunk_size=10;
#	x1 <- d.all$rd_sec.s;
#	x2 <- d.all$wr_sec.s;
	d.corr <- vector();
	xrange <- dim(d.all)[1];
	corr_plot_ymax <- 1.2;
	text_pos <- 4;
	text_cex <- 1.5;
	text_y_01 <- corr_plot_ymax * 0.97;
	i=0;
	for (begin in seq(1,xrange,chunk_size)) {
		i=i+1;
		corr.val = cor( x1[begin:(begin+chunk_size)], x2[begin:(begin+chunk_size)] );
		if (!is.na(corr.val)) {
			d.corr[i] <- corr.val;
		}
	}
	d.corr.mean <- mean(d.corr);
	d.corr.sd <- sd(d.corr);
#	plot.ts(d.corr, ylim=c((-1 * corr_plot_ymax), corr_plot_ymax));
	plot.ts(d.corr, ylim=y_lim);
	rect(xleft=1, xright=i, ybottom=(d.corr.mean - d.corr.sd), ytop=(d.corr.mean + d.corr.sd), density=5, col='green');
	text( x=1, pos=text_pos, y=text_y_01, col='black', cex=text_cex,
			labels=paste(
				"Corr (average, stdev) = (",
				as.character(round(d.corr.mean, digits=3)),
				",",
				as.character(round(d.corr.sd, digits=3)),
				")"
				) 
			);
	abline(h=d.corr.mean, col='darkgreen', lwd=2);
	abline(h=c(d.corr.mean + d.corr.sd, d.corr.mean - d.corr.sd), col='green');
	return (data.frame(corr=d.corr, corr_mean=d.corr.mean, corr_sd=d.corr.sd, chunk_size=chunk_size));
}
