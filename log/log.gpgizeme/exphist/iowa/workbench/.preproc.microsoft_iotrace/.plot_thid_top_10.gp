



############################################################################
clear
set yr [0:3e+11];
set title "MSN FileServer I/O Trace (Top 1 Hot Threads)";
set xlabel "time (microseconds)"
set ylabel "address (LBA)"
unset key;


plot \
"T033.msnfs.discovery_4plot.thread_id._thid__1756.out" u 2:5 w dot \
;
quit;







############################################################################
clear
set yr [0:3e+11];
set title "MSN FileServer I/O Trace (Top 3 Hot Threads)";
set xlabel "time (microseconds)"
set ylabel "address (LBA)"
unset key;


plot \
"T033.msnfs.discovery_4plot.thread_id._thid__8172.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__248.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__1756.out" u 2:5 w dot \
;
quit;







############################################################################
clear
set yr [0:3e+11];
set title "MSN FileServer I/O Trace (Top 5 Hot Threads)";
set xlabel "time (microseconds)"
set ylabel "address (LBA)"
unset key;


plot \
"T033.msnfs.discovery_4plot.thread_id._thid__11244.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__3508.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__8172.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__248.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__1756.out" u 2:5 w dot \
;
quit;







############################################################################
clear
set yr [0:3e+11];
set title "MSN FileServer I/O Trace (Top 10 Hot Threads)";
set xlabel "time (microseconds)"
set ylabel "address (LBA)"
unset key;


plot \
"T033.msnfs.discovery_4plot.thread_id._thid__8504.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__3800.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__9440.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__3348.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__10480.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__11244.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__3508.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__8172.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__248.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__1756.out" u 2:5 w dot \
;
quit;




############################################################################
clear
set yr [0:3e+11];
set title "MSN FileServer I/O Trace (Top 50 Hot Threads)";
set xlabel "time (microseconds)"
set ylabel "address (LBA)"
unset key;


plot \
"T033.msnfs.discovery_4plot.thread_id._thid__9700.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__9360.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__9044.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__11024.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__6096.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__8880.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__10948.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__9512.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__10000.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__6160.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__5588.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__7620.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__11240.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__9148.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__10916.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__4028.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__10960.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__5344.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__10508.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__704.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__9820.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__9592.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__8284.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__9680.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__1456.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__8992.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__10892.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__4644.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__6168.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__9228.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__4060.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__9300.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__4396.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__11152.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__10788.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__4184.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__9896.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__10244.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__3748.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__9792.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__8504.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__3800.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__9440.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__3348.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__10480.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__11244.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__3508.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__8172.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__248.out" u 2:5 w dot, \
"T033.msnfs.discovery_4plot.thread_id._thid__1756.out" u 2:5 w dot \
;
quit;


############################################################################


