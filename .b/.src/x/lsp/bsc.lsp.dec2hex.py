#!/usr/bin/python
## LSP: Line-by-line Stream Processing
##
## _this_prog="bsc.lsp.dec2hex.py"
## _ver="20130312_210857"




#import sys, os, getopt, fileinput
#from collections import defaultdict
#from string import punctuation
import fileinput


#_this_prog = os.path.basename(sys.argv[0])


for _line in fileinput.input():
	_hex = hex(int(_line, 10))
	print str(_hex)


#sys.exit(0)




