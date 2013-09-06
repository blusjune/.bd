#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Longest Common Subsequence, 3 phases comparisson algorithm.
# Copyright (C) 2012  Gonzalo Exequiel Pedone
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with This program. If not, see <http://www.gnu.org/licenses/>.
#
# Email	: hipersayan DOT x AT gmail DOT com
# Web-Site: http://hipersayanx.blogspot.com/
 
def lcs_v1(a=[], b=[]):
	ja = -1
	jb = -1
	n = 0
 
	if a == [] or b == []:
		return ja, jb, n
 
	l = len(a) + len(b) - 1
	ia = len(a) - 1
	ib = 0
	s = 1
 
	for k in range(l):
		nCur = 0
 
		for r in range(s):
			if a[ia + r] == b[ib + r]:
				nCur += 1
 
				if nCur > n:
					ja = ia + r - nCur + 1
					jb = ib + r - nCur + 1
					n = nCur
			else:
				nCur = 0
 
		if k < min(len(a), len(b)) - 1:
			ia -= 1
			s += 1
		elif k > l - min(len(a), len(b)) - 1:
			ib += 1
			s -= 1
		elif ia > 0:
			ia -= 1
		else:
			ib += 1
 
	return ja, jb, n

'''
def lcs_len(x, y):
	"""This function returns length of longest common sequence of x and y."""
	if len(x) == 0 or len(y) == 0:
		return 0
 
	xx = x[:-1]	# xx = sequence x without its last element	
	yy = y[:-1]
 
	if x[-1] == y[-1]:  # if last elements of x and y are equal
		return lcs_len(xx, yy) + 1
	else:
		return max(lcs_len(xx, y), lcs_len(x, yy))
'''


'''
	>>> lcs_rc('thisisatest', 'testing123testing')
	'tsitest'
'''
def lcs_rc(xstr, ystr):
	if not xstr or not ystr:
		return ""
	x, xs, y, ys = xstr[0], xstr[1:], ystr[0], ystr[1:]
	if x == y:
		return x + lcs_rc(xs, ys)
	else:
		return max(lcs_rc(xstr, ys), lcs_rc(xs, ystr), key=len)


def lcs_dp(a, b):
	lengths = [[0 for j in range(len(b)+1)] for i in range(len(a)+1)]
	# row 0 and column 0 are initialized to 0 already
	for i, x in enumerate(a):
		for j, y in enumerate(b):
			if x == y:
				lengths[i+1][j+1] = lengths[i][j] + 1
			else:
				lengths[i+1][j+1] = \
					max(lengths[i+1][j], lengths[i][j+1])
	# read the substring out from the matrix
	result = ""
	x, y = len(a), len(b)
	while x != 0 and y != 0:
		if lengths[x][y] == lengths[x-1][y]:
			x -= 1
		elif lengths[x][y] == lengths[x][y-1]:
			y -= 1
		else:
			assert a[x-1] == b[y-1]
			result = a[x-1] + result
			x -= 1
			y -= 1
	return result
 


#a = 'Andrea always wears black cat to all places she go.'
#b = 'She likes her black cat because it is very mischievous and playful.'
a = "thisisatest"
b = "testing123testing"
a1 = "thisisatestokiloyou"
b1 = "testing123testingyoukw"
 
ia, ib, n = lcs_v1(list(a), list(b))

print([a[ia: ia + n]])
print([b[ib: ib + n]])

print str(lcs_dp(a1,b1))
#print str(lcs_rc(a1,b1))


