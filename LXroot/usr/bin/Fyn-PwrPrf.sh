#!/bin/bash
swapoff -a
rmmod zram
sudo mkswap /dev/zram0
sudo swapon -p 32765 /dev/zram0

set_compression_level() {

local level=$1

echo "zstd:$level" > /sys/block/zram0/comp_algorithm

set_swappiness() {

local swappiness=$1

sysctl -w vm.swappiness=$swappiness

}

monitor_memory() {

local part_size=$(($mem_total / 22))

while true; do

mem_free=$(awk'/MemAvailable/ {print $2}' /proc/meminfo)

level=$((22 mem_free / part_size)) -

set_compression_level $((level < 1 ?1 level > 22 ? 22 :

swappiness=$((200 (mem_free * 200 / mem_total)))

set_swappiness $((swappiness < 0?0: swappiness > 200 ?

sleep 60

done
    }

    monitor_memory &
fi
