#!/bin/sh

rm -f te
rm -f *.o
rm -f *.so
rm -f lib*.so.*
find . -type l -exec rm {} \;
