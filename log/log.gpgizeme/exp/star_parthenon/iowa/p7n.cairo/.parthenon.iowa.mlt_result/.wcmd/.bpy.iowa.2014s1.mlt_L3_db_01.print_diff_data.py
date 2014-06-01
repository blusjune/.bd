#!/usr/bin/env python
#_author="Brian M. JUNG <brian.m.jung@gmail.com>";
#_ver=20140510_142913
#_ver=20140512_230524
#_ver=20140519_211144;




import os, sys, getopt
import math
from collections import defaultdict
from string import punctuation
from string import maketrans


_this_prog = os.path.basename(sys.argv[0])
nargs = len(sys.argv);
if (nargs > 1):
	_radix = (sys.argv[1]).strip();
else:
	_radix = _this_prog.strip().split('.')[5]
#print _radix


# perfile_io_summary_fname	a_count	r_count	w_count	r_bytes	w_bytes	r_wait_sum	r_wait_avg	r_wait_max	r_wait_min	w_wait_sum	w_wait_avg	w_wait_max	w_wait_min


class mlt_db_01_data(object):
	def __init__(self, _li_fname, _li_a_count, _li_r_count, _li_w_count, _li_r_bytes, _li_w_bytes,\
			_li_r_wait_sum, _li_r_wait_avg, _li_r_wait_max, _li_r_wait_min,\
			_li_w_wait_sum, _li_w_wait_avg, _li_w_wait_max, _li_w_wait_min\
		):
		self.fname = _li_fname
		self.a_count = _li_a_count
		self.r_count = _li_r_count
		self.w_count = _li_w_count
		self.r_bytes = _li_r_bytes
		self.w_bytes = _li_w_bytes
		self.r_wait_sum = _li_r_wait_sum
		self.r_wait_avg = _li_r_wait_avg
		self.r_wait_max = _li_r_wait_max
		self.r_wait_min = _li_r_wait_min
		self.w_wait_sum = _li_w_wait_sum
		self.w_wait_avg = _li_w_wait_avg
		self.w_wait_max = _li_w_wait_max
		self.w_wait_min = _li_w_wait_min
	def display(self):
		print self.fname + " "  +\
		str(self.a_count) + " "  +\
		str(self.r_count) + " "  +\
		str(self.w_count) + " "  +\
		str(self.r_bytes) + " "  +\
		str(self.w_bytes) + " "  +\
		str(self.r_wait_sum) + " "  +\
		str(self.r_wait_avg) + " "  +\
		str(self.r_wait_max) + " "  +\
		str(self.r_wait_min) + " "  +\
		str(self.w_wait_sum) + " "  +\
		str(self.w_wait_avg) + " "  +\
		str(self.w_wait_max) + " "  +\
		str(self.w_wait_min)


_cnt_1=0;
for _line in sys.stdin:

	_li = _line.strip().split()

	_li_fname = _li[0]
	_li_a_count = _li[1]
	_li_r_count = _li[2]
	_li_w_count = _li[3]
	_li_r_bytes = _li[4]
	_li_w_bytes = _li[5]
	_li_r_wait_sum = _li[6]
	_li_r_wait_avg = _li[7]
	_li_r_wait_max = _li[8]
	_li_r_wait_min = _li[9]
	_li_w_wait_sum = _li[10]
	_li_w_wait_avg = _li[11]
	_li_w_wait_max = _li[12]
	_li_w_wait_min = _li[13]

	_cnt_1 = _cnt_1 + 1;
	if ((_cnt_1 % 2) == 1):

		data_before = mlt_db_01_data( _li_fname, _li_a_count, _li_r_count, _li_w_count, _li_r_bytes, _li_w_bytes,\
				_li_r_wait_sum, _li_r_wait_avg, _li_r_wait_max, _li_r_wait_min,\
				_li_w_wait_sum, _li_w_wait_avg, _li_w_wait_max, _li_w_wait_min )

	else:

		data_after = mlt_db_01_data( _li_fname, _li_a_count, _li_r_count, _li_w_count, _li_r_bytes, _li_w_bytes,\
				_li_r_wait_sum, _li_r_wait_avg, _li_r_wait_max, _li_r_wait_min,\
				_li_w_wait_sum, _li_w_wait_avg, _li_w_wait_max, _li_w_wait_min )

		data_diff = mlt_db_01_data( _li_fname,\
				int(data_after.a_count) - int(data_before.a_count),\
				int(data_after.r_count) - int(data_before.r_count),\
				int(data_after.w_count) - int(data_before.w_count),\
				int(data_after.r_bytes) - int(data_before.r_bytes),\
				int(data_after.w_bytes) - int(data_before.w_bytes),\
				int(data_after.r_wait_sum) - int(data_before.r_wait_sum),\
				int(data_after.r_wait_avg) - int(data_before.r_wait_avg),\
				int(data_after.r_wait_max) - int(data_before.r_wait_max),\
				int(data_after.r_wait_min) - int(data_before.r_wait_min),\
				int(data_after.w_wait_sum) - int(data_before.w_wait_sum),\
				int(data_after.w_wait_avg) - int(data_before.w_wait_avg),\
				int(data_after.w_wait_max) - int(data_before.w_wait_max),\
				int(data_after.w_wait_min) - int(data_before.w_wait_min))

		if _radix == 'print_diff_data':
			data_diff.display()
		elif _radix == 'print_before_data':
			data_before.display()
		elif _radix == 'print_after_data':
			data_after.display()
		else:
			data_diff.display()




