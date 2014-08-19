#!/usr/bin/env python
#
# _ver=20140607_154237
# _ver=20140609_165722
# _ver=20140611_190437
#
# b@supernova$ head -10000 blktr.sdb.p0.log | .bpy.iowa.2014s1.mlt_L2_blktr.p010.py -d sdb -b D -x xp_ad_1 -n mysql -a 152520736+10000000 -t 1400310513+2
# -rw-rw-r-- 1 b b       1581 Jun  9 16:46 p7n.l2.blk.20140609_164653.sdb.gwp_summary.txt
# -rw-rw-r-- 1 b b          0 Jun  9 16:46 p7n.l2.blk.20140609_164653.sdb.io_tstamp_log_n.txt
# -rw-rw-r-- 1 b b        383 Jun  9 16:46 p7n.l2.blk.20140609_164653.sdb.io_tstamp_log_r.txt
# -rw-rw-r-- 1 b b        990 Jun  9 16:46 p7n.l2.blk.20140609_164653.sdb.io_tstamp_log_w.txt
# -rw-rw-r-- 1 b b          0 Jun  9 16:46 p7n.l2.blk.20140609_164653.sdb.rehit_tstamp_log_n.txt
# -rw-rw-r-- 1 b b          0 Jun  9 16:46 p7n.l2.blk.20140609_164653.sdb.rehit_tstamp_log_r.txt
# -rw-rw-r-- 1 b b          0 Jun  9 16:46 p7n.l2.blk.20140609_164653.sdb.rehit_tstamp_log_w.txt
# -rw-rw-r-- 1 b b       2204 Jun  9 16:46 p7n.l2.blk.20140609_164653.sdb.tracelog_p010.txt








import os, sys, subprocess, re, datetime, getopt
import math, numpy
from collections import defaultdict
from string import punctuation
from string import maketrans








_this_prog = os.path.basename(sys.argv[0])

_verbose_option = False;
_xp_analysis_depth = 0
_target_disk = None;
_filter_enabled = False;
_filter_blkopr = None;
_filter_pname = None;
_filter_addrrange = None;
_filter_addrrange_start = None;
_filter_addrrange_len = None;
_filter_timerange = None;
_filter_timerange_start = None;
_filter_timerange_len = None;

_usage_string = "\n\
	-h|--help\n\
	-v|--verbose\n\
	-x|--x-param=<param> /* reserved for future use */\n\
	-d|--disk=<target_disk:sda|sdb|sdc|...> /* mandatory option */\n\
	-b|--filter-blkopr=<block_oper_tag:Q,I,D,G,C,...>\n\
	-n|--filter-pname=<process_name>\n\
	-a|--filter-addrrange=<start_sector>+<num_of_sectors>\n\
	-t|--filter-timerange=<start_time>+<num_of_seconds>\n"

try:
	opts, args = getopt.getopt(sys.argv[1:], "hvx:d:b:n:a:t:", ["help", "verbose", "extra-param", "disk=", "filter-blkopr=", "filter-pname=", "filter-addrrange=", "filter-timerange="])
except getopt.GetoptError:
	print "[Usage]\n", _this_prog, _usage_string
	sys.exit(1)

for opt, arg in opts:
	if opt in ("-h", "--help"):
		print "[Help:Usage]\n", _this_prog, _usage_string
		sys.exit(0)
	elif opt in ("-v", "--verbose"):
		_verbose_option = True;
	elif opt in ("-x", "--extra-param"): # xp: extra parameters
		if "xp_ad_1" in arg: # ad: analysis depth
			_xp_analysis_depth = 1
		elif "xp_ad_2" in arg: # ad: analysis depth
			_xp_analysis_depth = 2
		else:
			_xp_analysis_depth = 0
	elif opt in ("-d", "--disk"):
		_target_disk = arg
	elif opt in ("-b", "--filter-blkopr"):
		_filter_blkopr = arg
		_filter_enabled = True
	elif opt in ("-n", "--filter-pname"):
		_filter_pname = arg
		_filter_enabled = True
	elif opt in ("-a", "--filter-addrrange"):
		_filter_addrrange = arg
		_filter_addrrange_start = int(_filter_addrrange.split('+')[0])
		_filter_addrrange_len = int(_filter_addrrange.split('+')[1])
		_filter_enabled = True
	elif opt in ("-t", "--filter-timerange"):
		_filter_timerange = arg
		_filter_timerange_start = int(_filter_timerange.split('+')[0])
		_filter_timerange_len = int(_filter_timerange.split('+')[1])
		_filter_enabled = True
	#else:

if _target_disk is None:
	print "ERROR: target_disk (with '-d|--disk') must be specified"
	sys.exit(2)




#
# { Start of global variables
#

_fname_prefix = "p7n.l2.blk." + datetime.datetime.now().strftime("%Y%m%d_%H%M%S") + "." + _target_disk + "."
_bytes_per_sector = 512

#
# { End of global variables
#








#
# { Start of main processing loop
#

_fname_tracelog_p010_a = _fname_prefix + "tracelog_p010.txt" # all

_f_a = open(_fname_tracelog_p010_a, 'w')

# Returns the size of range overlapped
def chk_range_overlap(arg_range_start, arg_range_len, arg_ref_range_start, arg_ref_range_len):
	range_start = int(arg_range_start)
	range_len = int(arg_range_len)
	ref_range_start = int(arg_ref_range_start)
	ref_range_len = int(arg_ref_range_len)
#	print str(range_start), str(range_len), str(ref_range_start), str(ref_range_len)
	if (range_start <= ref_range_start):
		if (range_start + range_len) > ref_range_start:
			range_overlap = (range_start + range_len) - ref_range_start
		else:
			range_overlap = 0
	elif range_start > ref_range_start:
		if range_start < (ref_range_start + ref_range_len):
			range_overlap = (ref_range_start + ref_range_len) - range_start
		else:
			range_overlap = 0
	return range_overlap

