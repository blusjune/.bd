#!/bin/sh

_datafile="teste";

_creat_datafile()
{
	echo "create data file";
	cat > teste << EOF
A,B,C
B,C
A,B,D
A,B,C,D
A
B
EOF
}

if [ ! -r $_datafile ]; then
	_creat_datafile;
fi
