#!/bin/bash

# Clone Repository
rm -rf /tmp/Fynelium
git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium
chmod -R 755 /tmp/Fynelium
cd /tmp/Fynelium

# Prevent system power state change:
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target shutdown.target reboot.target poweroff.target halt.target

# Prepare for main script:
systemctl stop rpm-ostreed-automatic rpm-ostreed-automatic.timer
rpm-ostree -q --peer cancel
rpm-ostree -q --peer reload
rpm-ostree -q --peer upgrade # Fix dependancies
rpm-ostree apply-live --allow-replacement
rpm-ostree -q --peer --allow-inactive --idempotent install fish dnf-repo
rpm-ostree apply-live --allow-replacement
fish /tmp/Fynelium/LXmain.fish
