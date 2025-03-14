#!/bin/fish

#Aliases
 alias rqp="rpm-ostree -q --peer"
 alias rqpa="rpm-ostree apply-live --allow-replacement"
 alias rqp+="rpm-ostree -q --peer install 
#CopyOver
 chmod -R 755 /etc/
 cp -r /tmp/Fynelium/LXroot/etc/* /etc/
 chmod -R 755 /var/
 cp -r /tmp/Fynelium/LXroot/var/* /var/

#Pkging
 #Flatpak
  #RefreshX1
   
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
   
  #Pkgs
   #Remove
    flatpak uninstall --all -y --noninteractive
   #Add
    flatpak install --system --noninteractive --or-update flathub com.gopeed.Gopeed \
    io.github.flattool.Warehouse \
    com.github.rkoesters.xkcd-gtk \
    org.geogebra.GeoGebra \
    com.vscodium.codium-insiders \
    se.sjoerd.Graphs \
    porg.cubocore.CoreStats \
    net.cozic.joplin_desktop \
    org.octave.Octave

 #RPM-OSTree
  #RefreshX1
   rpm-ostree -q --peer reload
   rpm-ostree -q --peer upgrade
   rpm-ostree apply-live --allow-replacement
  #Repos
   rpm-ostree -q --peer rebase fedora:fedora/rawhide/x86_64/silverblue
   rpm-ostree -q --peer install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-rawhide.noarch.rpm \
   https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-rawhide.noarch.rpm
  #RefreshX2
   rpm-ostree -q --peer reload
   rpm-ostree -q --peer upgrade
   rpm-ostree apply-live --allow-replacement
  #Pkgs
   #Add
    rpm-ostree -q --peer install --allow-inactive --idempotent tlp tlp-rdw \
    cinnamon \
    kernel-modules-extra \
    dnf dnf-repo \
    ghostty \
    rustup rust \
    golang \
    distcc \
    ostree-devel \
    torbrowser-launcher \
    boinc-client \
    topgrade \
    gnome-software \
    flatseal flatpak-selinux flatpak-session-helper xdg-desktop-portal flatpak-libs libportal host-spawn \
    beep \
    mosh openssh-server
   #Remove
    rpm-ostree -q --peer uninstall --allow-inactive --idempotent power-profiles-daemon \
    firefox
#System
 #Reload
  systemctl daemon-reload
 #Mask
  systemctl mask systemd-rfkill systemd-rfkill.socket
 #Enable
  systemctl enable tlp \
  autopgrade.timer autopgrade \
  boinc-client \
  zram-init \
  systemd-bsod \
  gdm \
  sshd
 #KernelArgs
  rpm-ostree -q --peer kargs --append-if-missing=threadirqs
  rpm-ostree -q --peer kargs --delete-if-present=rhgb
  rpm-ostree -q --peer kargs --append-if-missing=sysrq_always_enabled=1
  rpm-ostree -q --peer kargs --append-if-missing=consoleblank=0
  rpm-ostree -q --peer kargs --append-if-missing=quiet
  rpm-ostree -q --peer kargs --append-if-missing=loglevel=3
  rpm-ostree -q --peer kargs --append-if-missing=preempt=full
  rpm-ostree -q initramfs --enable
 #Completion
 systemctl unmask hybrid-sleep.target shutdown.target reboot.target poweroff.target sleep.target
 systemctl reboot
