#!/bin/sh




_dev="sdb";




_d=".data";
if [ ! -d $_d ]; then
	mkdir -p $_d;
fi

_list1=$(find . -name "blktr.$_dev.p010.jung" | grep -v 'result-s');
for _f1 in $_list1; do
	_name1=$(echo $_f1 | awk -F '/' '{ print $2 }');
	_name2=$(echo $_f1 | awk -F '/' '{ print $3 }' | awk -F 'm' '{ print $2 }');
	_blktr_p010_name="blktr.${_name1}.${_name2}.p010.jung"
	echo $_blktr_p010_name
#	(cd $_d;
#	 	ln -s ../$_f1 $_blktr_p010_name;
#	)
done




exit 0;

f1 <- "blktr.1.xfs.m.sdb.p010.jung"
f2 <- "blktr.1.xfs.s.sdb.p010.jung"
f3 <- "blktr.2.ext4.m.sdb.p010.jung"
f4 <- "blktr.2.ext4.s.sdb.p010.jung"
f5 <- "blktr.3.f2fs.m.sdb.p010.jung"
f6 <- "blktr.3.f2fs.s.sdb.p010.jung"

find . -name 'blktr.sdb.p010.jung'
