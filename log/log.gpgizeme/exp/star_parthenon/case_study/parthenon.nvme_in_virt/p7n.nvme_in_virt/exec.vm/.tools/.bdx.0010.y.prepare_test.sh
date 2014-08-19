#!/bin/sh

_nvme_dev="/dev/nvme0n1p2";
_nvme_dir="/mnt/nvme0n1p2";
if [ ! -f ${_nvme_dir}/..__NVME0N1P2_MOUNTED__ ]; then
	sudo mount -t ext4 -o noatime,discard $_nvme_dev $_nvme_dir;
	sudo chown -R b:b $_nvme_dir;
	(cd $_nvme_dir; sudo touch ..__timestamp_$(date +%Y%m%d_%H%M%S)__;)
	ls -alF $_nvme_dir;
fi
