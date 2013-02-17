_algo="cfq";
_devlist="sdb sdc sdd";

echo "
# before change";
for _i in $_devlist; do
        echo -n "$_i : ";
        cat /sys/block/$_i/queue/scheduler;
done

echo "
# after change";
for _i in $_devlist; do
        echo $_algo > /sys/block/$_i/queue/scheduler;
        echo -n "$_i : ";
        cat /sys/block/$_i/queue/scheduler;
done
