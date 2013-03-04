#!/usr/bin/env python
##bsc.iowa.lsp.preproc_bpout_s10.py
## : preprocessing to extract
##   - R/W flag
##   - GBL phase
##   - device ID
##   - time
##   - address
##   - IO size
##
##_ver=20130226_172858
##_ver=20130226_185715
##_ver=20130227_215119
##_ver=20130305_031555




import sys, os, getopt
from collections import defaultdict
from string import punctuation


_this_prog = os.path.basename(sys.argv[0])


##
## Processing input arguments
##
_arg_gbl_phase_filter = None # Generic Block Layer phase filter ['Q'|'D'] # -p|--gbl-phase-filter
def print_help_n_exit(_retval):
	print "Usage:", _this_prog, "[-h|--help] -p|--gbl-phase-filter=<_arg_gbl_phase_filter>"
	sys.exit(int(_retval))

try:
	opts, args = getopt.getopt(sys.argv[1:], "hp:", ["help", "gbl-phase-filter"])
except getopt.GetoptError:
	print_help_n_exit(1)

for opt, arg in opts:
	if opt in ("-h", "--help"):
		print_help_n_exit(0)
	elif opt in ("-p", "--gbl-phase-filter"):
		_arg_gbl_phase_filter = arg

if _arg_gbl_phase_filter is None:
	print "#>> ERROR: _arg_gbl_phase_filter is NOT set"
	print_help_n_exit(2)




##
## Processing_loop_10
##	- uio: Unit IO
## 
line_count_total = 0
line_count = 0
for line in sys.stdin:
	line_items = line.strip().split()
	if line_items.__len__() >= 7:
		uio_rwflag = line_items[6]
		if "R" in uio_rwflag or "W" in uio_rwflag:
			uio_gblphase = line_items[5]
			if _arg_gbl_phase_filter in uio_gblphase:
				if (line_items[7].isdigit() is True) and (line_items[9].isdigit() is True):
					uio_addr = int(line_items[7])
					uio_iosize = int(line_items[9])
					uio_devid = line_items[0]
				#	uio_timens = int(float(line_items[3]) * (10**9)) # in nanosecond
					uio_timens = float(line_items[3]) # in nanosecond
					print "_" + uio_rwflag + " " + "__" + uio_gblphase + " " + "___" + uio_devid + " " + str(uio_timens) + " " + str(uio_addr) + " " + str(uio_iosize)
					line_count += 1
	line_count_total += 1

#summary_line = "## line_count : " + str(line_count) + "\n"
#sys.stderr.write(summary_line)




