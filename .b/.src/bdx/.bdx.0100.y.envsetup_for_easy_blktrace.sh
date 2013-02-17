#!/bin/sh
##tstamp: 20121008_014838


## 
sysctl -w kernel.io_delay_type=3
sysctl kernel.io_delay_type

echo noop > /sys/block/sdb/queue/scheduler 
cat /sys/block/sdb/queue/scheduler 

## http://www.kernel.org/doc/Documentation/sysctl/vm.txt
sysctl -w vm.dirty_writeback_centisecs='1' 
sysctl vm.dirty_writeback_centisecs

## http://www.kernel.org/doc/Documentation/sysctl/vm.txt
sysctl -w vm.dirty_expire_centisecs='1'
sysctl vm.dirty_expire_centisecs

## http://linux-mm.org/Drop_Caches
sysctl -w vm.drop_caches=2
sysctl vm.drop_caches


