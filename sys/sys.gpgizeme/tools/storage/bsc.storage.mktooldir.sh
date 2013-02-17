#!/bin/sh

_tgt_dir=".storage_mgmt";

if [ -d $_tgt_dir ]; then
	echo "$_tgt_dir already exists. check please.";
	exit 0;
fi

(cd ${HOME}/.b/.src/x/storage; tar cf - .storage_mgmt) | tar xf -;

