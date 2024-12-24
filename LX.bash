#!/bin/bash

# Prevent system power state change:
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target shutdown.target reboot.target poweroff.target halt.target

# Prepare for main script:
systemctl stop rpm-ostreed-automatic rpm-ostreed-automatic.timer
rpm-ostree -q --peer cancel
rpm-ostree -q --peer reload
rpm-ostree -q --peer upgrade # Fix dependancies
rpm-ostree apply-live --allow-replacement
rpm-ostree -q --peer --allow-inactive --idempotent install fish
rpm-ostree apply-live --allow-replacement
fish /tmp/Fynelium/LXmain.fish