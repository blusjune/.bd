#!/bin/sh
#_author="Brian M. JUNG <brian.m.jung@gmail.com>";
#_ver=20140510_144304;


_work_p7n=".work.p7n";


if [ -d ../${_work_p7n} ]; then
	(cd ../${_work_p7n};
	 _BDX;
	 )
fi


