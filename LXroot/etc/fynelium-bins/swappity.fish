#!/usr/fish
# Helper function to calculate the percentage of memory used
function get_memory_used_percent
    set mem_total (awk '/^MemTotal:/ {print $2}' /proc/meminfo)
    set mem_free (awk '/^MemAvailable:/ {print $2}' /proc/meminfo)
    echo (math "(1 - ($mem_free / $mem_total)) * 100")
end

# Function to calculate a value between min and max based on memory usage
function scale_value
    set min $argv[1]
    set max $argv[2]
    set percent (get_memory_used_percent)
    set range (math "$max - $min")
    echo (math "round($min + ($percent * $range / 100))")
end

# Calculate individual sysctl values based on memory usage and user-defined ranges
function calculate_swappiness
    echo (scale_value 0 200)
end

function calculate_zram_compression
    echo (scale_value 0 21)
end

function calculate_vfs_cache_pressure
    echo (scale_value 0 2147483647)
end

# Function to adjust memory settings dynamically
function adjust_memory_settings
    sudo sysctl vm.swappiness=(calculate_swappiness)
    echo (calculate_zram_compression) | sudo tee /sys/block/zram0/comp_algorithm > /dev/null
    sudo sysctl vm.vfs_cache_pressure=(calculate_vfs_cache_pressure)
end

while true
    adjust_memory_settings
    set delay (math "1 + (59 * (get_memory_used_percent / 100))")
    sleep $delay
end