#!/bin/bash
swapoff -a
rmmod zram

if
sudo mkswap /dev/zram0
sudo swapon -p 32765 /dev/zram0