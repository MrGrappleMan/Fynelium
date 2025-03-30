#!/usr/bin/fish
sudo swapoff -a
sudo rmmod zram
sudo modprobe zram num_devices=1
set -g m (awk '/^MemTotal:/ {print $2}' /proc/meminfo)
echo $m | sudo tee /sys/block/zram0/disksize
sudo dd if=/dev/zero of=/swapfile bs=1MB count=$m
echo zstd | sudo tee /sys/block/zram0/comp_algorithm
sudo chmod 600 /dev/zram0
sudo chmod 600 /swapfile
sudo mkswap /dev/zram0
sudo mkswap /swapfile
sudo swapon /dev/zram0 -p 10
sudo swapon /swapfile -p 5
