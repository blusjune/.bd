#!/bin/sh

##bsc.find_files_with_words.sh
##ver: 20121122_233637
##ver: 20121127_005102
##ver: 20121129_015806
##ver: 20121207_001418
##_ver="20121207_194857";
_ver="20121207_194857";




if [ $# -eq 0 ]; then
	echo "ffww (find files with words) [ver:$_ver]";
	echo "#>> WARNING: argument (list of words to search) should be specified";
	echo "#>> INFO: directory to search can be specified with '_dir_root'";
	exit 0;
else
	_argc="$#";
	_argv="$*";
fi




_tstamp="$(tstamp)";
echo "------------------------------";
if [ "X$_dir_root" = "X" ]; then
	read -p "#?? directory to search: " _dir_root;
	if [ "X$_dir_root" = "X" ]; then
		_dir_root=".";
	fi
fi
_index_root=".idx.ffww";
_fname_tmp="$_index_root/.tmp";
_fname_head=".ffww_flist";
_fname_prefix="./$_index_root";
if [ ! -d $_index_root ]; then
	mkdir -p $_index_root;
fi
echo "#>> directory to search: '$_dir_root'";
echo "";




## processing loop
_count=1;
_word=$1;
shift;
echo "#>> [ $_count / $_argc ] processing word: '$_word' ...";
#_fname="./$_index_root/_flist_$_tstamp,$_word";
_fname_radix="${_fname_head}.$_tstamp,$_word";
_fname="$_fname_prefix/$_fname_radix";
echo -n "" > "$_fname";
grep -riaH "$_word" $_dir_root | sed -e 's/^\([^:]*\):.*/\1/g' | sort -u >> "$_fname";

while [ $_count -lt $_argc ]; do
	_count=$(expr $_count + 1);
	_word="$1";
	shift;
	echo "#>> [ $_count / $_argc ] processing word: '$_word' ...";
	_flist=$(cat "$_fname");
	rm "$_fname";
	_fname="${_fname},$_word";
	for _i in $_flist; do
	#	echo "	searching word '$_word' in file '$_i' ...";
	#	echo $_i | xargs grep -riH $_word $_fname | sed -e 's/^\([^:]*\):.*/\1/g' | sort -u >> $_fname; ## does it work properly?
		grep -riaH "$_word" $_i | sed -e 's/^\([^:]*\):.*/\1/g' | sort -u >> "$_fname";
	done
	cat "$_fname" | sort -u > $_fname_tmp;
	mv $_fname_tmp "$_fname";
done
if [ -f "$_fname_head" ]; then
	rm "$_fname_head";
fi
ln -s "$_fname" $_fname_head;
_number_of_matched_files=$(cat "$_fname" | wc -l);
echo "";
echo "#>> '$_fname' created ($_number_of_matched_files files are found)";
echo "------------------------------";
echo "";




