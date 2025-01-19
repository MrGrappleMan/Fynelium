#!/bin/fish

# System:
rm -rf /etc/yum.repos.d/*
chmod -R 755 /etc/
cp -r LXroot/etc/* /etc/
chmod -R 755 /var/
cp -r LXroot/var/* /var/

# Package management:-
# FPK cfg:

flatpak update --noninteractive --system

# RQE cfg:


# FPK pkg:

# RQE pkg:

rpm-ostree apply-live --allow-replacement
usermod -aG boinc root

systemctl unmask hybrid-sleep.target shutdown.target reboot.target poweroff.target sleep.target
echo Script executed successfuly
