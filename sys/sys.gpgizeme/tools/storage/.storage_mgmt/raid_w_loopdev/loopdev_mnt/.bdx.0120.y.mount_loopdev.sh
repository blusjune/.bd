#!/bin/sh

_tgt_dev_list="loop0 loop1 loop2 loop3";
_mnt_opt="-o noatime";

for _i in $_tgt_dev_list; do
	echo ">>> mount $_mnt_opt /dev/$_i /x/mnt/$_i";
	mount $_mnt_opt /dev/$_i /x/mnt/$_i;
done
