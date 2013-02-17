#!/bin/sh
##_ver="20121211_151120";


. .bdx-env.ftrace.sh




_tmplog=".tmp.log";
_ftlog=$(cd $_ftdir; ls -1 ${_ftlog_head}.* | tail -1);

(cd $_ftdir;
read -p "#>> target function: " _tfunc;
grep "$_tfunc <-" $_ftlog | awk '{ print $5 }' > $_tmplog;
cat $_tmplog | sort -u | tee ${_ftlog}.p1.${_tstamp};
)
