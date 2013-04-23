clear
unset key
set title "I/O intensiveness - Reads/Writes (MSN FileServer 6H)"
set xlabel "time (30-minute)"
set ylabel "address (LBA)"
set zlabel "hit count per addr"
show view
#set view 45, 60
set view 70, 80
show view
splot './f040.iomw_acs_cnt.sorted_by_acs_cnt' u 3:2:1 with points palette pointsize 2 pointtype 7
