#!/bin/sh
## BMCX: B Mail-based Command eXecution
## Fri May 11 00:45:23 KST 2012




_timestamp="$(date +%Y%m%d_%H%M%S)";

_bmcx_dir="${HOME}/.bmcx.d/${_timestamp}";
_bmcx_cmd="${_bmcx_dir}/.bmcx.${_timestamp}.sh";
_bmcx_log="${_bmcx_dir}/.bmcx.${_timestamp}.log";

mkdir -p $_bmcx_dir;
echo '(subject #!bmcx?#)
d' | mailx -N -f ${HOME}/.getmail/mbox/gmail.mbox | grep 'BMCX__' | sed -e 's/BMCX__\(.*\)/\1/g' > $_bmcx_cmd;
touch $_bmcx_log;

(
cd $_bmcx_dir;

_start_time=$(date +%s);
echo "##BMCX## start time: $_start_time (~= $(date))" >> $_bmcx_log;
echo "##BMCX## -----
" >> $_bmcx_log;
cat $_bmcx_cmd | sh | tee -a $_bmcx_log;
echo "
##BMCX## -----" >> $_bmcx_log;
_finish_time=$(date +%s);
echo "##BMCX## finish time: $_finish_time (~= $(date))" >> $_bmcx_log;
_elapsed_time=$(echo "$_finish_time - $_start_time" | bc);
echo "##BMCX## elapsed time: $_elapsed_time" >> $_bmcx_log;
)

