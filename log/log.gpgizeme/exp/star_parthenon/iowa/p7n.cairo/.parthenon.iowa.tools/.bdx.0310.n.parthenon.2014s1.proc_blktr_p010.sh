#!/bin/sh
# find . -name '*.blktrace.*' -exec dirname {} \; | sort -u > log




_dirs=$(cat dnrf.leaf.txt);
..ts;
for _i in $_dirs; do
	echo "$_i";
	(cd $_i;
	for _dev in $(ls -1 *.blktrace.* | sed -e 's/\(.*\)\.blktrace\.[0-9]*/\1/g' | sort -u); do
		.mlt_blkparse $_dev > blktr.${_dev}.p0.log;
		cat blktr.${_dev}.p0.log | bsc.x9.iowa.blktr.p010v02.py > blktr.${_dev}.p010.jung
	done
	..ts;
	)
done




