#!/bin/sh

_tpmc_file="tpcc.p010.tpmc.jung";
_dat="dat.tpmc.txt";

find . -name $_tpmc_file -exec echo -n {} \; -exec cat {} \; | sed -e "s/$_tpmc_file//g" | sed -e 's/\// /g' | sed -e 's/-/_/g' | awk '{ print $2"."$3, $4 }' > $_dat;
cat $_dat;
