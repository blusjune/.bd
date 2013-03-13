#!/usr/bin/env python
##bsc.iowa.lsp.preproc_msiotout_s010.py
##_ver=20130313_131510
##_ver=20130313_135320




# assumes that infile is T010.*.trace.csv.csv


import sys, os

for _line in sys.stdin:
	_li = _line.strip().split(',')
	_io_addr = int(_li[4], 16)
	_io_size = int(_li[5], 16)
	_li[4] = _io_addr
	_li[5] = _io_size
	print str(_li[0]) + ' , ' + str(_li[1]) + ' , ' + str(_li[2]) + ' , ' + str(_li[3]) + ' , ' + str(_li[4]) + ' , ' + str(_li[5]) + ' , ' + str(_li[6]) + ' , ' + str(_li[7])




