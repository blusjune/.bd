#!/bin/sh

qemu-img create -f qcow2 disk0_root.img 512G
qemu-img create -f qcow2 disk2_tlog.img 512G
