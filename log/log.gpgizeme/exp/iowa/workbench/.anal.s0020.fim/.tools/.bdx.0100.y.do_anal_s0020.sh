#!/bin/sh
#_ver=20130528_150103


#_datain=".datain.0000.log";
_datain=".datain";
cat $_datain | bsc.iowa.lsp.anal_s0020 > iowa_fim.R
echo "execute R with the following commands";
echo "> source('iowa_fim.R')";
echo "> f <- iowa_fim(ciop_d010, 0.01)";
echo "> dim(tidLists(f))";
echo "> inspect(f)";
echo "> image(tidLists(f))";
