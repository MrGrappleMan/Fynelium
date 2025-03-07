#!/usr/bin/fish

# Function to initialize zram
function setup_zram
    # Disable existing swap
    sudo swapoff -a 2>/dev/null
    # Remove and reload zram module
    sudo rmmod zram 2>/dev/null
    sudo modprobe zram num_devices=1

    # Set zram size to total RAM (from your code)
    set -g tmem (awk '/^MemTotal:/ {print $2}' /proc/meminfo)
    echo $tmem | sudo tee /sys/block/zram0/disksize

    # Set compression to zstd
    echo zstd | sudo tee /sys/block/zram0/comp_algorithm

    # Setup swap
    sudo mkswap /dev/zram0
    sudo swapon /dev/zram0
end

# Memory percentage calculation (from your code)
function mempercent
    set fmem (awk '/^MemAvailable:/ {print $2}' /proc/meminfo)
    echo (math "$fmem / $tmem * 100")
end

# Scale value function (from your code, improved)
function scale_value -a min max
    set percent (mempercent)
    set range (math "$max - $min")
    echo (math "round($min + ($percent * $range / 100))")
end

# Parameter calculation functions (rectified ranges)
function calc_swappiness
    echo (scale_value 0 200)  # Reasonable range for swappiness
end

function calc_vfs_cache_pressure
    echo (scale_value 50 150)  # More practical range than 0-2^31
end

function calc_nr_hugepages
    # Limit to reasonable maximum based on total memory
    set max_pages (math "floor($tmem / 2048)")  # Assuming 2MB pages
    echo (scale_value 0 $max_pages)
end

function calc_compaction_proactiveness
    echo (scale_value 0 100)  # Valid range for this parameter
end

function calc_extfrag_threshold
    echo (scale_value 500 1000)  # Default is typically 500-1000
end

function calc_zstd_level
    set percent (mempercent)
    # Reverse scale: less free memory = higher compression
    set comp_level (math "round(((100 - $percent) * 18) / 100) + 1")
    if test $comp_level -gt 19
        set comp_level 19
    else if test $comp_level -lt 1
        set comp_level 1
    end
    echo $comp_level
end

# Apply all parameters
function apply_parameters
    set swappiness (calc_swappiness)
    set vfs_cache (calc_vfs_cache_pressure)
    set hugepages (calc_nr_hugepages)
    set compact (calc_compaction_proactiveness)
    set extfrag (calc_extfrag_threshold)
    set zstd_level (calc_zstd_level)

    sudo sysctl -w vm.swappiness=$swappiness
    sudo sysctl -w vm.vfs_cache_pressure=$vfs_cache
    sudo sysctl -w vm.nr_hugepages=$hugepages
    sudo sysctl -w vm.compaction_proactiveness=$compact
    sudo sysctl -w vm.extfrag_threshold=$extfrag
    # Note: zstd level might require kernel patch
    sudo sysctl -w vm.zram_comp_level=$zstd_level 2>/dev/null

    # Logging
    echo "Applied: swappiness=$swappiness, vfs_cache=$vfs_cache, hugepages=$hugepages, compact=$compact, extfrag=$extfrag, zstd_level=$zstd_level"
end

# Main function for one-time execution
function main
    setup_zram
    apply_parameters
end

# Error handling
function error_handler
    if test $status -ne 0
        echo "Error: Check sudo privileges and zram support"
        exit 1
    end
end

main
set -e error_handler
