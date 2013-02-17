# .dynamic_gnuplot-ping-loop.gp

plot "< awk '{len1=length($6)-9; len2=length($8)-5; print substr($6, 10, len1),  substr($8, 6, len2)}' ping.update" t "www.google.com" w l
reread
