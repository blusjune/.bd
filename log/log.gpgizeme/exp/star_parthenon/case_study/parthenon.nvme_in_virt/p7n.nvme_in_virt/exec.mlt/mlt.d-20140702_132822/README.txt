## README - MLT (Multi-layer Tracing) tracing program launcher
## (C) 2014 Brian Myungjune JUNG <brian.m.jung@gmail.com>
## _ver=20140403_170323

Per-node Multi-layer Tracing Agent.


== How to use ==

# Edit the configuration files ./conf/test.cnf and ./conf/mlt.cnf
# Execute 'mlt.run_trace' program to launch the L1, L2, L3 tracers




== Release Note ==

=== 20140403_170323 ===

* First release

* Implements tracing task controller
:- tracer configuration regarding tracing duration time, tracing measurement interval
:- automatic trace log directory management (per test session)

* Implements L1 tracer
:- S.M.A.R.T information only. Other information should 
:- Should include in-SSD logging feature to be implemented later by SW development team

* Implements L2 tracer
:- modification of iostat, vmstat, blktrace to implement inter-tracer time sync feature
:- time-series logging of IO performance related system metrics

* L3 tracer - Not Yet Implemented
:- DB instrumentation is in progress




=== 20140404_163356 ===

* Added system information collector
:- CPU model, memory size, number and model of disks, file system, PCIe peripheral topology, and OS information




=== 20140617_212332 ===

* Type-1 MLT: includes L3(DB) tracer, L2(vm,io,blk) tracer, L1(S.M.A.R.T) tracer
* Type-2 MLT: includes L2(vm,io,blk) tracer, L1(S.M.A.R.T) tracer; excludes L3(DB) tracer from Type-1 MLT
* Type-3 MLT: includes L2(vm,io) tracer, L1(S.M.A.R.T) tracer; excludes L3(DB) tracer and L2(blk) tracer from Type-1 MLT
* Type-3.1 MLT: includes L2(vm,io,K) tracer, L1(S.M.A.R.T) tracer; excludes L3(DB) tracer and L2(blk) tracer from Type-1 MLT

