#!/bin/sh

_target_disk_list=$1;

_di="mlt.L2_sys_io.tlog";
cat $_di | awk "{ if (\$3 == '$_target_disk') { print \$0 } }"
