#!/usr/bin/fish
sudo swapoff /dev/zram0
sudo rmmod zram
sudo modprobe zram num_devices=1
set -g m (awk '/^MemTotal:/ {print $2}' /proc/meminfo)
echo $m | sudo tee /sys/block/zram0/disksize
echo zstd | sudo tee /sys/block/zram0/comp_algorithm
sudo chmod 600 /dev/zram0
sudo mkswap /dev/zram0
sudo swapon /dev/zram0 -p 10
