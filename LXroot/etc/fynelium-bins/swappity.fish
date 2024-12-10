#!/usr/fish
swapoff -a
rmmod zram
modprobe zram
set tmem (awk '/^MemTotal:/ {print $2}' /proc/meminfo)
echo $tmem | sudo tee /sys/block/zram0/disksize
sudo mkswap /dev/zram0
sudo swapon /dev/zram0

function mempercent
    set fmem (awk '/^MemAvailable:/ {print $2}' /proc/meminfo)
    echo (math "$fmem / $tmem * 100")
end

function scale_value
    set min $argv[1]
    set max $argv[2]
    set percent (mempercent)
    set range (math "$max - $min")
    echo (math "round($min + ($percent * $range / 100))")
end

function calc_swappiness
    echo (scale_value 0 200)
end

function calc_vfs_cache_pressure
    echo (scale_value 0 2147483647)
end

function calc_huge_pages
    echo (scale_value 128 9999999999999999999)
end

function apply_args
    sysctl vm.swappiness=(calculate_swappiness)
    sysctl vm.vfs_cache_pressure=(calculate_vfs_cache_pressure)
    sysctl vm.nr_hugepages=(calculate_huge_pages)
end

while true
    apply_args
    sleep 60
end
