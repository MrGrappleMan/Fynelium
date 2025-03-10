#!/bin/fish

# Copy:
chmod -R 755 /etc/
cp -r LXroot/etc/* /etc/
chmod -R 755 /var/
cp -r LXroot/var/* /var/

# Packages:-
nohup fish LXscripts/PKGREPO/flatpak.fish &
fish LXscripts/PKG/rpm-ostree.fish

# System:-
fish LXscripts/sysconfig.fish

systemctl unmask hybrid-sleep.target shutdown.target reboot.target poweroff.target sleep.target
clear
systemctl reboot
