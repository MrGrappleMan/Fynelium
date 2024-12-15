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

while true
    apply_args
    sleep 60
end
