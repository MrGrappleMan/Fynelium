#!/usr/fish

function calculate_delay
    set mem_total (awk '/^MemTotal:/ {print $2}' /proc/meminfo)
    set mem_free (awk '/^MemAvailable:/ {print $2}' /proc/meminfo)
    set used_percent (math "(1 - ($mem_free / $mem_total)) * 100")
    echo (math "round(1 + (59 * ($used_percent / 100)))")
end

function calculate_swappiness
    set mem_total (awk '/^MemTotal:/ {print $2}' /proc/meminfo)
    set mem_free (awk '/^MemAvailable:/ {print $2}' /proc/meminfo)
    set free_percent (math "$mem_free / $mem_total * 100")
    echo (math "min(100, max(1, 100 - $free_percent))")
end

function calculate_zram_compression
    set mem_total (awk '/^MemTotal:/ {print $2}' /proc/meminfo)
    set mem_free (awk '/^MemAvailable:/ {print $2}' /proc/meminfo)
    set free_ratio (math "$mem_free / $mem_total")
    echo (math "round(15 - (10 * $free_ratio))")
end

function calculate_dirty_ratio
    set mem_total (awk '/^MemTotal:/ {print $2}' /proc/meminfo)
    set mem_free (awk '/^MemAvailable:/ {print $2}' /proc/meminfo)
    set free_percent (math "$mem_free / $mem_total * 100")
    echo (math "min(30, max(5, 30 - $free_percent / 3))")
end

function calculate_dirty_background_ratio
    set dirty_ratio (calculate_dirty_ratio)
    echo (math "$dirty_ratio * 0.7")
end

function calculate_vfs_cache_pressure
    set mem_total (awk '/^MemTotal:/ {print $2}' /proc/meminfo)
    set mem_free (awk '/^MemAvailable:/ {print $2}' /proc/meminfo)
    set free_ratio (math "$mem_free / $mem_total")
    echo (math "round(50 + (50 * (1 - $free_ratio)))")
end

function adjust_memory_settings
    sudo sysctl vm.swappiness=(calculate_swappiness)
    echo (calculate_zram_compression) | sudo tee /sys/block/zram0/comp_algorithm > /dev/null
    sudo sysctl vm.dirty_ratio=(calculate_dirty_ratio)
    sudo sysctl vm.dirty_background_ratio=(calculate_dirty_background_ratio)
    sudo sysctl vm.vfs_cache_pressure=(calculate_vfs_cache_pressure)
end

while true
    adjust_memory_settings
    set delay (calculate_delay)
    sleep $delay
end