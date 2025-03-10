#!/bin/fish

# Copy:
chmod -R 755 /etc/
cp -r LXroot/etc/* /etc/
chmod -R 755 /var/
cp -r LXroot/var/* /var/

# Packages:-

# System:-

systemctl unmask hybrid-sleep.target shutdown.target reboot.target poweroff.target sleep.target
systemctl reboot
