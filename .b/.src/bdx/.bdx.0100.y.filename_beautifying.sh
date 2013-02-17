#!/bin/sh
## .bdx.0100.y.filename_beautifying.sh
##
##tstamp: 20120912_234801
##tstamp: 20121009_222004




_nof=$(ls -1 | wc -l);

_ci=0;
_cj=0;
while [ $_ci -lt $_nof ]; do
	_ci=$(echo "$_ci + 1" | bc);
	_fn="$(ls -1 | tail -n $_ci | head -1)";
	_fn_new=$(echo $_fn | tr [:upper:] [:lower:] | sed -e 's/[^0-9A-Za-z\.\-]/_/g');

	if [ "X$_fn" != "X$_fn_new" ]; then
		_cj=$(echo "$_cj + 1" | bc);
		echo "'$_fn' --> '$_fn_new'";
		mv "$_fn" "$_fn_new";
	fi
done

echo "
-----";
echo "total # of files   : $_nof";
echo "# of renamed files : $_cj";
