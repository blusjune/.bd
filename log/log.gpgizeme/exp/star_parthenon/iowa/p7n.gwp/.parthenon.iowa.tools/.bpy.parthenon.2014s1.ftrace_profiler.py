#!/usr/bin/env python
#_author="Brian M. JUNG <brian.m.jung@gmail.com>"
#_ver=20140618_060410
#_ver=20140619_011037
#_ver=20140625_224003


import os, sys, subprocess, re, datetime, getopt
import math as mt
import numpy as np
from collections import defaultdict
from string import punctuation
from string import maketrans


# cat tracepipe > /tmp/tlog.1
# cat /tmp/tlog.1 | grep -v -- '----------' | grep -v '=>' > /tmp/tlog.2
# cat /tmp/tlog.2 | _this_prog


_this_prog = os.path.basename(sys.argv[0])
_opt_verbose = False


_kvl_etf = {} # elapsed time for a function
_fname_stack = []
_skip_phrase_1 = '----'
_skip_phrase_2 = '=>'
_kiloval = 1000.0
_line_count = 0

for _line in sys.stdin:
	_line_count = _line_count + 1
	_ln = _line.strip()
	if _skip_phrase_1 in _ln:
		continue
	if _skip_phrase_2 in _ln:
		continue
	_li = _ln.split('|')
	if _li.__len__() >= 2:
#		print _li[0] + " ### " + _li[1]
		_fcall = _li[1].strip().split('()')
		if _fcall.__len__() >= 2:
			_fname = _fcall[0]
			_stub = _fcall[1]
			if _li[1].index(_fname) is not ((_fname_stack.__len__() + 1) * 2):
#				print _line.strip() + "    ERROR_1 " + str(_line_count) # debugging_bad
				_fname_stack.__init__()
				continue
			if ';' in _stub:
				_etstr = _li[0].strip().split() # elapsed time string
				_etsl = _etstr.__len__()
				if _etsl >= 3:
					#_warning = _etstr[_etsl - 3]
					_etime = float(_etstr[_etsl - 2])
					_etime_unit = _etstr[_etsl - 1]
					if _etime_unit is 'ms':
						_etime = _etime * _kiloval
					elif _etime_unit is 'ns':
						_etime = _etime / _kiloval
					else:
						pass
					if _fname not in _kvl_etf:
						_kvl_etf[_fname] = [_etime]
					else:
						_kvl_etf[_fname].append(_etime)
#					print _line.strip() + "    ####    " + str(_fname) + "    " + str(_line_count) # debugging_good
					if _opt_verbose is True:
						print '"' + str(_fname) + '"' + " : " \
							+ str(_etime) + " " \
							+ str(_etime_unit)
			elif '{' in _stub:
				_fname_stack.append(_fname)
			else:
				pass
		else: # if _fcall.__len__() >= 2:
			if '}' in _li[1]:
				if _fname_stack.__len__() <= 0:
#					print _line.strip() + "    ERROR_2 " + str(_line_count) # debugging_bad
					continue
				if _li[1].index('}') is not ((_fname_stack.__len__() + 0) * 2):
#					print _line.strip() + "    ERROR_3 " + str(_line_count) # debugging_bad
					_fname_stack.__init__()
					continue
				_fname_pop = _fname_stack.pop()
				_etstr = _li[0].strip().split() # elapsed time string
				_etsl = _etstr.__len__()
				if _etsl >= 3:
					#_warning = _etstr[_etsl - 3]
					_etime = float(_etstr[_etsl - 2])
					_etime_unit = _etstr[_etsl - 1]
					if _etime_unit is 'ms':
						_etime = _etime * _kiloval
					elif _etime_unit is 'ns':
						_etime = _etime / _kiloval
					else:
						pass
					if _fname_pop not in _kvl_etf:
						_kvl_etf[_fname_pop] = [_etime]
					else:
						_kvl_etf[_fname_pop].append(_etime)
#					print _line.strip() + "    ####    " + str(_fname_pop) + "    " + str(_line_count) # debugging_good
					if _opt_verbose is True:
						print '"' + str(_fname_pop) + '"' + " : " \
							+ str(_etime) + " " \
							+ str(_etime_unit)
					else: # if _opt_verbose is True:
						pass
				else: # if _etsl >= 3:
					pass
			else: # if '}' in _li[1]:
				pass
	else: # if _li.__len__() >= 2:
		pass

print "function_name    |    f_overhead_total    |    call_count    |    mean_us    |    sd_us"
if _opt_verbose is True:
	_round_dgt = 3
	for _fname in _kvl_etf:
		_str_etime = ""
		_etf = []
		for _etime in _kvl_etf[_fname]:
			_etf.append(_etime)
			_str_etime = _str_etime + " " + str(_etime)
		_fcall_count = _etf.__len__()
		_etf_mean = np.mean(_etf)
		_etf_sd = np.std(_etf)
		_fo_tot = _fcall_count * _etf_mean
		print '"' + _fname + '"' \
			+ "    |    " + str(_fo_tot) \
			+ "    |    " + str(_fcall_count) \
			+ "    |    " + str(round(_etf_mean, _round_dgt)) \
			+ "    |    " + str(round(_etf_sd, _round_dgt * 2)) \
			+ "    |    " + _str_etime	
else:
	_round_dgt = 3
	for _fname in _kvl_etf:
		_etf = []
		for _etime in _kvl_etf[_fname]:
			_etf.append(_etime)
		_fcall_count = _etf.__len__()
		_etf_mean = np.mean(_etf)
		_etf_sd = np.std(_etf)
		_fo_tot = _fcall_count * _etf_mean
		print '"' + _fname + '"' \
			+ "    |    " + str(_fo_tot) \
			+ "    |    " + str(_fcall_count) \
			+ "    |    " + str(round(_etf_mean, _round_dgt)) \
			+ "    |    " + str(round(_etf_sd, _round_dgt * 2)) \
			+ ""





