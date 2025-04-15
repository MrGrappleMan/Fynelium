#!/usr/bin/fish

if test (id -u) -ne 0
    exit
end

brh rebase unstable -y
rpm-ostree reload -q --peer
rpm-ostree upgrade -q --peer --allow-downgrade --bypass-driver
rpm-ostree initramfs -q --peer --enable
rpm-ostree apply-live --allow-replacement
