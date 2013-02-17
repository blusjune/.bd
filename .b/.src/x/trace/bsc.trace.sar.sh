#!/bin/sh
## sar.collect (sar: system activity report)
## 20120815_225946
## 20121023_023335


if [ "X$_session_id" = "X" ]; then
	_session_id="$(date +%Y%m%d_%H%M%S)";
fi
_logfile="${_session_id}.sar.log";
_sar_viewer="${_session_id}.sar_viewer.sh";

_update_interval_in_sec="1";
_iter_count="";

_sar_opt="-bBdHqrRSvwW -u ALL -P ALL";
#_sar_opt="-bBdHqrRSvwW -I SUM -I XALL -u ALL -P ALL";
## -A     This is equivalent to specifying -bBdHqrRSuvwWy -I SUM -I XALL -m ALL -n ALL -u ALL -P ALL.


echo ">>> check the collected trace later via $_sar_viewer";
cat > $_sar_viewer << EOF
#!/bin/sh
sar $_sar_opt -f $_logfile
EOF
chmod 755 $_sar_viewer;


# collect system activity
sar $_sar_opt -o $_logfile $_update_interval_in_sec $_iter_count

