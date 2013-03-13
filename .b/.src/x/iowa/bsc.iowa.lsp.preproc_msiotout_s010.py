#!/usr/bin/env python
##bsc.iowa.lsp.preproc_msiotout_s010.py
##_ver=20130313_131510



# assumes that infile is T010.*.trace.csv.csv


import sys, os

for _line in sys.stdin:
	_li = _line.strip().split()
	_io_addr = int(_li[9], 16)
	_io_size = int(_li[11], 16)
	_li[9] = _io_addr
	_li[11] = _io_size
	print _li[0], _li[1], _li[2], _li[3], _li[4], _li[5], _li[6], _li[7], _li[8], _li[9], _li[10], _li[11], _li[12], _li[13], _li[14], _li[15]




