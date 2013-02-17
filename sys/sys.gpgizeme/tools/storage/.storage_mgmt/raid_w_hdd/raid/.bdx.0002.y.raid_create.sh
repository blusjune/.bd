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

echo "
>>> mkfs -t ext3 -L HDD_Arr_${_raid_level} $_md_dev";
mkfs -t ext3 -L HDD_Arr_${_raid_level} $_md_dev;

if [ ! -d $_mount_pt ]; then
	echo "
>>> $_mount_pt does not exist, create it now";
	mkdir -p $_mount_pt;
fi
echo "
>>> mount $_md_dev $_mount_pt";
mount $_md_dev $_mount_pt;

echo "
>>> dumpe2fs -h $_md_dev";
dumpe2fs -h $_md_dev;




