#!/bin/sh


## read configuration
. .raidconf




echo "
>>> mdadm --query --detail $_md_dev";
mdadm --query --detail $_md_dev;

echo "
>>> umount $_md_dev";
umount $_md_dev;

echo "
>>> mdadm --stop $_md_dev";
mdadm --stop $_md_dev;




