#!/bin/bash

systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target shutdown.target reboot.target poweroff.target halt.target

# Cloning:
cd ~
rm -rf /tmp/Fynelium
git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium
chmod -R 755 /tmp/Fynelium
cd /tmp/Fynelium

notify-send "🟡 Refyning..." "Avoid powering off. Use your session normally." -u critical

# Prepare for main script:
systemctl stop rpm-ostreed-automatic rpm-ostreed-automatic.timer
rpm-ostree -q --peer cancel
rpm-ostree -q --peer reload
rpm-ostree -q --peer upgrade # Fix dependancies
rpm-ostree apply-live --allow-replacement
rpm-ostree -q --peer --allow-inactive --idempotent install fish # Better shell imo.
rpm-ostree apply-live --allow-replacement
fish -c "./main.fish"
