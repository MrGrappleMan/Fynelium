#!/bin/fish

rm -rf /etc/yum.repos.d/*
git clone https://github.com/MrGrappleMan/Fynelium.git /

#Aliases
 alias rpmr="rpm-ostree uninstall --peer --allow-inactive --idempotent -y "
 alias fpkr="flatpak uninstall -y -v --noninteractive --system --unused "
 alias fpka="flatpak install -y -v --noninteractive --system --or-update "

#Pkging
 #Flatpak
  #Repos
   flatpak remote-add --if-not-exists --system flathub https://flathub.org/repo/flathub.flatpakrepo
   flatpak remote-add --if-not-exists --system eos-sdk https://ostree.endlessm.com/ostree/eos-sdk
   flatpak remote-add --if-not-exists --system igalia https://software.igalia.com/flatpak-refs/igalia.flatpakrepo
   flatpak remote-add --if-not-exists --system dragon-nightly https://cdn.kde.org/flatpak/dragon-nightly/dragon-nightly.flatpakrepo
   flatpak remote-add --if-not-exists --system xwaylandvideobridge-nightly https://cdn.kde.org/flatpak/xwaylandvideobridge-nightly/xwaylandvideobridge-nightly.flatpakrepo
   flatpak remote-add --if-not-exists --system eos-apps https://ostree.endlessm.com/ostree/eos-apps
   flatpak remote-add --if-not-exists --system webkit https://software.igalia.com/flatpak-refs/webkit-sdk.flatpakrepo
   flatpak remote-add --if-not-exists --system flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
   flatpak remote-add --if-not-exists --system gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo
   flatpak remote-add --if-not-exists --system webkit-sdk https://software.igalia.com/flatpak-refs/webkit-sdk.flatpakrepo
   flatpak remote-add --if-not-exists --system fedora oci+https://registry.fedoraproject.org
   flatpak remote-add --if-not-exists --system fedora-testing oci+https://registry.fedoraproject.org/#testing
   flatpak remote-add --if-not-exists --system rhel https://flatpaks.redhat.io/rhel.flatpakrepo
   flatpak remote-add --if-not-exists --system eclipse-nightly https://download.eclipse.org/linuxtools/flatpak-I-builds/eclipse.flatpakrepo
   flatpak remote-add --if-not-exists --system elementaryos https://flatpak.elementary.io/repo.flatpakrepo
   flatpak remote-add --if-not-exists --system pureos https://store.puri.sm/repo/stable/pureos.flatpakrepo
   flatpak remote-add --if-not-exists --system kde-runtime-nightly https://cdn.kde.org/flatpak/kde-runtime-nightly/kde-runtime-nightly.flatpakrepo
 #RPM-OSTree
   rpm-ostree --peer reload
   rpm-ostree install --peer --allow-inactive --idempotent -y -A \
    tlp tlp-rdw \
    kernel-modules-extra \
    dnf dnf-repo \
    boinc-client \
    topgrade \
    flatseal flatpak-selinux flatpak-session-helper xdg-desktop-portal flatpak-libs libportal host-spawn
#System
  systemctl daemon-reload
  systemctl mask \
   systemd-rfkill systemd-rfkill.socket \
   suspend.target hibernate.target poweroff.target halt.target
  systemctl unmask \
   hybrid-sleep.target shutdown.target reboot.target sleep.target
  systemctl enable \
   tlp \
   autopgrade.timer autopgrade \
   refyne.timer \
   boinc-client \
   mem-mgr \
   systemd-bsod
 #KernelArgs
  rpm-ostree --peer kargs --append-if-missing="threadirqs \
   sysrq_always_enabled=1 \
   consoleblank=0 \
   quiet \
   loglevel=3 \
   rhgb \
   preempt=full"
  rpm-ostree initramfs --enable
