## 20140427_144843

## Compute the IO size distribution (iosz)




## Read blktrace p010.jung log and transform to normalized form
source('.rcmd.blktr.r')




cdf_table_sorted <- function(tab_sorted) {
	tt <- tab_sorted;
	for (i in 2:length(tt)) {
		tt[i] <- tt[i] + tt[i-1];
	}
	return (tt);
}




#tt <- d.blktr.xfs.m.iosz.table.norm_percent.sorted
#for (i in 2:length(tt)) {
#	tt[i] <- tt[i] + tt[i-1];
#}
#d.blktr.xfs.m.iosz.table.norm_percent.sorted.cdf <- tt;

d.blktr.xfs.m.iosz.table <- table(d.blktr.xfs.m$iosz);
d.blktr.xfs.m.iosz.table.norm_percent <- 100 * d.blktr.xfs.m.iosz.table / sum(d.blktr.xfs.m.iosz.table)
d.blktr.xfs.m.iosz.table.norm_percent.sorted <- sort( d.blktr.xfs.m.iosz.table.norm_percent , decreasing=T);
d.blktr.xfs.m.iosz.table.norm_percent.sorted.cdf <- cdf_table_sorted( d.blktr.xfs.m.iosz.table.norm_percent.sorted );

d.blktr.xfs.s.iosz.table <- table(d.blktr.xfs.s$iosz);
d.blktr.xfs.s.iosz.table.norm_percent <- 100 * d.blktr.xfs.s.iosz.table / sum(d.blktr.xfs.s.iosz.table)
d.blktr.xfs.s.iosz.table.norm_percent.sorted <- sort( d.blktr.xfs.s.iosz.table.norm_percent , decreasing=T);
d.blktr.xfs.s.iosz.table.norm_percent.sorted.cdf <- cdf_table_sorted( d.blktr.xfs.s.iosz.table.norm_percent.sorted );

d.blktr.ext4.m.iosz.table <- table(d.blktr.ext4.m$iosz);
d.blktr.ext4.m.iosz.table.norm_percent <- 100 * d.blktr.ext4.m.iosz.table / sum(d.blktr.ext4.m.iosz.table)
d.blktr.ext4.m.iosz.table.norm_percent.sorted <- sort( d.blktr.ext4.m.iosz.table.norm_percent , decreasing=T);
d.blktr.ext4.m.iosz.table.norm_percent.sorted.cdf <- cdf_table_sorted( d.blktr.ext4.m.iosz.table.norm_percent.sorted );

d.blktr.ext4.s.iosz.table <- table(d.blktr.ext4.s$iosz);
d.blktr.ext4.s.iosz.table.norm_percent <- 100 * d.blktr.ext4.s.iosz.table / sum(d.blktr.ext4.s.iosz.table)
d.blktr.ext4.s.iosz.table.norm_percent.sorted <- sort( d.blktr.ext4.s.iosz.table.norm_percent , decreasing=T);
d.blktr.ext4.s.iosz.table.norm_percent.sorted.cdf <- cdf_table_sorted( d.blktr.ext4.s.iosz.table.norm_percent.sorted );

d.blktr.f2fs.m.iosz.table <- table(d.blktr.f2fs.m$iosz);
d.blktr.f2fs.m.iosz.table.norm_percent <- 100 * d.blktr.f2fs.m.iosz.table / sum(d.blktr.f2fs.m.iosz.table)
d.blktr.f2fs.m.iosz.table.norm_percent.sorted <- sort( d.blktr.f2fs.m.iosz.table.norm_percent , decreasing=T);
d.blktr.f2fs.m.iosz.table.norm_percent.sorted.cdf <- cdf_table_sorted( d.blktr.f2fs.m.iosz.table.norm_percent.sorted );

d.blktr.f2fs.s.iosz.table <- table(d.blktr.f2fs.s$iosz);
d.blktr.f2fs.s.iosz.table.norm_percent <- 100 * d.blktr.f2fs.s.iosz.table / sum(d.blktr.f2fs.s.iosz.table)
d.blktr.f2fs.s.iosz.table.norm_percent.sorted <- sort( d.blktr.f2fs.s.iosz.table.norm_percent , decreasing=T);
d.blktr.f2fs.s.iosz.table.norm_percent.sorted.cdf <- cdf_table_sorted( d.blktr.f2fs.s.iosz.table.norm_percent.sorted );
