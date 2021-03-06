#!/usr/bin/env R




library(arules);
library(arulesViz);
library(e1071);
library(HMM);




cgtp_1 <- array(0, c(10,1));
for (i in 1:10) {
	cgtp_1[i] <- paste(sample(c(rep('0', 10), rep('1', 10))), collapse='')
}

cl_1 <- kmeans(cgtp_1, 5);
plot(cgtp_1, col=cl_1$cluster);




cgtp_2 <- array(0, c(10,1));
cgtp_2[1]  <- "01000100010010001001";
cgtp_2[2]  <- "01000100010010001001";
cgtp_2[3]  <- "01000100010010001001";
cgtp_2[4]  <- "00010100000100001001";
cgtp_2[5]  <- "00100001000010010010";
cgtp_2[6]  <- "01000010000100000000";
cgtp_2[7]  <- "10000010000010000010";
cgtp_2[8]  <- "10000010000010000010";
cgtp_2[9]  <- "00100001000010010010";
cgtp_2[10] <- "01000010001001000110";

cl_2 <- kmeans(cgtp_2, 6);
plot(cgtp_2, col=cl_2$cluster);




cgtop_vec <- array(0, c(12,1));
cgtop_vec[1]  <- "01000100010010001001";
cgtop_vec[2]  <- "01000100010010001001";
cgtop_vec[3]  <- "01000100010010001001";
cgtop_vec[4]  <- "00010100000100001001";
cgtop_vec[5]  <- "00100001000010010010";
cgtop_vec[6]  <- "01000010000100000000";
cgtop_vec[7]  <- "10000010000010000010";
cgtop_vec[8]  <- "10000010000010000010";
cgtop_vec[9]  <- "00100001000010010010";
cgtop_vec[10] <- "01000010001001000110";
cgtop_vec[11]  <- "00100001000010010010";
cgtop_vec[12]  <- "00100001000010010010";
cl_3 <- kmeans(cgtop_vec, 6);
plot(cgtop_vec, col=cl_3$cluster);





