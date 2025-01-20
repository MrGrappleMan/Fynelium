#!/bin/fish
swapoff -a
rmmod zram
modprobe zram
set tmem (awk '/^MemTotal:/ {print $2}' /proc/meminfo)

echo zstd > /sys/block/zram0/comp_algorithm
echo $tmem > /sys/block/zram0/disksize
mkswap /dev/zram0
swapon -p 10 /dev/zram0
