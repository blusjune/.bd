blktrace /dev/sda /dev/sdb /dev/sdc /dev/sdd /dev/sde
#cat sd* | blkparse -i - > bplog
#grep rsession bplog  | awk '{ print "_" $6,  "__" $7, $8, $0}' | grep '_Q' | grep '__R' 
