##.bdx-env.ftrace.sh
##_ver=20121211_221711
##_ver=20121213_133101


_tstamp="$(tstamp)";
_ftlog_head="ftlog";
_ftdir="/x/ftrace.logd";
#_pid="$$";
_pid="$(cat /sys/kernel/debug/tracing/set_ftrace_pid)";




if [ ! -d $_ftdir ]; then
	mkdir -p $_ftdir;
fi




