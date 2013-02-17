#!/bin/sh

_tgt_dev_list="sdb sdc sdd";
_mnt_opt="-o noatime";

for _i in $_tgt_dev_list; do
	echo ">>> mount $_mnt_opt /dev/$_i /mnt/$_i";
	mount $_mnt_opt /dev/$_i /mnt/$_i;
done
