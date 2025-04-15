#!/bin/fish

if test (id -u) -ne 0
    exit
end

rm -rf /tmp/Fynelium
mkdir /tmp/Fynelium 
git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium/
cp -r /tmp/Fynelium/etc/* /etc/
cp -r /tmp/Fynelium/var/* /var/

#RPM-OSTree
   brh rebase unstable -y
   rpm-ostree install --peer -q --allow-inactive --idempotent -y \
    tlp tlp-rdw \
    openssh-server \
    kernel-modules-extra \
    dnf dnf-repo \
    boinc-client \
    flatseal flatpak-selinux flatpak-session-helper xdg-desktop-portal flatpak-libs libportal host-spawn
   rpm-ostree apply-live --allow-replacement
#System
  systemctl daemon-reload
  systemctl mask \
   systemd-rfkill systemd-rfkill.socket \
   suspend.target hibernate.target halt.target
  systemctl unmask \
   hybrid-sleep.target shutdown.target reboot.target sleep.target poweroff.target
  systemctl enable \
   tlp \
   weekly-fyne.timer \
   hourly-fyne.timer \
   boinc-client \
   mem-mgr \
   systemd-bsod \
   sshd
 #KernelArgs
  rpm-ostree --peer -q kargs --append-if-missing="threadirqs sysrq_always_enabled=1 consoleblank=0 quiet loglevel=3 preempt=full" --delete-if-present=rhgb
  rpm-ostree --peer -q initramfs --enable
exit
