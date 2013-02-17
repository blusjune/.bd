#!/bin/sh

## bsc.bdx.gpgize_install.sh
## 20120816_012141

read -p ">>> destination directory to install bdx.gpgize suite: " _dstdir;

_rootdir="${HOME}/.b/.src/x/sec";
if [ ! -d "$_dstdir" ]; then
	mkdir -p $_dstdir;
fi

cp -r $_rootdir/gpgize/.bdx.* $_dstdir;