_rehit_tstamp_prev = 0
_io_hist = {}
def chk_io_rehit(addr, iosz, tstamp): # unit: sector (512B)
	global _rehit_tstamp_prev
	global _io_hist
	if (addr, iosz) in _io_hist: # exact matching
		rehit_tstamp_prev_copy = _rehit_tstamp_prev
		_rehit_tstamp_prev = tstamp
		_io_hist[(addr, iosz)] = _io_hist[(addr, iosz)] + 1 # increase the count
		return (iosz, rehit_tstamp_prev_copy)
	#
	# SHOULD be optimized for speed!!!
	# So naive current design, takes too long time
	#
	for ref_io in _io_hist.items():
		ref_io_addr = ref_io[0][0]
		ref_io_iosz= ref_io[0][1]
		overlap_iosz = chk_range_overlap(addr, iosz, ref_io_addr, ref_io_iosz)
		if overlap_iosz is not 0:
			rehit_tstamp_prev_copy = _rehit_tstamp_prev
			_rehit_tstamp_prev = tstamp
			_io_hist[(addr, overlap_iosz)] = 1 # create new one
			return (overlap_iosz, rehit_tstamp_prev_copy)
	_io_hist[(addr, iosz)] = 1 # create new one
	return (0, _rehit_tstamp_prev)

def filter_cond_chk(li_blkopr, li_pname, li_addr, li_iosz, li_tstamp_a):
	pass_flag = {'blkopr':True, 'pname':True, 'addrrange':True, 'timerange':True}
	passfail = True
	if _filter_blkopr is not None:
		if _filter_blkopr in li_blkopr:
			pass_flag['blkopr'] = True
		else:
			pass_flag['blkopr'] = False
	if _filter_pname is not None:
		if _filter_pname in li_pname:
			pass_flag['pname'] = True
		else:
			pass_flag['pname'] = False
	if _filter_addrrange is not None:
		if chk_range_overlap(li_addr, li_iosz, _filter_addrrange_start, _filter_addrrange_len) > 0:
			pass_flag['addrrange'] = True
		else:
			pass_flag['addrrange'] = False
	if _filter_timerange is not None:
		if chk_range_overlap(li_tstamp_a, 1, _filter_timerange_start, _filter_timerange_len) > 0:
			pass_flag['timerange'] = True
		else:
			pass_flag['timerange'] = False
	#
	for kv in pass_flag.items():
		#print ' (' + str(kv[0]) + ':' + str(kv[1]) + ') ' # debug
		passfail = passfail and kv[1]
	#
	return passfail

_iop_nu_seek_dist_abs_tot_a = 0
_iop_nu_seek_dist_abs_tot_r = 0
_iop_nu_seek_dist_abs_tot_w = 0
#_iop_nu_seek_dist_abs_tot_n = 0 # no way

_iop_nu_iocount_a = 0
_iop_nu_iocount_r = 0
_iop_nu_iocount_w = 0
_iop_nu_iocount_n = 0
_iop_nu_ioamount_a = 0
_iop_nu_ioamount_r = 0
_iop_nu_ioamount_w = 0
_iop_nu_ioamount_n = 0
_iop_kvl_io_addr_log_a = {}
_iop_kvl_io_addr_log_r = {}
_iop_kvl_io_addr_log_w = {}
#_iop_kvl_io_addr_log_n = {} # no way
_iop_kvl_io_tstamp_log_a = {}
_iop_kvl_io_tstamp_log_r = {}
_iop_kvl_io_tstamp_log_w = {}
_iop_kvl_io_tstamp_log_n = {}

_iop_nu_rehit_iocount_a = 0
_iop_nu_rehit_iocount_r = 0
_iop_nu_rehit_iocount_w = 0
_iop_nu_rehit_iocount_n = 0
_iop_nu_rehit_ioamount_a = 0
_iop_nu_rehit_ioamount_r = 0
_iop_nu_rehit_ioamount_w = 0
_iop_nu_rehit_ioamount_n = 0
_iop_kvl_rehit_addr_log_a = {}
_iop_kvl_rehit_addr_log_r = {}
_iop_kvl_rehit_addr_log_w = {}
#_iop_kvl_rehit_addr_log_n = {} # no way
_iop_kvl_rehit_tstamp_log_a = {}
_iop_kvl_rehit_tstamp_log_r = {}
_iop_kvl_rehit_tstamp_log_w = {}
_iop_kvl_rehit_tstamp_log_n = {}

#_li_tstamp_prev = 0
_li_addr_end_prev_a = 0
_li_addr_end_prev_r = 0
_li_addr_end_prev_w = 0

for _line in sys.stdin:

	_li = _line.strip().split()

	if (_li.__len__() < 9):
		continue;
	_li_dev = _li[0]
	_li_core = _li[1]
	_li_ioseqnum = _li[2]
