#!/bin/sh
#_ver=20130307_202008




#_montarget="/x/t/share/SNIA_blocktraces";

if [ "X$#" = "X1" ]; then
	_montarget="$1"
else
	read -p "monitoring target: " _montarget
fi

_logfile="log.inotify-$(..ts)-${_montarget}.txt";

_format_str="%T : %e : %w%f"
inotifywait -r -m --timefmt "%Y%m%d_%H%M%S" --format "$_format_str" $_montarget | tee $_logfile
#inotifywait -r -m r0/ | tee inotify.log.v1




