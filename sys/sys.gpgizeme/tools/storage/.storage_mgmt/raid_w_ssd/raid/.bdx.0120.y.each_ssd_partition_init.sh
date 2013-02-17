#!/bin/sh

## read configuration
. .raidconf

echo "_rdev_list: { $_rdev_list }";
read -p ">>> Do you want to edit the list of RAID member devices? [y|n] " _ans;
if [ "X$_ans" = "Xy" -o "X$_ans" = "XY" ]; then
	for _i in $_rdev_list; do
		_ii="$(echo $_i | sed -e 's/\([^0-9]*\)\([0-9]*\)/\1/g')";
		fdisk $_ii;
	done
fi

