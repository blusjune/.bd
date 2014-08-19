#!/bin/sh


_fnrf="fnrf.fio_out.txt";
_filelist=$(cat $_fnrf);


_d_tab="d.tab";
echo "tcase_name  bandwidth  iops  slat  clat  cpu_usr_pct  cpu_sys_pct" > $_d_tab;
for _i in $_filelist; do
	tail -1 $_i | awk -F';' '{ print $3, $48, $49, $53, $57, $88, $89 }' | sed -e 's/%//g' >> $_d_tab;
done
