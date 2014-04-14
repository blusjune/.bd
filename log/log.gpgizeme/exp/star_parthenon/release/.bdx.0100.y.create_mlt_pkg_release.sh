(cd ..; cp -pr mlt.d release/mlt.d-$(date +%Y%m%d_%H%M%S));
_mlt_latest_dir=$(ls -1 | grep 'mlt.d-' | tail -1);
(cd $_mlt_latest_dir; rm -fr .src; cd result; rm -fr *);
tar cf - $_mlt_latest_dir | gzip -c > ${_mlt_latest_dir}.tgz;

#_link_latest_dir="dir_latest";
#ln -s $_mlt_latest_dir $_link_latest_dir;

#_link_latest_tgz="pkg_latest.tgz";
#rm -f $_link_latest_tgz;
#ln -s ${_mlt_latest_dir}.tgz $_link_latest_tgz;
