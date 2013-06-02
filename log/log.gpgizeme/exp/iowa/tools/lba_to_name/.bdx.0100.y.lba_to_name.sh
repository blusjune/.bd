#!/bin/sh
##.bdx.0100.y.lba_to_name.sh
##_ver=20130311_153256
##_ver=20130311_190202
##_ver=20130312_190544




_conf=".conf.lba_to_name.sh";
if [ -r $_conf ]; then
	. $_conf;
	echo "#>> '_conf__target_lba_list' is configured from '$_conf' file";
else
	echo "#>> ERROR: '$_conf' conf-file is not found -- EXIT";
	echo "
'_conf__target_lba_list' can be generated from:
a1mjjung@secm:[iowa.sim.iox.20130306_202654.sigio_25.iowsz_100.t1_1000] $ tail -19 __simout.sigio_25.iowsz_100.t1_1000.__list__hitnum_and_addrs__.log.v2
1105 : [1267153912]
1113 : [1661223296]
1115 : [12856320, 12857344]
1237 : [2480]
1686 : [1266681984]
1693 : [1266683032]
1730 : [1266683160]
1732 : [2352]
1941 : [1661223328]
2077 : [2048]
2110 : [1267095912]
2188 : [327569400]
2265 : [1266683048]
2309 : [327568408]
2342 : [327568936]
2364 : [1661223320]
2395 : [1661223136]
2526 : [1401209744]
7185 : [1661223128]
";
	exit 1;
fi




read -p "#<< _conf__target_dev (e.g., /dev/sda) : " _conf__target_dev;
read -p "#<< _conf__target_dev_part (e.g., /dev/sda1) : " _conf__target_dev_part;

echo "----";
sudo fdisk -lu $_conf__target_dev | grep $_conf__target_dev_part
sudo tune2fs -l $_conf__target_dev_part | grep -i "Block Size"
echo "----";

read -p "#<< _conf__lba_fs_start: " _conf__lba_fs_start;
read -p "#<< _conf__fblk_size: " _conf__fblk_size;
read -p "#<< _conf__sector_size [512]: " _conf__sector_size;
if [ "X$_conf__sector_size" = "X" ]; then
	_conf__sector_size=512;
fi




_cal_fblk()
{
#	_lba_target     : target LBA
#	_lba_fs_start   : LBA which file system (partition) start (fdisk -lu /dev/sda)
#	_sector_size    : sector size in bytes (typically 512)
#	_fblk_size      : file system block size in bytes (tune2fs -l /dev/sda1 | grep Block)
	if [ "X$_lba_target" = "X" ]; then
		echo "#>> ERROR: _lba_target is not set -- EXIT";
		exit 1;
	fi
	if [ "X$_lba_fs_start" = "X" ]; then
		echo "#>> ERROR: _lba_fs_start is not set -- EXIT";
		exit 1;
	fi
	if [ "X$_sector_size" = "X" ]; then
		echo "#>> ERROR: _sector_size is not set -- EXIT";
		exit 1;
	fi
	if [ "X$_fblk_size" = "X" ]; then
		echo "#>> ERROR: _fblk_size is not set -- EXIT";
		exit 1;
	fi
	echo "( (($_lba_target - $_lba_fs_start) * $_sector_size) / $_fblk_size )" | bc
}




_target_dev_part=$_conf__target_dev_part;
_lba_fs_start=$_conf__lba_fs_start;
_sector_size=$_conf__sector_size;
_fblk_size=$_conf__fblk_size;
echo "
#>> START Processing";
for _items in $_conf__target_lba_list; do
# processing $_lba_target (on $_target_dev_part) ... debugfs{testb/icheck/ncheck}";
	_lba_target=$_items;
	_fblk=$(_cal_fblk);

	echo -n "${_target_dev_part}: $_lba_target ";

	_testblk_result="$(sudo debugfs -R "testb $_fblk" $_target_dev_part 2>&1 | grep -v 'debugfs')";
	_invalid_flag="$(echo $_testblk_result | grep -i "invalid block")";
	if [ "X$_invalid_flag" != "X" ]; then
		echo "-> _EXCEPTION_ # fsblock $_fblk seems INVALID BLOCK -- Skip processing";	
		continue;
	fi
	_inuse_flag="$(echo $_testblk_result | grep $_fblk | grep -i 'marked in use')";
	if [ "X$_inuse_flag" = "X" ]; then
		echo "-> _EXCEPTION_ # fsblock $_fblk is NOT IN USE -- Skip processing";	
		continue;
	fi

	_inode=$(sudo debugfs -R "icheck $_fblk" $_target_dev_part 2>&1 | grep -v 'debugfs' | grep $_fblk | awk '{ print $2 }')
	if [ "X$_inode" = "X<block" ]; then # exceptional case: "<block not found>"
		echo "-> _EXCEPTION_ # inode for $_fblk is NOT FOUND -- Skip processing";
	else
		_target_name=$(sudo debugfs -R "ncheck $_inode" $_target_dev_part 2>&1 | grep -v 'debugfs' | grep $_inode | sed -e "s/$_inode[ 	]*\(.*\)/\1/g" | awk '{ print $0 }');
		echo "-> $_target_name # DEV:LBA:FBLK:INODE( $_target_dev_part : $_lba_target : $_fblk : $_inode )";
	fi
done




