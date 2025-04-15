#!/bin/fish

rm -rf /tmp/Fynelium
mkdir /tmp/Fynelium 
git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium/
cp -r /tmp/Fynelium/*

#Aliases
 alias rpmr="rpm-ostree uninstall --peer --allow-inactive --idempotent -y "

#RPM-OSTree
if test (id -u) -ne 0
    exit
end
   brh rebase unstable -y
   rpm-ostree --peer -q reload
   rpm-ostree install --peer -q --allow-inactive --idempotent -y -A \
    tlp tlp-rdw \
    openssh-server \
    kernel-modules-extra \
    dnf dnf-repo \
    boinc-client \
    flatseal flatpak-selinux flatpak-session-helper xdg-desktop-portal flatpak-libs libportal host-spawn
#System
  systemctl daemon-reload
  systemctl mask \
   systemd-rfkill systemd-rfkill.socket \
   suspend.target hibernate.target halt.target
  systemctl unmask \
   hybrid-sleep.target shutdown.target reboot.target sleep.target poweroff.target
  systemctl enable \
   tlp \
   refyne.timer \
   boinc-client \
   mem-mgr \
   systemd-bsod \
   sshd
 #KernelArgs
  rpm-ostree --peer -q kargs --append-if-missing="threadirqs \
   sysrq_always_enabled=1 \
   consoleblank=0 \
   quiet \
   loglevel=3 \
   rhgb \
   preempt=full"
  rpm-ostree initramfs --peer --enable -q 
exit
