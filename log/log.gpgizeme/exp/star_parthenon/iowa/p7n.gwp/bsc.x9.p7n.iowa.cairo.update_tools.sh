#!/bin/sh
#_ver=20140520_212648




_iowa_tools=".tools";

#_files_to_del=$(ls -1 .bdx.* .rcmd.* .rlib.*);
_files_to_del=$(ls -1 .bdx.* .bpy.* .rlib.*);
rm -f $_files_to_del;
echo "#>> $(echo $_files_to_del | wc -w) files are removed";

#_files_to_link=$(cd ../$_iowa_tools; ls -1 .bdx.* .rcmd.* .rlib.*);
_files_to_link=$(cd ../$_iowa_tools; ls -1 .bdx.* .bpy.* .rlib.*);
for _i in $_files_to_link; do
	ln -s ../$_iowa_tools/$_i;
done
echo "#>> $(echo $_files_to_link | wc -w) files are newly linked here";




