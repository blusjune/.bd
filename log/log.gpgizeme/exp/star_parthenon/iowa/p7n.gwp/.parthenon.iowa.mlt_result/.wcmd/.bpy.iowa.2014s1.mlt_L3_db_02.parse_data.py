#!/usr/bin/env python
#_author="Brian M. JUNG <brian.m.jung@gmail.com>";
#_ver=20140510_142913
#_ver=20140511_202043
#_ver=20140512_230544
#_ver=20140519_211144;




import os, sys, getopt
import re
import math
from collections import defaultdict
from string import punctuation
from string import maketrans


_this_prog = os.path.basename(sys.argv[0])
#nargs = len(sys.argv);
#if (nargs > 1):
#	_radix = (sys.argv[1]).strip();
#else:
#	_radix = _this_prog.strip().split('.')[5]
#print _radix


# old version of mlt (20140511_202043)
# _cnt_b=00  ##  *************************** 1. row ***************************
# _cnt_b=01  ##  Tstamp_a: 1398694727
# _cnt_b=02  ##  Tstamp_b: 20140428_231847
# _cnt_b=03  ##  innodb_buffer_pool_stats_plid	plsz	plsz_free	dbpg	dbpg_old	dbpg_mod	pg_young	pg_no_young	r_pages	c_pages	w_pages	r_pend	lru_io_tot	lru_io_cur	hit_rate
# _cnt_b=04  ##  0	8191	5230	2960	1112	280	2	0	2954	0	2896	6	0	2632	924
# _cnt_b=05  ##  1	8192	5630	2562	965	279	0	0	2558	2	3184	2	0	2632	876
# _cnt_b=06  ##  2	8192	5351	2841	1068	213	0	0	2836	0	2883	5	0	2632	856
# _cnt_b=07  ##  3	8192	5304	2888	1086	244	0	0	2884	0	2869	4	0	2632	818
# _cnt_b=08  ##  4	8192	5229	2963	1113	594	0	0	2957	1	5818	5	0	2632	910
# _cnt_b=09  ##  5	8192	5545	2647	997	161	0	0	2644	0	2732	3	0	2632	837
# _cnt_b=10  ##  6	8192	5434	2758	1038	164	0	0	2754	0	2561	4	0	2632	790
# _cnt_b=11  ##  7	8192	5596	2596	978	147	0	0	2591	2	2725	3	0	2632	874
# _cnt_b=00  ##  *************************** 1. row ***************************


# new version of mlt (20140512_113903)
#
# bpid	bpsz	bpsz_free	dbpg	dbpg_old	dbpg_mod	pend_decomp	pend_read	pend_flush_lru	pend_flush_list	pg_young	pg_no_young	pg_young_rate	pg_no_young_rate	npg_read	npg_crea	npg_writ	pg_rate_read	pg_rate_crea	pg_rate_writ	npg_get	hit_rate	young_mk_per_1k_gets	no_young_mk_per_1k_gets	npg_ra	npg_ra_evic	ra_rate	ra_evic_rate	lru_io_tot	lru_io_cur	uncomp_tot	uncomp_cur
#
# bpid, bpsz, bpsz_free, dbpg, dbpg_old, dbpg_mod, pend_decomp, pend_read, pend_flush_lru, pend_flush_list, pg_young, pg_no_young, pg_young_rate, pg_no_young_rate, npg_read, npg_crea, npg_writ, pg_rate_read, pg_rate_crea, pg_rate_writ, npg_get, hit_rate, young_mk_per_1k_gets, no_young_mk_per_1k_gets, npg_ra, npg_ra_evic, ra_rate, ra_evic_rate, lru_io_tot, lru_io_cur, uncomp_tot, uncomp_cur



#bpid, bpsz, bpsz_free, dbpg, dbpg_old, dbpg_mod,\
#pend_decomp, pend_read, pend_flush_lru, pend_flush_list,\
#pg_young, pg_no_young, pg_young_rate, pg_no_young_rate,\
#npg_read, npg_crea, npg_writ, pg_rate_read, pg_rate_crea, pg_rate_writ, npg_get,\
#hit_rate, young_mk_per_1k_gets, no_young_mk_per_1k_gets,\
#npg_ra, npg_ra_evic, ra_rate, ra_evic_rate,\
#lru_io_tot, lru_io_cur, uncomp_tot, uncomp_cur


delim_01 = re.compile(r"\*+ [0-9]+\. row \*+") # _cnt_b=00  ##  "*************************** 1. row ***************************"


