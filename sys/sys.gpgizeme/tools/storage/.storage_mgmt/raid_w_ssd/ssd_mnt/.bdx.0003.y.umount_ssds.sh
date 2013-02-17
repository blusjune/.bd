#!/bin/sh

_tgt_dev_list="sdb sdc sdd";

for _i in $_tgt_dev_list; do
	echo "umount /mnt/$_i";
	umount /mnt/$_i;
done
