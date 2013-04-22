#!/usr/bin/env python
##bsc.iowa.lsp.anal_s0010.py
##	LSP: Line-by-line Stream Processing
##
##_ver=20130208_151133
##_ver=20130221_154549
##_ver=20130305_035930
##_ver=20130305_042344
##_ver=20130313_161428
##_ver=20130422_234813




import sys, os, getopt
from collections import defaultdict
from string import punctuation


_this_prog = os.path.basename(sys.argv[0])


##
## processing input parameters
##
_ioc_percent = None # IO contribution (IOC) percent
_iomw_size = None # IO measurement window (IOMW) size (in microseconds)
_prd_t1 = None # periodicity t1 value
_prd_t2 = None # periodicity t2 value (currently this is dummy variable - actually t2 may be set as _ioc_total)

def print_help_n_exit(_retval):
	print "Usage", _this_prog, "[-h|--help] -c|--ioc-percent=<_ioc_percent> -w|--iomw-size=<_iomw_size> -p|--periodicity-t1=<_prd_t1> -q|--periodicity-t2=<_prd_t2>"
	sys.exit(int(_retval))

## main getopt processing with exception handling
try:
	opts, args = getopt.getopt(sys.argv[1:], "hc:w:p:q:", ["help", "ioc-percent=", "iomw-size=", "periodicity-t1=", "periodicity-t2="])
except getopt.GetoptError:
	print_help_n_exit(1)
for opt, arg in opts:
	if opt in ("-h", "--help"):
		print_help_n_exit(0)
	elif opt in ("-c", "--ioc-percent"):
		_ioc_percent = int(arg)
	elif opt in ("-w", "--iomw-size"):
		_iomw_size = int(arg)
	elif opt in ("-p", "--periodicity-t1"):
		_prd_t1 = int(arg)
	elif opt in ("-q", "--periodicity-t2"):
		_prd_t2 = int(arg)

## sanity check
if _ioc_percent is None:
	print "#>> ERROR: _ioc_percent is not set"
	print_help_n_exit(2)
if _iomw_size is None:
	print "#>> ERROR: _iomw_size is not set"
	print_help_n_exit(2)
if _prd_t1 is None:
	print "#>> ERROR: _prd_t1 is not set"
	print_help_n_exit(2)
if _prd_t2 is None:
	_prd_t2 = _iomw_size


##
## function definition
##
def hamming_distance(v1, v2):
	assert len(v1) == len(v2)
	return sum(e1 != e2 for e1, e2 in zip(v1, v2))

from math import sqrt
def meanstdv(x):
	n, mean, stdv = len(x), 0, 0
	for i in x:
		mean = mean + i
	mean = mean / float(n)
	for i in x:
		stdv = stdv + (i - mean)**2
	stdv = sqrt(stdv / float(n-1))
	return mean, stdv


## periodicity marking key-value list (pmkvl) update function
## in a memory-and-computation efficient manner
##
## kvl[key][0]: periodicity metric
## kvl[key][1]: last clock
## t1: t1 interval (to update periodicity metric)
## key: currently hit item
## clk: starts from zero(0)
##
## kvl[key][0] is being updated once during t1, accumulated during t2
##             and can be normalized by N(=t2/t1)
##
def pmkvl_update(kvl, t1, key, clk):
	if key not in kvl:
		kvl[key] = [1, clk]
	else:
		bnd_lower = (int(clk/t1) * t1)
		bnd_upper = bnd_lower + (t1 - 1)
		lastclk = kvl[key][1]
		if lastclk >= bnd_lower and lastclk <= bnd_upper:
			kvl[key][1] = clk # update the lastclk
		else:
			kvl[key][0] += 1
			kvl[key][1] = clk # update the lastclk
#	return kvl # for debugging only
	## END_OF_DEF


def pmkvl_print(kvlbase, t1, t2):
	for kv_key, kv_val in kvlbase[t1].items():
		print "__list__periodicity_metric__t1_" + str(t1) + "__t2_" + str(t2) + "__ " + str(kv_key) + " : " + str(kv_val[0]) + " : " + str(float(kv_val[0]) / (float(t2)/float(t1)))


def get_iomw_id(t_curr, t_init, t_wnsz):
	return int((t_curr - t_init) / t_wnsz)




###############################################################################################################################
###############################################################################################################################




