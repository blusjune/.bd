#!/bin/sh
#./R/.bdx.0100.y.iowa_anal.sh
#_ver=20130429_135104




## read configuration
. iowa_anal.conf

## per-case different configuration
_infile="f010.T021.${_target}.R.out";
_iotype_rw="Reads Only";




. .bdx.0010.n.iowa_anal_s0010_core.sh;
