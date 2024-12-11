#!/bin/bash
# Cloning:
cd ~
rm -rf /tmp/Fynelium/*
git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium
chmod -R 755 /tmp/Fynelium
cd /tmp/Fynelium

# Prepare for main script:
rpm-ostree -q --peer cancel
rpm-ostree -q --peer reload
rpm-ostree -q --peer install fish
rpm-ostree apply-live --allow-replacement
sudo /bin/fish -c "./main.fish">/dev/null
