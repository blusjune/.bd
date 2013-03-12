#!/usr/bin/python
## LSP: Line-by-line Stream Processing
##
## _this_prog="bsc.lsp.hex2dec.py"
## _ver="20130312_210509"




#import sys, os, getopt, fileinput
#from collections import defaultdict
#from string import punctuation
import fileinput


#_this_prog = os.path.basename(sys.argv[0])


for _line in fileinput.input():
	_dec = int(_line, 16)
	print str(_dec)


#sys.exit(0)




