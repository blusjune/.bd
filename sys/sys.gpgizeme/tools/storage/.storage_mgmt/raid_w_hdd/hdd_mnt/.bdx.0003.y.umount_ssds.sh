#!/bin/sh

_tgt_dev_list="sdc1 sdd1 sde1";

for _i in $_tgt_dev_list; do
	echo "umount /x/mnt/$_i";
	umount /x/mnt/$_i;
done