#	_li_tstamp = _li[3] # original blkparse --> _li_tstamp_z
	_li_tstamp_z = _li[3] # blusjune's blkparse # 0.001951327
	_li_tstamp_a = _li[4] # blusjune's blkparse # 1400310512
	_li_tstamp_b = _li[5] # blusjune's blkparse # 20140517_160832
	_li_pid = _li[6]
	_li_blkopr = _li[7]
	_li_rwbs = _li[8]

	#_li_tdiff = float("%.9f" % (float(_li_tstamp_z) - float(_li_tstamp_prev)))
	#_li_tstamp_prev = _li_tstamp_z

	if "R" in _li_rwbs:
		_li_iot = "R" # read
	elif "W" in _li_rwbs:
		_li_iot = "W" # write
	else:
		_li_iot = "_" # none of read/write

        # when line is the following case: (but, '-hst' option to the blkparse shakes this out)
        #     <LBA>  '+'     <IOSZ>  '['<PROC_NAME>']'
	#     _li[9] _li[10] _li[11] _li[12]
	if (_li.__len__() >= 13) and (_li[10] == "+") and (isinstance(int(_li[11]), (int))):

		_li_addr = int(_li[9]);
		_li_iosz = int(_li[11]);
		_li_pname = re.sub(r'\[(.*)\]', r'\1', _li[12]);

		if filter_cond_chk(_li_blkopr, _li_pname, _li_addr, _li_iosz, _li_tstamp_a):

			# IO skewness for 'A'
			_iop_kvl_io_addr_log_a[_iop_nu_iocount_a] = _li_addr

			# IO interval for 'A'
			_iop_kvl_io_tstamp_log_a[_iop_nu_iocount_a] = _li_tstamp_z 

			# IO seek distance for 'A'
			_li_seek_dist_a = _li_addr - _li_addr_end_prev_a
			_li_addr_end_prev_a = _li_addr + _li_iosz

			# Accumulation
			_iop_nu_iocount_a = _iop_nu_iocount_a + 1
			_iop_nu_ioamount_a = _iop_nu_ioamount_a + _li_iosz
			_iop_nu_seek_dist_abs_tot_a = _iop_nu_seek_dist_abs_tot_a + abs(_li_seek_dist_a)

			# Save to a file
			_f_a.write(str('0') + ' ' + str(_li_tstamp_z) + ' ' + str(_li_tstamp_a) + ' ' + str(_li_tstamp_b)\
					+ ' ' + str(_li_dev) + ' ' + str(_li_core) + ' ' + str(_li_ioseqnum) + ' ' + str(_li_pid)\
					+ ' ' + str(_li_blkopr) + ' ' + str(_li_rwbs) + ' ' + str(_li_iot)\
					+ ' ' + str(_li_addr) + ' ' + str(_li_iosz) + ' ' + str(_li_seek_dist_a) + ' ' + str(_li_pname)\
					+ '\n');
#			print '0', _li_tstamp_z, _li_tstamp_a, _li_tstamp_b,\
#				_li_dev, _li_core, _li_ioseqnum, _li_pid, _li_blkopr, _li_rwbs, _li_iot,\
#				_li_addr, _li_iosz, _li_seek_dist_a, _li_pname\
#				;
#
#			colnames(d) <- 
#				c("__a", "tstamp_z", "tstamp_a", "tstamp_b", "dev", "core", "ioseqnum", "pid", "blkopr", "rwbs", "iot", "addr", "iosz", "seek_dist", "pname")

			if _li_iot is "R":
				# IO skewness for 'R'
				_iop_kvl_io_addr_log_r[_iop_nu_iocount_r] = _li_addr
				# IO interval for 'R'
				_iop_kvl_io_tstamp_log_r[_iop_nu_iocount_r] = _li_tstamp_z 
				# IO seek distance for 'R'
				_li_seek_dist_r = _li_addr - _li_addr_end_prev_r
				_li_addr_end_prev_r = _li_addr + _li_iosz
				# Accumulation
				_iop_nu_iocount_r = _iop_nu_iocount_r + 1
				_iop_nu_ioamount_r = _iop_nu_ioamount_r + _li_iosz
				_iop_nu_seek_dist_abs_tot_r = _iop_nu_seek_dist_abs_tot_r + abs(_li_seek_dist_r)

			elif _li_iot is "W":
				# IO skewness for 'W'
				_iop_kvl_io_addr_log_w[_iop_nu_iocount_w] = _li_addr
				# IO interval for 'W'
				_iop_kvl_io_tstamp_log_w[_iop_nu_iocount_w] = _li_tstamp_z 
				# IO seek distance for 'W'
				_li_seek_dist_w = _li_addr - _li_addr_end_prev_w
				_li_addr_end_prev_w = _li_addr + _li_iosz
				# Accumulation
				_iop_nu_iocount_w = _iop_nu_iocount_w + 1
				_iop_nu_ioamount_w = _iop_nu_ioamount_w + _li_iosz
				_iop_nu_seek_dist_abs_tot_w = _iop_nu_seek_dist_abs_tot_w + abs(_li_seek_dist_w)

			else:
				# IO interval for 'N'
				_iop_kvl_io_tstamp_log_n[_iop_nu_iocount_n] = _li_tstamp_z 
				# Accumulation
				_iop_nu_iocount_n = _iop_nu_iocount_n + 1
				_iop_nu_ioamount_n = _iop_nu_ioamount_n + _li_iosz

			# AnalysisDepth >= 1
			if _xp_analysis_depth >= 1:
				#
				# Tracing for re-hit IO
				io_rehit = chk_io_rehit(_li_addr, _li_iosz, _li_tstamp_z)
				if io_rehit[0] is not 0: # yes, rehit!
					# Rehit skewness for 'A'
					_iop_kvl_rehit_addr_log_a[_iop_nu_rehit_iocount_a] = _li_addr
					_iop_kvl_rehit_tstamp_log_a[_iop_nu_rehit_iocount_a] = _li_tstamp_z
					# Accumulation
					_iop_nu_rehit_iocount_a = _iop_nu_rehit_iocount_a + 1
					_iop_nu_rehit_ioamount_a = _iop_nu_rehit_ioamount_a + io_rehit[0]
					if _li_iot is "R":
						_iop_kvl_rehit_addr_log_r[_iop_nu_rehit_iocount_r] = _li_addr
						_iop_kvl_rehit_tstamp_log_r[_iop_nu_rehit_iocount_r] = _li_tstamp_z
						# Accumulation
						_iop_nu_rehit_iocount_r = _iop_nu_rehit_iocount_r + 1 
						_iop_nu_rehit_ioamount_r = _iop_nu_rehit_ioamount_r + io_rehit[0]
					elif _li_iot is "W":
						_iop_kvl_rehit_addr_log_w[_iop_nu_rehit_iocount_w] = _li_addr
						_iop_kvl_rehit_tstamp_log_w[_iop_nu_rehit_iocount_w] = _li_tstamp_z
						# Accumulation
						_iop_nu_rehit_iocount_w = _iop_nu_rehit_iocount_w + 1 
						_iop_nu_rehit_ioamount_w = _iop_nu_rehit_ioamount_w + io_rehit[0]
					else:
						_iop_kvl_rehit_tstamp_log_n[_iop_nu_rehit_iocount_n] = _li_tstamp_z
						# Accumulation
						_iop_nu_rehit_iocount_n = _iop_nu_rehit_iocount_n + 1 
						_iop_nu_rehit_ioamount_n = _iop_nu_rehit_ioamount_n + io_rehit[0]

	elif _verbose_option is True:

		_li_auxinf_raw = _li[9:];
		_str2 = "";
		_list2 = [];
		for _li2 in _li_auxinf_raw:
			_li2_new = re.sub(r'[\[\]]', r'', _li2);
			_list2 = [_str2, _li2_new];
			_str2 = " ".join(_list2);
		_li_auxinf = _str2;

		_f_a.write(str('#') + ' ' + str(_li_tstamp_z) + ' ' + str(_li_tstamp_a) + ' ' + str(_li_tstamp_b)\
				+ ' ' + str(_li_dev) + ' ' + str(_li_core) + ' ' + str(_li_ioseqnum) + ' ' + str(_li_pid)\
				+ ' ' + str(_li_blkopr) + ' ' + str(_li_rwbs) + ' ' + str(_li_iot)\
				+ ' ' + str(_li_auxinf)\
				+ '\n');

