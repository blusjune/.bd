#!/bin/sh
#./A/.bdx.0100.y.iowa_anal.sh
#_ver=20130429_135104




## read configuration
. iowa_anal.conf

## per-case different configuration
_infile="f010.T011.${_target}.out";
_iotype_rw="Reads/Writes";




. .bdx.0010.n.iowa_anal_s0010_core.sh;