class per_bufpool_metric(object): # per-buffer-pool metric

	def __init__(self, tstamp_a, tstamp_b,\
			bpid, bpsz, bpsz_free, dbpg, dbpg_old, dbpg_mod,\
			pend_decomp, pend_read, pend_flush_lru, pend_flush_list,\
			pg_young, pg_no_young, pg_young_rate, pg_no_young_rate,\
			npg_read, npg_crea, npg_writ, pg_rate_read, pg_rate_crea, pg_rate_writ, npg_get,\
			hit_rate, young_mk_per_1k_gets, no_young_mk_per_1k_gets,\
			npg_ra, npg_ra_evic, ra_rate, ra_evic_rate,\
			lru_io_tot, lru_io_cur, uncomp_tot, uncomp_cur\
			):
		self.tstamp_a = tstamp_a # 1
		self.tstamp_b = tstamp_b # 2
		self.bpid = bpid # 3
		self.bpsz = bpsz # 4
		self.bpsz_free = bpsz_free # 5
		self.dbpg = dbpg # 6
		self.dbpg_old = dbpg_old # 7
		self.dbpg_mod = dbpg_mod # 8
		self.pend_decomp = pend_decomp # 9
		self.pend_read = pend_read # 10
		self.pend_flush_lru = pend_flush_lru # 11
		self.pend_flush_list = pend_flush_list # 12
		self.pg_young = pg_young # 13
		self.pg_no_young = pg_no_young # 14
		self.pg_young_rate = pg_young_rate # 15
		self.pg_no_young_rate = pg_no_young_rate # 16
		self.npg_read = npg_read # 17
		self.npg_crea = npg_crea # 18
		self.npg_writ = npg_writ # 19
		self.pg_rate_read = pg_rate_read # 20
		self.pg_rate_crea = pg_rate_crea # 21
		self.pg_rate_writ = pg_rate_writ # 22
		self.npg_get = npg_get # 23
		self.hit_rate = hit_rate # 24
		self.young_mk_per_1k_gets = young_mk_per_1k_gets # 25
		self.no_young_mk_per_1k_gets = no_young_mk_per_1k_gets # 26
		self.npg_ra = npg_ra # 27
		self.npg_ra_evic = npg_ra_evic # 28
		self.ra_rate = ra_rate # 29
		self.ra_evic_rate = ra_evic_rate # 30
		self.lru_io_tot = lru_io_tot # 31
		self.lru_io_cur = lru_io_cur # 32
		self.uncomp_tot = uncomp_tot # 33
		self.uncomp_cur = uncomp_cur # 34

	def display(self):
		print \
			self.tstamp_a,\
			self.tstamp_b,\
			self.bpid,\
			self.bpsz,\
			self.bpsz_free,\
			self.dbpg,\
			self.dbpg_old,\
			self.dbpg_mod,\
			self.pend_decomp,\
			self.pend_read,\
			self.pend_flush_lru,\
			self.pend_flush_list,\
			self.pg_young,\
			self.pg_no_young,\
			self.pg_young_rate,\
			self.pg_no_young_rate,\
			self.npg_read,\
			self.npg_crea,\
			self.npg_writ,\
			self.pg_rate_read,\
			self.pg_rate_crea,\
			self.pg_rate_writ,\
			self.npg_get,\
			self.hit_rate,\
			self.young_mk_per_1k_gets,\
			self.no_young_mk_per_1k_gets,\
			self.npg_ra,\
			self.npg_ra_evic,\
			self.ra_rate,\
			self.ra_evic_rate,\
			self.lru_io_tot,\
			self.lru_io_cur,\
			self.uncomp_tot,\
			self.uncomp_cur

	def get(self):
		return \
			self.tstamp_a,\
			self.tstamp_b,\
			self.bpid,\
			self.bpsz,\
			self.bpsz_free,\
			self.dbpg,\
			self.dbpg_old,\
			self.dbpg_mod,\
			self.pend_decomp,\
			self.pend_read,\
			self.pend_flush_lru,\
			self.pend_flush_list,\
			self.pg_young,\
			self.pg_no_young,\
			self.pg_young_rate,\
			self.pg_no_young_rate,\
			self.npg_read,\
			self.npg_crea,\
			self.npg_writ,\
			self.pg_rate_read,\
			self.pg_rate_crea,\
			self.pg_rate_writ,\
			self.npg_get,\
			self.hit_rate,\
			self.young_mk_per_1k_gets,\
			self.no_young_mk_per_1k_gets,\
			self.npg_ra,\
			self.npg_ra_evic,\
			self.ra_rate,\
			self.ra_evic_rate,\
			self.lru_io_tot,\
			self.lru_io_cur,\
			self.uncomp_tot,\
			self.uncomp_cur

	def get_bpid(self):
		return self.bpid


