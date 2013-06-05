#!/bin/sh
#_ver=20130528_150103
#_ver=20130605_231519




_ciop_data_src="ciop_data";
_ciop_fim_supp="0.1";
_ciop_fim_conf="0.5";
_ciop_fim_maxlen="10";
_ciop_fim_minlen="1";

#_datain=".datain.0000.log";
_datain=".datain";
cat $_datain | bsc.iowa.lsp.anal_s0020 -d $_ciop_data_src -s $_ciop_fim_supp -c $_ciop_fim_conf -m $_ciop_fim_maxlen -n $_ciop_fim_minlen > iowa_fim.R
echo "execute R with the following commands";
echo "> source('iowa_fim.R')";
echo "> f <- iowa_fim(ciop_d010, 0.1)";
echo "> dim(tidLists(f))";
echo "> summary(f)";
echo "> image(tidLists(f))";
