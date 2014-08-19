blk <- read.table(header=T, file='.blkop_and_tpcc.dat');

blk_1of3 <- blk[1:3,];
blk_2of3 <- blk[4:6,];
blk_3of3 <- blk[7:9,];

par(mfcol=c(3,1));

barplot(cbind(blk_1of3$TpmC, blk_2of3$TpmC, blk_3of3$TpmC),
		beside=T,
		col=rainbow(3),
		names.arg=c("TestCase 1_of_3\nlru_scan_depth = 128",
			"TestCase 2_of_3\nlru_scan_depth = 1024",
			"TestCase 3_of_3\nlru_scan_depth = 2048"),
		main="Database System Performance (800GB DB table)",
		ylab="TpmC",
		legend.text=c("XFS", "Ext4", "F2FS"));
barplot(rbind(blk$I2D, blk$D2C),
		beside=F,
		col=cm.colors(2), 
		names.arg=blk$TestCase, 
		main="IO operation overhead: Host (block layer) Vs. Device",
		legend.text=c("I2D", "D2C"), ylim=c(0,0.025));
barplot(rbind(blk$SEEK_Q2Q_AVG, blk$SEEK_D2D_AVG),
		beside=T,
		names.arg=blk$TestCase,
		col=terrain.colors(2),
		main="Seek Distance Average - Randomness of Access",
		legend.text=c("Q2Q Distance", "D2D Distance"));
