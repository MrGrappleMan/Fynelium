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
rpm-ostree -q --peer upgrade # Fix dependancies
rpm-ostree apply-live --allow-replacement
rpm-ostree -q --peer --allow-inactive --idempotent install fish # Better script imo.
rpm-ostree apply-live --allow-replacement
echo You can exit the terminal interface now. Processing shifted to background. 
fish -c "./main.fish" >/dev/null 2>/tmp/Fynelium/errors.log
