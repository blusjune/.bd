## _author="Brian M. JUNG <brian.m.jung@gmail.com>"
## _module_name="distance.py"
## _ver="20130206_012309"
##
## Distance functions
##		hamming distance
##		kaddrgrp distance
##		levenshtein distance
##
## Examples - levenshtein_distance
##		L1 = raw_input('1st list : ')
##		L2 = raw_input('2nd list : ')
##		distance = levenshtein_distance(L1, L2)
##		print 'The Levenshtein-distance of ', L1, ' and ', L2, ' is ', distance


def hamming_distance(v1, v2):
    assert len(v1) == len(v2)
    return sum(e1 != e2 for e1, e2 in zip(v1, v2))


def kaddrgrp_distance(v1, v2):
    if len(v1) == len(v2):
		_distance = 0 
		_count = 0 
		for e1 in v1: 
			for e2 in v2: 
				if e1 == e2: 
					_count = _count + 1 
		_distance = len(v1) - _count
		if _distance < 0: # debugging
			print "kag_distance: ", _distance, "len(v1): ", len(v1), " _count: ", _count    # debug
			print "v1: [ ", v1, " ]"    # debug
			print "v2: [ ", v2, " ]"    # debug
			return _distance
		else:
			# -- CANNOT calculate the distance properly --
			# this should be the last case
			# because length of input stream may not be integer-multiples of k
			return -1; 


def matrix_print(m):
	print ' '
	for line in m:
		spTupel = ()
		breite = len(line)
		for column in line:
			spTupel = spTupel + (column, )
		print "%3i"*breite % spTupel


def levenshtein_distance(v1, v2):
	l1 = len(v1)
	l2 = len(v2)
	matrix = [range(l1 + 1)] * (l2 + 1)
	for zz in range(l2 + 1):
		matrix[zz] = range(zz,zz + l1 + 1)
	for zz in range(0,l2):
		for sz in range(0,l1):
			if v1[sz] == v2[zz]:
				matrix[zz+1][sz+1] = min(matrix[zz+1][sz] + 1, matrix[zz][sz+1] + 1, matrix[zz][sz])
			else:
				matrix[zz+1][sz+1] = min(matrix[zz+1][sz] + 1, matrix[zz][sz+1] + 1, matrix[zz][sz] + 1)
	print "That's the levenshtein_distance-Matrix:"
	matrix_print(matrix)
	return matrix[l2][l1]
