#!/bin/sh
## bsc.gnuplot.install_examples.sh
## Fri Apr 13 01:48:33 KST 2012

_timestamp="$(date +%Y%m%d_%H%M%S)";
_exdir=".gnuplot-examples-$_timestamp";

if [ -d $_exdir ]; then
	echo ">>> $_exdir already exists! terminate this program";
	exit 1;
fi

(cp -r ${HOME}/.b/.src/x/gnuplot/examples $_exdir);