T033.msnfs.discovery_4plot.thread_id._thid__9700.out
T033.msnfs.discovery_4plot.thread_id._thid__9360.out
T033.msnfs.discovery_4plot.thread_id._thid__9044.out
T033.msnfs.discovery_4plot.thread_id._thid__11024.out
T033.msnfs.discovery_4plot.thread_id._thid__6096.out
T033.msnfs.discovery_4plot.thread_id._thid__8880.out
T033.msnfs.discovery_4plot.thread_id._thid__10948.out
T033.msnfs.discovery_4plot.thread_id._thid__9512.out
T033.msnfs.discovery_4plot.thread_id._thid__10000.out
T033.msnfs.discovery_4plot.thread_id._thid__6160.out
T033.msnfs.discovery_4plot.thread_id._thid__5588.out
T033.msnfs.discovery_4plot.thread_id._thid__7620.out
T033.msnfs.discovery_4plot.thread_id._thid__11240.out
T033.msnfs.discovery_4plot.thread_id._thid__9148.out
T033.msnfs.discovery_4plot.thread_id._thid__10916.out
T033.msnfs.discovery_4plot.thread_id._thid__4028.out
T033.msnfs.discovery_4plot.thread_id._thid__10960.out
T033.msnfs.discovery_4plot.thread_id._thid__5344.out
T033.msnfs.discovery_4plot.thread_id._thid__10508.out
T033.msnfs.discovery_4plot.thread_id._thid__704.out
T033.msnfs.discovery_4plot.thread_id._thid__9820.out
T033.msnfs.discovery_4plot.thread_id._thid__9592.out
T033.msnfs.discovery_4plot.thread_id._thid__8284.out
T033.msnfs.discovery_4plot.thread_id._thid__9680.out
T033.msnfs.discovery_4plot.thread_id._thid__1456.out
T033.msnfs.discovery_4plot.thread_id._thid__8992.out
T033.msnfs.discovery_4plot.thread_id._thid__10892.out
T033.msnfs.discovery_4plot.thread_id._thid__4644.out
T033.msnfs.discovery_4plot.thread_id._thid__6168.out
T033.msnfs.discovery_4plot.thread_id._thid__9228.out
T033.msnfs.discovery_4plot.thread_id._thid__4060.out
T033.msnfs.discovery_4plot.thread_id._thid__9300.out
T033.msnfs.discovery_4plot.thread_id._thid__4396.out
T033.msnfs.discovery_4plot.thread_id._thid__11152.out
T033.msnfs.discovery_4plot.thread_id._thid__10788.out
T033.msnfs.discovery_4plot.thread_id._thid__4184.out
T033.msnfs.discovery_4plot.thread_id._thid__9896.out
T033.msnfs.discovery_4plot.thread_id._thid__10244.out
T033.msnfs.discovery_4plot.thread_id._thid__3748.out
T033.msnfs.discovery_4plot.thread_id._thid__9792.out
T033.msnfs.discovery_4plot.thread_id._thid__8504.out
T033.msnfs.discovery_4plot.thread_id._thid__3800.out
T033.msnfs.discovery_4plot.thread_id._thid__9440.out
T033.msnfs.discovery_4plot.thread_id._thid__3348.out
T033.msnfs.discovery_4plot.thread_id._thid__10480.out
T033.msnfs.discovery_4plot.thread_id._thid__11244.out
T033.msnfs.discovery_4plot.thread_id._thid__3508.out
T033.msnfs.discovery_4plot.thread_id._thid__8172.out
T033.msnfs.discovery_4plot.thread_id._thid__248.out
T033.msnfs.discovery_4plot.thread_id._thid__1756.out




ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__9700.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__9360.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__9044.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__11024.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__6096.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__8880.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__10948.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__9512.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__10000.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__6160.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__5588.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__7620.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__11240.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__9148.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__10916.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__4028.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__10960.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__5344.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__10508.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__704.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__9820.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__9592.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__8284.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__9680.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__1456.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__8992.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__10892.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__4644.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__6168.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__9228.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__4060.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__9300.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__4396.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__11152.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__10788.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__4184.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__9896.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__10244.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__3748.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__9792.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__8504.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__3800.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__9440.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__3348.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__10480.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__11244.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__3508.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__8172.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__248.out'
ls -1 T033.msnfs.discovery_4plot.* | grep -e '_thid__1756.out'




-rw-rw-r-- 1 a1mjjung X0101   4322802 Apr  4 12:53 T033.msnfs.discovery_4plot.thread_id._thid__9864.out
-rw-rw-r-- 1 a1mjjung X0101       221 Apr  4 12:53 T033.msnfs.discovery_4plot.thread_id._thid__9872.out
-rw-rw-r-- 1 a1mjjung X0101       129 Apr  4 12:53 T033.msnfs.discovery_4plot.thread_id._thid__9892.out
-rw-rw-r-- 1 a1mjjung X0101  11939458 Apr  4 12:53 T033.msnfs.discovery_4plot.thread_id._thid__9896.out
-rw-rw-r-- 1 a1mjjung X0101   1928284 Apr  4 12:53 T033.msnfs.discovery_4plot.thread_id._thid__9912.out
-rw-rw-r-- 1 a1mjjung X0101      3910 Apr  4 12:53 T033.msnfs.discovery_4plot.thread_id._thid__9928.out
-rw-rw-r-- 1 a1mjjung X0101       301 Apr  4 12:53 T033.msnfs.discovery_4plot.thread_id._thid__9956.out
-rw-rw-r-- 1 a1mjjung X0101       264 Apr  4 12:54 T033.msnfs.discovery_4plot.thread_id._thid__9960.out
-rw-rw-r-- 1 a1mjjung X0101       254 Apr  4 12:54 T033.msnfs.discovery_4plot.thread_id._thid__9968.out
-rw-rw-r-- 1 a1mjjung X0101   1001304 Apr  4 12:54 T033.msnfs.discovery_4plot.thread_id._thid__9992.out





