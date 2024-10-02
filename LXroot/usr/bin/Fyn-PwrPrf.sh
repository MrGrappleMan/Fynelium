#!/bin/bash
swapoff -a
rmmod zram
if [[ "$1"=="Y" ]]; then
	sudo mkswap /dev/zram0
	sudo swapon -p 32765 /dev/zram0
fi