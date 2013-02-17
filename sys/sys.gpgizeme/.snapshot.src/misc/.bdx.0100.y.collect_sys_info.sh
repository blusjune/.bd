#!/bin/sh

## .bdx.0100.y.collect_sys_info.sh
##tstamp: 20121006_211639


#sudo aa-status > aa-status.log		## 'apparmor' related stuff
sudo ifconfig > ifconfig.log
sudo iptables -S > iptables.log
sudo lsb_release -a > lsb_release.log 2>&1
sudo lsblk > lsblk.log 
sudo lscpu > lscpu.log
sudo lshw > lshw.log 
sudo lspci > lspci.log
sudo lsscsi > lsscsi.log
sudo lsusb > lsusb.log 
sudo mount > mount.log
sudo route -n > route-n.log


ls -alF ~/x/ > x_list.log

# _whoami=$(whoami);
# sudo chown $_whoami:$_whoami *.log
