#!/bin/sh




. .bdx-env.ftrace.sh




_ftlog="${_ftdir}/${_ftlog_head}.${_tstamp}.pid_${_pid}.log";




## online monitoring (but may be with massive noise)
cat /sys/kernel/debug/tracing/trace_pipe | tee $_ftlog;

## offline trace dump
#cat /sys/kernel/debug/tracing/trace > $_ftlog;

