#!/bin/bash

# Clone Repository
rm -rf /tmp/Fynelium
git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium
chmod -R 777 /tmp/Fynelium/

# Prevent system power state change:
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target shutdown.target reboot.target poweroff.target halt.target

# Prepare for main script:
rpm-ostree --peer cancel
rpm-ostree --peer reload
rpm-ostree --peer upgrade
rpm-ostree apply-live --allow-replacement
rpm-ostree --peer --allow-inactive --idempotent install fish
rpm-ostree apply-live --allow-replacement
fish /tmp/Fynelium/main.fish