#		print '#', _li_tstamp_z, _li_tstamp_a, _li_tstamp_b,\
#			_li_dev, _li_core, _li_ioseqnum, _li_pid, _li_blkopr, _li_rwbs, _li_iot,\
#			_li_auxinf\
#			;

_f_a.close()

#
# } End of main processing loop
#








#
# { Start of storing the result to the files
#

#
# Save timestamp log data to each file
#

_io_r_interval_mean = 0
_io_r_interval_sd = 0
_io_w_interval_mean = 0
_io_w_interval_sd = 0
_io_n_interval_mean = 0
_io_n_interval_sd = 0
_rehit_r_interval_mean = 0
_rehit_r_interval_sd = 0
_rehit_w_interval_mean = 0
_rehit_w_interval_sd = 0
_rehit_n_interval_mean = 0
_rehit_n_interval_sd = 0

def rcmd_cal_iointerval_mean_sd(fn_dat):
# Child R command for mother Python:
#	(1) to calculate IO interval mean and standard deviation
#	(2) to save the results to the separate files
#
	_fn_rcmd = '.rcmd.cal_iointerval_mean_sd.r'
	_fn_rout_mean = '.rout.mean'
	_fn_rout_sd = '.rout.sd'
#
	# write to _fn_rcmd
	f = open(_fn_rcmd, 'w')
	f.write('d <- read.table("' + fn_dat + '"); write(mean(d$V5), file="' + _fn_rout_mean + '"); write(sd(d$V5), file="' + _fn_rout_sd + '");')
	f.close()
#
	# execute _fn_rcmd
	subprocess.call(["R", "--silent", "-f", _fn_rcmd])
#
	# read from _fn_rout_mean
	f = open(_fn_rout_mean, 'r')
	mean = f.readline().strip()
	f.close()
#
	# read from _fn_rout_sd
	f = open(_fn_rout_sd, 'r')
	sd = f.readline().strip()
	f.close()
#
	# clear (delete) tmp files
	subprocess.call(["rm", "-f", _fn_rcmd, _fn_rout_mean, _fn_rout_sd])
	return (mean, sd)

# Processing time-series timestamp data:
#	(1) compute mean and sd
#	(2) save timestamp and interval to a file
# Parameters:
#	ts_kvl = _iop_kvl_io_tstamp_log_r
#	rec_hdr_str = "io_tstamp_log  _r_  seconds  "
#		fn_radix = 'io_tstamp_log_r.txt'
#	fn_prefix = _fname_prefix
def proc_ts_tstamp_data(ts_kvl, rec_hdr_str, fn_prefix):
	tok = rec_hdr_str.split()
#	fn_radix = tok[0] + '_' + tok[1].split('_')[1] + '.txt'
	fn_radix = tok[0] + tok[1] + '.txt'
	fn = fn_prefix + fn_radix
	if ts_kvl.__len__() is not 0:
		f = open(fn, 'w')
		_v_prev = -1
		for k,v in ts_kvl.items():
			if _v_prev is -1:
				_v_prev = v
			f.write("io_tstamp_log  __r  seconds  " + str(v) + "  " + str(float(v) - float(_v_prev)) + "  " + "\n")
			_v_prev = v
		f.close()
		return (rcmd_cal_iointerval_mean_sd(fn))
		#_retval = rcmd_cal_iointerval_mean_sd(fn)
		#_io_r_interval_mean = _retval[0]
		#_io_r_interval_sd = _retval[1]
	else:
		print "P7N:WARNING: proc_ts_tstamp_data(): ts_kvl is empty: " + str(rec_hdr_str)
		f = open(fn, 'w')
		f.close()
		return ('NA', 'NA')

# io _a_
_retval = proc_ts_tstamp_data(_iop_kvl_io_tstamp_log_a, "io_tstamp_log  __a  seconds  ", _fname_prefix)
_io_a_interval_mean = _retval[0]
_io_a_interval_sd = _retval[1]
# io _r_
_retval = proc_ts_tstamp_data(_iop_kvl_io_tstamp_log_r, "io_tstamp_log  __r  seconds  ", _fname_prefix)
_io_r_interval_mean = _retval[0]
_io_r_interval_sd = _retval[1]
# io _w_
_retval = proc_ts_tstamp_data(_iop_kvl_io_tstamp_log_w, "io_tstamp_log  __w  seconds  ", _fname_prefix)
_io_w_interval_mean = _retval[0]
_io_w_interval_sd = _retval[1]
# io _n_
_retval = proc_ts_tstamp_data(_iop_kvl_io_tstamp_log_n, "io_tstamp_log  __n  seconds  ", _fname_prefix)
_io_n_interval_mean = _retval[0]
_io_n_interval_sd = _retval[1]

