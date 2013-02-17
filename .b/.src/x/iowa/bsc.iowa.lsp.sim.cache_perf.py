#!/usr/bin/python
## bsc.iowa.lsp.cache_perf_sim.py
## LSP: Line-by-line Stream Processing
##
## _ver=20130208_151133


import sys, os, getopt
from collections import defaultdict
from string import punctuation


_this_prog = os.path.basename(sys.argv[0])


##
## processing input parameters
##
_ioc_permill = None # IO contribution (IOC) permill
def print_help_n_exit(_retval):
	print "Usage", _this_prog, "[-h|--help] -c|--ioc-permill=<_ioc_permill>"
	sys.exit(int(_retval))
try:
	opts, args = getopt.getopt(sys.argv[1:], "hc:", ["help", "ioc-permill="])
except getopt.GetoptError:
	print_help_n_exit(1)
for opt, arg in opts:
	if opt in ("-h", "--help"):
		print_help_n_exit(0)
	elif opt in ("-c", "--ioc-permill"):
		_ioc_permill = int(arg)

## sanity check
if _ioc_permill is None:
	print "#!! ERROR: _ioc_permill is not set"
	print_help_n_exit(2)


##
## function definition
##
def hamming_distance(v1, v2):
	assert len(v1) == len(v2)
	return sum(e1 != e2 for e1, e2 in zip(v1, v2))


##
## processing_loop_10
##	- count: number of hits for each address
##	- collect: hit timestamps for each address
##
_kv_cdst__hits_per_addr = defaultdict(int)
_kv_list__addr_hit_tstamp = {}
vtime_L10 = 0	# vtime: virtual time (not 'real' time) of which value is increased by stream line count
for line in sys.stdin:
	addr_L10 = int(line.strip())
	## count: address hits
	_kv_cdst__hits_per_addr[addr_L10] += 1
	## collect: address hit timestamp
	if addr_L10 not in _kv_list__addr_hit_tstamp:
		_kv_list__addr_hit_tstamp[addr_L10] = [vtime_L10]
	else:
		_kv_list__addr_hit_tstamp[addr_L10].append(vtime_L10)
	## update loop variables
	vtime_L10 += 1
_ioc_total = vtime_L10
_ioc_stop_target = int((float(_ioc_permill) / float(1000)) * float(_ioc_total))
## print the collected and calculated results for processing_loop_10
for kv_key, kv_val in _kv_list__addr_hit_tstamp.items():
	print "__list__addr_hit_tstamp__ " + str(kv_key) + " : " + str(kv_val)
for kv_key, kv_val in _kv_cdst__hits_per_addr.items():
	print "__cdst__hits_per_addr__ " + str(kv_key) + " : " + str(kv_val)


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
## NOW we have '_sighitcnt', '_n_o_sigaddrs', and '_sigioc_acc'
## print the collected and calculated results for processing_loop_30
print "__valu__sig__ _ioc_permill : ", _ioc_permill	# permill value defining significant IO contribution
print "__valu__sig__ _sighitcnt : ", _sighitcnt	# significant hit count
print "__valu__sig__ _n_o_sigaddrs : ", _n_o_sigaddrs	# number of significant addresses (hits>=sighitcnt)
print "__valu__sig__ _sigioc_acc : ", _sigioc_acc	# IO contribution by significant addresses: 


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
## processing loop 50
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
## print the collected and calculated results
for kv_key, kv_val in _kv_cdst__addr_hit_interval.items():
	print "__cdst__addr_hit_interval__ " + str(kv_key) + " : " + str(kv_val)




