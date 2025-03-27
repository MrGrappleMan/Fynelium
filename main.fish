#!/bin/fish

#Aliases
 alias rpma="rpm-ostree install --peer --allow-inactive --idempotent -y -A "
 alias rpmr="rpm-ostree uninstall --peer --allow-inactive --idempotent -y "
 alias fpka="flatpak install -y -v --noninteractive --system --or-update --include-sdk --include-debug "
 alias fpkr="flatpak uninstall -y -v --noninteractive --system --unused "

#Unlock
 chmod -R 777 /etc/
 chmod -R 777 /var/
#Modify
 cp -r /tmp/Fynelium/LXroot/etc/* /etc/
 cp -r /tmp/Fynelium/LXroot/var/* /var/
 rm -rf /etc/yum.repos.d/*
#Relock
 chmod -R 755 /etc/
 chmod -R 755 /var/

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
  #RefreshX2
   flatpak update --noninteractive --system --force-remove --system
  #Pkgs
   #Add
    f+ flathub com.gopeed.Gopeed \
    io.github.flattool.Warehouse \
    net.cozic.joplin_desktop

 #RPM-OSTree
  #RefreshX1
   rpm-ostree --peer reload
   rpm-ostree --peer upgrade
   rpm-ostree apply-live --allow-replacement
  #Repos
   r+ https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-rawhide.noarch.rpm \
   https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-rawhide.noarch.rpm
  #Pkgs
   #Add
    r+ tlp tlp-rdw \
    kernel-modules-extra \
    rpm-ostree \
    dnf dnf-repo \
    boinc-client \
    topgrade \
    flatseal flatpak-selinux flatpak-session-helper xdg-desktop-portal flatpak-libs libportal host-spawn
#System
 #Reload
  systemctl daemon-reload
 #Mask
  systemctl mask systemd-rfkill systemd-rfkill.socket
 #Enable
  systemctl enable tlp \
  autopgrade.timer \
  boinc-client \
  zram \
  systemd-bsod \
  gdm
 #KernelArgs
  rpm-ostree --peer kargs --append-if-missing=threadirqs
  rpm-ostree --peer kargs --delete-if-present=rhgb
  rpm-ostree --peer kargs --append-if-missing=sysrq_always_enabled=1
  rpm-ostree --peer kargs --append-if-missing=consoleblank=0
  rpm-ostree --peer kargs --append-if-missing=quiet
  rpm-ostree --peer kargs --append-if-missing=loglevel=3
  rpm-ostree --peer kargs --append-if-missing=preempt=full
  rpm-ostree initramfs --enable
 #Completion
sudo chmod -R 600 /tmp/Fynelium/
 systemctl unmask hybrid-sleep.target shutdown.target reboot.target poweroff.target sleep.target
sudo chmod -R 600 /tmp/Fynelium/