#!/bin/bash

# Cloning:
cd ~
rm -rf /tmp/Fynelium
git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium
chmod -R 755 /tmp/Fynelium
cd /tmp/Fynelium

uname=$(uname);
case "$uname" in
    (*Linux*) scriptFile='LX.bash'; ;;
    (*Darwin*) scriptFile='DW.bash'; ;;
    (*) echo 'error: unsupported platform.'; exit 2; ;;
esac;

pkill -t tty3
script -q -c "$scriptFile" /dev/tty3