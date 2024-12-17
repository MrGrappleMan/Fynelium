#!/bin/bash
# Cloning:
cd ~
rm -rf /tmp/Fynelium
git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium
chmod -R 755 /tmp/Fynelium
cd /tmp/Fynelium

# Prepare for main script:
systemctl stop rpm-ostreed-automatic rpm-ostreed-automatic.timer
rpm-ostree -q --peer cancel
rpm-ostree -q --peer reload
rpm-ostree -q --peer --allow-inactive --idempotent install fish
rpm-ostree apply-live --allow-replacement
nohup fish -c "./main.fish" >/dev/null 2>/tmp/Fynelium/errors.log &
