#!/bin/sh

. .bhdr; echo "$_BHDR $(basename $0)";
./.anal_addr.sh .blktrace.log
