#!/bin/sh


## Do Case_A or Case_B

## Case_A
#sudo vi /etc/ld.so.conf
#sudo ldconfig

## Case_B
ldconfig -n .


ln -s libbrian.so.1 libbrian.so # this is key !!!
ldconfig -p | grep brian