# AnalysisDepth >= 1
if _xp_analysis_depth >= 1:
	# rehit _a_
	_retval = proc_ts_tstamp_data(_iop_kvl_rehit_tstamp_log_a, "rehit_tstamp_log  __a  seconds  ", _fname_prefix)
	_rehit_a_interval_mean = _retval[0]
	_rehit_a_interval_sd = _retval[1]
	# rehit _r_
	_retval = proc_ts_tstamp_data(_iop_kvl_rehit_tstamp_log_r, "rehit_tstamp_log  __r  seconds  ", _fname_prefix)
	_rehit_r_interval_mean = _retval[0]
	_rehit_r_interval_sd = _retval[1]
	# rehit _w_
	_retval = proc_ts_tstamp_data(_iop_kvl_rehit_tstamp_log_w, "rehit_tstamp_log  __w  seconds  ", _fname_prefix)
	_rehit_w_interval_mean = _retval[0]
	_rehit_w_interval_sd = _retval[1]
	# rehit _n_
	_retval = proc_ts_tstamp_data(_iop_kvl_rehit_tstamp_log_n, "rehit_tstamp_log  __n  seconds  ", _fname_prefix)
	_rehit_n_interval_mean = _retval[0]
	_rehit_n_interval_sd = _retval[1]




_fname_io_addr_a = _fname_prefix + "addr_log_io_skew_a.txt"
_fname_io_addr_r = _fname_prefix + "addr_log_io_skew_r.txt"
_fname_io_addr_w = _fname_prefix + "addr_log_io_skew_w.txt"
_fname_rehit_addr_a = _fname_prefix + "addr_log_rehit_skew_a.txt"
_fname_rehit_addr_r = _fname_prefix + "addr_log_rehit_skew_r.txt"
_fname_rehit_addr_w = _fname_prefix + "addr_log_rehit_skew_w.txt"

def save_kvl_data_to_file(ts_kvl, fn):
	f = open(fn, 'w')
	if ts_kvl.__len__() is not 0:
		for k,v in ts_kvl.items():
			f.write(str(v) + "  " + "\n")
	else:
	  	print "P7N:WARNING: save_kvl_data_to_file(): ts_kvl is empty: " + str(fn)
	f.close()

save_kvl_data_to_file(_iop_kvl_io_addr_log_a, _fname_io_addr_a)
save_kvl_data_to_file(_iop_kvl_io_addr_log_r, _fname_io_addr_r)
save_kvl_data_to_file(_iop_kvl_io_addr_log_w, _fname_io_addr_w)

# AnalysisDepth >= 1
if _xp_analysis_depth >= 1:
	save_kvl_data_to_file(_iop_kvl_rehit_addr_log_a, _fname_rehit_addr_a)
	save_kvl_data_to_file(_iop_kvl_rehit_addr_log_r, _fname_rehit_addr_r)
	save_kvl_data_to_file(_iop_kvl_rehit_addr_log_w, _fname_rehit_addr_w)

def rcmd_cal_ioskew(fn_dat, param_cdf_ref):
# Child R command for mother Python:
#	(1) to calculate IO skewness
#
	_fn_rcmd = '.rcmd.cal_ioskew.r'
	_fn_rout = '.rout.topk_for_cdf'
#
	_rcmd_str_01__func_a = '\
cal_topk_for_cdf <- function(d, cdf_ref, zone_sz=1000, ndigits=3) {\n\
	pct_coef = 1;\n\
	ktotal = length(d);\n\
	d.tab.sort <- sort(table(floor(d/zone_sz) * zone_sz), decreasing=T);\n\
	for (k in 1:ktotal) {\n\
		topk_cdf <- sum(d.tab.sort[1:k]/ktotal);\n\
		if (topk_cdf > cdf_ref) {\n\
			break;\n\
		}\n\
	};\n\
	retval <- data.frame(topk=k, topk_pct=round(pct_coef * k/ktotal, digits=ndigits), cdf_by_topk=round(pct_coef * topk_cdf, digits=ndigits), k_total=ktotal);\n\
	return(retval);\n\
};\n\
';
	_rcmd_str_02__read_table = 'd <- read.table("' + fn_dat + '");\n'
	#_rcmd_str_03__set_colnames = 'colnames(d) <- c("__a", "tstamp_z", "tstamp_a", "tstamp_b", "dev", "core", "ioseqnum", "pid", "blkopr", "rwbs", "iot", "addr", "iosz", "seek_dist", "pname");\n';
	_rcmd_str_03__set_colnames = 'colnames(d) <- c("addr");\n';
	#_rcmd_str_04__call_func_a = 'result <- cal_topk_for_cdf(d$addr, cdf_ref=0.8, zone_sz=1000);'
	_rcmd_str_04__call_func_a = 'result <- cal_topk_for_cdf(d$addr, cdf_ref=' + str(param_cdf_ref) + ', zone_sz=1000);\n'
	_rcmd_str_05__save_result_to_a_file = 'write(unlist(result), file="' + str(_fn_rout) + '");\n'
#
	finfo = os.stat(fn_dat)
	if finfo.st_size is not 0:
		# write to _fn_rcmd
		f = open(_fn_rcmd, 'w')
		f.write(_rcmd_str_01__func_a);
		f.write(_rcmd_str_02__read_table);
		f.write(_rcmd_str_03__set_colnames);
		f.write(_rcmd_str_04__call_func_a);
		f.write(_rcmd_str_05__save_result_to_a_file);
		f.close()
		# execute _fn_rcmd
		subprocess.call(["R", "--silent", "-f", _fn_rcmd])
		# read from _fn_rout
		f = open(_fn_rout, 'r')
		result = f.readline().strip().split()
		topk = result[0]
		topk_pct = result[1]
		cdf_by_topk = result[2]
		k_total = result[3]
		f.close()
		# clear (delete) tmp files
		subprocess.call(["rm", "-f", _fn_rcmd, _fn_rout])
		# return the results
		return (topk, topk_pct, cdf_by_topk, k_total)
	else:
		print "P7N:WARNING: rcmd_cal_ioskew()" + str(fn_dat) + " is an empty file"
		# return the results
		return ('NA', 'NA', 'NA', 'NA')




#
# Save summary data to a file
#

_fname_iop_summary = _fname_prefix + 'gwp_summary.txt'
f = _f_iop_summary = open(_fname_iop_summary, 'w')

