#!/usr/bin/fish

# skip if sleeping - no wakeups
if test -f /sys/power/state
    set state (cat /sys/power/state)
    if string match -q "*freeze*" $state; or string match -q "*mem*" $state; or string match -q "*disk*" $state
        exit 0  # suspend/hibernation = no tweak
    end
end

# global mem total
set -g tmem (awk '/^MemTotal:/ {print $2}' /proc/meminfo)

# % free mem
function mempercent
    set fmem (awk '/^MemAvailable:/ {print $2}' /proc/meminfo)
    echo (math "$fmem / $tmem * 100")
end

# scale stuff - min to max
function scale_value -a min max
    set percent (mempercent)
    set range (math "$max - $min")
    echo (math "round($min + ($percent * $range / 100))")
end

# cpu % - 1s avg
function cpupercent
    set cpu (awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1)*100/(t-t1);}' <(cat /proc/stat | grep '^cpu ') <(sleep 1; cat /proc/stat | grep '^cpu '))
    echo (math "round($cpu)")
end

# swappiness - more mem used = more swap
function calc_swappiness
    echo (scale_value 0 200)
end

# vfs cache - more mem used = free more
function calc_vfs_cache_pressure
    echo (scale_value 50 150)
end

# hugepages - more free = more huge
function calc_nr_hugepages
    set max_pages (math "floor($tmem / 2048)")  # 2MB pages
    echo (scale_value 0 $max_pages)
end

# compaction - more mem used = more work
function calc_compaction_proactiveness
    echo (scale_value 0 100)
end

# frag thresh - more mem used = higher
function calc_extfrag_threshold
    echo (scale_value 500 1000)
end

# zstd level - less free = more compress
function calc_zstd_level
    set percent (mempercent)
    set comp_level (math "round(((100 - $percent) * 18) / 100) + 1")
    if test $comp_level -gt 19; set comp_level 19; end
    if test $comp_level -lt 1; set comp_level 1; end
    echo $comp_level
end

# sync time - high cpu/mem = fast sync
function calc_sync_interval
    set cpu (cpupercent)
    set mem_percent (mempercent)
#!/usr/bin/fish

# skip if sleeping - no wakeups
if test -f /sys/power/state
    set state (cat /sys/power/state)
    if string match -q "*freeze*" $state; or string match -q "*mem*" $state; or string match -q "*disk*" $state
        exit 0  # suspend/hibernation = no tweak
    end
end

# global mem total
set -g tmem (awk '/^MemTotal:/ {print $2}' /proc/meminfo)

# % free mem
function mempercent
    set fmem (awk '/^MemAvailable:/ {print $2}' /proc/meminfo)
    echo (math "$fmem / $tmem * 100")
end

# scale stuff - min to max
function scale_value -a min max
    set percent (mempercent)
    set range (math "$max - $min")
    echo (math "round($min + ($percent * $range / 100))")
end

# cpu % - 1s avg
function cpupercent
    set cpu (awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1)*100/(t-t1);}' <(cat /proc/stat | grep '^cpu ') <(sleep 1; cat /proc/stat | grep '^cpu '))
    echo (math "round($cpu)")
end

# swappiness - more mem used = more swap
function calc_swappiness
    echo (scale_value 0 200)
end

# vfs cache - more mem used = free more
function calc_vfs_cache_pressure
    echo (scale_value 50 150)
end

# hugepages - more free = more huge
function calc_nr_hugepages
    set max_pages (math "floor($tmem / 2048)")  # 2MB pages
    echo (scale_value 0 $max_pages)
end

# compaction - more mem used = more work
function calc_compaction_proactiveness
    echo (scale_value 0 100)  # from sysctl, dynamic now
end

# frag thresh - more mem used = higher
function calc_extfrag_threshold
    echo (scale_value 500 1000)  # from sysctl, dynamic
end

# zstd level - less free = more compress
function calc_zstd_level
    set percent (mempercent)
    set comp_level (math "round(((100 - $percent) * 18) / 100) + 1")
    if test $comp_level -gt 19; set comp_level 19; end
    if test $comp_level -lt 1; set comp_level 1; end
    echo $comp_level
end

# zswap pool - more mem used = bigger pool
function calc_zswap_max_pool
    echo (scale_value 20 75)  # 20-75% range, sane limits
end

# sync time - high cpu/mem = fast sync
function calc_sync_interval
    set cpu (cpupercent)
    set mem_percent (mempercent)
    set inv_mem (math "100 - $mem_percent")
    if test $cpu -ge 90
        echo 10  # 90%+ cpu = fast sync
    else if test $cpu -le 10
        echo 120  # 10%- cpu = slow sync
    else
        set cpu_range (math "120 - 10")
        set cpu_scaled (math "round(10 + (($cpu - 10) * $cpu_range / 80))")
        set mem_weight (math "round($inv_mem / 100 * $cpu_scaled)")
        echo (math "$cpu_scaled + $mem_weight")
    end
end

# tweak it all
function tweak_parameters
    set swappiness (calc_swappiness)
    set vfs_cache (calc_vfs_cache_pressure)
    set hugepages (calc_nr_hugepages)
    set compact (calc_compaction_proactiveness)
    set extfrag (calc_extfrag_threshold)
    set zstd_level (calc_zstd_level)
    set zswap_pool (calc_zswap_max_pool)
    set sync_interval (calc_sync_interval)

    # apply tweaks - no user touchy
    sudo sysctl -w vm.swappiness=$swappiness
    sudo sysctl -w vm.vfs_cache_pressure=$vfs_cache
    sudo sysctl -w vm.nr_hugepages=$hugepages
    sudo sysctl -w vm.compaction_proactiveness=$compact
    sudo sysctl -w vm.extfrag_threshold=$extfrag
    sudo sysctl -w vm.zram_comp_level=$zstd_level 2>/dev/null  # patch maybe
    sudo sysctl -w zswap.max_pool_percent=$zswap_pool

    # sync at 90%+ mem - save from OOM
    set mem_used (math "100 - $(mempercent)")
    if test $mem_used -ge 90
        sudo sync
        sudo sysctl -w vm.drop_caches=3  # from sysctl, clear caches at high mem
    end

    # bg sync - no overlap
    if not pgrep -f "sync_timer" > /dev/null
        fish -c "sleep $sync_interval; sudo sync" & disown
        echo "sync in $sync_interval secs"
    end

    # log for debug
    echo "swappy=$swappiness vfs=$vfs_cache huge=$hugepages comp=$compact ext=$extfrag zstd=$zstd_level zswap_pool=$zswap_pool sync=$sync_interval"
end

# do it
tweak_parameters

# yell if borked
if test $status -ne 0
    echo "tweak ded, check perms or zram"
    exit 1
endrag
    sudo sysctl -w vm.zram_comp_level=$zstd_level 2>/dev/null  # patch maybe

    # sync at 90%+ mem - save from OOM
    set mem_used (math "100 - $(mempercent)")
    if test $mem_used -ge 90
        sudo sync
    end

    # bg sync - no overlap
    if not pgrep -f "sync_timer" > /dev/null
        fish -c "sleep $sync_interval; sudo sync" & disown
        echo "sync in $sync_interval secs"
    end

    # log for debug
    echo "swappy=$swappiness vfs=$vfs_cache huge=$hugepages comp=$compact ext=$extfrag zstd=$zstd_level sync=$sync_interval"
end

# do it
tweak_parameters

# yell if borked
if test $status -ne 0
    echo "tweak ded, check perms or zram"
    exit 1
end
