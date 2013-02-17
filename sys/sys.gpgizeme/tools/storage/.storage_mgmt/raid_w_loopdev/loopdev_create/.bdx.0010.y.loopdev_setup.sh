
_loopdev_list="loop0 loop1 loop2 loop3";

for _i in $_loopdev_list; do
	echo "
--
	";
	_dd_bs=4096 _dd_count=1000000 _dd_if="/dev/zero" _loopdev="/dev/$_i" _mount_pt="/x/mnt/$_i" bsc.loop_dev_fs.create
done
