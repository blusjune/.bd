#!/bin/sh
#afterproc.sh
#_ver="20130629_194345";

_target_dir="swpkg";
(cd $_target_dir; if [ $(ls -1d .bdx.*.y.*.sh | wc -l) -ge 1 ]; then _BDX; fi)
