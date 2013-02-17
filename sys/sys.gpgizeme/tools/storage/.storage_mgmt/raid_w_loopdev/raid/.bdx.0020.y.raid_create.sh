#!/bin/sh


## read configuration
. .raidconf




echo "
>>> mdadm -C $_md_dev --level=$_raid_level --raid-devices=$_nrdev $_rdev_list";
mdadm -C $_md_dev --level=$_raid_level --raid-devices=$_nrdev $_rdev_list;
if [ "X$?" != "X0" ]; then
	echo ">>> you abort RAID creation and further processing";
	exit 1;
fi

	## this does not work -_-;
	#echo ">>> mke2fs -t $_fstype -L ssd_raid_${_raid_level} $_md_dev";
	#mke2fs -t $_fstype -L ssd_raid_${_raid_level} $_md_dev;

echo "
>>> mkfs -t ext3 -L LO_Arr_${_raid_level} $_md_dev";
mkfs -t ext3 -L LO_Arr_${_raid_level} $_md_dev;

echo "
>>> mount $_md_dev $_mount_pt";
mount $_md_dev $_mount_pt;

echo "
>>> dumpe2fs -h $_md_dev";
dumpe2fs -h $_md_dev;




