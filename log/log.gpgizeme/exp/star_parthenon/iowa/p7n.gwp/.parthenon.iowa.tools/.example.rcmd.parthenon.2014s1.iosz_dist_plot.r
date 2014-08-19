## 20140427_144843

## Plot the IO size distribution (iosz)
##
## Two prerequisite source files:
##	.rcmd.blktr.r
##	.rcmd.iosz_dist_compute.r
##




par(mfrow=c(4,3))
k <- 10;
v_ylim <- 100;
v_ylab <- "Probability of occurrence (%)"
v_xlab <- "IO size (sector)"
cutline_1 <- 90;




tctag="\nXFS Master";
v_maintitle=paste("IO size distribution in percent; Top-K items sorted, K =", k, tctag);
barplot(d.blktr.xfs.m.iosz.table.norm_percent.sorted[1:k], ylim=c(0,v_ylim), ylab=v_ylab, xlab=v_xlab, main=v_maintitle, space=c(0,0));
points(d.blktr.xfs.m.iosz.table.norm_percent.sorted.cdf[1:k], ylim=c(0,v_ylim));
lines(d.blktr.xfs.m.iosz.table.norm_percent.sorted.cdf[1:k], ylim=c(0,v_ylim));
abline(h=c(cutline_1), col='red');

tctag="\nExt4 Master";
v_maintitle=paste("IO size distribution in percent; Top-K items sorted, K =", k, tctag);
barplot(d.blktr.f2fs.m.iosz.table.norm_percent.sorted[1:k], ylim=c(0,v_ylim), ylab=v_ylab, xlab=v_xlab, main=v_maintitle, space=c(0,0));
points(d.blktr.f2fs.m.iosz.table.norm_percent.sorted.cdf[1:k], ylim=c(0,v_ylim));
lines(d.blktr.f2fs.m.iosz.table.norm_percent.sorted.cdf[1:k], ylim=c(0,v_ylim));
abline(h=c(cutline_1), col='red');

tctag="\nF2FS Master";
v_maintitle=paste("IO size distribution in percent; Top-K items sorted, K =", k, tctag);
barplot(d.blktr.ext4.s.iosz.table.norm_percent.sorted[1:k], ylim=c(0,v_ylim), ylab=v_ylab, xlab=v_xlab, main=v_maintitle, space=c(0,0));
points(d.blktr.ext4.s.iosz.table.norm_percent.sorted.cdf[1:k], ylim=c(0,v_ylim));
lines(d.blktr.ext4.s.iosz.table.norm_percent.sorted.cdf[1:k], ylim=c(0,v_ylim));
abline(h=c(cutline_1), col='red');

tctag="\nXFS Slave";
v_maintitle=paste("IO size distribution in percent; Top-K items sorted, K =", k, tctag);
barplot(d.blktr.ext4.m.iosz.table.norm_percent.sorted[1:k], ylim=c(0,v_ylim), ylab=v_ylab, xlab=v_xlab, main=v_maintitle, space=c(0,0));
points(d.blktr.ext4.m.iosz.table.norm_percent.sorted.cdf[1:k], ylim=c(0,v_ylim));
lines(d.blktr.ext4.m.iosz.table.norm_percent.sorted.cdf[1:k], ylim=c(0,v_ylim));
abline(h=c(cutline_1), col='red');

tctag="\nExt4 Slave";
v_maintitle=paste("IO size distribution in percent; Top-K items sorted, K =", k, tctag);
barplot(d.blktr.xfs.s.iosz.table.norm_percent.sorted[1:k], ylim=c(0,v_ylim), ylab=v_ylab, xlab=v_xlab, main=v_maintitle, space=c(0,0));
points(d.blktr.xfs.s.iosz.table.norm_percent.sorted.cdf[1:k], ylim=c(0,v_ylim));
lines(d.blktr.xfs.s.iosz.table.norm_percent.sorted.cdf[1:k], ylim=c(0,v_ylim));
abline(h=c(cutline_1), col='red');

tctag="\nF2FS Slave";
v_maintitle=paste("IO size distribution in percent; Top-K items sorted, K =", k, tctag);
barplot(d.blktr.f2fs.s.iosz.table.norm_percent.sorted[1:k], ylim=c(0,v_ylim), ylab=v_ylab, xlab=v_xlab, main=v_maintitle, space=c(0,0));
points(d.blktr.f2fs.s.iosz.table.norm_percent.sorted.cdf[1:k], ylim=c(0,v_ylim));
lines(d.blktr.f2fs.s.iosz.table.norm_percent.sorted.cdf[1:k], ylim=c(0,v_ylim));
abline(h=c(cutline_1), col='red');




tctag="\nXFS Master";
v_maintitle=paste("IO size distribution in percent; Whole items", tctag);
barplot(d.blktr.xfs.m.iosz.table.norm_percent, ylim=c(0,v_ylim), ylab=v_ylab, xlab=v_xlab, main=v_maintitle);

tctag="\nExt4 Master";
v_maintitle=paste("IO size distribution in percent; Whole items", tctag);
barplot(d.blktr.f2fs.m.iosz.table.norm_percent, ylim=c(0,v_ylim), ylab=v_ylab, xlab=v_xlab, main=v_maintitle);

tctag="\nF2FS Master";
v_maintitle=paste("IO size distribution in percent; Whole items", tctag);
barplot(d.blktr.ext4.s.iosz.table.norm_percent, ylim=c(0,v_ylim), ylab=v_ylab, xlab=v_xlab, main=v_maintitle);

tctag="\nXFS Slave";
v_maintitle=paste("IO size distribution in percent; Whole items", tctag);
barplot(d.blktr.ext4.m.iosz.table.norm_percent, ylim=c(0,v_ylim), ylab=v_ylab, xlab=v_xlab, main=v_maintitle);

tctag="\nExt4 Slave";
v_maintitle=paste("IO size distribution in percent; Whole items", tctag);
barplot(d.blktr.xfs.s.iosz.table.norm_percent, ylim=c(0,v_ylim), ylab=v_ylab, xlab=v_xlab, main=v_maintitle);

tctag="\nF2FS Slave";
v_maintitle=paste("IO size distribution in percent; Whole items", tctag);
barplot(d.blktr.f2fs.s.iosz.table.norm_percent, ylim=c(0,v_ylim), ylab=v_ylab, xlab=v_xlab, main=v_maintitle);