#class per_bufpool_metric(object): # per-buffer-pool metric
#
#	def __init__(self, tstamp_a, tstamp_b, bpid, plsz, plsz_free,\
#			dbpg, dbpg_old, dbpg_mod, pg_young, pg_no_young,\
#			r_pages, c_pages, w_pages, r_pend,\
#			lru_io_tot, lru_io_cur, hit_rate):
#		self.tstamp_a = tstamp_a # 1
#		self.tstamp_b = tstamp_b # 2
#		self.bpid = bpid # 3
#		self.plsz = plsz # 4
#		self.plsz_free = plsz_free # 5
#		self.dbpg = dbpg # 6
#		self.dbpg_old = dbpg_old # 7
#		self.dbpg_mod = dbpg_mod # 8
#		self.pg_young = pg_young # 9
#		self.pg_no_young = pg_no_young # 10
#		self.r_pages = r_pages # 11
#		self.c_pages = c_pages # 12
#		self.w_pages = w_pages # 13
#		self.r_pend = r_pend # 14
#		self.lru_io_tot = lru_io_tot # 15
#		self.lru_io_cur = lru_io_cur # 16
#		self.hit_rate = hit_rate # 17
#
#	def display(self):
#		print \
#		self.tstamp_a,\
#		self.tstamp_b,\
#		self.bpid,\
#		self.plsz,\
#		self.plsz_free,\
#		self.dbpg,\
#		self.dbpg_old,\
#		self.dbpg_mod,\
#		self.pg_young,\
#		self.pg_no_young,\
#		self.r_pages,\
#		self.c_pages,\
#		self.w_pages,\
#		self.r_pend,\
#		self.lru_io_tot,\
#		self.lru_io_cur,\
#		self.hit_rate
#
#	def get(self):
#		return \
#		self.tstamp_a,\
#		self.tstamp_b,\
#		self.bpid,\
#		self.plsz,\
#		self.plsz_free,\
#		self.dbpg,\
#		self.dbpg_old,\
#		self.dbpg_mod,\
#		self.pg_young,\
#		self.pg_no_young,\
#		self.r_pages,\
#		self.c_pages,\
#		self.w_pages,\
#		self.r_pend,\
#		self.lru_io_tot,\
#		self.lru_io_cur,\
#		self.hit_rate
#
#	def get_bpid(self):
#		return self.bpid


## line stream processing
_cnt_a = 0; # line count
_cnt_b = 0; # line count in the actual content range
_cnt_c = 0; # per-buffer-pool ID
_cnt_c_max = 0; # record the max value of per-buffer-pool ID
_cnt_time = -1;
_td = {}; # trace data per buffer pool
for _line in sys.stdin:

	_line = _line.strip() # one whole line
	_li = _line.split() # each individual item
	_cnt_a = _cnt_a + 1

#	reor = delim_01.search(_line) # remr: regular expression operation result
	reor = delim_01.match(_line) # remr: regular expression operation result
	if reor == None: # delimiter NOT matched: i.e., actual data
#		print str(_cnt_a) + " " + "NOT MATCHED - actual data"
		_cnt_b = _cnt_b + 1
		if _cnt_b == 1:
			_cnt_time = _cnt_time + 1
			_li_tstamp_a = _li[1]
			_td[_cnt_time] = []

		elif _cnt_b == 2:
			_li_tstamp_b = _li[1]
		elif _cnt_b == 3: # header string, initialize trace data class instances for multiple buffer pools
			_cnt_c = 0
		else:
			_td[_cnt_time].insert(_cnt_c, per_bufpool_metric(_li_tstamp_a, _li_tstamp_b,\
						_li[0], _li[1], _li[2], _li[3], _li[4], _li[5], _li[6], _li[7], _li[8],\
						_li[9], _li[10], _li[11], _li[12], _li[13], _li[14], _li[15], _li[16],\
						_li[17], _li[18], _li[19], _li[20], _li[21], _li[22], _li[23], _li[24],\
						_li[25], _li[26], _li[27], _li[28], _li[29], _li[30], _li[31]\
						))
#			print str(_cnt_a) + " " + str(_cnt_c) + " " + str(_td[_cnt_time][_cnt_c].get()) # debug
			_cnt_c = _cnt_c + 1
			_cnt_c_max = max(_cnt_c_max, _cnt_c)
	else: # delimiter matched
#		print str(_cnt_a) + " " + str(reor.group()) # debug
		_cnt_b = 0




print "\n---------------------\n"
print "len(_td):" + str(len(_td))
#print "dir(_td):" + str(dir(_td))
print "items(_td):" + str(_td.items())
print "_cnt_c_max: " + str(_cnt_c_max)
print "\n---------------------\n"




_fo_name = ".tmp.num_of_bufpool.txt" # will be used by .bdx to save the trace data to the separate files for each buffer-pool
_fo = open(_fo_name, 'w')
_fo.write(str(_cnt_c_max))
_fo.close()




for _td_moment in _td.items():
	print "# " + str(_td_moment[0])
	for _per_bpfl_metric in _td_moment[1]: # per-buffer-pool trace data
#		_per_bpfl_metric.display()
		_display_stmt = str("bufpool_id_") + str(_per_bpfl_metric.get_bpid())
		for _field in _per_bpfl_metric.get():
			_display_stmt = _display_stmt + " " + str(_field)
		print _display_stmt




# bpid
# bpsz
# bpsz_free
# dbpg
# dbpg_old
# dbpg_mod
# pend_decomp
# pend_read
# pend_flush_lru
# pend_flush_list
# pg_young
# pg_no_young
# pg_young_rate
# pg_no_young_rate
# npg_read
# npg_crea
# npg_writ
# pg_rate_read
# pg_rate_crea
# pg_rate_writ
# npg_get
# hit_rate
# young_mk_per_1k_gets
# no_young_mk_per_1k_gets
# npg_ra
# npg_ra_evic
# ra_rate
# ra_evic_rate
# lru_io_tot
# lru_io_cur
# uncomp_tot
# uncomp_cur




