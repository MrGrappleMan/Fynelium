#!/bin/fish

#Initialize:-
chmod -R 755 /etc/
cp -r LXroot/etc/* /etc/
chmod -R 755 /var/
cp -r LXroot/var/* /var/
source /etc/fish/config.fish

#Packaging
  #Flatpak
    #Repos
      flatpak remote-delete --force --system flathub
      flatpak remote-delete --force --system eos-sdk
      flatpak remote-delete --force --system igalia
      flatpak remote-delete --force --system dragon-nightly
      flatpak remote-delete --force --system xwaylandvideobridge-nightly
      flatpak remote-delete --force --system eos-apps
      flatpak remote-delete --force --system webkit
      flatpak remote-delete --force --system flathub-beta
      flatpak remote-delete --force --system gnome-nightly
      flatpak remote-delete --force --system webkit-sdk
      flatpak remote-delete --force --system fedora
      flatpak remote-delete --force --system fedora-testing
      flatpak remote-delete --force --system rhel
      flatpak remote-add --if-not-exists --system flatpak remote-delete --force --system eclipse-nightly
      flatpak remote-delete --force --system elementaryos
      flatpak remote-delete --force --system pureos
      flatpak remote-delete --force --system kde-runtime-nightly

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

flatpak remote-modify --system --subset=floss flathub
flatpak remote-modify --system --subset=floss flathub-beta
#Pkgs

#RPM-OSTree
#Repos

#Pkgs
#System

systemctl daemon-reload

systemctl mask systemd-rfkill systemd-rfkill.socket

systemctl enable tlp
systemctl enable autopgrade.timer
systemctl enable boinc-client
systemctl enable zram-init
systemctl enable systemd-bsod

plymouth-set-default-theme spinner

rqe kargs --append-if-missing=threadirqs
rqe kargs --delete-if-present=rhgb
rqe kargs --append-if-missing=sysrq_always_enabled=1
rqe kargs --append-if-missing=consoleblank=1
rqe kargs --append-if-missing=quiet
rqe kargs --append-if-missing=loglevel=3
rqe kargs --append-if-missing=preempt=full
rqe initramfs --enable

systemctl unmask hybrid-sleep.target shutdown.target reboot.target poweroff.target sleep.target
systemctl reboot
