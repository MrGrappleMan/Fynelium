#!/usr/bin/fish

if test (id -u) -ne 0
    exit
end

rm -rf /tmp/Fynelium
mkdir /tmp/Fynelium
git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium/
if test $status -ne 0
    echo "Repo clone failed."
    exit 1
end
cp -r /tmp/Fynelium/etc/* /etc/
cp -r /tmp/Fynelium/var/* /var/
cp -r /tmp/Fynelium/root/* /root/
ujust update
rpm-ostree apply-live --allow-replacement
systemctl daemon-reload
boinccmd --acct_mgr sync
