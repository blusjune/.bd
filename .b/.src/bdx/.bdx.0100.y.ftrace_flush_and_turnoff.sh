#!/bin/sh

echo 1 > tracing/buffer_size_kb;
cat tracing/trace;
echo 0 > tracing/tracing_on;

echo "#>> ftrace turned-off";

