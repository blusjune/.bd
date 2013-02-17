#!/bin/sh
## .bdx.0100.y.analexec__range_ptrns.sh
## _ver=20130118_103419
## _ver=20130130_191245


_k_spec=".k_of_kaddrgrp";
if [ -f $_k_spec ]; then
	_k_of_kaddrgrp=$(cat $_k_spec);
	echo "#>> k of k-addr-group is set to '$_k_of_kaddrgrp'";
else
	echo "#>> ERROR: $_k_spec file does not exist -- EXIT";
	exit 1;
fi

_range_spec=".addr_range";
if [ -f $_range_spec ]; then
	_range=$(cat $_range_spec);
	echo "#>> address range is set to '$_range'";
else
	echo "#>> ERROR: $_range_spec file does not exist -- EXIT";
	exit 1;
fi


_tstamp="$(tstamp)";
_input_file="infile";	## hard-coded in analysis python script
_output_file="out.range_ptrns-${_tstamp}";
_plotdir="plot-${_tstamp}";

if [ ! -f $_input_file ]; then
	echo "#>> ERROR: No input file '$_input_file' -- EXIT";
	exit 1;
fi

echo "#>> START: $_tstamp"
bsc.iowa.lsp.addr.range_ptrns -k $_k_of_kaddrgrp -r $_range > $_output_file
echo "#>> END: $(tstamp)"


mkdir $_plotdir;

_anal_item="addr_range_countdist";
_of_log="${_output_file}.${_anal_item}.log";
cat $_output_file | grep "__${_anal_item}__" > $_of_log;
cat $_of_log | awk '{ print $2, $4 }' | sort -n > ${_plotdir}/${_anal_item};

_anal_item="runs_range_countdist";
_of_log="${_output_file}.${_anal_item}.log";
cat $_output_file | grep "__${_anal_item}__" > $_of_log;
cat $_of_log | awk '{ print $2, $4 }' | sort -n > ${_plotdir}/${_anal_item};

_anal_item="addr_range_hit_interval";
_of_log="${_output_file}.${_anal_item}.log";
cat $_output_file | grep "__${_anal_item}__" > $_of_log;
cat $_of_log | awk '{ print $2, $4 }' | sort -n > ${_plotdir}/${_anal_item};

_anal_item="rehit_interval";
_of_log="${_output_file}.${_anal_item}.log";
cat $_output_file | grep "__${_anal_item}__" > $_of_log;
cat $_of_log | awk '{ print $2, $4 }' | sort -n > ${_plotdir}/${_anal_item};

_anal_item="k_addr_group";
_of_log="${_output_file}.${_anal_item}.log";
cat $_output_file | grep "__${_anal_item}__" > $_of_log;
cat $_of_log | awk '{ print $2, $4 }' | sort -n > ${_plotdir}/${_anal_item};


