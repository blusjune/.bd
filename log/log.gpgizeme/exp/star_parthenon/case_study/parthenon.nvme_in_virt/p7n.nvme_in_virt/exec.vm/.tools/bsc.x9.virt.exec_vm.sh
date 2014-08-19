#!/bin/sh




#_opt_vnc="-vnc localhost:2";
_opt_vnc="";
_disk_0="disk0_root.img";
_disk_1="disk1_data.img";
_disk_2="disk2_tlog.img";
_log_root="/x/ramdisk/kvmlog";
_kvm_exec_log_prefix="kvm.exec.log";
_kvm_exec_log="${_log_root}/${_kvm_exec_log_prefix}-$(date +%Y%m%s_%H%M%s)";
_log_latest_link="${_kvm_exec_log_prefix}.latest";




if [ "X$(id -u)" != "X0" ]; then
	echo "#ERROR>> you SHOULD have root privilege -- EXIT";
	exit 1;
fi




if [ ! -d $_log_root ]; then
	mkdir -p $_log_root;
fi
update_latest_kvm_exec_log()
{
	(cd $_log_root;
	_log_latest=$(ls -1 | grep -- "${_kvm_exec_log_prefix}-" | tail -1);
	if [ "X$_log_latest" = "X" ]; then
		echo "#ERROR>> no $_kvm_exec_log_prefix files have been created -- EXIT";
		exit 1;
	fi
	if [ -e $_log_latest_link ]; then
		rm $_log_latest_link;
	fi
	ln -s $_log_latest $_log_latest_link;
	)
}




_target_nvme_partition="nvme0n1p2";
_nvme_mount_point="/mnt/$_target_nvme_partition";
_check_nvme_mount()
{
	if [ "X$(mount | grep $_target_nvme_partition | wc -l)" = "X0" ]; then
		echo "$_target_nvme_partition is not mounted yet";
		if [ -e /dev/$_target_nvme_partition ]; then
			mount /dev/$_target_nvme_partition $_nvme_mount_point;
			echo "$_target_nvme_partition is mounted successfully";
		fi
	fi
}




_launch_vm__nvme_virtio()
{
	touch $_kvm_exec_log;
	update_latest_kvm_exec_log;

	## it works well
	_check_nvme_mount;
	/usr/local/x/qemu/bin/qemu-system-x86_64 \
		-d int,cpu,ioport \
		--enable-kvm \
		-smp 24 \
		-m 100000 \
		-hda $_disk_0 \
		-hdb $_disk_2 \
		-drive file=${_nvme_mount_point}/${_disk_1},if=virtio,id=nvme012,cache=writethrough \
		-net user,hostfwd=tcp::10022-:22 -net nic \
		$_opt_vnc \
		> $_kvm_exec_log

	#/usr/local/x/qemu/bin/qemu-system-x86_64 -m 100000 -hda $_disk_0 -hdb $_disk_2 -drive file=/mnt/nvme0n1p2/${_disk_1},if=virtio,id=nvme012,cache=writethrough -device virtio-blk-pci,drive=nvme012,serial=1234 --enable-kvm -smp 24 $_opt_vnc -net user,hostfwd=tcp::10022-:22 -net nic -d int,cpu,ioport > $_kvm_exec_log  ## it does not work well ## qemu-system-x86_64: -drive file=/mnt/nvme0n1p2/disk1_data.img,if=virtio,id=nvme012,cache=writethrough: Property 'virtio-blk-pci.drive' can't take value 'nvme012', it's in use
}




_launch_vm__nvme_normal()
{
	touch $_kvm_exec_log;
	update_latest_kvm_exec_log;

	## it works well
	_check_nvme_mount;
	/usr/local/x/qemu/bin/qemu-system-x86_64 \
		-d int,cpu,ioport \
		--enable-kvm \
		-smp 24 \
		-m 100000 \
		-hda $_disk_0 \
		-hdb $_disk_2 \
		-drive file=${_nvme_mount_point}/${_disk_1},if=none,id=nvme012,cache=writethrough \
		-device nvme,drive=nvme012,serial=1234 \
		-net user,hostfwd=tcp::10022-:22 -net nic \
		$_opt_vnc \
		> $_kvm_exec_log
}




_launch_vm__nvme_pciept()
{
	touch $_kvm_exec_log;
	update_latest_kvm_exec_log;

	## it works well
	modprobe pci_stub;

	_nvme_dev_id=$(lspci | grep -i -- 'Non-Volatile memory controller' | awk '{ print $1 }');
	_nvme_dev_dom_id=$(lspci -D | grep -i -- 'Non-Volatile memory controller' | awk '{ print $1 }');
	_nvme_vendor_device_id=$(lspci -Dn | grep "$_nvme_dev_dom_id" | awk '{ print $3 }' | awk -F ':' '{ print $1, $2 }');

	echo "NVMe_dev_ID ($_nvme_dev_id)";
	echo "NVMe_dev_ID_with_domain ($_nvme_dev_dom_id)";
	echo "NVMe_device_and_vendor_ID ($_nvme_vendor_device_id)";

	_pci_drivers_pcistub_newid="/sys/bus/pci/drivers/pci-stub/new_id";
	_pci_devices_driver_unbind="/sys/bus/pci/devices/${_nvme_dev_dom_id}/driver/unbind";
	_pci_drivers_pcistub_bind="/sys/bus/pci/drivers/pci-stub/bind";

	echo "#>> preparing PCIe passthrough for NVMe device ($_nvme_dev_dom_id $_nvme_vendor_device_id) ...";
	echo "$_nvme_vendor_device_id" > $_pci_drivers_pcistub_newid;
	echo "$_nvme_dev_dom_id" > $_pci_devices_driver_unbind;
	echo "$_nvme_dev_dom_id" > $_pci_drivers_pcistub_bind;
	echo "#>> PCIe passthrough started";

	modprobe kvm;
	modprobe kvm-intel;

	/usr/local/x/qemu/bin/qemu-system-x86_64 \
		-d int,cpu,ioport \
		--enable-kvm \
		-smp 24 \
		-m 100000 \
		-hda $_disk_0 \
		-hdb $_disk_2 \
		-device pci-assign,host=${_nvme_dev_id} \
		-net user,hostfwd=tcp::10022-:22 -net nic \
		$_opt_vnc \
		> $_kvm_exec_log
}




_launch_vm__nvme_normal;
#_launch_vm__nvme_virtio;
#_launch_vm__nvme_pciept;




