#!/usr/bin/fish

# one-time zram setup at boot
function setup_zram
    # kill existing swap
    sudo swapoff -a 2>/dev/null
    # nuke and reload zram
    sudo rmmod zram 2>/dev/null
    sudo modprobe zram num_devices=1

    # set zram to full RAM size
    set -g tmem (awk '/^MemTotal:/ {print $2}' /proc/meminfo)
    echo $tmem | sudo tee /sys/block/zram0/disksize

    # zstd go brrr
    echo zstd | sudo tee /sys/block/zram0/comp_algorithm

    # make it swap space
    sudo mkswap /dev/zram0
    sudo swapon /dev/zram0
end

# run setup
setup_zram

# start the timer - no user meddling
sudo systemctl start zram.timer

# scream if dead
if test $status -ne 0
    echo "zram init ded, check kernel or perms"
    exit 1
end
