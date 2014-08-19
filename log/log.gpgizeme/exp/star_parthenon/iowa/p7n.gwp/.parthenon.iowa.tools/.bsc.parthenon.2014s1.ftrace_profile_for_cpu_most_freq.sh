#_ver=20140625_213138

_ktrace="mlt.L2_sys_krnl.tlog";
_ktrace_cpu_most_freq="${_ktrace}.cpu_most_freq";
_cpuid_file=".cpuid.txt";
_ftrace_profiler=".bpy.parthenon.2014s1.ftrace_profiler.py";
_d_table="d.tab";

cat $_ktrace | awk '{ print $1 }' | grep -v -- '----' | grep -v '=>' | sort | uniq -c | sort -n > $_cpuid_file;
_cpu_most_freq=$(cat $_cpuid_file | tail -1 | awk '{ print $2 }');
cat $_ktrace | awk "{ if ( \$1 == \"$_cpu_most_freq\" ) { print \$0 } }" > ${_ktrace_cpu_most_freq};

cat ${_ktrace_cpu_most_freq} | ${_ftrace_profiler} > $_d_table
