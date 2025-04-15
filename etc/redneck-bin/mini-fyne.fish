#!/usr/bin/fish

function check_error
    if test $status -ne 0
        echo "Error code: $status"
        sleep 3
        exit $status
    end
end

if test (id -u) -ne 0
    exit
end

brh rebase unstable -y
rpm-ostree reload -q --peer
rpm-ostree upgrade -q --peer --allow-downgrade --bypass-driver
rpm-ostree initramfs -q --peer --enable
