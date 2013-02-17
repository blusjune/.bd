#!/bin/sh

##tstamp: 20121006_105740

_vroot="vroot";
_host_specific_root="conf/$(uname -n)";
if [ -L $_vroot ]; then
	echo ">>> update existing $_vroot";
	rm $_vroot;
fi
ln -s $_host_specific_root $_vroot;
