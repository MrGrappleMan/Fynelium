#!/bin/fish

# System:
rm -rf /etc/yum.repos.d/*
chmod -R 755 /etc/
cp -r LXroot/etc/* /etc/
chmod -R 755 /var/
cp -r LXroot/var/* /var/

# PKGREPO:-
# flatpak:
nohup fish LXscripts/PKGREPO &
flatpak update --noninteractive --system

# rpm-ostree:
nohup fish LXscripts/PKGREPO &

# PKG:-
# flatpak:
nohup fish LXscripts/ &

# rpm-ostree:
nohup fish LXscripts/ &
rpm-ostree apply-live --allow-replacement
usermod -aG boinc root

systemctl unmask hybrid-sleep.target shutdown.target reboot.target poweroff.target sleep.target
clear
echo Shaboinky
