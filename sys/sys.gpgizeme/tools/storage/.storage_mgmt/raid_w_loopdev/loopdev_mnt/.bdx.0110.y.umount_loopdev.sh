#!/bin/sh

_tgt_dev_list="loop0 loop1 loop2 loop3";

for _i in $_tgt_dev_list; do
	echo "umount /dev/$_i";
	umount /dev/$_i;
done
