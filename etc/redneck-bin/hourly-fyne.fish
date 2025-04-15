#!/usr/bin/fish

if test (id -u) -ne 0
    exit
end

rpm-ostree reload -q --peer
rpm-ostree upgrade -q --peer --allow-downgrade --bypass-driver
rpm-ostree apply-live --allow-replacement
systemctl daemon-reload
