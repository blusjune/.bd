#!/usr/bin/python
## LSP: Line-by-line Stream Processing
##
## _this_prog="bsc.lsp.sum.py";
## _ver="20130123_201925";


#import sys, os, getopt, fileinput
#from collections import defaultdict
#from string import punctuation
import fileinput


#_this_prog = os.path.basename(sys.argv[0])


##{ test code: read lines from stdin
##
##	_count=0
##	for line in fileinput.input():
##		_count += 1
##		print str(_count) + " : " + "\"" + line.strip() + "\""
##	
##	sys.exit(0)
##
##} test code: read lines from stdin


_result__sum=0
for line in fileinput.input():
	_result__sum += int(line)


print "#RESULT__SUM: ", _result__sum


#sys.exit(0)


