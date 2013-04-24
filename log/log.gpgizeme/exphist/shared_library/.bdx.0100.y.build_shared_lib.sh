#!/bin/sh

ln -s .libbrian.c libbrian.c
ln -s .libbrian.h libbrian.h
gcc -fPIC -g -c -Wall libbrian.c
gcc -shared -Wl,-soname,libbrian.so.1 -o libbrian.so.1.0.0 libbrian.o -lc

#sudo vi /etc/ld.so.conf
#sudo ldconfig
#ldconfig -p | grep brian

