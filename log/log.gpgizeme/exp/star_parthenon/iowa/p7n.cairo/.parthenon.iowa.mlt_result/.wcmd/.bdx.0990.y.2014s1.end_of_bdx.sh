#!/bin/sh
#_ver=20140520_172517


_tstamp=$(tstamp);
_cwd=$(pwd | sed -e 's/\//_/g');
touch .end_of_bdx.${_tstamp}.${_cwd};
