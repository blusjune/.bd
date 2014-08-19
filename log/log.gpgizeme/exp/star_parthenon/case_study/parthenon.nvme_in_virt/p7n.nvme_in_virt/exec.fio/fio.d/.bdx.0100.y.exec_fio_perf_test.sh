#_ver=20140620_034643




#fio --minimal --latency-log --bandwith-log .nvme-test.fio;
#fio --minimal .nvme-test.fio;




if [ "X$(id -u)" != "X0" ]; then
        echo "#ERROR>> you SHOULD have root privilege -- EXIT";
        exit 1;
fi




_DEV_default="nvme0n1p1";
_TG_default="XXXX"; # Tag
_QD_default="192"; # QueueDepth
_NJ_default="192"; # Number of Jobs
_BS_default="4k";  # Block Size
_TY_default="RW";  # IO Type: SR(SequentialRead), SW(SequentialWrite), RR(RandomRead), RW(RandomWrite)
_mlt_test_cnf="test.cnf";




if [ "X$_DEV" = "X" ]; then
	lsblk;
	echo "------------------------------------------------
";
	read -p "_DEV [$_DEV_default]: " _DEV;
	if [ "X$_DEV" = "X" ]; then
		_DEV=$_DEV_default;
	fi
fi
if [ "X$_TG" = "X" ]; then
	read -p "_TG [$_TG_default]: " _TG;
	if [ "X$_TG" = "X" ]; then
		_TG=$_TG_default;
	fi
fi
if [ "X$_QD" = "X" ]; then
	read -p "_QD [$_QD_default]: " _QD;
	if [ "X$_QD" = "X" ]; then
		_QD=$_QD_default;
	fi
fi
if [ "X$_NJ" = "X" ]; then
	read -p "_NJ [$_NJ_default]: " _NJ;
	if [ "X$_NJ" = "X" ]; then
		_NJ=$_NJ_default;
	fi
fi
if [ "X$_BS" = "X" ]; then
	read -p "_BS [$_BS_default]: " _BS;
	if [ "X$_BS" = "X" ]; then
		_BS=$_BS_default;
	fi
fi
if [ "X$_TY" = "X" ]; then
	read -p "_TY [$_TY_default]: " _TY;
	if [ "X$_TY" = "X" ]; then
		_TY=$_TY_default;
	fi
fi




_fio_job_file=".p7n_test.fio";
_test_name="tg${_TG}_ty${_TY}_qd${_QD}_nj${_NJ}_bs${_BS}";




#_DEV="nvme0n1p1";
_target_dev_mount_point="/mnt/$_DEV";
_check_nvme_mount()
{
        if [ "X$(mount | grep $_DEV | wc -l)" = "X0" ]; then
                echo "$_DEV is not mounted yet - SHOULD be mounted";
                if [ -e /dev/$_DEV ]; then
                        mount /dev/$_DEV $_target_dev_mount_point;
                        echo "$_DEV is mounted successfully";
                fi
        fi
}
_check_nvme_mount;




cat > $_fio_job_file << EOF_FIO_JOB_BASE
# Brian M. JUNG <brian.m.jung@gmail.com>
# _ver=20140620_024609

# Do some important numbers on SSD drives, to gauge what kind of
# performance you might get out of them.
#
# Sequential read and write speeds are tested, these are expected to be
# high. Random reads should also be fast, random writes are where crap
# drives are usually separated from the good drives.
#
# This uses a queue depth of 4. New SATA SSD's will support up to 32
# in flight commands, so it may also be interesting to increase the queue
# depth and compare. Note that most real-life usage will not see that
# large of a queue depth, so 4 is more representative of normal use.
#

[global]
iodepth=$_QD
numjobs=$_NJ
bs=$_BS
direct=1
ramp_time=30
runtime=60
randrepeat=1
overwrite=0
ioengine=libaio
group_reporting
time_based
norandommap
size=1g
filename=fio.test.file
directory=$_target_dev_mount_point
name=${_test_name}
EOF_FIO_JOB_BASE


_EXIT_NOW="n";
case $_TY in
"SR")
	cat >> $_fio_job_file << EOF_FIO_JOB_IOTYPE

[seq-read]
rw=read
stonewall
EOF_FIO_JOB_IOTYPE
	;;
"SW")
	cat >> $_fio_job_file << EOF_FIO_JOB_IOTYPE

[seq-write]
rw=write
stonewall
EOF_FIO_JOB_IOTYPE
	;;
"RR")
	cat >> $_fio_job_file << EOF_FIO_JOB_IOTYPE

[rand-read]
rw=randread
stonewall
EOF_FIO_JOB_IOTYPE
	;;
"RW")
	cat >> $_fio_job_file << EOF_FIO_JOB_IOTYPE

[rand-write]
rw=randwrite
stonewall
EOF_FIO_JOB_IOTYPE
	;;
*)
	echo "#BDX>> ERROR: '$_TY' is NOT a valid token -- EXIT";
	_EXIT_NOW="y";
	;;
esac

if [ "X$_EXIT_NOW" = "Xy" ]; then
	exit -1;
fi




_tstamp=$(tstamp);
_test_id="FIO_${_tstamp}";
cat > /tmp/$_mlt_test_cnf << EOF_MLT_TEST_CNF
# $_tstamp
_test_param_id="$_test_id";
_test_param_seq="1_of_1";         # 1,12,24,192
_test_param_name="TCase";
_test_param_val="$_test_name";
EOF_MLT_TEST_CNF
echo "'/tmp/$_mlt_test_cnf' is created";
cat /tmp/$_mlt_test_cnf | head -2;
echo "
";




_test_result_dir="result";
if [ ! -d $_test_result_dir ]; then
	mkdir -p $_test_result_dir;
fi
_fio_result_out_file="${_test_result_dir}/${_test_id}.${_test_name}.out";




echo "start FIO ($_test_name) ...";
fio --append-terse --output=$_fio_result_out_file $_fio_job_file




