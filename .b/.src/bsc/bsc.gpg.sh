#!/bin/sh
### bsc.gpg.sh 

_bgpg="gpg";

$_bgpg -ca --cipher-algo twofish --openpgp --comment "Brian M. JUNG <brian.m.jung@gmail.com> $(date)"
