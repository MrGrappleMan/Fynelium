#!/usr/fish
swapoff -a
rmmod zram
modprobe zram

function get_memory_used_percent
    set mem_total (awk '/^MemTotal:/ {print $2}' /proc/meminfo)
    set mem_free (awk '/^MemAvailable:/ {print $2}' /proc/meminfo)
    echo (math "(1 - ($mem_free / $mem_total)) * 100")
end

function scale_value
    set min $argv[1]
    set max $argv[2]
    set percent (get_memory_used_percent)
    set range (math "$max - $min")
    echo (math "round($min + ($percent * $range / 100))")
end

function calculate_swappiness
    echo (scale_value 0 200)
end

function calculate_zram_compression
    echo (scale_value 0 22)
end

function calculate_vfs_cache_pressure
    echo (scale_value 0 2147483647)
end

function calculate_huge_pages
    echo (scale_value 128 102400)
end

function adjust_memory_settings
    sysctl vm.swappiness=(calculate_swappiness)
    echo zstd | sudo tee /sys/block/zram0/comp_algorithm > /dev/null
    sysctl vm.vfs_cache_pressure=(calculate_vfs_cache_pressure)
sysctl vm.nr_hugepages=(calculate_huge_pages)
end

while true
    adjust_memory_settings
    set delay (math "1 + (59 * (get_memory_used_percent / 100))")
    sleep $delay
end