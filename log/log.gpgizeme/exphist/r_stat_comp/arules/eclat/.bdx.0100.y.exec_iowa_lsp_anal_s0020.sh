#!/bin/sh
#.bdx.0100.y.exec_iowa_lsp_anal_s0020.sh
#_ver=20130527_143010


echo "execute: bsc.iowa.lsp.anal_s0020";
echo "input: rawdat.gz";
gunzip -c rawdat.gz | bsc.iowa.lsp.anal_s0020 > iowa_arm.R;
echo "output: iowa_arm.R";
