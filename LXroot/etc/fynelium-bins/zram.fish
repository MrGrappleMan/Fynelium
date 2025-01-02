#!/bin/fish
swapoff -a
rmmod zram
modprobe zram
set tmem (awk '/^MemTotal:/ {print $2}' /proc/meminfo)
set swap_size (math $tmem \* 2)

echo $tmem | sudo tee /sys/block/zram0/disksize
mkswap /dev/zram0
swapon -p 5/dev/zram0

sudo fallocate -l (math $swap_size \* 1024) /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon -p 10 /swapfile

# What about zram on tmp?