# GWP:IOSizeAvg
if _iop_nu_iocount_r is not 0:
	f.write("average_iosize  __r  bytes  " + str(_bytes_per_sector * _iop_nu_ioamount_r / _iop_nu_iocount_r) + "\n")
else:
	f.write("average_iosize  __r  bytes  " + str('NA') + "\n")
if _iop_nu_iocount_w is not 0:
	f.write("average_iosize  __w  bytes  " + str(_bytes_per_sector * _iop_nu_ioamount_w / _iop_nu_iocount_w) + "\n")
else:
	f.write("average_iosize  __w  bytes  " + str('NA') + "\n")

# GWP:SeekDistanceAvg
if _iop_nu_iocount_a is not 0:
	f.write("average_seek_dist_per_io  __a  bytes  " + str(round(float(_bytes_per_sector * _iop_nu_seek_dist_abs_tot_a)/float(_iop_nu_iocount_a), 3)) + "\n")
else:
	f.write("average_seek_dist_per_io  __a  bytes  " + str('NA') + "\n")
if _iop_nu_iocount_r is not 0:
	f.write("average_seek_dist_per_io  __r  bytes  " + str(round(float(_bytes_per_sector * _iop_nu_seek_dist_abs_tot_r)/float(_iop_nu_iocount_r), 3)) + "\n")
else:
	f.write("average_seek_dist_per_io  __r  bytes  " + str('NA') + "\n")
if _iop_nu_iocount_w is not 0:
	f.write("average_seek_dist_per_io  __w  bytes  " + str(round(float(_bytes_per_sector * _iop_nu_seek_dist_abs_tot_w)/float(_iop_nu_iocount_w), 3)) + "\n")
else:
	f.write("average_seek_dist_per_io  __w  bytes  " + str('NA') + "\n")

# GWP:AccessSkewness
_ref_cdf = float(0.8); _ioskew_retval = rcmd_cal_ioskew(_fname_io_addr_a, _ref_cdf); _ioskew_topk_pct = _ioskew_retval[1];
f.write("io_skewness_80  __a  (top_k_addr=" + str(_ioskew_retval[0]) + "/total_addr=" + str(_ioskew_retval[3]) + ")  " + str(_ioskew_topk_pct) + "\n")
_ref_cdf = float(0.5); _ioskew_retval = rcmd_cal_ioskew(_fname_io_addr_a, _ref_cdf); _ioskew_topk_pct = _ioskew_retval[1];
f.write("io_skewness_50  __a  (top_k_addr=" + str(_ioskew_retval[0]) + "/total_addr=" + str(_ioskew_retval[3]) + ")  " + str(_ioskew_topk_pct) + "\n")
_ref_cdf = float(0.2); _ioskew_retval = rcmd_cal_ioskew(_fname_io_addr_a, _ref_cdf); _ioskew_topk_pct = _ioskew_retval[1];
f.write("io_skewness_20  __a  (top_k_addr=" + str(_ioskew_retval[0]) + "/total_addr=" + str(_ioskew_retval[3]) + ")  " + str(_ioskew_topk_pct) + "\n")
#
_ref_cdf = float(0.8); _ioskew_retval = rcmd_cal_ioskew(_fname_io_addr_r, _ref_cdf); _ioskew_topk_pct = _ioskew_retval[1];
f.write("io_skewness_80  __r  (top_k_addr=" + str(_ioskew_retval[0]) + "/total_addr=" + str(_ioskew_retval[3]) + ")  " + str(_ioskew_topk_pct) + "\n")
_ref_cdf = float(0.5); _ioskew_retval = rcmd_cal_ioskew(_fname_io_addr_r, _ref_cdf); _ioskew_topk_pct = _ioskew_retval[1];
f.write("io_skewness_50  __r  (top_k_addr=" + str(_ioskew_retval[0]) + "/total_addr=" + str(_ioskew_retval[3]) + ")  " + str(_ioskew_topk_pct) + "\n")
_ref_cdf = float(0.2); _ioskew_retval = rcmd_cal_ioskew(_fname_io_addr_r, _ref_cdf); _ioskew_topk_pct = _ioskew_retval[1];
f.write("io_skewness_20  __r  (top_k_addr=" + str(_ioskew_retval[0]) + "/total_addr=" + str(_ioskew_retval[3]) + ")  " + str(_ioskew_topk_pct) + "\n")
#
_ref_cdf = float(0.8); _ioskew_retval = rcmd_cal_ioskew(_fname_io_addr_w, _ref_cdf); _ioskew_topk_pct = _ioskew_retval[1];
f.write("io_skewness_80  __w  (top_k_addr=" + str(_ioskew_retval[0]) + "/total_addr=" + str(_ioskew_retval[3]) + ")  " + str(_ioskew_topk_pct) + "\n")
_ref_cdf = float(0.5); _ioskew_retval = rcmd_cal_ioskew(_fname_io_addr_w, _ref_cdf); _ioskew_topk_pct = _ioskew_retval[1];
f.write("io_skewness_50  __w  (top_k_addr=" + str(_ioskew_retval[0]) + "/total_addr=" + str(_ioskew_retval[3]) + ")  " + str(_ioskew_topk_pct) + "\n")
_ref_cdf = float(0.2); _ioskew_retval = rcmd_cal_ioskew(_fname_io_addr_w, _ref_cdf); _ioskew_topk_pct = _ioskew_retval[1];
f.write("io_skewness_20  __w  (top_k_addr=" + str(_ioskew_retval[0]) + "/total_addr=" + str(_ioskew_retval[3]) + ")  " + str(_ioskew_topk_pct) + "\n")

