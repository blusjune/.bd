#/usr/bin/env gnuplot
#_ver=20130403_232747




set title "MSN FileServer I/O Trace (Top 10 Hot full_path)";
set xlabel "time (microseconds)";
set ylabel "address (LBA)";
set yr [0:3e+11];




plot \
"T033.msn_filesrvr.discovery_4plot.full_path._path__Disk8__s4_s5_s6.out" u 2:5 w dot, \
"T033.msn_filesrvr.discovery_4plot.full_path._path__Disk9__s0_s1_s13.out" u 2:5 w dot, \
"T033.msn_filesrvr.discovery_4plot.full_path._path__Disk8__s0_s1_s7.out" u 2:5 w dot, \
"T033.msn_filesrvr.discovery_4plot.full_path._path__Disk9__s3_s4_s6.out" u 2:5 w dot, \
"T033.msn_filesrvr.discovery_4plot.full_path._path__Disk8__s0_s1_s9.out" u 2:5 w dot, \
"T033.msn_filesrvr.discovery_4plot.full_path._path__Disk9__s0_s1_s7.out" u 2:5 w dot, \
"T033.msn_filesrvr.discovery_4plot.full_path._path__Disk9__s3_s4_s5.out" u 2:5 w dot, \
"T033.msn_filesrvr.discovery_4plot.full_path._path__Disk9__s0_s1_s3.out" u 2:5 w dot, \
"T033.msn_filesrvr.discovery_4plot.full_path._path__Disk8__s0_s1_s2.out" u 2:5 w dot, \
"T033.msn_filesrvr.discovery_4plot.full_path._path__Disk9__s0_s1_s2.out" u 2:5 w dot \
;
quit;







 382331  _path_    "Disk8:\s4\s5\s6"
 403592  _path_    "Disk9:\s0\s1\s13"
 413900  _path_    "Disk8:\s0\s1\s7"
 418544  _path_    "Disk9:\s3\s4\s6"
 428969  _path_    "Disk8:\s0\s1\s9"
 450260  _path_    "Disk9:\s0\s1\s7"
 466085  _path_    "Disk9:\s3\s4\s5"
 600647  _path_    "Disk9:\s0\s1\s3"
 811630  _path_    "Disk8:\s0\s1\s2"
 982166  _path_    "Disk9:\s0\s1\s2"
