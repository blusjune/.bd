#!/usr/bin/env gnuplot


clear
set xlabel "time (microsec)"
set ylabel "address (LBA)"
set title "MSN FileServer 6h Trace (Top 5 Processes, Dot)"


plot \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p0_2004.out" u 2:5 w dot, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p1_4.out" u 2:5 w dot, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p2_4.out" u 2:5 w dot, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p2_1500.out" u 2:5 w dot, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p3_1500.out" u 2:5 w dot \
;
quit;


plot \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p0_2004.out" u 2:5 w dot, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p1_4.out" u 2:5 w dot, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p2_4.out" u 2:5 w dot, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p2_1500.out" u 2:5 w dot, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p3_1500.out" u 2:5 w dot, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p3_1216.out" u 2:5 w dot, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p4_1500.out" u 2:5 w dot, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p2_1216.out" u 2:5 w dot, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p1_1216.out" u 2:5 w dot, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p1_1500.out" u 2:5 w dot \
;
quit


plot \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p0_2004.out" u 2:5 w dot, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p1_4.out" u 2:5 w p, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p2_4.out" u 2:5 w p, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p2_1500.out" u 2:5 w p, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p3_1500.out" u 2:5 w p\
;
quit;


plot \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p0_2004.out" u 2:5 w dot, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p1_4.out" u 2:5 w p, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p2_4.out" u 2:5 w p, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p2_1500.out" u 2:5 w p, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p3_1500.out" u 2:5 w p, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p3_1216.out" u 2:5 w p, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p4_1500.out" u 2:5 w p, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p2_1216.out" u 2:5 w p, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p1_1216.out" u 2:5 w p, \
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p1_1500.out" u 2:5 w p \
;
quit







    584  _prid__p1_1500 
    646  _prid__p1_1216 
    826  _prid__p2_1216 
    972  _prid__p4_1500 
   1428  _prid__p3_1216 
   2512  _prid__p3_1500 
   2900  _prid__p2_1500 
  37866  _prid__p2_4 
  78975  _prid__p1_4 
29212972  _prid__p0_2004 



# ls -1 T033.msn_filesrvr.discovery_4plot.* | grep -e "_prid__p1_1500" -e "_prid__p1_1216" -e "_prid__p2_1216" -e "_prid__p4_1500" -e "_prid__p3_1216" -e "_prid__p3_1500" -e "_prid__p2_1500" -e "_prid__p2_4" -e "_prid__p1_4" -e "_prid__p0_2004"
# ls -1 T033.msn_filesrvr.discovery_4plot.* | grep -e _prid__p3_1500 -e _prid__p2_1500 -e _prid__p2_4 -e _prid__p1_4 -e _prid__p0_2004 



plot
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p0_2004.out" u 2:5 w dot,
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p1_4.out" u 2:5 w dot,
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p2_4.out" u 2:5 w dot,
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p2_1500.out" u 2:5 w dot,
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p3_1500.out" u 2:5 w dot,
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p3_1216.out" u 2:5 w dot,
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p4_1500.out" u 2:5 w dot,
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p2_1216.out" u 2:5 w dot,
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p1_1216.out" u 2:5 w dot,
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p1_1500.out" u 2:5 w dot
;

plot
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p0_2004.out" u 2:5 w dot,
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p1_4.out" u 2:5 w dot,
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p2_4.out" u 2:5 w dot,
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p2_1500.out" u 2:5 w dot,
"./T033.msn_filesrvr.discovery_4plot.process_id._prid__p3_1500.out" u 2:5 w dot
;

