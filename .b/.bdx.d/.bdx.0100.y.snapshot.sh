#!/bin/sh
##.bdx.0100.y.snapshot.sh
##_ver=20120528_173510
##_ver=20130218_003842
##	${HOME}/.bd/sys/_/snapshot directory should exist




_tstamp="$(date '+%Y%m%d_%H%M%S')";
_me="$(whoami)";
_snapshot_src=".snapshot.src";
_snapshot_dst_root="${HOME}/.bd/sys/_/snapshot";
_snapshot_dst="${_snapshot_dst_root}/${_tstamp}-$(uname -n)";
_bhome_link=".bhome";




_eth_if="$(ifconfig -s | grep eth | sort -u | awk '{ print $1 }' | head -1)";
_place_hw="$(ifconfig $_eth_if | grep HWaddr | awk '{ print $5 }' | sed -e 's/://g')";
_inet_addr=$( ifconfig $_eth_if | grep 'inet addr' | awk '{ print $2 }' | sed -e 's/.*:\(.*\)/\1/' );
_prefix="[${_place_hw}_${_inet_addr}_$(hostname)]";




## simple sanity check
if [ ! -d $_snapshot_src ]; then
	echo ">>> cannot access snapshot src ($_snapshot_src) directory";
	exit 1;
fi

if [ ! -d $_snapshot_dst_root ]; then
	echo ">>> cannot access snapshot dst ($_snapshot_dst_root) directory";
	exit 1;
else
	mkdir -p $_snapshot_dst;
fi




## timestamp
if [ "X${_bpk_timestamp}" = "X" ]; then
#	_timestamp="$(date '+%Y%m%d_%H%M%S')";
	_timestamp="$_tstamp";
else
	_timestamp=$_bpk_timestamp;
fi




##
## take a snapshot for each target
##

(
cd ${_snapshot_src}; 
if [ -L $_bhome_link ]; then
	echo ">>> update $_bhome_link to '${HOME}'";
	rm $_bhome_link;
fi
ln -s ${HOME} $_bhome_link;
)


_gpg="gpg";
read -p ">>> bpp(snapshot): " _bpp_snapshot;


echo ">>> take a snapshot of '/home/${_me}' directory";
_target="home.${_me}";
_fo_tgz="${_prefix}${_target}.${_timestamp}.tgz";
_fo_tgz_asc="${_fo_tgz}.asc";
(cd ${_snapshot_src}; tar cfh - ${_target}) | (cd ${_snapshot_dst}; gzip -c > ${_fo_tgz})
(cd ${_snapshot_dst}; echo "${_bpp_snapshot}" | $_gpg -ca --cipher-algo twofish --openpgp --comment "bpk snapshot ( $_timestamp // $_target // $(uname -srmn) )" --passphrase-fd 0 -o ${_fo_tgz_asc} ${_fo_tgz}; gzip $_fo_tgz_asc; rm $_fo_tgz;)


echo ">>> take a snapshot of '/etc' directory";
_target="etc";
_fo_tgz="${_prefix}${_target}.${_timestamp}.tgz";
_fo_tgz_asc="${_fo_tgz}.asc";
(cd ${_snapshot_src}; tar cfh - ${_target}) | (cd ${_snapshot_dst}; gzip -c > ${_fo_tgz})
(cd ${_snapshot_dst}; echo "${_bpp_snapshot}" | $_gpg -ca --cipher-algo twofish --openpgp --comment "bpk snapshot ( $_timestamp // $_target // $(uname -srmn) )" --passphrase-fd 0 -o ${_fo_tgz_asc} ${_fo_tgz}; gzip $_fo_tgz_asc; rm $_fo_tgz;)


echo ">>> take a snapshot of misc system information";
_target="misc";
(cd ${_snapshot_src}/${_target}; _BDX;)
_fo_tgz="${_prefix}${_target}.${_timestamp}.tgz";
_fo_tgz_asc="${_fo_tgz}.asc";
(cd ${_snapshot_src}; tar cfh - ${_target}) | (cd ${_snapshot_dst}; gzip -c > ${_fo_tgz})
(cd ${_snapshot_dst}; echo "${_bpp_snapshot}" | $_gpg -ca --cipher-algo twofish --openpgp --comment "bpk snapshot ( $_timestamp // $_target // $(uname -srmn) )" --passphrase-fd 0 -o ${_fo_tgz_asc} ${_fo_tgz}; gzip $_fo_tgz_asc; rm $_fo_tgz;)
(cd ${_snapshot_src}/${_target}; rm *.log;)