##
## processing_loop_10
##	- count: number of hits for each address
##	- collect: hit timestamps for each address
##	- collect: per IO measurement window statistics
##
_kv_cdst__hits_per_addr = defaultdict(int)
_kv_list__addr_hit_tstamp = {}
_kv_list__iomw_whole_list_of_addr_acsd = {} # IOMW(IO Measurement Window) statistics: list of addresses accessed during measurement window
_kv_list__iomw_acs_cnt_per_addr = {} # IOMW(IO Measurement Window) statistics: access count of the address during measurement window
_kv_list__periodicity_metric = {} # periodicity metrics accumulated (t1=variable, t2=positive_infinite)
_kv_list__periodicity_metric[_prd_t1] = {} # t1=_prd_t1, t2=positive_infinite(_ioc_total)
linecount_L10 = 0	# line count is used as a virtual time (not 'real' time) of which value is increased by stream line count
iomw_id = 0
#iomw_index_for_all_addr = 0
_iomw_init_time = -1 # initial time value to calculate IOMW ID
for line in sys.stdin:

	line_items = line.strip().split(',')
	if line_items.__len__() == 1:
		# case A: single item per line (addr)
		time_L10 = linecount_L10 # this is not recommended, but simple work-around for non-timestamp case
		addr_L10 = int(line_items[0].strip())
	elif line_items.__len__() == 2:
		# case B: two items per line (timestamp, addr)
		time_L10 = int(line_items[0].strip())
		addr_L10 = int(line_items[1].strip())
	elif line_items.__len__() >= 4:
		# case C: more than four items per line (timestamp, addr, iosize, rwflag, ...)
		time_L10 = int(line_items[0].strip())
		addr_L10 = int(line_items[1].strip())
		iosz_L10 = int(line_items[2].strip())
		rwid_L10 = int(line_items[3].strip())
	else:
		# case D: erroneous case
		sys.exit(1)
	
	if linecount_L10 == 0:
		_iomw_init_time = time_L10
	iomw_id = get_iomw_id(time_L10, _iomw_init_time, _iomw_size)

	## count: address hits
	_kv_cdst__hits_per_addr[addr_L10] += 1

	## collect: address hit timestamp
	if addr_L10 not in _kv_list__addr_hit_tstamp:
		_kv_list__addr_hit_tstamp[addr_L10] = [time_L10]
	else:
		_kv_list__addr_hit_tstamp[addr_L10].append(time_L10)

	## collect: IOMW statistics
	if iomw_id not in _kv_list__iomw_whole_list_of_addr_acsd:
		_kv_list__iomw_whole_list_of_addr_acsd[iomw_id] = [addr_L10]
	else:
		_kv_list__iomw_whole_list_of_addr_acsd[iomw_id].append(addr_L10)
	if addr_L10 not in _kv_list__iomw_acs_cnt_per_addr:
		_kv_list__iomw_acs_cnt_per_addr[addr_L10] = {}
		_kv_list__iomw_acs_cnt_per_addr[addr_L10][iomw_id] = 1
	else:
		if iomw_id not in _kv_list__iomw_acs_cnt_per_addr[addr_L10]:
			_kv_list__iomw_acs_cnt_per_addr[addr_L10][iomw_id] = 1
		else:
			_kv_list__iomw_acs_cnt_per_addr[addr_L10][iomw_id] += 1

	## collect: periodicity metrics
	pmkvl_update(_kv_list__periodicity_metric[_prd_t1], _prd_t1, addr_L10, time_L10)

	## sort the list items
#	if (linecount_L10 % _iomw_size) == (_iomw_size - 1):
#		_kv_list__iomw_whole_list_of_addr_acsd[iomw_index_for_all_addr] = [int(x) for x in _kv_list__iomw_whole_list_of_addr_acsd[iomw_index_for_all_addr]]
#		_kv_list__iomw_whole_list_of_addr_acsd[iomw_index_for_all_addr].sort()
#		iomw_index_for_all_addr += 1

	## update loop variables
	linecount_L10 += 1

	## End-of-for-loop (L10)

_ioc_total = linecount_L10
_ioc_stop_target = int((float(_ioc_percent) / float(100)) * float(_ioc_total))
_n_o_addr_total = len(_kv_cdst__hits_per_addr) # total number of addresses accessed
## print the collected and calculated results for processing_loop_10
for kv_key, kv_val in _kv_list__addr_hit_tstamp.items():
	print "__list__addr_hit_tstamp__ " + str(kv_key) + " : " + str(kv_val)
for kv_key, kv_val in _kv_cdst__hits_per_addr.items():
	print "__cdst__hits_per_addr__ " + str(kv_key) + " : " + str(kv_val)
pmkvl_print(_kv_list__periodicity_metric, _prd_t1, _ioc_total) # __list__periodicity_metric__


##
## processing_loop_20
##
_kv_cdst__addrs_per_hitnum = defaultdict(int)
for kv_key, kv_val in _kv_cdst__hits_per_addr.items():
	_kv_cdst__addrs_per_hitnum[kv_val] += 1
## print the collected and calculated results for processing_loop_20
for kv_key, kv_val in _kv_cdst__addrs_per_hitnum.items():
	print "__cdst__addrs_per_hitnum__ " + str(kv_key) + " : " + str(kv_val)


