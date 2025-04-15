#!/bin/fish

if test (id -u) -ne 0
    exit
end

rm -rf /tmp/Fynelium
mkdir /tmp/Fynelium 
git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium/
cp -r /tmp/Fynelium/etc/* /etc/
cp -r /tmp/Fynelium/var/* /var/
cp -r /tmp/Fynelium/root/* /root/

#Flatpak
flatpak remote-add --if-not-exists --system flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists --system flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
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
   brh rebase unstable -y
   rpm-ostree install --peer -q --allow-inactive --idempotent -y \
    tlp tlp-rdw \
    openssh-server \
    kernel-modules-extra \
    dnf-repo \
    boinc-client \
    flatseal flatpak-selinux flatpak-session-helper xdg-desktop-portal flatpak-libs libportal host-spawn
   rpm-ostree apply-live --allow-replacement
#Systemd
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
   podman \
   mem-mgr \
   systemd-bsod \
   sshd

#GSettings
 gsettings set org.gnome.desktop.interface enable-animations false

#Kernel
  rpm-ostree --peer -q kargs --append-if-missing="threadirqs sysrq_always_enabled=1 consoleblank=0 quiet loglevel=3 preempt=full" --delete-if-present=rhgb
  rpm-ostree --peer -q initramfs --enable
exit
