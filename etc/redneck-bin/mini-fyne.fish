#!/bin/env /bin/fish

nohup flatpak update --system -y --noninteractive

rpm-ostree -q --peer reload
rpm-ostree -q --peer cleanup -b
rpm-ostree -q --peer upgrade --bypass-driver --allow-downgrade --trigger-automatic-update-policy
rpm-ostree apply-live
rpm-ostree apply-live --allow-replacement
