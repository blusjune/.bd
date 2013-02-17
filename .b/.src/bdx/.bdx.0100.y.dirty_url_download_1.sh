#!/bin/sh
##

##tstamp: 20121006_203506

_tstamp=$(tstamp);
_down_d="dir.$_tstamp";
_url_in="url.in";
_url_out=".url.out";

if [ -f $_url_in ]; then
	mkdir -p $_down_d;
	if [ "X$_memo" = "X" ]; then
		read -p "type memo for a file to download: " _memo;
	fi
	_fn_new="$_tstamp-$_memo";
	( cd $_down_d;
	cat ../$_url_in | sed -e 's/%3A/:/g' | sed -e 's/%2F/\//g' > $_url_out; wget $(cat $_url_out);
	_fn_old="$(ls -1)"; mv $_fn_old $_fn_new; cp -p $_fn_new ..;
	)
	echo ">>> '$_fn_new' is saved";
else
	echo ">>> ERROR: $_url_in (input file) is needed";
fi
