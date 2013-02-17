#!/bin/sh




_gfp_files=$(ls -1 .bdx.*.n.gfp_*.sh);
for _i in $_gfp_files; do
	. $_i;
done
