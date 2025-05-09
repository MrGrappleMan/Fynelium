#!/bin/env /bin/fish

nohup flatpak update --system -y --noninteractive --force-remove &

rpm-ostree -q --peer reload
rpm-ostree -q --peer cleanup -b
rpm-ostree -q --peer upgrade --bypass-driver --allow-downgrade --trigger-automatic-update-policy
rpm-ostree apply-live
rpm-ostree apply-live --allow-replacement

systemctl daemon-reload

timedatectl set-ntp true --no-ask-password
systemd-resolve --flush-caches
