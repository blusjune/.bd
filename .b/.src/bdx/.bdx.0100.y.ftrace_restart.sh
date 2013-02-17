#!/bin/sh
##_ver="20121211_150004";




## current_tracer
_ct="function";
#_ct="function_graph";


_tstamp=$(tstamp);
_bufsz=100000;
_attic=".archive";


if [ ! -d $_attic ]; then
	mkdir -p $_attic;
fi


echo 1 > tracing/tracing_enabled;

echo 1 > tracing/buffer_size_kb;
echo 0 > tracing/tracing_on;
echo $_ct > tracing/current_tracer;

cat tracing/set_ftrace_filter > $_attic/set_ftrace_filter.${_tstamp}.logtmp;
cat cfg.set_ftrace_filter | grep -v '#' > tracing/set_ftrace_filter;

echo $_bufsz > tracing/buffer_size_kb;
echo 1 > tracing/tracing_on;
