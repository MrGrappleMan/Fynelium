#!/bin/fish
swapoff -a
rmmod zram
modprobe zram
set tmem (awk '/^MemTotal:/ {print $2}' /proc/meminfo)
echo $tmem | sudo tee /sys/block/zram0/disksize
mkswap /dev/zram0
swapon -p 5/dev/zram0

echo $tmem | sudo tee /sys/block/zram0/disksize
mkswap /dev/zram0
swapon -p 5/dev/zram0