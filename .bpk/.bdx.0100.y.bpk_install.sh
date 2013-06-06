#!/bin/sh

## .bdx.0100.y.bpk_install.sh
##tstamp: 20121026_004955
##tstamp: 20121026_012313

_bpk_latest="$(ls -1 bpk-*.asc.sh.gz | tail -1)";
gunzip -c $_bpk_latest > ./bpk.sh;
. ./bpk.sh;
rm -fr ./bpk.sh ./.bpk_td#bpk*

