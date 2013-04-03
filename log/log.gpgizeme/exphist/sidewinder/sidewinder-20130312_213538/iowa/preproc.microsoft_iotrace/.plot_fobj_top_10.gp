#/usr/bin/env gnuplot
#_ver=20130403_232747




set title "MSN FileServer I/O Trace (Top 10 Hot file_obj)";
set xlabel "time (microseconds)";
set ylabel "address (LBA)";
set yr [0:3e+11];




plot \
"T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3b166db0.out" u 2:5 w dot, \
"T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3adc7660.out" u 2:5 w dot, \
"T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3b1603f0.out" u 2:5 w dot, \
"T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3aafef40.out" u 2:5 w dot, \
"T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3b71e8f0.out" u 2:5 w dot, \
"T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3ada5d20.out" u 2:5 w dot, \
"T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3bde8ab0.out" u 2:5 w dot, \
"T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3c2c97b0.out" u 2:5 w dot, \
"T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3b90cda0.out" u 2:5 w dot, \
"T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3ab668d0.out" u 2:5 w dot \
;
quit;




plot \
"T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3b166db0.out" u 2:5 w p, \
"T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3adc7660.out" u 2:5 w p, \
"T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3b1603f0.out" u 2:5 w p, \
"T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3aafef40.out" u 2:5 w p, \
"T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3b71e8f0.out" u 2:5 w p, \
"T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3ada5d20.out" u 2:5 w p, \
"T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3bde8ab0.out" u 2:5 w p, \
"T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3c2c97b0.out" u 2:5 w p, \
"T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3b90cda0.out" u 2:5 w p, \
"T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3ab668d0.out" u 2:5 w p \
;
quit;




T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3b166db0.out
T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3adc7660.out
T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3b1603f0.out
T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3aafef40.out
T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3b71e8f0.out
T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3ada5d20.out
T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3bde8ab0.out
T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3c2c97b0.out
T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3b90cda0.out
T033.msn_filesrvr.discovery_4plot.file_obj._fobj__0xfffffadf3ab668d0.out




ls -1 T033.msn_filesrvr.discovery_4plot* | grep 0xfffffadf3b166db0
ls -1 T033.msn_filesrvr.discovery_4plot* | grep 0xfffffadf3adc7660
ls -1 T033.msn_filesrvr.discovery_4plot* | grep 0xfffffadf3b1603f0
ls -1 T033.msn_filesrvr.discovery_4plot* | grep 0xfffffadf3aafef40
ls -1 T033.msn_filesrvr.discovery_4plot* | grep 0xfffffadf3b71e8f0
ls -1 T033.msn_filesrvr.discovery_4plot* | grep 0xfffffadf3ada5d20
ls -1 T033.msn_filesrvr.discovery_4plot* | grep 0xfffffadf3bde8ab0
ls -1 T033.msn_filesrvr.discovery_4plot* | grep 0xfffffadf3c2c97b0
ls -1 T033.msn_filesrvr.discovery_4plot* | grep 0xfffffadf3b90cda0
ls -1 T033.msn_filesrvr.discovery_4plot* | grep 0xfffffadf3ab668d0




0xfffffadf3b166db0
0xfffffadf3adc7660
0xfffffadf3b1603f0
0xfffffadf3aafef40
0xfffffadf3b71e8f0
0xfffffadf3ada5d20
0xfffffadf3bde8ab0
0xfffffadf3c2c97b0
0xfffffadf3b90cda0
0xfffffadf3ab668d0


