#!/usr/bin/python
## bsc.iowa.lsp.addr.access_ptrns.py
## LSP: Line-by-line Stream Processing
##
## _ver=20130117_234444
## _ver=20130118_100005
## _ver=20130205_003905
## _ver=20130206_112428
## _ver=20130208_145200


import sys, os, getopt
from collections import defaultdict
from string import punctuation


_this_prog = os.path.basename(sys.argv[0])


##
## processing input parameters
##
_k_of_kaddrgrp = ''	# k of k-address-group
_achunk_size = ''	# size (in LBA) of address chunk (simply combining adjacent addresses)

try:
	opts, args = getopt.getopt(sys.argv[1:], "hk:c:", ["help", "kaddrgrp=", "chunksize="])
except getopt.GetoptError:
	print "[Usage]", _this_prog, "-k|--kaddrgrp=<k_of_k_addr_group> -c|--chunksize=<chunk_size_in_sector>"
	sys.exit(2)

for opt, arg in opts:
	if opt in ("-h", "--help"): #	if opt == '-h':	# works well too, but I need more
		print "[Help:Usage]", _this_prog, "-k|--kaddrgrp=<k_of_k_addr_group> -c|--chunksize=<chunk_size_in_sector>"
		sys.exit(0)
	elif opt in ("-k", "--kaddrgrp"):
		_k_of_kaddrgrp = arg
	elif opt in ("-c", "--chunksize"):
		_achunk_size = arg

if _k_of_kaddrgrp != '':
	print "_k_of_kaddrgrp: ", _k_of_kaddrgrp
	_k_of_kaddrgrp = int(_k_of_kaddrgrp)
else:
	print "#>> ERROR: _k_of_kaddrgrp is not specified"
	print "[Usage]", _this_prog, "-k|--kaddrgrp=<k_of_k_addr_group> -c|--chunksize=<chunk_size_in_sector>"
	sys.exit(3)

if _achunk_size != '':
	print "_achunk_size: ", _achunk_size
	_achunk_size = int(_achunk_size)
else:
	print "#>> ERROR: _achunk_size is not specified"
	print "[Usage]", _this_prog, "-k|--kaddrgrp=<k_of_k_addr_group> -c|--chunksize=<chunk_size_in_sector>"
	sys.exit(4)


##
## check and open input file 'infile'
##
try:
	fn_i='infile'
	textf = open(fn_i, 'r')
except IOError:
	print '#>> ERROR: CANNOT open file "%s" for reading' % fn_i
	sys.exit(4)


##
## function definition
##
def hamming_distance(v1, v2):
	assert len(v1) == len(v2)
	return sum(e1 != e2 for e1, e2 in zip(v1, v2))


def kag_distance(v1, v2):	# k-address-group distance
	if len(v1) == len(v2):
		_distance = 0
		_count = 0
		for e1 in v1:
			for e2 in v2:
				if e1 == e2:
					_count = _count + 1
		_distance = len(v1) - _count
		if _distance < 0: # debugging
			print "kag_distance: ", _distance, "len(v1): ", len(v1), " _count: ", _count	# debug
			print "v1: [ ", v1, " ]"	# debug
			print "v2: [ ", v2, " ]"	# debug
		return _distance
	else:
		# -- CANNOT calculate the distance properly --
		# this should be the last case
		# because length of input stream may not be integer-multiples of k
		return -1;


##
## 1st processing loop
##
kv__list__achunk_hit_timestamp = {}
kv__list__kaddrgrp = {}
kv__cdst__achunk_hit = defaultdict(int)
kv__cdst__achunk_hit_runs = defaultdict(int)
lines = 0				# line number starting from '1' (not zero)
achunk_prev = 0		# initial dummy value for calculating seek distance (A - B)
kaddrgrp_count = 0
runs_range = 1
for line in textf: ## reads one line at a time
	addr_curr = int(line.strip())
	achunk_curr = (addr_curr / _achunk_size) * _achunk_size

	## count: achunk hits
	kv__cdst__achunk_hit[achunk_curr] += 1

	## collect: achunk (address chunk) hit timestamp
#	if kv__list__achunk_hit_timestamp.has_key(achunk_curr) == False:	# .has_key() is deprecated in favor of 'key (not) in d'
	if achunk_curr not in kv__list__achunk_hit_timestamp:
		kv__list__achunk_hit_timestamp[achunk_curr] = [lines]
	else:
		kv__list__achunk_hit_timestamp[achunk_curr].append(lines)

	## count: achunk runs
	if achunk_curr == achunk_prev:
		runs_range += 1
	else:
		kv__cdst__achunk_hit_runs[runs_range] += 1
		runs_range = 1

	## collect: k-addrgrp
	if kaddrgrp_count not in kv__list__kaddrgrp:
		kv__list__kaddrgrp[kaddrgrp_count] = [achunk_curr]
	else:
		kv__list__kaddrgrp[kaddrgrp_count].append(achunk_curr)

	## update loop variables
	if (lines % _k_of_kaddrgrp) == (_k_of_kaddrgrp - 1):
		kv__list__kaddrgrp[kaddrgrp_count] = [int(x) for x in kv__list__kaddrgrp[kaddrgrp_count]]
		kv__list__kaddrgrp[kaddrgrp_count].sort()
		kaddrgrp_count += 1
	achunk_prev = achunk_curr
	lines += 1


##
## 2nd processing loop
##
kv__cdst__achunk_rehit_interval = defaultdict(int)
for k in kv__list__achunk_hit_timestamp.keys():
	time_curr = 0
	time_prev = 0
	lc_v = 0
	for v in kv__list__achunk_hit_timestamp[k]:
		time_curr = v
		if lc_v != 0:
			kv__cdst__achunk_rehit_interval[time_curr - time_prev] += 1
		time_prev = time_curr
		lc_v += 1


##
## 3rd processing loop
##
mat = [[0 for i in range(kaddrgrp_count+1)] for j in range(kaddrgrp_count+1)] # kaddrgrp distance matrix
kv__cdst__kag_distance = defaultdict(int)
for ik, iv in kv__list__kaddrgrp.items():
	for jk, jv in kv__list__kaddrgrp.items():
		if (ik != jk):
			mat[ik][jk] = kag_distance(kv__list__kaddrgrp[ik], kv__list__kaddrgrp[jk])
			kv__cdst__kag_distance[mat[ik][jk]] += 1


##
## print the collected and calculated results
##
for kv_key, kv_val in kv__list__achunk_hit_timestamp.items():
	print "__list__achunk_hit_timestamp__ " + str(kv_key) + " : " + str(kv_val)

for kv_key, kv_val in kv__list__kaddrgrp.items():
	print "__list__kaddrgrp__ " + str(kv_key) + " : " + str(kv_val)

for kv_key, kv_val in kv__cdst__achunk_hit.items():
	print "__cdst__achunk_hit__ " + str(kv_key) + " : " + str(kv_val)

for kv_key, kv_val in kv__cdst__achunk_hit_runs.items():
	print "__cdst__achunk_hit_runs__ " + str(kv_key) + " : " + str(kv_val)

for kv_key, kv_val in kv__cdst__achunk_rehit_interval.items():
	print "__cdst__achunk_rehit_interval__ " + str(kv_key) + " : " + str(kv_val)

for kv_key, kv_val in kv__cdst__kag_distance.items():
	print "__cdst__kag_distance__ " + str(kv_key) + " : " + str(kv_val)




