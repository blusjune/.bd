#!/bin/sh

_hadoop_root="/usr/local/hadoop";

echo "cp -pr conf.*_node_cluster $_hadoop_root";
cp -pr conf.*_node_cluster $_hadoop_root;
echo "make a symbolic link to the one of these dirs";
