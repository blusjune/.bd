d.fi <- read.table('dbstat.perfstat.file_summary_by_instance.txt.order_by_wbytes', header=T)
d.fi
d.fi[10]
d.fi[10,]
d.fi[1:10,]
sum(d.fi$wbytes)
d.fi$wbytes / sum(d.fi$wbytes)
round(d.fi$wbytes / sum(d.fi$wbytes), digits=2)
round(100* d.fi$wbytes / sum(d.fi$wbytes), digits=2)
dum(d.fi$wbytes)
sum(d.fi$wbytes)
d.fi$wbytes[1:10,]
d.fi$wbytes[1:10]
round(100* d.fi$wbytes / sum(d.fi$wbytes), digits=2)
barplot(round(100* d.fi$wbytes / sum(d.fi$wbytes), digits=2))
barplot(d.fi$event_name, round(100* d.fi$wbytes / sum(d.fi$wbytes), digits=2))
barplot(d.fi$event_name, round(100* d.fi$wbytes / sum(d.fi$wbytes), digits=2))
example(barplot)
barplot(legend=d.fi$event_name, round(100* d.fi$wbytes / sum(d.fi$wbytes), digits=2))
barplot(legend=rownames(d.fi$event_name), round(100* d.fi$wbytes / sum(d.fi$wbytes), digits=2))
barplot(legend=(d.fi$event_name), round(100* d.fi$wbytes / sum(d.fi$wbytes), digits=2))
barplot(legend=(d.fi$event_name[20]), round(100* d.fi$wbytes / sum(d.fi$wbytes), digits=2))
barplot(legend=(d.fi$event_name[1:20]), round(100* d.fi$wbytes / sum(d.fi$wbytes), digits=2))
barplot(legend=(d.fi$file_name[1:20]), round(100* d.fi$wbytes / sum(d.fi$wbytes), digits=2))
barplot(legend=(d.fi$file_name[1:20]), col=rainbow(20), round(100* d.fi$wbytes / sum(d.fi$wbytes), digits=2))
barplot(legend=(d.fi$file_name[1:20]), col=rainbow(20), round(100* d.fi$wbytes / sum(d.fi$wbytes), digits=2)[1:20])
barplot(legend=(d.fi$file_name[1:20]), col=rainbow(20), round(100* d.fi$wbytes / sum(d.fi$wbytes), digits=2)[1:20], ylim=c(0,100))
barplot(legend=(d.fi$file_name[1:10]), col=rainbow(10), round(100* d.fi$wbytes / sum(d.fi$wbytes), digits=2)[1:10], ylim=c(0,100))
ecdf(d.fi$wbytes / sum(d.fi$wbytes))
points(ecdf(d.fi$wbytes / sum(d.fi$wbytes)))
plot(legend=(d.fi$file_name[1:10]), col=rainbow(10), round(100* d.fi$wbytes / sum(d.fi$wbytes), digits=2)[1:10], ylim=c(0,100))
plot(legend=(d.fi$file_name[1:10]), col=rainbow(10), round(100* d.fi$wbytes / sum(d.fi$wbytes), digits=2)[1:10], ylim=c(0,100), cex=.5)
plot(legend=(d.fi$file_name[1:10]), col=rainbow(10), round(100* d.fi$wbytes / sum(d.fi$wbytes), digits=2)[1:10], ylim=c(0,100), cex=.5, pch=0)
plot(legend=(d.fi$file_name[1:10]), col=rainbow(10), round(100* d.fi$wbytes / sum(d.fi$wbytes), digits=2)[1:10], ylim=c(0,100), cex=.5, pch=1)
plot(legend=(d.fi$file_name[1:10]), col=rainbow(10), round(100* d.fi$wbytes / sum(d.fi$wbytes), digits=2)[1:10], ylim=c(0,100), cex=.5, pch=1)
plot(legend=(d.fi$file_name[1:10]), col=rainbow(10), round(100* d.fi$wbytes / sum(d.fi$wbytes), digits=2)[1:10], ylim=c(0,100), cex=.5, pch=1)
points(ecdf(d.fi$wbytes / sum(d.fi$wbytes)))
plot(ecdf(d.fi$wbytes / sum(d.fi$wbytes)))
?lines
abline(h=0.5)
abline(h=0.5, v=0.4)
abline(h=0.5, v=0.4, col='red')
abline(h=c(0.3, 0.5), v=0.4, col='red')
plot(legend=(d.fi$file_name[1:10]), col=rainbow(10), round(100* d.fi$wbytes / sum(d.fi$wbytes), digits=2)[1:10], ylim=c(0,100), cex=.5, pch=1)
barplot(legend=(d.fi$file_name[1:10]), col=rainbow(10), round(100* d.fi$wbytes / sum(d.fi$wbytes), digits=2)[1:10], ylim=c(0,100), cex=.5, pch=1)
barplot(legend=(d.fi$file_name[1:10]), col=rainbow(10), round(100* d.fi$wbytes / sum(d.fi$wbytes), digits=2)[1:10], ylim=c(0,100))
?sort
?order
barplot(legend=(d.fi.wbytes$file_name[1:10]), col=rainbow(10), round(100* d.fi.wbytes$wbytes / sum(d.fi.wbytes$wbytes), digits=2)[1:10], ylim=c(0,100))
d.fi.wbytes <- read.table('dbstat.perfstat.file_summary_by_instance.txt.order_by_wbytes', header=T)
d.fi.rbytes <- read.table('dbstat.perfstat.file_summary_by_instance.txt.order_by_rbytes', header=T)
?order
example(order)
example(order)
?order
?xtfrm
?rank
?xtfrm
?order
l
ls()
d.fi.rbytes
d.fi.rbytes[1,]
order(d.fi.rbytes$wbytes)
order(d.fi.rbytes$wbytes, decreasing=T)
order(d.fi.rbytes$wbytes, decreasing=F)
order(d.fi.rbytes, decreasing=F)
order(d.fi.rbytes$wbytes)
xtfrm(d.fi.rbytes$wbytes)
xtfrm(d.fi.rbytes)
?sort.list
?with
d.fi.rbytes
d.fi.rbytes
d.fi.rbytes[1:10]
d.fi.rbytes[1:10,]
d.fi.rbytes[1:10, 1,2]
d.fi.rbytes[1:10, 1,2]
d.fi.rbytes[1:10, 1:2]
d.fi.rbytes[1:10, c(1,2,3)]
d.fi.rbytes[1:10, c(1,3,4)]
d.fi.rbytes[1:10, c(1,3,4)][order(d.fi.rbytes$wbytes)]]
d.fi.rbytes[1:10, c(1,3,4)][order(d.fi.rbytes$wbytes)]
d.fi.rbytes[1:10, c(1,3,4)][order(d.fi.rbytes$wbytes)
,]
,]
d.fi.rbytes[1:10, c(1,3,4)][order(d.fi.rbytes$wbytes),]
d.fi.rbytes[1:10, c(1,3,4)][order(d.fi.rbytes[,3]),]
d.fi.rbytes[1:10, c(1,3,4)][order(d.fi.rbytes[,3]),]
(d.fi.rbytes[1:10, c(1,3,4)])[order(d.fi.rbytes[,3]),]
(d.fi.rbytes[1:10, c(1,3,4)])[order(d.fi.rbytes[,4]),]
(d.fi.rbytes[1:10, c(1,3,4)])[order(d.fi.rbytes[,1]),]
(d.fi.rbytes[1:10, c(1,3,4)])[order(d.fi.rbytes[,5]),]
(d.fi.rbytes[1:10, c(1,3,4)])[order(d.fi.rbytes[,5]),]
d.fi.rbytes[1:10,]
d.fi.rbytes[order(d.fi.rbytes$wbytes),]
d.fi.rbytes[order(d.fi.rbytes$wbytes),][1:10,]
d.fi.rbytes[order(d.fi.rbytes$wbytes),][1:10,]
d.fi.rbytes[order(-d.fi.rbytes$wbytes),][1:10,]
d.fi.rbytes[order(-d.fi.rbytes$rcount),][1:10,]
d.fi.rbytes[order(-d.fi.rbytes$wcount),][1:10,]
d.fi.rbytes[order(-d.fi.rbytes$wcount),][1:20,]
d.fi.wcount_top20 <- d.fi.rbytes[order(-d.fi.rbytes$wcount),][1:20,]
d.fi.rcount_top20 <- d.fi.rbytes[order(-d.fi.rbytes$rcount),][1:20,]
d.fi.rbytes_top20 <- d.fi.rbytes[order(-d.fi.rbytes$rbytes),][1:20,]
d.fi.wbytes_top20 <- d.fi.rbytes[order(-d.fi.rbytes$wbytes),][1:20,]
d.fi.wcount_top20
barplot(legend=(d.fi.rbytes_top20$file_name[1:20]), col=rainbow(20), round(100* d.fi.rbytes_top20$wbytes / sum(d.fi.rbytes_top20$wbytes), digits=2)[1:10], ylim=c(0,100))
d.fi.wbytes_top20
d.fi.wbytes <- d.fi.rbytes[order(-d.fi.rbytes$wbytes),]
d.fi.rbytes <- d.fi.rbytes[order(-d.fi.rbytes$rbytes),]
d.fi.rcount <- d.fi.rbytes[order(-d.fi.rbytes$rcount),]
d.fi.wcount <- d.fi.rbytes[order(-d.fi.rbytes$wcount),]
d.fi.riosz <- d.fi.rbytes[order(-d.fi.rbytes$riosz),]
d.fi.rbytes
d.fi.rbytes[1,]
d.fi.rbytes
d.fi.rbytes
d.fi.wbytes
d.fi.rbytes
d.fi.wbytes
ls()
rm(list=ls())
ls()
d.fi.rbytes <- read.table('dbstat.perfstat.file_summary_by_instance.txt.order_by_rbytes', header=T)
d.fi.wbytes <- read.table('dbstat.perfstat.file_summary_by_instance.txt.order_by_wbytes', header=T)
d.fi.rcount <- read.table('dbstat.perfstat.file_summary_by_instance.txt.order_by_rcount', header=T)
d.fi.wcount <- read.table('dbstat.perfstat.file_summary_by_instance.txt.order_by_wcount', header=T)
d.fi.riosz <- read.table('dbstat.perfstat.file_summary_by_instance.txt.order_by_riosz', header=T)
d.fi.wiosz <- read.table('dbstat.perfstat.file_summary_by_instance.txt.order_by_wiosz', header=T)
barplot(legend=d.fi.rbytes$file_name[1:20], round(d.fi.rbytes$rbytes[1:20]/sum(d.fi.rbytes$rbytes), digits=2), col=rainbow(20), ylim=c(0,100))
barplot(legend=d.fi.rbytes$file_name[1:20], round(100 * d.fi.rbytes$rbytes[1:20] / sum(d.fi.rbytes$rbytes), digits=2), col=rainbow(20), ylim=c(0,100))
topk <- 10
barplot(legend=d.fi.rbytes$file_name[1:topk], round(100 * d.fi.rbytes$rbytes[1:topk] / sum(d.fi.rbytes$rbytes), digits=2), col=rainbow(topk), ylim=c(0,100))
barplot(legend=d.fi.wbytes$file_name[1:topk], round(100 * d.fi.wbytes$wbytes[1:topk] / sum(d.fi.wbytes$wbytes), digits=2), col=rainbow(topk), ylim=c(0,100))
d.ev.rbytes <- read.table('dbstat.perfstat.file_summary_by_event_name.txt.order_by_rbytes', header=T)
d.ev.wbytes <- read.table('dbstat.perfstat.file_summary_by_event_name.txt.order_by_wbytes', header=T)
d.ev.rcount <- read.table('dbstat.perfstat.file_summary_by_event_name.txt.order_by_rcount', header=T)
d.ev.wcount <- read.table('dbstat.perfstat.file_summary_by_event_name.txt.order_by_wcount', header=T)
d.ev.riosz <- read.table('dbstat.perfstat.file_summary_by_event_name.txt.order_by_riosz', header=T)
d.ev.wiosz <- read.table('dbstat.perfstat.file_summary_by_event_name.txt.order_by_wiosz', header=T)
barplot(legend=d.ev.rbytes$event_name[1:topk], round(100 * d.ev.rbytes$rbytes[1:topk] / sum(d.ev.rbytes$rbytes), digits=2), col=rainbow(topk), ylim=c(0,100))
barplot(legend=d.ev.wbytes$event_name[1:topk], round(100 * d.ev.wbytes$wbytes[1:topk] / sum(d.ev.wbytes$wbytes), digits=2), col=rainbow(topk), ylim=c(0,100))
d.ev.rbytes <- read.table('dbstat.perfstat.file_summary_by_event_name.txt.order_by_rbytes', header=T)
d.ev.wbytes <- read.table('dbstat.perfstat.file_summary_by_event_name.txt.order_by_wbytes', header=T)
d.ev.rcount <- read.table('dbstat.perfstat.file_summary_by_event_name.txt.order_by_rcount', header=T)
d.ev.wcount <- read.table('dbstat.perfstat.file_summary_by_event_name.txt.order_by_wcount', header=T)
d.ev.riosz <- read.table('dbstat.perfstat.file_summary_by_event_name.txt.order_by_riosz', header=T)
d.ev.wiosz <- read.table('dbstat.perfstat.file_summary_by_event_name.txt.order_by_wiosz', header=T)
barplot(legend=d.ev.rbytes$event_name[1:topk], round(100 * d.ev.rbytes$rbytes[1:topk] / sum(d.ev.rbytes$rbytes), digits=2), col=rainbow(topk), ylim=c(0,100))
barplot(legend=d.ev.rbytes$event_name[1:topk], round(100 * d.ev.rbytes$rbytes[1:topk] / sum(d.ev.rbytes$rbytes), digits=2), col=rainbow(topk), ylim=c(0,100))
w
sh()
shell()
shell
pwd
pwd()
d.ev.rbytes <- read.table('dbstat.perfstat.file_summary_by_event_name.txt.order_by_rbytes', header=T)
d.ev.wbytes <- read.table('dbstat.perfstat.file_summary_by_event_name.txt.order_by_wbytes', header=T)
d.ev.rcount <- read.table('dbstat.perfstat.file_summary_by_event_name.txt.order_by_rcount', header=T)
d.ev.wcount <- read.table('dbstat.perfstat.file_summary_by_event_name.txt.order_by_wcount', header=T)
d.ev.riosz <- read.table('dbstat.perfstat.file_summary_by_event_name.txt.order_by_riosz', header=T)
d.ev.wiosz <- read.table('dbstat.perfstat.file_summary_by_event_name.txt.order_by_wiosz', header=T)
barplot(legend=d.ev.rbytes$event_name[1:topk], round(100 * d.ev.rbytes$rbytes[1:topk] / sum(d.ev.rbytes$rbytes), digits=2), col=rainbow(topk), ylim=c(0,100))
savehistory('.rhist.20140313')
savehistory('.rhist.20140313.r')
savehistory('.rhist.20140313.r')
d.ev.rbytes <- read.table('dbstat.perfstat.file_summary_by_event_name.txt.order_by_rbytes', header=T)
d.fi.wbytes <- read.table('dbstat.perfstat.file_summary_by_event_name.txt.order_by_wbytes', header=T)
barplot(legend=d.ev.rbytes$event_name[1:topk], round(100 * d.ev.rbytes$rbytes[1:topk] / sum(d.ev.rbytes$rbytes), digits=2), col=rainbow(topk), ylim=c(0,100))
topk=10
topk <- 10
barplot(legend=d.ev.rbytes$event_name[1:topk], round(100 * d.ev.rbytes$rbytes[1:topk] / sum(d.ev.rbytes$rbytes), digits=2), col=rainbow(topk), ylim=c(0,100))
barplot(legend=d.ev.rbytes$event_name[1:topk], round(100 * d.ev.rbytes$rbytes[1:topk] / sum(d.ev.rbytes$rbytes), digits=2), col=rainbow(topk), ylim=c(0,100))
barplot(legend=d.ev.wbytes$event_name[1:topk], round(100 * d.ev.wbytes$wbytes[1:topk] / sum(d.ev.wbytes$wbytes), digits=2), col=rainbow(topk), ylim=c(0,100))
barplot(legend=d.ev.wbytes$event_name[1:topk], round(100 * d.ev.rbytes$rbytes[1:topk] / sum(d.ev.rbytes$rbytes), digits=2), col=rainbow(topk), ylim=c(0,100))
barplot(legend=d.ev.wbytes$event_name[1:topk], round(100 * d.ev.wbytes$wbytes[1:topk] / sum(d.ev.wbytes$wbytes), digits=2), col=rainbow(topk), ylim=c(0,100))
barplot(legend=d.ev.wbytes$event_name[1:topk], round(100 * d.ev.wbytes$wbytes[1:topk] / sum(d.ev.wbytes$wbytes), digits=2), col=rainbow(topk), ylim=c(0,100))
barplot(legend=d.ev.rbytes$event_name[1:topk], round(100 * d.ev.rbytes$rbytes[1:topk] / sum(d.ev.rbytes$rbytes), digits=2), col=rainbow(topk), ylim=c(0,100), main="Top-10 files ordered by bytes read")
barplot(legend=d.ev.rbytes$event_name[1:topk], round(100 * d.ev.rbytes$rbytes[1:topk] / sum(d.ev.rbytes$rbytes), digits=2), col=rainbow(topk), ylim=c(0,100), main="Top-10 files ordered by bytes read, Master-1")
barplot(legend=d.ev.wbytes$event_name[1:topk], round(100 * d.ev.wbytes$wbytes[1:topk] / sum(d.ev.wbytes$wbytes), digits=2), col=rainbow(topk), ylim=c(0,100), main="Top-10 files ordered by bytes written, Master-1")
d.fi.rbytes <- read.table('dbstat.perfstat.file_summary_by_instance.txt.order_by_rbytes', header=T)
d.fi.wbytes <- read.table('dbstat.perfstat.file_summary_by_instance.txt.order_by_wbytes', header=T)
barplot(legend=d.fi.rbytes$event_name[1:topk], round(100 * d.fi.rbytes$rbytes[1:topk] / sum(d.fi.rbytes$rbytes), digits=2), col=rainbow(topk), ylim=c(0,100), main="Top-10 files ordered by bytes read, Master-1")
barplot(legend=d.fi.rbytes$event_name[1:topk], round(100 * d.fi.rbytes$rbytes[1:topk] / sum(d.fi.rbytes$rbytes), digits=2), col=rainbow(topk), ylim=c(0,100), main="Top-10 files ordered by bytes read, Master-1")
barplot(legend=d.fi.rbytes$file_name[1:topk], round(100 * d.fi.rbytes$rbytes[1:topk] / sum(d.fi.rbytes$rbytes), digits=2), col=rainbow(topk), ylim=c(0,100), main="Top-10 files ordered by bytes read, Master-1")
barplot(legend=d.fi.rbytes$event_name[1:topk], round(100 * d.fi.rbytes$rbytes[1:topk] / sum(d.fi.rbytes$rbytes), digits=2), col=rainbow(topk), ylim=c(0,100), main="Top-10 files ordered by bytes read, Master-1")
barplot(legend=d.fi.rbytes$file_name[1:topk], round(100 * d.fi.rbytes$rbytes[1:topk] / sum(d.fi.rbytes$rbytes), digits=2), col=rainbow(topk), ylim=c(0,100), main="Top-10 files ordered by bytes read, Master-1")
barplot(legend=d.fi.wbytes$file_name[1:topk], round(100 * d.fi.wbytes$wbytes[1:topk] / sum(d.fi.wbytes$wbytes), digits=2), col=rainbow(topk), ylim=c(0,100), main="Top-10 files ordered by bytes written, Master-1")
barplot(legend=d.ev.rbytes$event_name[1:topk], round(100 * d.ev.rbytes$rbytes[1:topk] / sum(d.ev.rbytes$rbytes), digits=2), col=rainbow(topk), ylim=c(0,100), main="Top-10 file types ordered by bytes read, Master-1")
barplot(legend=d.ev.wbytes$event_name[1:topk], round(100 * d.ev.wbytes$wbytes[1:topk] / sum(d.ev.wbytes$wbytes), digits=2), col=rainbow(topk), ylim=c(0,100), main="Top-10 file types ordered by bytes written, Master-1")
savehistory('.rhist.20140313.r')
ls()
sum(d.fi.rbytes$rbytes)
sum(d.fi.wbytes$wbytes)
d.fi.wbytes$wbytes
sum(d.fi.wbytes$wbytes)
sort(d.fi.wbytes$wbytes, decreasing=T)
sort(d.fi.wbytes$wbytes, decreasing=T)[1:10]
sort(d.fi.wbytes$wbytes, decreasing=T)[1:10]
sum(d.fi.wbytes$wbytes)
options(digits=9); sum(d.fi.wbytes$wbytes)
options(digits=1); sum(d.fi.wbytes$wbytes)
options(digits=2); sum(d.fi.wbytes$wbytes)
options(digits=12); sum(d.fi.wbytes$wbytes)
options(digits=18); sum(d.fi.wbytes$wbytes)
sum(d.fi.wbytes$wbytes)
sum(sort(d.fi.wbytes$wbytes, decreasing=T)[1:10])/sum(d.fi.wbytes$wbytes)
topk=10; sum(sort(d.fi.wbytes$wbytes, decreasing=T)[1:topk])/sum(d.fi.wbytes$wbytes)
topk=20; sum(sort(d.fi.wbytes$wbytes, decreasing=T)[1:topk])/sum(d.fi.wbytes$wbytes)
topk=5; sum(sort(d.fi.wbytes$wbytes, decreasing=T)[1:topk])/sum(d.fi.wbytes$wbytes)
topk=5; sum(sort(d.fi.wbytes$wbytes, decreasing=T)[1:topk])/sum(d.fi.wbytes$wbytes)
savehistory('.rhist.20140313-01.r')