# GWP:IOCount
f.write("iocount  __a  ios  " + str(_iop_nu_iocount_a) + "\n")
f.write("iocount  __r  ios  " + str(_iop_nu_iocount_r) + "\n")
f.write("iocount  __w  ios  " + str(_iop_nu_iocount_w) + "\n")
f.write("iocount  __n  ios  " + str(_iop_nu_iocount_n) + "\n")
if (_iop_nu_iocount_r is not 0) and (_iop_nu_iocount_w is not 0):
	f.write("iocount  __rwratio  (read/write)  " + \
			str(float(_iop_nu_iocount_r)/float(_iop_nu_iocount_w)) + "\n")
	f.write("iocount  __rwratio_log10  log10(read/write)  " + \
			str(round(math.log(float(_iop_nu_iocount_r)/float(_iop_nu_iocount_w), 10), 3)) + "\n")
else:
	f.write("iocount  __rwratio  (read/write)  " + "NA" + "\n")
	f.write("iocount  __rwratio_log10  log10(read/write)  " + "NA" + "\n")

# GWP:IOAmount
f.write("ioamount  __a  bytes  " + str(_bytes_per_sector * _iop_nu_ioamount_a) + "\n")
f.write("ioamount  __r  bytes  " + str(_bytes_per_sector * _iop_nu_ioamount_r) + "\n")
f.write("ioamount  __w  bytes  " + str(_bytes_per_sector * _iop_nu_ioamount_w) + "\n")
f.write("ioamount  __n  bytes  " + str(_bytes_per_sector * _iop_nu_ioamount_n) + "\n")
if (_iop_nu_ioamount_r is not 0) and (_iop_nu_ioamount_w is not 0):
	f.write("ioamount  __rwratio  (read/write)  " + \
			str(float(_iop_nu_ioamount_r)/float(_iop_nu_ioamount_w)) + "\n")
	f.write("ioamount  __rwratio_log10  log10(read/write)  " + \
			str(round(math.log(float(_iop_nu_ioamount_r)/float(_iop_nu_ioamount_w), 10), 3)) + "\n")
else:
	f.write("ioamount  __rwratio  (read/write)  " + "NA" + "\n")
	f.write("ioamount  __rwratio_log10  log10(read/write)  " + "NA" + "\n")

# GWP:IOInterval
f.write("io_interval_mean  __a  seconds  " + str(_io_a_interval_mean) + "\n")
f.write("io_interval_mean  __r  seconds  " + str(_io_r_interval_mean) + "\n")
f.write("io_interval_mean  __w  seconds  " + str(_io_w_interval_mean) + "\n")
f.write("io_interval_mean  __n  seconds  " + str(_io_n_interval_mean) + "\n")
f.write("io_interval_sd  __a  seconds  " + str(_io_a_interval_sd) + "\n")
f.write("io_interval_sd  __r  seconds  " + str(_io_r_interval_sd) + "\n")
f.write("io_interval_sd  __w  seconds  " + str(_io_w_interval_sd) + "\n")
f.write("io_interval_sd  __n  seconds  " + str(_io_n_interval_sd) + "\n")

