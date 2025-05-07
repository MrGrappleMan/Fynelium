#!/bin/env fish
#Checks
 if test (id -u) -ne 0
  echo "Not root user"
  exit 1
 end
swapoff -a
rmmod zram
modprobe -q zram num_devices=1
set -g m (awk '/^MemTotal:/ {print $2}' /proc/meminfo)
echo $m | tee /sys/block/zram0/disksize
echo lz4 | tee /sys/block/zram0/comp_algorithm
chmod 600 /dev/zram0
mkswap /dev/zram0
swapon /dev/zram0 -p 32767
