##tstamp: 20121120_220624

_bhdr_set()
{
	if [ "X$_NESTL" = "X" ]; then
		_NESTL=0;
		_BHDR_INDENT="_/";
	else
		_NESTL=$(expr $_NESTL + 1);
		_BHDR_INDENT="${_BHDR_INDENT}_/";
#		_i=0;
#		while [ $_i -lt $_NESTL ]; do
#			_BHDR_INDENT="$_BHDR_INDENT ";
#			_i=$(expr $_i + 1);
#		done
	fi
	_BHDR="[${_BHDR_INDENT} $(date +%Y%m%d_%H%M%S) ]#";
	export _NESTL;
	export _BHDR_INDENT;
	export _BHDR;
}

_bhdr_set;

