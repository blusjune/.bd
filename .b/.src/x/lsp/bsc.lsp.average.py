#!/usr/bin/python
## LSP: Line-by-line Stream Processing
##
## _this_prog="bsc.lsp.average.py"
## _ver="20130123_204255"


#import sys, os, getopt, fileinput
#from collections import defaultdict
#from string import punctuation
import fileinput


#_this_prog = os.path.basename(sys.argv[0])


_result__average=0
_count=0
for line in fileinput.input():
	_count += 1
	_result__average += int(line)


print "#RESULT__AVERAGE: ", (float(_result__average) / float(_count))


#sys.exit(0)


