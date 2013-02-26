#!/usr/bin/python
##bsc.iowa.lsp.addr.hit_freq.py
##LSP: Line-by-line Stream Processing
##tstamp: 20121114_150933


lines = 0


from collections import defaultdict
from string import punctuation


words = defaultdict(int)


try:
	fn_i='infile'
	textf = open(fn_i, 'r')
except IOError:
	print 'CANNOT open file "%s" for reading' % fn_i
	import sys
	sys.exit(0)


## reads one line at a time
for line in textf:
#	print line, # test
#	words[line.strip(punctuation)] += 1	# it causes unexpected result
	words[line] += 1
	lines += 1


for word, freq in words.items():
	print word.strip() + " : " + str(freq)


