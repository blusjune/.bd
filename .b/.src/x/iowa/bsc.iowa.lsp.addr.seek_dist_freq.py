#!/usr/bin/python
##bsc.iowa.lsp.addr.seek_dist_freq.py
##LSP: Line-by-line Stream Processing
##_ver=20130115_215520


lines = 1		# line number starting from '1' (not zero)
line_prev = 0	# initial dummy value for calculating seek distance (A - B)


from collections import defaultdict
from string import punctuation

word_kv = defaultdict(int)
seekdist_kv = defaultdict(int)


try:
	fn_i='infile'
	textf = open(fn_i, 'r')
except IOError:
	print 'CANNOT open file "%s" for reading' % fn_i
	import sys
	sys.exit(0)


## reads one line at a time
for line in textf:
	line_curr = int(line.strip())
	seek_dist = line_curr - line_prev
	seekdist_kv[lines] = seek_dist
	line_prev = line_curr
	word_kv[line] += 1
	lines += 1


for time_seq, dist in seekdist_kv.items():
	print str(time_seq) + " : " + str(dist)


