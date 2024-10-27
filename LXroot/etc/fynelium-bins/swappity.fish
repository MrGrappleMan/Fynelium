#!/bin/fish

swapoff -a
rmmod zram
get_battery_status() {
    if [[ -f /sys/class/power_supply/BAT0/capacity ]]; then
        battery_capacity=$(cat /sys/class/power_supply/BAT0/capacity)
    else
        battery_capacity=100
    fi
    if [[ -f /sys/class/power_supply/AC/online ]]; then
        power_status=$(cat /sys/class/power_supply/AC/online)
    else
        power_status=0
    fi
}
if [[ "$1" == "Y" ]]; then
    sudo modprobe zram
    mem_total=$(free | awk '/^Mem:/{print $2}')
    mem_total_bytes=$((mem_total * 1024))
    
    echo $mem_total_bytes | sudo tee /sys/block/zram0/disksize > /dev/null
    sudo mkswap /dev/zram0
    sudo swapon -p 32765 /dev/zram0
    set_compression_level() {
        local level=$1
        echo "zstd:$level" | sudo tee /sys/block/zram0/comp_algorithm > /dev/null
    }
    set_swappiness() {
        local swappiness=$1
        sudo sysctl -w vm.swappiness=$swappiness > /dev/null
    }
    set_dirty_values() {
        local dirty_ratio=$1
        local dirty_background_ratio=$2
        sudo sysctl -w vm.dirty_ratio=$dirty_ratio > /dev/null
        sudo sysctl -w vm.dirty_background_ratio=$dirty_background_ratio > /dev/null
    }
    set_min_free_kbytes() {
        local min_free_kbytes=$1
        sudo sysctl -w vm.min_free_kbytes=$min_free_kbytes > /dev/null
    }
    set_vfs_cache_pressure() {
        local pressure=$1
        sudo sysctl -w vm.vfs_cache_pressure=$pressure > /dev/null
    }
    set_net_buffer_sizes() {
        local rmem_max=$1
        local wmem_max=$2
        sudo sysctl -w net.core.rmem_max=$rmem_max > /dev/null
        sudo sysctl -w net.core.wmem_max=$wmem_max > /dev/null
    }
    set_net_params() {
        local max_syn_backlog=$1
        local tcp_fin_timeout=$2
        sudo sysctl -w net.ipv4.tcp_max_syn_backlog=$max_syn_backlog > /dev/null
        sudo sysctl -w net.ipv4.tcp_fin_timeout=$tcp_fin_timeout > /dev/null
    }
    monitor_memory() {
        local part_size=$((mem_total / 22))
        while true; do
            get_battery_status
            mem_free=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)
            level=$((22 - mem_free / part_size))
            set_compression_level $((level < 1 ? 1 : level > 22 ? 22 : level))
            # Adjust swappiness
            if [[ "$power_status" -eq 1 && "$battery_capacity" -eq 100 ]]; then
                swappiness=$((200 - (mem_free * 200 / mem_total)))
                set_min_free_kbytes 65536  # Minimum free memory when on AC
                set_vfs_cache_pressure 50   # Less pressure for caching when on AC
                set_net_buffer_sizes 16777216  # Max TCP buffer sizes for performance
                set_net_params 256  # Max SYN backlog for performance
            else
                swappiness=$((100 - (battery_capacity * 100 / 100)))
                set_min_free_kbytes 32768  # Lower minimum free memory for battery
                set_vfs_cache_pressure 100   # More pressure for caching to save memory
                set_net_buffer_sizes 8388608  # Reduced TCP buffer sizes for battery saving
                set_net_params 128  # Lower max SYN backlog for battery
            fi
            set_swappiness $((swappiness < 0 ? 0 : swappiness > 200 ? 200 : swappiness))
            # Adjust dirty values
            if [[ "$power_status" -eq 1 && "$battery_capacity" -eq 100 ]]; then
                dirty_ratio=30
                dirty_background_ratio=15
            else
                dirty_ratio=$((15 + (battery_capacity * 15 / 100)))
                dirty_background_ratio=$((7 + (battery_capacity * 7 / 100)))
            fi
            set_dirty_values $((dirty_ratio < 5 ? 5 : dirty_ratio > 30 ? 30 : dirty_ratio)) \
                             $((dirty_background_ratio < 1 ? 1 : dirty_background_ratio > 15 ? 15 : dirty_background_ratio))
            sleep 60
        done
    }
    monitor_memory &
fi