##
## processing_loop_30
##
_list__addrs_per_hitnum = sorted(_kv_cdst__addrs_per_hitnum.items(), reverse=True)
_n_o_sigaddrs = 0	# number of significant addresses
_sighitcnt = 0	# significant hit count (addresses of hits >= this value will be handled significantly)
_sigioc_acc = 0	# IO contribution accumulated
lcv_1 = 0	# loop count variable #1
for item in _list__addrs_per_hitnum:	# item[0]: hitnum ; item[1]: number of corresponding addresses
	_n_o_sigaddrs += item[1]
	_sigioc_acc += (item[0] * item[1])	# IO contribution
	if _sigioc_acc >= _ioc_stop_target:
		_sighitcnt = item[0]
		break;
_sigaddrs_efficiency = ( float(_sigioc_acc) / float(_n_o_sigaddrs) )
## NOW we have '_sighitcnt', '_n_o_sigaddrs', and '_sigioc_acc'
## print the collected and calculated results for processing_loop_30
print "__valu__sig__ _ioc_percent : ", _ioc_percent	# percent value defining significant IO contribution
print "__valu__sig__ _sighitcnt : ", _sighitcnt	# significant hit count as a threshold
print "__valu__sig__ _n_o_sigaddrs : ", _n_o_sigaddrs	# number of significant addresses (hits>=sighitcnt)
print "__valu__sig__ _sigioc_acc : ", _sigioc_acc	# IO contribution by significant addresses: 
print "__valu__sig__ _sigaddrs_efficiency : ", _sigaddrs_efficiency	# efficiency index about significant addresses to the IO contribution (_sigioc_acc / _n_o_sigaddrs)
print "__valu__sig__ _n_o_addr_total : ", _n_o_addr_total	# total number of addresses accessed
print "__valu__sig__ _ioc_total : ", _ioc_total	# IO contribution total (# of total IO accesses)


##
## processing_loop_40
##
_kv_list__hitnum_and_addrs = {}
_kv_list__sig_hitnum_and_addrs = {}
for addr_L40, hits_L40 in _kv_cdst__hits_per_addr.items():
	if hits_L40 not in _kv_list__hitnum_and_addrs:
		_kv_list__hitnum_and_addrs[hits_L40] = [addr_L40]
	else:
		_kv_list__hitnum_and_addrs[hits_L40].append(addr_L40)
	if hits_L40 >= _sighitcnt:
		if hits_L40 not in _kv_list__sig_hitnum_and_addrs:
			_kv_list__sig_hitnum_and_addrs[hits_L40] = [addr_L40]
		else:
			_kv_list__sig_hitnum_and_addrs[hits_L40].append(addr_L40)
## print the collected and calculated results for processing_loop_40
for kv_key, kv_val in _kv_list__hitnum_and_addrs.items():
	print "__list__hitnum_and_addrs__ " + str(kv_key) + " : " + str(kv_val)
for kv_key, kv_val in _kv_list__sig_hitnum_and_addrs.items():
	print "__list__sig_hitnum_and_addrs__ " + str(kv_key) + " : " + str(kv_val)


##
## processing_loop_50
##	- address hit interval (requires: _kv_list__addr_hit_tstamp)
##
_kv_cdst__addr_hit_interval = defaultdict(int)
for k in _kv_list__addr_hit_tstamp.keys():
	vtime_curr = 0
	vtime_prev = 0
	foo = 0
	for v in _kv_list__addr_hit_tstamp[k]:
		vtime_curr = v
		if foo != 0:
			_kv_cdst__addr_hit_interval[vtime_curr - vtime_prev] += 1
		vtime_prev = vtime_curr
		foo += 1
## print the collected and calculated results for processing_loop_50
for kv_key, kv_val in _kv_cdst__addr_hit_interval.items():
	print "__cdst__addr_hit_interval__ " + str(kv_key) + " : " + str(kv_val)


##
## processing_loop_60
##  - statistical processing for IOMW (IO Measurement Window)
## !!!
_kv_list__iomw_stat = {}
for k_iomw_index, v_iomw_alist in _kv_list__iomw_whole_list_of_addr_acsd.items():
	_kv_list__iomw_stat[k_iomw_index] = meanstdv(v_iomw_alist)

for kv_key, kv_val in _kv_list__iomw_stat.items():
	print "__list__iomw_stat__ " + str(kv_key) + " : " + str(kv_val[0]) + " : " + str(kv_val[1])
	## kv_key:k_iomw_index; kv_val[0]:mean; kv_val[1]:stdv;

for i in _kv_list__iomw_acs_cnt_per_addr:
	for j in _kv_list__iomw_acs_cnt_per_addr[i]:
		print "__list__iomw_acs_cnt_per_addr__ " + "_addr: " + str(i) + " , " + "_timewin: " + str(j) + " , " + "_acscnt: " + str(_kv_list__iomw_acs_cnt_per_addr[i][j])




