#!/bin/env /bin/fish


#BasicChecks
 if test (id -u) -ne 0
  echo "Not root user"
  exit 1
 end
 if not ping -c 1 -W 2 1.1.1.1 > /dev/null
    echo "No internet"
    exit 1
 end

nohup systemctl daemon-reload &

nohup timedatectl set-ntp true --no-ask-password &
nohup systemd-resolve --flush-caches &

nohup flatpak update --system -y --noninteractive --force-remove &

rpm-ostree -q --peer reload
rpm-ostree -q --peer cleanup -b
rpm-ostree -q --peer upgrade --bypass-driver --allow-downgrade --trigger-automatic-update-policy
