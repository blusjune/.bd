qemu-system-x86_64 -m 110000 -hda main.img \
                   -hdb /mnt/853t/pm853t.img \
		   -drive file=/mnt/vnvm/vm_nvme.img,if=none,id=N22 -device nvme,drive=N22,serial=1234 \
                   --enable-kvm -smp 24 -vnc localhost:2 \
		   -net user,hostfwd=tcp::10022-:22 -net nic
