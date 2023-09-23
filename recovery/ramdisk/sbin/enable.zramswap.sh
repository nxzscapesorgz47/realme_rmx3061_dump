#!/sbin/sh
MemTotalStr=`cat /proc/meminfo | grep MemTotal`
MemTotal=${MemTotalStr:16:8}
if [ -f /sys/block/zram0/disksize ]; then
    #config 2GB+512MB zram size with memory 4 GB
    echo lz4 > /sys/block/zram0/comp_algorithm
    echo 1342177280 > /sys/block/zram0/disksize
    echo 160 > /proc/sys/vm/swappiness
    echo 60 > /proc/sys/vm/direct_swappiness
    mkswap /dev/block/zram0
    swapon /dev/block/zram0 -p 32758
fi
