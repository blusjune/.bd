#!/bin/sh
# find . -name '*.blktrace.*' -exec dirname {} \; | sort -u > log




_dirs=$(cat dnrf.leaf.txt);
..ts;
for _i in $_dirs; do
	echo "$_i";
	(cd $_i;
	for _dev in $(ls -1 *.blktrace.* | sed -e 's/\(.*\)\.blktrace\.[0-9]*/\1/g' | sort -u); do
		_tla_blk_p0_raw="blktr.${_dev}.p0.log";
		_tla_blk_p010_jung="blktr.${_dev}.p010.jung";
		.mlt_blkparse -hs $_dev > $_tla_blk_p0_raw;
		cat $_tla_blk_p0_raw | bsc.x9.iowa.blktr.p010v02.py > $_tla_blk_p010_jung;
	done
	..ts;
	)
done




