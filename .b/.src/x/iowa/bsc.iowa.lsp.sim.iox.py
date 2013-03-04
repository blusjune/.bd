#!/usr/bin/env python
## bsc.iowa.lsp.sim.iox.py # Simulator/IOXceleration
## LSP: Line-by-line Stream Processing
##
## _ver=20130208_151133
## _ver=20130221_154549
## _ver=20130305_035930
## _ver=20130305_042344




import sys, os, getopt
from collections import defaultdict
from string import punctuation


_this_prog = os.path.basename(sys.argv[0])


##
## processing input parameters
##
_ioc_percent = None # IO contribution (IOC) percent
_iow_size = None # IO window (IOW) size
_prd_t1 = None # periodicity t1 value
_prd_t2 = None # periodicity t2 value (currently this is dummy variable - actually t2 may be set as _ioc_total)

def print_help_n_exit(_retval):
	print "Usage", _this_prog, "[-h|--help] -c|--ioc-percent=<_ioc_percent> -w|--iow-size=<_iow_size> -p|--periodicity-t1=<_prd_t1> -q|--periodicity-t2=<_prd_t2>"
	sys.exit(int(_retval))

## main getopt processing with exception handling
try:
	opts, args = getopt.getopt(sys.argv[1:], "hc:w:p:q:", ["help", "ioc-percent=", "iow-size=", "periodicity-t1=", "periodicity-t2="])
except getopt.GetoptError:
	print_help_n_exit(1)
for opt, arg in opts:
	if opt in ("-h", "--help"):
		print_help_n_exit(0)
	elif opt in ("-c", "--ioc-percent"):
		_ioc_percent = int(arg)
	elif opt in ("-w", "--iow-size"):
		_iow_size = int(arg)
	elif opt in ("-p", "--periodicity-t1"):
		_prd_t1 = int(arg)
	elif opt in ("-p", "--periodicity-t2"):
		_prd_t2 = int(arg)

## sanity check
if _ioc_percent is None:
	print "#>> ERROR: _ioc_percent is not set"
	print_help_n_exit(2)
if _iow_size is None:
	print "#>> ERROR: _iow_size is not set"
	print_help_n_exit(2)
if _prd_t1 is None:
	print "#>> ERROR: _prd_t1 is not set"
	print_help_n_exit(2)


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




###############################################################################################################################
###############################################################################################################################




##
## processing_loop_10
##	- count: number of hits for each address
##	- collect: hit timestamps for each address
##	- collect: per-IO window statistics
##
_kv_cdst__hits_per_addr = defaultdict(int)
_kv_list__addr_hit_tstamp = {}
_kv_list__iow_list = {} # IOW(IO Window) list
_kv_list__periodicity_metric = {} # periodicity metrics accumulated (t1=variable, t2=positive_infinite)
_kv_list__periodicity_metric[_prd_t1] = {} # t1=_prd_t1, t2=positive_infinite(_ioc_total)
#_kv_list__periodicity_metric[20000] = {} # t1=20000, t2=positive_infinite(_ioc_total)
#_kv_list__periodicity_metric[30000] = {} # t1=30000, t2=positive_infinite(_ioc_total)
#_kv_list__periodicity_metric[50000] = {} # t1=50000, t2=positive_infinite(_ioc_total)
#_kv_list__periodicity_metric[70000] = {} # t1=70000, t2=positive_infinite(_ioc_total)
linecount_L10 = 0	# line count is used as a virtual time (not 'real' time) of which value is increased by stream line count
iow_index = 0
for line in sys.stdin:
	line_items = line.strip().split()
	if line_items.__len__() == 1:
		addr_L10 = int(line_items[0]) # case A: single item per line (addr)
	else:
		addr_L10 = int(line_items[1]) # case B: two items per line (timestamp, addr)
	## count: address hits
	_kv_cdst__hits_per_addr[addr_L10] += 1
	## collect: address hit timestamp
	if addr_L10 not in _kv_list__addr_hit_tstamp:
		_kv_list__addr_hit_tstamp[addr_L10] = [linecount_L10]
	else:
		_kv_list__addr_hit_tstamp[addr_L10].append(linecount_L10)
	## collect: IOW list (for future statistical processing per IO Window)
	if iow_index not in _kv_list__iow_list:
		_kv_list__iow_list[iow_index] = [addr_L10]
	else:
		_kv_list__iow_list[iow_index].append(addr_L10)
	## collect: periodicity metrics
	pmkvl_update(_kv_list__periodicity_metric[_prd_t1], _prd_t1, addr_L10, linecount_L10)
#	pmkvl_update(_kv_list__periodicity_metric[20000], 20000, addr_L10, linecount_L10)
#	pmkvl_update(_kv_list__periodicity_metric[30000], 30000, addr_L10, linecount_L10)
#	pmkvl_update(_kv_list__periodicity_metric[50000], 50000, addr_L10, linecount_L10)
#	pmkvl_update(_kv_list__periodicity_metric[70000], 70000, addr_L10, linecount_L10)

	## update loop variables
	if (linecount_L10 % _iow_size) == (_iow_size - 1):
		_kv_list__iow_list[iow_index] = [int(x) for x in _kv_list__iow_list[iow_index]]
		_kv_list__iow_list[iow_index].sort()
		iow_index += 1
	linecount_L10 += 1
	## End-of-for-loop

_ioc_total = linecount_L10
_ioc_stop_target = int((float(_ioc_percent) / float(100)) * float(_ioc_total))
_n_o_addr_total = len(_kv_cdst__hits_per_addr) # total number of addresses accessed
## print the collected and calculated results for processing_loop_10
for kv_key, kv_val in _kv_list__addr_hit_tstamp.items():
	print "__list__addr_hit_tstamp__ " + str(kv_key) + " : " + str(kv_val)
for kv_key, kv_val in _kv_cdst__hits_per_addr.items():
	print "__cdst__hits_per_addr__ " + str(kv_key) + " : " + str(kv_val)
pmkvl_print(_kv_list__periodicity_metric, _prd_t1, _ioc_total) # __list__periodicity_metric__
#pmkvl_print(_kv_list__periodicity_metric, 20000, _ioc_total)
#pmkvl_print(_kv_list__periodicity_metric, 30000, _ioc_total)
#pmkvl_print(_kv_list__periodicity_metric, 50000, _ioc_total)
#pmkvl_print(_kv_list__periodicity_metric, 70000, _ioc_total)




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
##  - statistical processing for IOW (IO Window)
##
_kv_list__iow_stat = {}
for k_iow_index, v_iow_alist in _kv_list__iow_list.items():
	_kv_list__iow_stat[k_iow_index] = meanstdv(v_iow_alist)

for kv_key, kv_val in _kv_list__iow_stat.items():
	print "__list__iow_stat__ " + str(kv_key) + " : " + str(kv_val[0]) + " : " + str(kv_val[1])
	## kv_key:k_iow_index; kv_val[0]:mean; kv_val[1]:stdv;




