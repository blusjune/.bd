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





