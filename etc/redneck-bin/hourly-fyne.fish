#!/usr/bin/fish

#CheckS
 if test (id -u) -ne 0
  exit 1
 end
 if not ping -c 1 -W 2 1.1.1.1 > /dev/null
    echo "No internet"
    exit 1
 end
set metered (busctl get-property org.freedesktop.NetworkManager /org/freedesktop/NetworkManager/ActiveConnection/0 org.freedesktop.NetworkManager.Connection Metered | awk '{print $2}')
if test "$metered" -eq 1
    echo "Metered connection"
    exit 1
end

#RepoClone
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

#PerformUpdates
 ujust update
 rpm-ostree apply-live --allow-replacement
 systemctl daemon-reload
 boinccmd --acct_mgr sync
