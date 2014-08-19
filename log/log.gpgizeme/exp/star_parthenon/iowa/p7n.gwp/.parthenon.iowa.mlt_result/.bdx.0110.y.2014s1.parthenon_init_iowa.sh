#!/bin/sh
#_author="Brian M. JUNG <brian.m.jung@gmail.com>";
#_ver=20140510_144304;


_work_p7n=".work.p7n";

if [ ! -d ../${_work_p7n} ]; then
	(cd ..; mkdir -p $_work_p7n);
fi

_wcmd_dir=".wcmd";
_wcmd_files=$(cd $_wcmd_dir; ls -1 .bdx.* .bsc.* .bpy.* .rcmd.*)

_dat_files="
mlt.L3_db_01_oflm.tlog
mlt.L3_db_02_onlm.tlog
mlt.L3_db_03_onlm.tlog
";

echo -n "#P7N>> copying worker command files ... ";
(cd $_wcmd_dir; tar cf - $_wcmd_files) | (cd ../${_work_p7n}; tar xf -);
echo "completed";

_mltdir="$(cd ..; ls -1F | grep '/' | awk -F'/' '{print $1}')"; 
_idstr=$(echo $_mltdir | awk -F'.' '{print $1, $2}')

if [ "X$(echo $_idstr | awk '{ print $1 }')" = "Xmlt" ]; then
	if [ "X$(echo $_idstr | awk '{print $2}' | sed -e 's/[0-9]\{8\}_[0-9]\{6\}/MATCHED/g')" = "XMATCHED" ]; then
		echo -n "#P7N>> copying data files ... ";
		(cd ../$_mltdir; cp $_dat_files ../${_work_p7n};)
		echo "completed";
	else
		echo "#P7N:ERROR>> could not find the proper directory for the trace log data -- EXIT";
		exit 1;
	fi
else
	echo "#P7N:ERROR>> failed to identify MLT related directory -- EXIT";
	exit 1;
fi


