#!/usr/bin/python
## LSP: Line-by-line Stream Processing
## _this_prog="bsc.lsp.range_pass_count.py";
## _ver="20130206_212742";
## _ver="20130206_224119";


import sys, os, getopt, fileinput
#from collections import defaultdict
#from string import punctuation


_this_prog = os.path.basename(sys.argv[0])


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


##
## processing input parameters
##
_range_lower = ''
_range_upper = ''

try:
	opts, args = getopt.getopt(sys.argv[1:], "hl:u:", ["help", "range-lower=", "range-upper="])
except getopt.GetoptError:
	print "[Usage]", _this_prog, "-l|--range-lower=<range_lower_bound> -u|--range-upper=<range_upper_bound>"
	sys.exit(2)

for opt, arg in opts:
	if opt in ("-h", "--help"): #	if opt == '-h':	# works well too, but I need more
		print "[Help:Usage]", _this_prog, "-l|--range-lower=<range_lower_bound> -u|--range-upper=<range_upper_bound>"
		sys.exit(0)
	elif opt in ("-l", "--range-lower"):
		_range_lower = arg
	elif opt in ("-u", "--range-upper"):
		_range_upper = arg

if _range_lower != '':
	print "_range_lower: ", _range_lower
	_range_lower = int(_range_lower)
else:
	print "#>> ERROR: _range_lower is not specified"
	print "[Usage]", _this_prog, "-l|--range-lower=<range_lower_bound> -u|--range-upper=<range_upper_bound>"
	sys.exit(3)

if _range_upper != '':
	print "_range_upper: ", _range_upper
	_range_upper = int(_range_upper)
else:
	print "#>> ERROR: _range_upper is not specified"
	print "[Usage]", _this_prog, "-l|--range-lower=<range_lower_bound> -u|--range-upper=<range_upper_bound>"
	sys.exit(4)


##
## processing input parameters
##
_total_count=0
_pass_count=0
# for line in fileinput.input():	# does not work properly. ('-l' or '-u' is mishandled as a standard input)
for line in sys.stdin:
	_value_curr = int(line.strip())
	if (_value_curr >= _range_lower) and (_value_curr <= _range_upper):
		_pass_count += 1
	_total_count += 1
	

print "pass/total: ", _pass_count, " / ", _total_count


#sys.exit(0)


