#!/bin/sh
#.bdx.0100.y.mkzip_n_xfer.sh
#_ver="20130629_192220";




_zip_src_radix="wintrace";
_target_dir="/media/sf__vshare/sw";




_tmpdir=".files";
_zip_src="$(ls -1d ${_zip_src_radix}-* | tail -1)";
_zip_file="${_zip_src}.zip";

read -p "#<< Do you want to copy $_zip_file to $_target_dir directory? [y|n] " _answer
if [ "X$_answer" = "Xy" ]; then
	echo "#>> Copying $_zip_file to $_target_dir ...";
	if [ ! -d $_tmpdir ]; then
		mkdir -p $_tmpdir;
	fi
	sudo zip -r ${_tmpdir}/${_zip_file} $_zip_src;
	sudo cp ${_tmpdir}/${_zip_file} $_target_dir;
else
	echo "#>> Nothing happened";
fi




