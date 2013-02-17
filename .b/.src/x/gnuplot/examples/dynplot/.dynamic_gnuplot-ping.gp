# .dynamic_gnuplot-ping.gp

set key left Left rev bottom
set grid
set ylabel "time (s)"
set xlabel "icmp seq (#)"
set yrange [0:]
load ".dynamic_gnuplot-ping-loop.gp"

