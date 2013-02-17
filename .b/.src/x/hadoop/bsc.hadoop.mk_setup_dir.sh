#!/bin/sh

##bsc.hadoop.mk_setup_dir.sh
##tstamp: 20121127_014612

read -p ">>> destination directory to create hadoop setup directory: " _dstdir;

_rootdir="${HOME}/.b/.src/x/hadoop";
if [ ! -d "$_dstdir" ]; then
	mkdir -p $_dstdir;
fi

cp -r $_rootdir/.hadoop_setup $_dstdir;
