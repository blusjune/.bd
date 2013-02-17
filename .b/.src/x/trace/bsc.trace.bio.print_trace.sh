#!/bin/sh

### Wed Mar 14 21:56:04 KST 2012

_this_prog=$(basename $0);

if [ $# -eq 0 ]; then
        echo "[usage] $_this_prog <one or more device path(s)>";
        echo "	e.g., $_this_prog /dev/sda1 /dev/sdb1 /dev/sdc2";
	echo "";
	echo "[help] quick checklist for trouble shooting";
	echo "	$ mount -t debugfs debugfs /sys/kernel/debug # mount debugfs";
	echo "	$ blktrace -d /dev/xxx -k # remove zombie blktrace";
	echo "";
        exit 0;
else
        _devpath_list="$*";
        _dev_id_list="dev";
        for _i in $_devpath_list; do
                _dev_id="$(echo $_i | sed -e 's/.*\/\(.*\)/\1/g')";
                _dev_id_list=${_dev_id_list}_${_dev_id};
        done
fi
_timestamp="$(date +%Y%m%d-%H%M%S)";
_blktrace_out="traceout.${_dev_id_list}.${_timestamp}.blktrace";
_blkparse_out="traceout.${_dev_id_list}.${_timestamp}.blkparse";

#blktrace -d /dev/${_device} -o - | tee ${_blktrace_out} | blkparse -i - -f "%5T.%9t %D %2c [ %6p : %5s ] %2a %8S : %4n ( %8N ) # %C\n" | tee ${_blkparse_out};

echo "blktrace ${_devpath_list} -o - | tee ${_blktrace_out} | blkparse -i - -f \"%5T.%9t %D %2c %3d [ %6p : %5s ] %2a %8S : %4n ( %8N ) # %C\n\" | tee ${_blkparse_out}";
blktrace ${_devpath_list} -o - | tee ${_blktrace_out} | blkparse -i - -f "%5T.%9t %D %2c %3d [ %6p : %5s ] %2a %8S : %4n ( %8N ) # %C\n" | tee ${_blkparse_out};


