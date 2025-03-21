#!/usr/bin/fish
sudo swapoff -a
sudo rmmod zram
sudo modprobe zram num_devices=1
set -g tmem (awk '/^MemTotal:/ {print $2}' /proc/meminfo)
echo $tmem | sudo tee /sys/block/zram0/disksize
echo zstd | sudo tee /sys/block/zram0/comp_algorithm
sudo mkswap /dev/zram0
sudo swapon /dev/zram0