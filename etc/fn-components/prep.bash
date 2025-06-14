#!/bin/bash
### Retrieves fish prior to main script execution ###

#BasicChecks
if [ "$(id -u)" -ne 0 ]; then
    echo "Not root user"
    exit 1
fi
if ! ping -c 1 -W 2 8.8.8.8 > /dev/null 2>&1; then
    echo "No access to internet or Google DNS"
    exit 1
fi

#RepoClone
 rm -rf /tmp/Fynelium
 mkdir /tmp/Fynelium
 git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium/
 if test $status -ne 0
  echo "Repo clone failed"
  exit 1
 end
 cp -r /tmp/Fynelium/etc/* /etc/
 cp -r /tmp/Fynelium/var/* /var/
 ##cp -r /tmp/Fynelium/root/* /root/

rpm-ostree -q --peer reload
rpm-ostree -q --peer cleanup -b
rpm-ostree -q --peer upgrade --bypass-driver --allow-downgrade --trigger-automatic-update-policy
rpm-ostree install --allow-inactive --idempotent -y -q --peer fish
rpm-ostree apply-live
rpm-ostree apply-live --allow-replacement

apt install fish
dnf install fish

fish /etc/fn-components/main.fish
