#!/bin/sh

##bsc.krnl.ftrace.filter_update.sh
##tstamp: 20121206_014526
##tstamp: 20121206_155701
##tstamp: 20121207_000301


_ft="/sys/kernel/debug/tracing";
_ft_filter="set_ftrace_filter";
_filter_cfg="/tmp/${_ft_filter}.cfg";
_ft_buf_size="10000";


read -p "do you want to edit filter.cfg ? [y|n]" _ans;
if [ "X$_ans" = "Xy" ]; then
	vi $_filter_cfg
fi


read -p "go ahead with edited filter.cfg ? [y|n]" _ans;
if [ "X$_ans" != "Xy" ]; then
	echo "#>> nothing happened, exit";
	exit 0;
fi


echo 1 > $_ft/buffer_size_kb;
echo 0 > $_ft/tracing_on;
cat $_filter_cfg | grep -v '#' > $_ft/$_ft_filter;
read -p "ready to restart ftrace? [y|n]" _ans;
echo $_ft_buf_size > $_ft/buffer_size_kb;
echo 1 > $_ft/tracing_on;