# AnalysisDepth >= 1
if _xp_analysis_depth >= 1:

	# rehit iocount
	f.write("rehit_iocount  __a  ios  " + str(_iop_nu_rehit_iocount_a) + "\n")
	f.write("rehit_iocount  __r  ios  " + str(_iop_nu_rehit_iocount_r) + "\n")
	f.write("rehit_iocount  __w  ios  " + str(_iop_nu_rehit_iocount_w) + "\n")
	f.write("rehit_iocount  __n  ios  " + str(_iop_nu_rehit_iocount_n) + "\n")
	if (_iop_nu_rehit_iocount_r is not 0) and (_iop_nu_rehit_iocount_w is not 0):
		f.write("rehit_iocount  __rwratio  (read/write)  " + \
				str(float(_iop_nu_rehit_iocount_r)/float(_iop_nu_rehit_iocount_w)) + "\n")
		f.write("rehit_iocount  __rwratio_log10  log10(read/write)  " + \
				str(round(math.log(float(_iop_nu_rehit_iocount_r)/float(_iop_nu_rehit_iocount_w), 10), 3)) + "\n")
	else:
		f.write("rehit_iocount  __rwratio  (read/write)  " + "NA" + "\n")
		f.write("rehit_iocount  __rwratio_log10  log10(read/write)  " + "NA" + "\n")

	# rehit ioamount
	f.write("rehit_ioamount  __r  bytes  " + str(_bytes_per_sector * _iop_nu_rehit_ioamount_r) + "\n")
	f.write("rehit_ioamount  __w  bytes  " + str(_bytes_per_sector * _iop_nu_rehit_ioamount_w) + "\n")
	f.write("rehit_ioamount  __n  bytes  " + str(_bytes_per_sector * _iop_nu_rehit_ioamount_n) + "\n")
	if (_iop_nu_rehit_ioamount_r is not 0) and (_iop_nu_rehit_ioamount_w is not 0):
		f.write("rehit_ioamount  __rwratio  (read/write)  " + \
				str(float(_iop_nu_rehit_ioamount_r)/float(_iop_nu_rehit_ioamount_w)) + "\n")
		f.write("rehit_ioamount  __rwratio_log10  log10(read/write)  " + \
				str(round(math.log(float(_iop_nu_rehit_ioamount_r)/float(_iop_nu_rehit_ioamount_w), 10), 3)) + "\n")
	else:
		f.write("rehit_ioamount  __rwratio  (read/write)  " + "NA" + "\n")
		f.write("rehit_ioamount  __rwratio_log10  log10(read/write)  " + "NA" + "\n")

	# rehit/total iocount
	if _iop_nu_iocount_r is not 0:
		f.write("rehit_vs_total_iocount  __rer_r_ratio  (rehit_ios_r/total_ios_r)  " + \
				str(float(_iop_nu_rehit_iocount_r) / float(_iop_nu_iocount_r)) + "\n")
	else:
		f.write("rehit_vs_total_iocount  __rer_r_ratio  (rehit_ios_r/total_ios_r)  " + \
				str('NA') + "\n")
	if _iop_nu_iocount_w is not 0:
		f.write("rehit_vs_total_iocount  __rew_w_ratio  (rehit_ios_w/total_ios_w)  " + \
				str(float(_iop_nu_rehit_iocount_w) / float(_iop_nu_iocount_w)) + "\n")
	else:
		f.write("rehit_vs_total_iocount  __rew_w_ratio  (rehit_ios_w/total_ios_w)  " + \
				str('NA') + "\n")

	# rehit/total ioamount
	if _iop_nu_ioamount_r is not 0:
		f.write("rehit_vs_total_ioamount  __rer_r_ratio  (rehit_bytes_r/total_bytes_r)  " + \
				str(float(_iop_nu_rehit_ioamount_r) / float(_iop_nu_ioamount_r)) + "\n")
	else:
		f.write("rehit_vs_total_ioamount  __rer_r_ratio  (rehit_bytes_r/total_bytes_r)  " + \
				str('NA') + "\n")
	if _iop_nu_ioamount_w is not 0:
		f.write("rehit_vs_total_ioamount  __rew_w_ratio  (rehit_bytes_w/total_bytes_w)  " + \
				str(float(_iop_nu_rehit_ioamount_w) / float(_iop_nu_ioamount_w)) + "\n")
	else:
		f.write("rehit_vs_total_ioamount  __rew_w_ratio  (rehit_bytes_w/total_bytes_w)  " + \
				str('NA') + "\n")

	# rehit skewness
	_ref_cdf = float(0.8); _ioskew_retval = rcmd_cal_ioskew(_fname_rehit_addr_a, _ref_cdf); _ioskew_topk_pct = _ioskew_retval[1];
	f.write("rehit_skewness_80  __a  (top_k_addr=" + str(_ioskew_retval[0]) + "/total_addr=" + str(_ioskew_retval[3]) + ")  " + str(_ioskew_topk_pct) + "\n")
	_ref_cdf = float(0.5); _ioskew_retval = rcmd_cal_ioskew(_fname_rehit_addr_a, _ref_cdf); _ioskew_topk_pct = _ioskew_retval[1];
	f.write("rehit_skewness_50  __a  (top_k_addr=" + str(_ioskew_retval[0]) + "/total_addr=" + str(_ioskew_retval[3]) + ")  " + str(_ioskew_topk_pct) + "\n")
	_ref_cdf = float(0.2); _ioskew_retval = rcmd_cal_ioskew(_fname_rehit_addr_a, _ref_cdf); _ioskew_topk_pct = _ioskew_retval[1];
	f.write("rehit_skewness_20  __a  (top_k_addr=" + str(_ioskew_retval[0]) + "/total_addr=" + str(_ioskew_retval[3]) + ")  " + str(_ioskew_topk_pct) + "\n")
	#
	_ref_cdf = float(0.8); _ioskew_retval = rcmd_cal_ioskew(_fname_rehit_addr_r, _ref_cdf); _ioskew_topk_pct = _ioskew_retval[1];
	f.write("rehit_skewness_80  __r  (top_k_addr=" + str(_ioskew_retval[0]) + "/total_addr=" + str(_ioskew_retval[3]) + ")  " + str(_ioskew_topk_pct) + "\n")
	_ref_cdf = float(0.5); _ioskew_retval = rcmd_cal_ioskew(_fname_rehit_addr_r, _ref_cdf); _ioskew_topk_pct = _ioskew_retval[1];
	f.write("rehit_skewness_50  __r  (top_k_addr=" + str(_ioskew_retval[0]) + "/total_addr=" + str(_ioskew_retval[3]) + ")  " + str(_ioskew_topk_pct) + "\n")
	_ref_cdf = float(0.2); _ioskew_retval = rcmd_cal_ioskew(_fname_rehit_addr_r, _ref_cdf); _ioskew_topk_pct = _ioskew_retval[1];
	f.write("rehit_skewness_20  __r  (top_k_addr=" + str(_ioskew_retval[0]) + "/total_addr=" + str(_ioskew_retval[3]) + ")  " + str(_ioskew_topk_pct) + "\n")
	#
	_ref_cdf = float(0.8); _ioskew_retval = rcmd_cal_ioskew(_fname_rehit_addr_w, _ref_cdf); _ioskew_topk_pct = _ioskew_retval[1];
	f.write("rehit_skewness_80  __w  (top_k_addr=" + str(_ioskew_retval[0]) + "/total_addr=" + str(_ioskew_retval[3]) + ")  " + str(_ioskew_topk_pct) + "\n")
	_ref_cdf = float(0.5); _ioskew_retval = rcmd_cal_ioskew(_fname_rehit_addr_w, _ref_cdf); _ioskew_topk_pct = _ioskew_retval[1];
	f.write("rehit_skewness_50  __w  (top_k_addr=" + str(_ioskew_retval[0]) + "/total_addr=" + str(_ioskew_retval[3]) + ")  " + str(_ioskew_topk_pct) + "\n")
	_ref_cdf = float(0.2); _ioskew_retval = rcmd_cal_ioskew(_fname_rehit_addr_w, _ref_cdf); _ioskew_topk_pct = _ioskew_retval[1];
	f.write("rehit_skewness_20  __w  (top_k_addr=" + str(_ioskew_retval[0]) + "/total_addr=" + str(_ioskew_retval[3]) + ")  " + str(_ioskew_topk_pct) + "\n")

	# rehit interval
	f.write("rehit_interval_mean  __a  seconds  " + str(_rehit_a_interval_mean) + "\n")
	f.write("rehit_interval_mean  __r  seconds  " + str(_rehit_r_interval_mean) + "\n")
	f.write("rehit_interval_mean  __w  seconds  " + str(_rehit_w_interval_mean) + "\n")
	f.write("rehit_interval_mean  __n  seconds  " + str(_rehit_n_interval_mean) + "\n")
	f.write("rehit_interval_sd  __a  seconds  " + str(_rehit_a_interval_sd) + "\n")
	f.write("rehit_interval_sd  __r  seconds  " + str(_rehit_r_interval_sd) + "\n")
	f.write("rehit_interval_sd  __w  seconds  " + str(_rehit_w_interval_sd) + "\n")
	f.write("rehit_interval_sd  __n  seconds  " + str(_rehit_n_interval_sd) + "\n")

_f_iop_summary.close()

#
# } End of storing the result to the files
#




