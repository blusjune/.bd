dset
dset[1]
dset[[1]]
dset
trx <- as(dset, "transactions")
trx
rules <- eclat(trx, parameter=list(supp=0.1, maxlen=5, minlen=2, tidLists=T))
summary(rules)
summary(rules)
image(tidLists(trx))
image(tidLists(rules))
rules
trx
dset
summary(rules)
summary(trx)
items(trx)
items(rules)
itemFrequency(trx)
savehistory('.arules.example.R')
source('~/x9/bsc.x9.iowa.blktr.p020.r')
items(rules)f
par(mfrow=c(3,2))
plot(d.blktr.m1$addr, cex=.3, col=ifelse(d.blktr.m1$tag_iot == '_IOT_R', 'green', ifelse(d.blktr.m1$tag_iosz_align == '_IOSZ_ALIGN_Y', 'blue', 'red')), main="address - master 1");
plot(d.blktr.s1$addr, cex=.3, col=ifelse(d.blktr.s1$tag_iot == '_IOT_R', 'green', ifelse(d.blktr.s1$tag_iosz_align == '_IOSZ_ALIGN_Y', 'blue', 'red')), main="address - slave 1");
plot(d.blktr.s2$addr, cex=.3, col=ifelse(d.blktr.s2$tag_iot == '_IOT_R', 'green', ifelse(d.blktr.s2$tag_iosz_align == '_IOSZ_ALIGN_Y', 'blue', 'red')), main="address - slave 2");
par(mfrow=c(2,3))
plot(d.blktr.m1$addr, cex=.3, col=ifelse(d.blktr.m1$tag_iot == '_IOT_R', 'green', ifelse(d.blktr.m1$tag_iosz_align == '_IOSZ_ALIGN_Y', 'blue', 'red')), main="address - master 1");
plot(d.blktr.s1$addr, cex=.3, col=ifelse(d.blktr.s1$tag_iot == '_IOT_R', 'green', ifelse(d.blktr.s1$tag_iosz_align == '_IOSZ_ALIGN_Y', 'blue', 'red')), main="address - slave 1");
plot(d.blktr.s2$addr, cex=.3, col=ifelse(d.blktr.s2$tag_iot == '_IOT_R', 'green', ifelse(d.blktr.s2$tag_iosz_align == '_IOSZ_ALIGN_Y', 'blue', 'red')), main="address - slave 2");
plot(d.blktr.m1$iosz, cex=.3, col=ifelse(d.blktr.m1$tag_iot == '_IOT_R', 'green', ifelse(d.blktr.m1$tag_iosz_align == '_IOSZ_ALIGN_Y', 'blue', 'red')), main="iosz - master 1");
plot(d.blktr.s1$iosz, cex=.3, col=ifelse(d.blktr.s1$tag_iot == '_IOT_R', 'green', ifelse(d.blktr.s1$tag_iosz_align == '_IOSZ_ALIGN_Y', 'blue', 'red')), main="iosz - slave 1");
par(mfrow=c(2,3))
par(mfrow=c(2,3))
plot(d.blktr.m1$addr, cex=.3, col=ifelse(d.blktr.m1$tag_iot == '_IOT_R', 'green', ifelse(d.blktr.m1$tag_iosz_align == '_IOSZ_ALIGN_Y', 'blue', 'red')), main="address - master 1");
plot(d.blktr.s1$addr, cex=.3, col=ifelse(d.blktr.s1$tag_iot == '_IOT_R', 'green', ifelse(d.blktr.s1$tag_iosz_align == '_IOSZ_ALIGN_Y', 'blue', 'red')), main="address - slave 1");
plot(d.blktr.s2$addr, cex=.3, col=ifelse(d.blktr.s2$tag_iot == '_IOT_R', 'green', ifelse(d.blktr.s2$tag_iosz_align == '_IOSZ_ALIGN_Y', 'blue', 'red')), main="address - slave 2");
plot(d.blktr.m1$iosz, cex=.3, col=ifelse(d.blktr.m1$tag_iot == '_IOT_R', 'green', ifelse(d.blktr.m1$tag_iosz_align == '_IOSZ_ALIGN_Y', 'blue', 'red')), main="iosz - master 1");
plot(d.blktr.s1$iosz, cex=.3, col=ifelse(d.blktr.s1$tag_iot == '_IOT_R', 'green', ifelse(d.blktr.s1$tag_iosz_align == '_IOSZ_ALIGN_Y', 'blue', 'red')), main="iosz - slave 1");
plot(d.blktr.s2$i, cex=.3, col=ifelse(d.blktr.s2$tag_iot == '_IOT_R', 'green', ifelse(d.blktr.s2$tag_iosz_align == '_IOSZ_ALIGN_Y', 'blue', 'red')), main="iosz - slave 2");
density(d.blktr.m1$io_interval)
plot(density(d.blktr.m1$io_interval))
plot(table(d.blktr.m1$io_interval))
plot(table(d.blktr.m1$iosz))
dim(table(d.blktr.m1$iosz))
tb.m1.iosz <- table(d.blktr.m1$iosz)
tb.m1.addr <- table(d.blktr.m1$addr)
tb.m1.io_interval <- table(d.blktr.m1$io_interval)
plot(tb.m1.iosz)
plot(tb.m1.addr)
plot(log10(tb.m1.addr))
plot(log10(tb.m1.iosz))
plot(log10(tb.m1.io_interval))
plot(d.blktr.m1$addr, cex=.3, col=ifelse(d.blktr.m1$tag_io == '_IOT_R', 'green', ifelse(d.blktr.m1$tag_iosz_align == '_IOSZ_ALIGN_Y', 'blue', 'red')), main="address - master 1");
summary(d.blktr.m1); summary(d.blktr.s1); summary(d.blktr.s2);
tb.m1.iosz[1:5]
tb.m1.iosz.sort <- sort(tb.m1.iosz, decreasing=T)
tb.m1.addr.sort <- sort(tb.m1.addr, decreasing=T)
tb.s1.iosz <- table(d.blktr.s1$iosz); tb.s1.addr <- table(d.blktr.s1$addr); tb.s1.iosz.sort <- sort(tb.s1.iosz, decreasing=T); tb.s1.addr.sort <- sort(tb.s1.addr, decreasing=T);
tb.m1.iosz.sort[1:10]
tb.m1.addr.sort[1:10]
dim(d.blktr.m1)
m1.ion <- dim(d.blktr.m1)[1]
s1.ion <- dim(d.blktr.s1)[1]
s2.ion <- dim(d.blktr.s2)[1]
m1.ion
tb.m1.iosz.sort[1:10] / m1.ion
plot(tb.m1.iosz.sort[1:10] / m1.ion)
hist(tb.m1.iosz.sort[1:10] / m1.ion)
plot(tb.m1.iosz.sort[1:10] / m1.ion)
tb.m1.iosz.sort[1:10] / m1.ion
tb.s2.iosz <- table(d.blktr.s2$iosz); tb.s2.addr <- table(d.blktr.s2$addr); tb.s2.iosz.sort <- sort(tb.s2.iosz, decreasing=T); tb.s2.addr.sort <- sort(tb.s2.addr, decreasing=T);
barplot(tb.m1.iosz.sort[1:10] / m1.ion)
barplot(tb.m1.iosz.sort[1:10] / m1.ion, col=rainbow(10))
barplot(tb.m1.iosz.sort[1:10] / m1.ion, col=rainbow(10), main="IO size - Top10", ylab="Prob.")
barplot(tb.m1.iosz.sort[1:10] * 100 / m1.ion, col=rainbow(10), main="IO size - Top10", ylab="%")
barplot(tb.s1.iosz.sort[1:10] * 100 / s1.ion, col=rainbow(10), main="IO size - Top10", ylab="%")
barplot(tb.s2.iosz.sort[1:10] * 100 / s2.ion, col=rainbow(10), main="IO size - Top10", ylab="%")
barplot(tb.m1.iosz.sort[1:10] * 100 / m1.ion, col=rainbow(10), main="master1 io size, top-10", ylab="%")
barplot(tb.m1.iosz.sort[1:10] * 100 / m1.ion, col=rainbow(10), main="master1 IO size, top-10", ylab="%")
barplot(tb.m1.iosz.sort[1:10] * 100 / m1.ion, col=rainbow(10), main="IO size top-10, master-1", ylab="%")
barplot(tb.s1.iosz.sort[1:10] * 100 / s1.ion, col=rainbow(10), main="IO size top-10, slave-1", ylab="%")
barplot(tb.s2.iosz.sort[1:10] * 100 / s2.ion, col=rainbow(10), main="IO size top-10, slave-2", ylab="%")
barplot(tb.m1.addr.sort[1:10] * 100 / m1.ion, col=rainbow(10), main="Address accessed top-10, master-1", ylab="%")
barplot(tb.m1.iosz.sort[1:10] * 100 / m1.ion, col=rainbow(10), main="IO size top-10, master-1", ylab="%")
barplot(tb.m1.addr.sort[1:10] * 100 / m1.ion, col=rainbow(10), main="Address accessed top-10, master-1", ylab="%")
barplot(tb.m1.addr.sort[1:100] * 100 / m1.ion, col=rainbow(10), main="Address accessed top-10, master-1", ylab="%")
barplot(tb.m1.addr.sort[1:20] * 100 / m1.ion, col=rainbow(10), main="Address accessed top-10, master-1", ylab="%")
barplot(tb.m1.addr.sort[1:20] * 100 / m1.ion, col=rainbow(10), main="Address accessed top-20, master-1", ylab="%")
barplot(tb.m1.addr.sort[1:20] * 100 / m1.ion, col=rainbow(10), main="Address accessed top-20, master-1", ylab="%")
tb.m1.addr.sort[1:20] * 100 / m1.ion
tb.m1.iosz.sort[1:20] * 100 / m1.ion
sum(tb.m1.iosz.sort[1:20] * 100 / m1.ion)
sum(tb.m1.addr.sort[1:20] * 100 / m1.ion)
sum(tb.m1.addr.sort[1:100] * 100 / m1.ion)
sum(tb.m1.addr.sort[1:10000] * 100 / m1.ion)
sum(tb.m1.addr.sort[1:100000] * 100 / m1.ion)
sum(tb.m1.addr.sort[1:1000000] * 100 / m1.ion)
sum(tb.m1.addr.sort[1:10000000] * 100 / m1.ion)
sum(tb.m1.addr.sort[1:1000000] * 100 / m1.ion)
?pdf
sum(tb.m1.addr.sort[1:100000] * 100 / m1.ion)
sum(tb.m1.addr.sort[1:100000] * 100 / m1.ion)
sum(tb.m1.iosz.sort[1:100000] * 100 / m1.ion)
sum(tb.m1.iosz.sort[1:10] * 100 / m1.ion)
sum(tb.m1.iosz.sort[1:20] * 100 / m1.ion)
plot(tb.m1.iosz.sort[1:20] * 100 / m1.ion)
barplot(tb.m1.iosz.sort[1:20] * 100 / m1.ion)
barplot(tb.s1.iosz.sort[1:20] * 100 / m1.ion)
barplot(tb.m1.iosz.sort[1:20] * 100 / m1.ion)
barplot(tb.m1.iosz.sort[1:20] * 100 / m1.ion, col=rainbow())
barplot(tb.m1.iosz.sort[1:20] * 100 / m1.ion, col=rainbow(20))
?
barplot
barplot
?barplot
barplot(tb.m1.iosz.sort[1:20] * 100 / m1.ion, col=rainbow(20))
barplot(tb.s1.iosz.sort[1:20] * 100 / s1.ion, col=rainbow(20))
barplot(tb.s2.iosz.sort[1:20] * 100 / s2.ion, col=rainbow(20))
barplot(tb.m1.iosz.sort[1:20] * 100 / m1.ion, col=rainbow(20), ylim=c(0,100))
barplot(tb.m1.iosz.sort[1:20] * 100 / m1.ion, col=rainbow(20), ylim=c(0,100))
sum(tb.m1.iosz.sort[1:20] * 100 / m1.ion)
sum(tb.m1.iosz.sort[1:5] * 100 / m1.ion)
sum(tb.s1.iosz.sort[1:5] * 100 / m1.ion)
sum(tb.s2.iosz.sort[1:5] * 100 / m1.ion)
sum(tb.m1.iosz.sort[1:5] * 100 / m1.ion)
sum(tb.s1.iosz.sort[1:5] * 100 / s1.ion)
sum(tb.s2.iosz.sort[1:5] * 100 / s2.ion)
sum(tb.s2.iosz.sort[1:10] * 100 / s2.ion)
sum(tb.s1.iosz.sort[1:10] * 100 / s1.ion)
sum(tb.m1.iosz.sort[1:10] * 100 / m1.ion)
sum(tb.m1.iosz.sort[1:20] * 100 / m1.ion)
sum(tb.s1.iosz.sort[1:20] * 100 / s1.ion)
sum(tb.s2.iosz.sort[1:20] * 100 / s2.ion)
barplot(tb.m1.iosz.sort[1:20] * 100 / m1.ion, col=rainbow(20), ylim=c(0,100))
barplot(tb.m1.iosz.sort[1:5] * 100 / m1.ion, col=rainbow(5), ylim=c(0,100))
barplot(tb.m1.iosz.sort[1:10] * 100 / m1.ion, col=rainbow(10), ylim=c(0,100))
barplot(tb.s1.iosz.sort[1:10] * 100 / s1.ion, col=rainbow(10), ylim=c(0,100))
barplot(tb.s2.iosz.sort[1:10] * 100 / s2.ion, col=rainbow(10), ylim=c(0,100))
barplot(tb.m1.iosz.sort[1:10] * 100 / m1.ion, col=rainbow(10), ylim=c(0,100))
barplot(tb.m1.iosz.sort[1:10] * 100 / m1.ion, col=rainbow(10), ylim=c(0,100), main="I/O size top-10, master-1")
barplot(tb.s1.iosz.sort[1:10] * 100 / s1.ion, col=rainbow(10), ylim=c(0,100), main="I/O size top-10, slave-1")
barplot(tb.s2.iosz.sort[1:10] * 100 / s2.ion, col=rainbow(10), ylim=c(0,100), main="I/O size top-10, slave-2")
plot(tb.s2.iosz)
plot(tb.s1.iosz)
plot(tb.m1.iosz)
plot(tb.m1.iosz.sort)
tb.m1.iosz.sort[1:10]
plot(tb.m1.iosz)
plot(tb.m1.iosz, ylim=c(0,3200000))
plot(tb.s1.iosz, ylim=c(0,3200000))
plot(tb.s2.iosz, ylim=c(0,3200000))
plot(tb.m1.iosz, ylim=c(0,3200000), main="I/O size distribution, master-1")
plot(tb.s1.iosz, ylim=c(0,3200000), main="I/O size distribution, slave-1")
plot(tb.s2.iosz, ylim=c(0,3200000), main="I/O size distribution, slave-2")
plot(tb.m1.iosz, ylim=c(0,3200000), main="I/O size distribution (log10), master-1")
plot(log10(tb.m1.iosz), ylim=c(0,3200000), main="I/O size distribution (log10), master-1")
plot(log10(tb.m1.iosz), main="I/O size distribution (log10), master-1")
plot(log10(tb.m1.iosz), ylim=c(0,10), main="I/O size distribution (log10), master-1")
plot(log10(tb.s1.iosz), ylim=c(0,10), main="I/O size distribution (log10), slave-1")
plot(log10(tb.s2.iosz), ylim=c(0,10), main="I/O size distribution (log10), slave-2")
plot(log10(tb.m1.iosz), ylim=c(0,7), main="I/O size distribution (log10), master-1")
plot(log10(tb.s1.iosz), ylim=c(0,7), main="I/O size distribution (log10), slave-1")
plot(log10(tb.s2.iosz), ylim=c(0,7), main="I/O size distribution (log10), slave-2")
plot(log10(tb.m1.iosz), ylim=c(0,7), main="I/O size distribution (log10), master-1")
plot(log10(tb.s1.iosz), ylim=c(0,7), main="I/O size distribution (log10), slave-1")
plot(log10(tb.s2.iosz), ylim=c(0,7), main="I/O size distribution (log10), slave-2")
plot(log10(tb.m1.addr), ylim=c(0,7), main="address accessed distribution (log10), master-1")
plot(log10(tb.s1.addr), ylim=c(0,5), main="address accessed distribution (log10), slave-1")
plot(log10(tb.s2.addr), ylim=c(0,5), main="address accessed distribution (log10), slave-2")
plot(log10(tb.m1.addr), ylim=c(0,5), main="address accessed distribution (log10), master-1")
plot((tb.m1.addr), main="address accessed distribution, master-1")
tb.m1.iosz[1:10]
tb.m1.iosz.sort[1:10]
tb.s1.iosz.sort[1:10]
tb.s2.iosz.sort[1:10]
tb.m1.addr.sort[1:10]
tb.s1.addr.sort[1:10]
tb.s2.addr.sort[1:10]
tb.m1.addr.sort[1:10] / m1.ion
tb.m1.iosz.sort[1:10] / m1.ion
tb.m1.iosz.sort[1:10] * 100 / m1.ion
tb.m1.iosz.sort[1:10] * 100 / m1.ion
tb.s1.iosz.sort[1:10] * 100 / s1.ion
tb.s2.iosz.sort[1:10] * 100 / s2.ion
tb.m1.addr.sort[1:10] * 100 / m1.ion
tb.s1.addr.sort[1:10] * 100 / s1.ion
tb.s2.addr.sort[1:10] * 100 / s2.ion
plot(d.blktr.m1$addr, cex=ifelse(d.blktr.m1$tag_iot == '_IOT_R', .3, .1), col=ifelse(d.blktr.m1$tag_iot == '_IOT_R', 'green', ifelse(d.blktr.m1$tag_iosz_align == '_IOSZ_ALIGN_Y', 'blue', 'red')), main="address - master 1");
plot(d.blktr.m1$addr, cex=ifelse(d.blktr.m1$tag_iot == '_IOT_R', .1, ifelse(d.blktr.m1$tag_iosz_align == '_IOSZ_ALIGN_Y', .1, .3)), col=ifelse(d.blktr.m1$tag_iot == '_IOT_R', 'green', ifelse(d.blktr.m1$tag_iosz_align == '_IOSZ_ALIGN_Y', 'blue', 'red')), main="address - master 1");
tb.m1.iosz.sort[c(2,3)] * 100 / m1.ion
tb.m1.iosz.sort[c(2,3,5,8,9,10)] * 100 / m1.ion
sum(tb.m1.iosz.sort[c(2,3,5,8,9,10)] * 100 / m1.ion)
tb.m1.iosz.sort[c(2,3,5,8,9,10)] * 100 / m1.ion
tb.m1.iosz.sort[c(2,3,5,8,9,10)] * 100 / m1.ion * c(64, 96, 128, 384, 256, 1024)
64*6.41
tb.m1.iosz.sort[c(2,3,5,8,9,10)] * 100 / m1.ion * c(64, 96, 128, 384, 256, 1024)
sum(tb.m1.iosz.sort[c(2,3,5,8,9,10)] * 100 / m1.ion * c(64, 96, 128, 384, 256, 1024))
tb.m1.iosz.sort[1]
tb.m1.iosz.sort[1] * 10
tb.m1.iosz.sort[1] * 32
tb.m1.iosz.sort[1]
tb.m1.iosz.sort[1] * 100 / m1.ion
(tb.m1.iosz.sort[1] * 100 / m1.ion) * 32
sum(tb.s1.iosz.sort[c(2,3,5,8,9,10)] * 100 / m1.ion * c(64, 96, 128, 384, 256, 1024))
(tb.m1.iosz.sort[1] * 100 / m1.ion) * 32
tb.m1.iosz.sort[1] * 100 / m1.ion
tb.m1.iosz.sort[1:10] * 100 / m1.ion
tb.s1.iosz.sort[1:10] * 100 / s1.ion
tb.s1.iosz.sort[1:10] * 100 / s1.ion
tb.s1.iosz.sort[c(2,6,8,9,10)] * 100 / s1.ion
(tb.s1.iosz.sort[c(2,6,8,9,10)] * 100 / s1.ion)
(tb.s1.iosz.sort[c(2,6,8,9,10)] * 100 / s1.ion) * c(64,96,256,1024,128)
sum((tb.s1.iosz.sort[c(2,6,8,9,10)] * 100 / s1.ion) * c(64,96,256,1024,128))
sum((tb.s1.iosz.sort[c(1)] * 100 / s1.ion) * c(32))
sum((tb.s1.iosz.sort[c(2,6,8,9,10)]) * c(64,96,256,1024,128))
dim(d.blktr.s1)
tb.m1.iosz.sort[1]
tb.m1.iosz.sort[1:10]
tb.m1.iosz.sort[c(4,7)]
tb.m1.iosz.sort[c(4,7)] * c(1024, 512*3)
sum(tb.m1.iosz.sort[c(4,7)] * c(1024, 512*3))
sum(tb.m1.iosz.sort[c(4,7)] * c(1024, 512*3)) / 1000000
tb.m1.iosz.sort[1:100]
sum(tb.m1.iosz.sort)
sum(tb.m1.iosz.sort[1:2])
sum(tb.m1.iosz.sort[1:10])
sum(tb.m1.iosz.sort[1:10] * 100 / m1.ion)
(tb.m1.iosz.sort[1:10] * 100 / m1.ion)
(tb.m1.iosz.sort[c(4,7)] * 100 / m1.ion)
(tb.m1.iosz.sort[c(4,7)] * 100 / m1.ion) 
(tb.m1.iosz.sort[c(4,7)] * c(1,1) *  100 / m1.ion) 
(tb.m1.iosz.sort[c(4,7)] * c(2,3) *  100 / m1.ion) 
sum(tb.m1.iosz.sort[c(4,7)] * c(2,3) *  100 / m1.ion) 
sum(tb.m1.iosz.sort[c(4,7)] * c(2,3) * 512
sum(tb.m1.iosz.sort[c(4,7)] * c(2,3) * 512)
sum(tb.m1.iosz.sort[c(4,7)] * c(2,3) * 512) / 10^6
sum(tb.m1.iosz.sort[c(4,7)] * c(2,3) * 512) / 10^6
sum(tb.m1.iosz.sort[c(4,7)] * c(2,3) * 512) / 10^6
ls()
plot(table(d.blktr.m1$io_interval), cex=.5)
plot(log10(table(d.blktr.m1$io_interval)), cex=.5)
tb.m1.io_interval.log10  <- log10(table(d.blktr.m1$io_interval))
plot(tb.m1.io_interval.log10, cex=.5)
tb.m1.io_interval.log10[1:10]
tb.m1.io_interval.log10.sorted <- sort(tb.m1.io_interval.log10, decreasing=T)
tb.m1.io_interval.log10.sorted[1:10]
tb.m1.io_interval <- table(d.blktr.m1$io_interval)
tb.m1.io_interval.sorted <- sort(tb.m1.io_interval, decreasing=T)
tb.m1.io_interval.sorted[1:20]
barplot(tb.m1.io_interval.sorted[1:20])
barplot(tb.m1.io_interval.sorted[1:20], col=rainbow(20))
barplot(tb.m1.io_interval.sorted[1:100], col=rainbow(100))
dim(d.blktr.m1)[1]


dim(tb.m1.io_interval )
?round
l

?round
round(1.3324, digits=2)
round(1.3324, digits=0)
round(1.3324, digits=4)
round(1.33240003343, digits=4)
round(tb.m1.io_interval[1:100], digits=4)
round(0.12321321, digits=4)
round(tb.m1.io_interval[1:100], digits=4)
round(tb.m1.io_interval[1:100], digits=4)
round(tb.m1.io_interval[1:100], digits=4)
tb.m1.io_interval_100us <- round(tb.m1.io_interval, digits=4)
dim(tb.m1.io_interval_100us)
d.m1.io_interval <- round(d.blktr.m1$io_interval, digits=4)
dim(d.m1.io_interval)
dim(d.blktr.m1$io_interval)
d.blktr.m1$io_interval
lenght(d.m1.io_interval)
length(d.m1.io_interval)
dim(d.blktr.m1)
length(d.m1.io_interval
d.m1.io_interval_100us <- round(d.blktr.m1$io_interval, digits=4)
length(d.m1.io_interval_100us)
d.m1.io_interval_100us
table(d.m1.io_interval_100us)
tb.m1.io_interval_100us <- table(d.m1.io_interval_100us)
tb.m1.io_interval_100us.sorted <- sort(tb.m1.io_interval_100us, decreasing=T)
tb.m1.io_interval_100us.sorted[1:100]
barplot(tb.m1.io_interval_100us.sorted[1:100])
barplot(tb.m1.io_interval_100us.sorted[1:20], col=rainbow(20))
tb.m1.io_interval_100us.sorted[1:20]
tb.m1.io_interval_100us.sorted[1:20] * 100 / totalion
sum(tb.m1.io_interval_100us.sorted[1:20] * 100 / totalion)
d.blktr.m1[1:1000]
d.blktr.m1$timestamp[1:1000]
d.blktr.m1.r <- read.table('blktr.m1.p010._IOT_R.jung')
d.blktr.m1.w <- read.table('blktr.m1.p010._IOT_W.jung')
dim(d.blktr.m1.r)
dim(d.blktr.m1.w)
colnames(d.blktr.m1.w) <- c( "timestamp", "io_interval", "gbl_stg", "req_type", "addr", "iosz", "pname", "cpucore", "pid", "rwbs", "_", "tag_iot", "tag_iosz_align", "tag_iosz_huge", "tag_iointv");
colnames(d.blktr.m1.r) <- c( "timestamp", "io_interval", "gbl_stg", "req_type", "addr", "iosz", "pname", "cpucore", "pid", "rwbs", "_", "tag_iot", "tag_iosz_align", "tag_iosz_huge", "tag_iointv");
d.m1.w.io_interval_100ms <-  round(d.blktr.m1.w$io_interval, digits=4)
d.m1.r.d.m1.r.io_interval_100ms 
tb.m1.w.io_interval_100us <- table(d.m1.w.io_interval_100ms)
d.m1.w.io_interval_100us <- d.m1.w.io_interval_100ms
rm(d.m1.w.io_interval_100ms)
tb.m1.w.io_interval_100us.sorted <- sort(tb.m1.w.io_interval_100us, decreasing=T)
length(tb.m1.w.io_interval_100us.sorted)
tb.m1.w.io_interval_100us.sorted[1:100]
dim(d.blktr.m1.w)
dim(d.blktr.m1.w)[1]
dim(d.blktr.m1.w)[1]
dim(d.blktr.m1.w)[1]
ion.m1.w <- dim(d.blktr.m1.w)[1]
ion.m1.r <- dim(d.blktr.m1.r)[1]
ion.m1.w
ion.m1.r
d.m1.r.io_interval_100us <- d.m1.r.io_interval_100ms
rm(d.m1.r.io_interval_100ms)
d.m1.r.io_interval_100us[1:100]
d.m1.w.io_interval_100us[1:100]
dim(d.m1.w.io_interval_100us)
length(d.m1.w.io_interval_100us)
length(d.m1.r.io_interval_100us)
tb.m1.r.io_interval_100us <- table(d.m1.r.io_interval_100us)
tb.m1.r.io_interval_100us.sorted <- sort(tb.m1.r.io_interval_100us)
tb.m1.r.io_interval_100us.sorted
tb.m1.w.io_interval_100us.sorted
tb.m1.r.io_interval_100us.sorted
tb.m1.r.io_interval_100us.sorted <- sort(tb.m1.r.io_interval_100us, decreasing=T)
tb.m1.r.io_interval_100us.sorted
tb.m1.w.io_interval_100us.sorted
barplot(tb.m1.w.io_interval_100us.sorted)
barplot(tb.m1.r.io_interval_100us.sorted)
barplot(tb.m1.w.io_interval_100us.sorted)
barplot(tb.m1.w.io_interval_100us.sorted)
barplot(tb.m1.r.io_interval_100us.sorted)
barplot(log10(tb.m1.r.io_interval_100us.sorted))
barplot(log10(tb.m1.w.io_interval_100us.sorted))
barplot(log10(tb.m1.r.io_interval_100us.sorted))
barplot(log2(tb.m1.r.io_interval_100us.sorted))
barplot((tb.m1.r.io_interval_100us.sorted))
(tb.m1.r.io_interval_100us.sorted)[1:10]
sum(tb.m1.r.io_interval_100us.sorted)
dim(d.blktr.m1.r)
dim(d.blktr.m1.w)
sum(tb.m1.w.io_interval_100us.sorted)
sum(tb.m1.w.io_interval_100us.sorted)
ion.m1.w
sum(tb.m1.w.io_interval_100us.sorted[1:10]
)
sum(tb.m1.w.io_interval_100us.sorted[1:10]) * 100 / ion.m1.w
sum(tb.m1.w.io_interval_100us.sorted[1:100]) * 100 / ion.m1.w
sum(tb.m1.w.io_interval_100us.sorted[1:100]) * 100 / ion.m1.w
sum(tb.m1.w.io_interval_100us.sorted[1:20]) * 100 / ion.m1.w
(tb.m1.w.io_interval_100us.sorted[1:20]) * 100 / ion.m1.w
barplot((tb.m1.w.io_interval_100us.sorted[1:20]) * 100 / ion.m1.w)
barplot((tb.m1.w.io_interval_100us.sorted[1:20]) * 100 / ion.m1.w)
barplot((tb.m1.w.io_interval_100us.sorted[1:20]) * 100 / ion.m1.w, col=rainbow())
barplot((tb.m1.w.io_interval_100us.sorted[1:20]) * 100 / ion.m1.w, col=rainbow(20))
barplot((tb.m1.w.io_interval_100us.sorted[1:20]) * 100 / ion.m1.w, col=rainbow(20), ylim=c(0:100))
barplot((tb.m1.w.io_interval_100us.sorted[1:20]) * 100 / ion.m1.w, col=rainbow(20), ylim=c(0,100))
?cdplot
ecdf((tb.m1.w.io_interval_100us.sorted[1:20]))
plot(ecdf((tb.m1.w.io_interval_100us.sorted[1:20])))
plot(ecdf((tb.m1.w.io_interval_100us.sorted)))
plot(ecdf((tb.m1.w.io_interval_100us.sorted[1:20])))
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), xlim=c(1,20))
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), xlim=c(1,30))
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), xlim=c(1,20))
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), xlim=c(1,1000))
?plot
plot(ecdf((tb.m1.io_interval_100us.sorted)), xlim=c(1,1000))
points(ecdf((tb.m1.r.io_interval_100us.sorted)), xlim=c(1,1000), col='blue')
plot(ecdf((tb.m1.r.io_interval_100us.sorted)), xlim=c(1,1000), col='blue')
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), xlim=c(1,1000), col='red')
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), xlim=c(1,10000), col='red')
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), xlim=c(1,1000), col='red')
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), xlim=c(1,10000), col='red')
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), xlim=c(1,10000), col='red', cex=.5)
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), xlim=c(1,10000), col='red', cex=.5, pch=1)
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), col='red', cex=.5, pch=1)
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), xlim=c(1,10000), col='red', cex=.5, pch=1)
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), col='red', cex=.5, pch=1)
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), xlim=c(1,10000), col='red', cex=.5, pch=1)
plot(ecdf((tb.m1.r.io_interval_100us.sorted)), xlim=c(1,10000), col='red', cex=.5, pch=1)
plot(ecdf((tb.m1.r.io_interval_100us.sorted)), xlim=c(1,10000), ylim=c(0,1.1), col='red', cex=.5, pch=1)
plot(ecdf((tb.m1.r.io_interval_100us.sorted)), xlim=c(1,10000), ylim=c(0,1.0), col='red', cex=.5, pch=1)
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), xlim=c(1,10000), ylim=c(0,1.0), col='red', cex=.5, pch=1)
plot(ecdf((tb.m1.io_interval_100us.sorted)), xlim=c(1,10000), ylim=c(0,1.0), col='red', cex=.5, pch=1)
par(mfrow=c(3,1))
plot(ecdf((tb.m1.io_interval_100us.sorted)), xlim=c(1,10000), ylim=c(0,1.0), col='red', cex=.5, pch=1)
par(mfrow=c(1,3))
plot(ecdf((tb.m1.io_interval_100us.sorted)), xlim=c(1,10000), ylim=c(0,1.0), col='red', cex=.5, pch=1)
plot(ecdf((tb.m1.r.io_interval_100us.sorted)), xlim=c(1,10000), ylim=c(0,1.0), col='red', cex=.5, pch=1)
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), xlim=c(1,10000), ylim=c(0,1.0), col='red', cex=.5, pch=1)
par(mfrow=c(2,3))
plot(ecdf((tb.m1.io_interval_100us.sorted)), xlim=c(1,10000), ylim=c(0,1.0), col='red', cex=.5, pch=1)
plot(ecdf((tb.m1.r.io_interval_100us.sorted)), xlim=c(1,10000), ylim=c(0,1.0), col='blue', cex=.5, pch=1)
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), xlim=c(1,10000), ylim=c(0,1.0), col='red', cex=.5, pch=1)
plot(ecdf((tb.m1.io_interval_100us.sorted)), xlim=c(1,10000), ylim=c(0,1.0), col='black', cex=.5, pch=1)
plot(ecdf((tb.m1.io_interval_100us.sorted)), xlim=c(1,10000), ylim=c(0,1.0), col='black', cex=.5, pch=1)
plot(ecdf((tb.m1.io_interval_100us.sorted)), xlim=c(1,10000), ylim=c(0,1.0), col='black', cex=.5, pch=1)
par(mfrow=c(2,3))
plot(ecdf((tb.m1.io_interval_100us.sorted)), xlim=c(1,10000), ylim=c(0,1.0), col='black', cex=.5, pch=1)
plot(ecdf((tb.m1.r.io_interval_100us.sorted)), xlim=c(1,10000), ylim=c(0,1.0), col='blue', cex=.5, pch=1)
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), xlim=c(1,10000), ylim=c(0,1.0), col='red', cex=.5, pch=1)
barplot(ecdf((tb.m1.io_interval_100us.sorted)), xlim=c(1,10000), ylim=c(0,1.0), col='black', cex=.5, pch=1)
plot(ecdf((tb.m1.r.io_interval_100us.sorted)), xlim=c(1,100), ylim=c(0,1.0), col='black', cex=.5, pch=1)
plot(ecdf((tb.m1.r.io_interval_100us.sorted)), xlim=c(1,100), ylim=c(0,1.0), col='blue', cex=.5, pch=1)
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), xlim=c(1,100), ylim=c(0,1.0), col='red', cex=.5, pch=1)
ecdf
plot
plot.ecdf
?abline
abline(h=100, v=0.8)
abline(h=100, v=0.8)
abline(h=100, v=0.8)
abline(h=100, v=0.8)
abline(h=100, v=0.8)
abline(h=100, v=0.8)
abline(h=100, v=0.8)
abline(h=100, v=0.8)
abline(h=100, v=0.8)
abline(h=100, v=0.8)
abline(h=100, v=0.8)
?abline
l
par(mfrow=c(2,3))
plot(ecdf((tb.m1.io_interval_100us.sorted)), xlim=c(1,10000), ylim=c(0,1.0), col='black', cex=.5, pch=1)
abline(h=0.8, v=100)
abline(h=0.9, v=100)
?abline
plot(ecdf((tb.m1.r.io_interval_100us.sorted)), xlim=c(1,10000), ylim=c(0,1.0), col='blue', cex=.5, pch=1)
abline(h=c(0.8, 0.9), v=100)
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), xlim=c(1,10000), ylim=c(0,1.0), col='red', cex=.5, pch=1)
abline(h=c(0.8, 0.9), v=100)
plot(ecdf((tb.m1.io_interval_100us.sorted)), xlim=c(1,100), ylim=c(0,1.0), col='black', cex=.5, pch=1)
abline(h=c(0.8, 0.9), v=100)
plot(ecdf((tb.m1.r.io_interval_100us.sorted)), xlim=c(1,100), ylim=c(0,1.0), col='blue', cex=.5, pch=1)
abline(h=c(0.8, 0.9), v=100)
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), xlim=c(1,100), ylim=c(0,1.0), col='blue', cex=.5, pch=1)
abline(h=c(0.8, 0.9), v=100)
barplot((tb.m1.io_interval_100us.sorted), xlim=c(1,100), ylim=c(0,1.0), col='black', cex=.5, pch=1)
barplot((tb.m1.io_interval_100us.sorted), xlim=c(1,100), ylim=c(0,1.0), col='black', cex=.5)
barplot((tb.m1.io_interval_100us.sorted), xlim=c(1,100), ylim=c(0,1.0), col='black')
barplot((tb.m1.io_interval_100us.sorted), xlim=c(1,100), col=rainbow(100))
barplot((tb.m1.r.io_interval_100us.sorted), xlim=c(1,100), col=rainbow(100))
barplot((tb.m1.w.io_interval_100us.sorted), xlim=c(1,100), col=rainbow(100))
barplot((tb.m1.w.io_interval_100us.sorted), xlim=c(1,100), col=rainbow(100))
barplot((tb.m1.w.io_interval_100us.sorted), xlim=c(1,100), col=rainbow(100))
barplot((tb.m1.io_interval_100us.sorted), xlim=c(1,100), col=rainbow(100))
barplot((tb.m1.r.io_interval_100us.sorted), xlim=c(1,100), col=rainbow(100))
barplot((tb.m1.w.io_interval_100us.sorted), xlim=c(1,100), col=rainbow(100))
par(mfrow=c(3,3))
plot(ecdf((tb.m1.io_interval_100us.sorted)), xlim=c(1,1000), ylim=c(0,1.0), col='black', cex=.5, pch=1)
plot(ecdf((tb.m1.r.io_interval_100us.sorted)), xlim=c(1,1000), ylim=c(0,1.0), col='blue', cex=.5, pch=1)
par(mfrow=c(3,3))
plot(ecdf((tb.m1.r.io_interval_100us.sorted)), xlim=c(1,1000), ylim=c(0,1.0), col='blue', cex=.5, pch=1)
abline(h=c(0.8,0.9), v=100)
abline(h=c(0.8,0.9), v=100, col='red')
abline(h=c(0.8,0.9), v=100, col='gray')
abline(h=c(0.8,0.9), v=100, col='green')
abline(h=c(0.8,0.9), v=100, col='green')
par(mfrow=c(3,3))
plot(ecdf((tb.m1.io_interval_100us.sorted)), xlim=c(1,1000), ylim=c(0,1.0), col='black', cex=.5, pch=1)
abline(h=c(0.8,0.9), v=100, col='yellow')
abline(h=c(0.8,0.9), v=100, col='gray')
plot(ecdf((tb.m1.r.io_interval_100us.sorted)), xlim=c(1,1000), ylim=c(0,1.0), col='blue', cex=.5, pch=1)
abline(h=c(0.8,0.9), v=100, col='gray')
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), xlim=c(1,1000), ylim=c(0,1.0), col='red', cex=.5, pch=1)
abline(h=c(0.8,0.9), v=100, col='gray')
abline(h=c(0.8,0.9), v=20, col='gray')
par(mfrow=c(3,3))
par(mfrow=c(3,3))
plot(ecdf((tb.m1.io_interval_100us.sorted)), xlim=c(1,1000), ylim=c(0,1.0), col='black', cex=.5, pch=1)
abline(h=c(0.8,0.9), v=c(20,100), col='gray')
plot(ecdf((tb.m1.r.io_interval_100us.sorted)), xlim=c(1,1000), ylim=c(0,1.0), col='blue', cex=.5, pch=1)
abline(h=c(0.8,0.9), v=c(20,100), col='gray')
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), xlim=c(1,1000), ylim=c(0,1.0), col='red', cex=.5, pch=1)
abline(h=c(0.8,0.9), v=c(20,100), col='gray')
plot(ecdf((tb.m1.io_interval_100us.sorted)), xlim=c(1,100), ylim=c(0,1.0), col='black', cex=.5, pch=1)
abline(h=c(0.8,0.9), v=c(20,100), col='gray')
plot(ecdf((tb.m1.r.io_interval_100us.sorted)), xlim=c(1,100), ylim=c(0,1.0), col='blue', cex=.5, pch=1)
abline(h=c(0.8,0.9), v=c(20,100), col='gray')
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), xlim=c(1,100), ylim=c(0,1.0), col='red', cex=.5, pch=1)
abline(h=c(0.8,0.9), v=c(20,100), col='gray')
barplot((tb.m1.io_interval_100us.sorted), xlim=c(1,20), col=rainbow(100))
barplot((tb.m1.r.io_interval_100us.sorted), xlim=c(1,20), col=rainbow(100))
barplot((tb.m1.w.io_interval_100us.sorted), xlim=c(1,20), col=rainbow(100))
par(mfrow=c(3,3))
plot(ecdf((tb.m1.io_interval_100us.sorted)), xlim=c(1,1000), ylim=c(0,1.0), col='black', cex=.5, pch=1)
abline(h=c(0.8,0.9), v=c(20,100), col='gray')
plot(ecdf((tb.m1.r.io_interval_100us.sorted)), xlim=c(1,1000), ylim=c(0,1.0), col='blue', cex=.5, pch=1)
abline(h=c(0.8,0.9), v=c(20,100), col='gray')
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), xlim=c(1,1000), ylim=c(0,1.0), col='red', cex=.5, pch=1)
abline(h=c(0.8,0.9), v=c(20,100), col='gray')
plot(ecdf((tb.m1.io_interval_100us.sorted)), xlim=c(1,100), ylim=c(0,1.0), col='black', cex=.5, pch=1)
abline(h=c(0.8,0.9), v=c(20,100), col='gray')
plot(ecdf((tb.m1.r.io_interval_100us.sorted)), xlim=c(1,100), ylim=c(0,1.0), col='blue', cex=.5, pch=1)
abline(h=c(0.8,0.9), v=c(20,100), col='gray')
plot(ecdf((tb.m1.w.io_interval_100us.sorted)), xlim=c(1,100), ylim=c(0,1.0), col='red', cex=.5, pch=1)
abline(h=c(0.8,0.9), v=c(20,100), col='gray')
ion.m1.r + ion.m1.w
dim(d.blktr.m1)
dim(d.blktr.m1)[1]
ion.m1.all <- dim(d.blktr.m1)[1]
barplot((tb.m1.io_interval_100us.sorted)*100/ion.m1.all, xlim=c(1,20), ylim=c(0,100), col=rainbow(100))
barplot((tb.m1.r.io_interval_100us.sorted)*100/ion.m1.r, xlim=c(1,20), ylim=c(0,100), col=rainbow(100))
barplot((tb.m1.w.io_interval_100us.sorted)*100/ion.m1.w, xlim=c(1,20), ylim=c(0,100), col=rainbow(100))
tb.m1.io_interval_100us.sorted[1:20]
l
savehistory('.rhist.20140306.r')
